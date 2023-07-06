/* ----------------------------------------------------------------------
   LAMMPS - Large-scale Atomic/Molecular Massively Parallel Simulator
   http://lammps.sandia.gov, Sandia National Laboratories
   Steve Plimpton, sjplimp@sandia.gov

   Copyright (2003) Sandia Corporation.  Under the terms of Contract
   DE-AC04-94AL85000 with Sandia Corporation, the U.S. Government retains
   certain rights in this software.  This software is distributed under
   the GNU General Public License.

   See the README file in the top-level LAMMPS directory.
------------------------------------------------------------------------- */

/* ----------------------------------------------------------------------
   References:

   This code:
   Stewart J A and Spearot D E (2013) Atomistic simulations of nanoindentation on the basal plane of crystalline molybdenum disulfide. Modelling Simul. Mater. Sci. Eng. 21.

   Based on:
   Liang T, Phillpot S R and Sinnott S B (2009) Parameterization of a reactive many-body potential for Mo�S systems. Phys. Rev. B79 245110.
   Liang T, Phillpot S R and Sinnott S B (2012) Erratum: Parameterization of a reactive many-body potential for Mo-S systems. (Phys. Rev. B79 245110 (2009)) Phys. Rev. B85 199903(E).

   LAMMPS file contributing authors: James Stewart, Khanh Dang and Douglas Spearot (University of Arkansas)
------------------------------------------------------------------------- */

#include "math.h"
#include "stdio.h"
#include "stdlib.h"
#include "string.h"
#include "mpi.h"
#include "pair_rebomos.h"
#include "atom.h"
#include "neighbor.h"
#include "neigh_request.h"
#include "force.h"
#include "comm.h"
#include "neighbor.h"
#include "neigh_list.h"
#include "neigh_request.h"
#include "math_const.h"
#include "memory.h"
#include "error.h"

using namespace LAMMPS_NS;
using namespace MathConst;

#define MAXLINE 1024
#define TOL 1.0e-9
#define PI 3.141592653
#define PGDELTA 1

/* ---------------------------------------------------------------------- */

PairREBOMoS::PairREBOMoS(LAMMPS *lmp) : Pair(lmp)
{
  single_enable = 0;
  one_coeff = 1;
  ghostneigh = 1;

  maxlocal = 0;
  REBO_numneigh = NULL;
  REBO_firstneigh = NULL;
  maxpage = 0;
  pages = NULL;
  nM = nS = NULL;
}

/* ----------------------------------------------------------------------
   Check if allocated, since class can be destructed when incomplete
------------------------------------------------------------------------- */

PairREBOMoS::~PairREBOMoS()
{
  memory->destroy(REBO_numneigh);
  memory->sfree(REBO_firstneigh);
  for (int i = 0; i < maxpage; i++) memory->destroy(pages[i]);
  memory->sfree(pages);
  memory->destroy(nM);
  memory->destroy(nS);

  if (allocated) {
    memory->destroy(setflag);
    memory->destroy(cutsq);
    memory->destroy(cutghost);

    memory->destroy(cutljsq);
    memory->destroy(lj1);
    memory->destroy(lj2);
    memory->destroy(lj3);
    memory->destroy(lj4);
    delete [] map;
  }
}

/* ---------------------------------------------------------------------- */

void PairREBOMoS::compute(int eflag, int vflag)
{
  if (eflag || vflag) ev_setup(eflag,vflag);
  else evflag = vflag_fdotr = vflag_atom = 0;

  REBO_neigh();
  FREBO(eflag,vflag);
  if (ljflag) FLJ(eflag,vflag);

  if (vflag_fdotr) virial_fdotr_compute();
}

/* ----------------------------------------------------------------------
   allocate all arrays
------------------------------------------------------------------------- */

void PairREBOMoS::allocate()
{
  allocated = 1;
  int n = atom->ntypes;

  memory->create(setflag,n+1,n+1,"pair:setflag");
  for (int i = 1; i <= n; i++)
    for (int j = i; j <= n; j++)
      setflag[i][j] = 0;

  memory->create(cutsq,n+1,n+1,"pair:cutsq");
  memory->create(cutghost,n+1,n+1,"pair:cutghost");

  // only sized by M,S = 2 types

  memory->create(cutljsq,2,2,"pair:cutljsq");
  memory->create(lj1,2,2,"pair:lj1");
  memory->create(lj2,2,2,"pair:lj2");
  memory->create(lj3,2,2,"pair:lj3");
  memory->create(lj4,2,2,"pair:lj4");

  map = new int[n+1];
}

/* ----------------------------------------------------------------------
   global settings
------------------------------------------------------------------------- */

void PairREBOMoS::settings(int narg, char **arg)
{
  if (narg != 0) error->all(FLERR,"Illegal pair_style command");

  cutlj = 0;
  ljflag = 1;
}

/* ----------------------------------------------------------------------
   set coeffs for one or more type pairs
------------------------------------------------------------------------- */

void PairREBOMoS::coeff(int narg, char **arg)
{
  if (!allocated) allocate();

  if (narg != 3 + atom->ntypes)
    error->all(FLERR,"Incorrect args for pair coefficients");

  // insure I,J args are * *

  if (strcmp(arg[0],"*") != 0 || strcmp(arg[1],"*") != 0)
    error->all(FLERR,"Incorrect args for pair coefficients");

  // read args that map atom types to M and S
  // map[i] = which element (0,1) the Ith atom type is, -1 if NULL

  for (int i = 3; i < narg; i++) {
    if (strcmp(arg[i],"NULL") == 0) {
      map[i-2] = -1;
      continue;
    } else if (strcmp(arg[i],"M") == 0) {
      map[i-2] = 0;
    } else if (strcmp(arg[i],"S") == 0) {
      map[i-2] = 1;
    } else error->all(FLERR,"Incorrect args for pair coefficients");
  }

  // read potential file and initialize fitting splines

  read_file(arg[2]);

  // clear setflag since coeff() called once with I,J = * *

  int n = atom->ntypes;
  for (int i = 1; i <= n; i++)
    for (int j = i; j <= n; j++)
      setflag[i][j] = 0;

  // set setflag i,j for type pairs where both are mapped to elements

  int count = 0;
  for (int i = 1; i <= n; i++)
    for (int j = i; j <= n; j++)
      if (map[i] >= 0 && map[j] >= 0) {
        setflag[i][j] = 1;
        count++;
      }

  if (count == 0) error->all(FLERR,"Incorrect args for pair coefficients");
}

/* ----------------------------------------------------------------------
   init specific to this pair style
------------------------------------------------------------------------- */

void PairREBOMoS::init_style()
{
  if (atom->tag_enable == 0)
    error->all(FLERR,"Pair style Mo-S REBO requires atom IDs");
  if (force->newton_pair == 0)
    error->all(FLERR,"Pair style Mo-S REBO requires newton pair on");

  // need a full neighbor list, including neighbors of ghosts

  int irequest = neighbor->request(this);
  neighbor->requests[irequest]->half = 0;
  neighbor->requests[irequest]->full = 1;
  neighbor->requests[irequest]->ghost = 1;

  // local REBO neighbor list memory

  pgsize = neighbor->pgsize;
  oneatom = neighbor->oneatom;
  if (maxpage == 0) add_pages();
}

/* ----------------------------------------------------------------------
   init for one type pair i,j and corresponding j,i
------------------------------------------------------------------------- */

double PairREBOMoS::init_one(int i, int j)
{
  if (setflag[i][j] == 0) error->all(FLERR,"All pair coeffs are not set");

  // convert to M,S types

  int ii = map[i];
  int jj = map[j];

  // use M-M values for these cutoffs since M atoms are biggest

  // cut3rebo = 3 REBO distances

  cut3rebo = 3.0 * rcmax[0][0];

  // cutljrebosq = furthest distance from an owned atom a ghost atom can be
  //               to need its REBO neighs computed
  // interaction = M-K-I-J-L-N with I = owned and J = ghost
  //   this insures N is in the REBO neigh list of L
  //   since I-J < rcLJmax and J-L < rmax

  double cutljrebo = rcLJmax[0][0] + rcmax[0][0];
  cutljrebosq = cutljrebo * cutljrebo;

  // cutmax = furthest distance from an owned atom
  //          at which another atom will feel force, i.e. the ghost cutoff
  // for REBO term in potential:
  //   interaction = M-K-I-J-L-N with I = owned and J = ghost
  //   I to N is max distance = 3 REBO distances
  // for LJ term in potential:
  //   short interaction = M-K-I-J-L-N with I = owned, J = ghost, I-J < rcLJmax
  //   rcLJmax + 2*rcmax, since I-J < rcLJmax and J-L,L-N = REBO distances
  //   long interaction = I-J with I = owned and J = ghost
  //   cutlj*sigma, since I-J < LJ cutoff
  // cutghost = REBO cutoff used in REBO_neigh() for neighbors of ghosts

  double cutmax = cut3rebo;
  if (ljflag) {
    cutmax = MAX(cutmax,rcLJmax[0][0] + 2.0*rcmax[0][0]);
    cutmax = MAX(cutmax,cutlj*sigma[0][0]);
  }

  cutghost[i][j] = rcmax[ii][jj];
  cutljsq[ii][jj] = cutlj*sigma[ii][jj] * cutlj*sigma[ii][jj];
  lj1[ii][jj] = 48.0 * epsilon[ii][jj] * pow(sigma[ii][jj],12.0);
  lj2[ii][jj] = 24.0 * epsilon[ii][jj] * pow(sigma[ii][jj],6.0);
  lj3[ii][jj] = 4.0 * epsilon[ii][jj] * pow(sigma[ii][jj],12.0);
  lj4[ii][jj] = 4.0 * epsilon[ii][jj] * pow(sigma[ii][jj],6.0);

  cutghost[j][i] = cutghost[i][j];
  cutljsq[jj][ii] = cutljsq[ii][jj];
  lj1[jj][ii] = lj1[ii][jj];
  lj2[jj][ii] = lj2[ii][jj];
  lj3[jj][ii] = lj3[ii][jj];
  lj4[jj][ii] = lj4[ii][jj];

  return cutmax;
}

/* ----------------------------------------------------------------------
   create REBO neighbor list from main neighbor list
   REBO neighbor list stores neighbors of ghost atoms
------------------------------------------------------------------------- */

void PairREBOMoS::REBO_neigh()
{
  int i,j,ii,jj,n,allnum,jnum,itype,jtype;
  double xtmp,ytmp,ztmp,delx,dely,delz,rsq,dS;
  int *ilist,*jlist,*numneigh,**firstneigh;
  int *neighptr;

  double **x = atom->x;
  int *type = atom->type;
  int nlocal = atom->nlocal;
  int nall = nlocal + atom->nghost;

  if (atom->nmax > maxlocal) {
    maxlocal = atom->nmax;
    memory->destroy(REBO_numneigh);
    memory->sfree(REBO_firstneigh);
    memory->destroy(nM);
    memory->destroy(nS);
    memory->create(REBO_numneigh,maxlocal,"rebomos:numneigh");
    REBO_firstneigh = (int **) memory->smalloc(maxlocal*sizeof(int *),
                                               "rebomos:firstneigh");
    memory->create(nM,maxlocal,"rebomos:nM");
    memory->create(nS,maxlocal,"rebomos:nS");
  }

  allnum = list->inum + list->gnum;
  ilist = list->ilist;
  numneigh = list->numneigh;
  firstneigh = list->firstneigh;

  // store all REBO neighs of owned and ghost atoms
  // scan full neighbor list of I

  int npage = 0;
  int npnt = 0;

  for (ii = 0; ii < allnum; ii++) {
    i = ilist[ii];

    if (pgsize - npnt < oneatom) {
      npnt = 0;
      npage++;
      if (npage == maxpage) add_pages();
    }
    neighptr = &pages[npage][npnt];
    n = 0;

    xtmp = x[i][0];
    ytmp = x[i][1];
    ztmp = x[i][2];
    itype = map[type[i]];
    nM[i] = nS[i] = 0.0;
    jlist = firstneigh[i];
    jnum = numneigh[i];

    for (jj = 0; jj < jnum; jj++) {
      j = jlist[jj];
      j &= NEIGHMASK;
      jtype = map[type[j]];
      delx = xtmp - x[j][0];
      dely = ytmp - x[j][1];
      delz = ztmp - x[j][2];
      rsq = delx*delx + dely*dely + delz*delz;

      if (rsq < rcmaxsq[itype][jtype]) {
        neighptr[n++] = j;
        if (jtype == 0)
          nM[i] += Sp(sqrt(rsq),rcmin[itype][jtype],rcmax[itype][jtype],dS);
        else
          nS[i] += Sp(sqrt(rsq),rcmin[itype][jtype],rcmax[itype][jtype],dS);
      }
    }

    REBO_firstneigh[i] = neighptr;
    REBO_numneigh[i] = n;
    npnt += n;
    if (npnt >= pgsize)
      error->one(FLERR,
                 "Neighbor list overflow, boost neigh_modify one or page");
  }
}

/* ----------------------------------------------------------------------
   REBO forces and energy
------------------------------------------------------------------------- */

void PairREBOMoS::FREBO(int eflag, int vflag)
{
  int i,j,k,m,ii,inum,itype,jtype,itag,jtag;
  double delx,dely,delz,evdwl,fpair,xtmp,ytmp,ztmp;
  double rsq,rij,wij;
  double Qij,Aij,alphaij,VR,pre,dVRdi,VA,term,bij,dVAdi,dVA;
  double dwij,del[3];
  int *ilist,*REBO_neighs;

  evdwl = 0.0;

  double **x = atom->x;
  double **f = atom->f;
  int *type = atom->type;
  int *tag = atom->tag;
  int nlocal = atom->nlocal;
  int newton_pair = force->newton_pair;

  inum = list->inum;
  ilist = list->ilist;

  // two-body interactions from REBO neighbor list, skip half of them

  for (ii = 0; ii < inum; ii++) {
    i = ilist[ii];
    itag = tag[i];
    itype = map[type[i]];
    xtmp = x[i][0];
    ytmp = x[i][1];
    ztmp = x[i][2];
    REBO_neighs = REBO_firstneigh[i];

    for (k = 0; k < REBO_numneigh[i]; k++) {
      j = REBO_neighs[k];
      jtag = tag[j];

      if (itag > jtag) {
        if ((itag+jtag) % 2 == 0) continue;
      } else if (itag < jtag) {
        if ((itag+jtag) % 2 == 1) continue;
      } else {
        if (x[j][2] < ztmp) continue;
        if (x[j][2] == ztmp && x[j][1] < ytmp) continue;
        if (x[j][2] == ztmp && x[j][1] == ytmp && x[j][0] < xtmp) continue;
      }

      jtype = map[type[j]];

      delx = x[i][0] - x[j][0];
      dely = x[i][1] - x[j][1];
      delz = x[i][2] - x[j][2];
      rsq = delx*delx + dely*dely + delz*delz;
      rij = sqrt(rsq);
      wij = Sp(rij,rcmin[itype][jtype],rcmax[itype][jtype],dwij);
      if (wij <= TOL) continue;

      Qij = Q[itype][jtype];
      Aij = A[itype][jtype];
      alphaij = alpha[itype][jtype];

      VR = wij*(1.0+(Qij/rij)) * Aij*exp(-alphaij*rij);
      pre = wij*Aij * exp(-alphaij*rij);
      dVRdi = pre * ((-alphaij)-(Qij/rsq)-(Qij*alphaij/rij));
      dVRdi += VR/wij * dwij;

      VA = dVA = 0.0;
      VA = -wij * BIJc[itype][jtype] * exp(-Beta[itype][jtype]*rij);

      dVA = -Beta[itype][jtype] * VA;
      dVA += VA/wij * dwij;

      del[0] = delx;
      del[1] = dely;
      del[2] = delz;
      bij = bondorder(i,j,del,rij,VA,f,vflag_atom);
      dVAdi = bij*dVA;

      fpair = -(dVRdi+dVAdi) / rij;
      f[i][0] += delx*fpair;
      f[i][1] += dely*fpair;
      f[i][2] += delz*fpair;
      f[j][0] -= delx*fpair;
      f[j][1] -= dely*fpair;
      f[j][2] -= delz*fpair;

      if (eflag) evdwl = VR + bij*VA;
      if (evflag) ev_tally(i,j,nlocal,newton_pair,
                           evdwl,0.0,fpair,delx,dely,delz);
    }
  }
}

/* ----------------------------------------------------------------------
   compute LJ forces and energy
------------------------------------------------------------------------- */

void PairREBOMoS::FLJ(int eflag, int vflag)
{
  int i,j,k,m,ii,jj,kk,mm,inum,jnum,itype,jtype,ktype,mtype,itag,jtag;
  int atomi,atomj,atomk,atomm;   
  double evdwl,fpair,xtmp,ytmp,ztmp;          
  double rsq,best,wik,wkm,cij,rij,dwij,dwik,dwkj,dwkm,dwmj;
  double delij[3],rijsq,delik[3],rik,deljk[3];
  double rkj,wkj,dC,VLJ,dVLJ,VA;
  double vdw,slw,dvdw,dslw,drij;
  double rljmin,rljmax,sigcut,sigmin,sigwid;
  double delkm[3],rkm,deljm[3],rmj,wmj,r2inv,r6inv,scale,delscale[3];
  int *ilist,*jlist,*numneigh,**firstneigh;
  int *REBO_neighs_i,*REBO_neighs_k;
  double delikS[3],deljkS[3],delkmS[3],deljmS[3],delimS[3];
  double rikS,rkjS,rkmS,rmjS,wikS,dwikS;
  double wkjS,dwkjS,wkmS,dwkmS,wmjS,dwmjS;
  double fi[3],fj[3],fk[3],fm[3];
  double c2,c3,dr,drp,r6;

  // I-J interaction from full neighbor list
  // skip 1/2 of interactions since only consider each pair once              

  evdwl = 0.0;
  rljmin = 0.0;                          
  rljmax = 0.0;            
  sigcut = 0.0;     
  sigmin = 0.0;     
  sigwid = 0.0;     


  double **x = atom->x;
  double **f = atom->f;            
  int *tag = atom->tag;     
  int *type = atom->type;   
  int nlocal = atom->nlocal;
  int newton_pair = force->newton_pair; 

  inum = list->inum;                        
  ilist = list->ilist;
  numneigh = list->numneigh;         
  firstneigh = list->firstneigh;

  // loop over neighbors of my atoms

  for (ii = 0; ii < inum; ii++) {
    i = ilist[ii];
    itag = tag[i];
    itype = map[type[i]];
    atomi = i;
    xtmp = x[i][0];
    ytmp = x[i][1];
    ztmp = x[i][2];
    jlist = firstneigh[i];
    jnum = numneigh[i];

    for (jj = 0; jj < jnum; jj++) {
      j = jlist[jj];
      j &= NEIGHMASK;
      jtag = tag[j];

      if (itag > jtag) {
        if ((itag+jtag) % 2 == 0) continue;
      } else if (itag < jtag) {
        if ((itag+jtag) % 2 == 1) continue;
      } else {
        if (x[j][2] < ztmp) continue;
        if (x[j][2] == ztmp && x[j][1] < ytmp) continue;
        if (x[j][2] == ztmp && x[j][1] == ytmp && x[j][0] < xtmp) continue;
      }
      jtype = map[type[j]];
      atomj = j;

      delij[0] = xtmp - x[j][0];
      delij[1] = ytmp - x[j][1];
      delij[2] = ztmp - x[j][2];
      rijsq = delij[0]*delij[0] + delij[1]*delij[1] + delij[2]*delij[2];
      rij = sqrt(rijsq);

      // compute LJ forces and energy

      // Outside Rmax
      if (rij > rcLJmax[itype][jtype] || rij < rcLJmin[itype][jtype]){
          VLJ = 0;            
          dVLJ = 0;                 
      }

      // Inside Rmax and above 0.95*sigma
      else if (rij <= rcLJmax[itype][jtype] && rij >= 0.95*sigma[itype][jtype]){
              r2inv = 1.0/rijsq;           
              r6inv = r2inv*r2inv*r2inv;
              VLJ = r6inv*(lj3[itype][jtype]*r6inv-lj4[itype][jtype]);
              dVLJ = -r6inv*(lj1[itype][jtype]*r6inv - lj2[itype][jtype])/rij;
      }

      // Below 0.95*sigma
      else if (rij < 0.95*sigma[itype][jtype] && rij >= rcLJmin[itype][jtype]){
              dr = 0.95*sigma[itype][jtype] - rcLJmin[itype][jtype];
              r6 = pow((sigma[itype][jtype]/(0.95*sigma[itype][jtype])),6);
              vdw = 4*epsilon[itype][jtype]*r6*(r6 - 1.0);
              dvdw = (-4*epsilon[itype][jtype]/(0.95*sigma[itype][jtype]))*r6*(12.0*r6 - 6.0);
              c2 = ((3.0/dr)*vdw - dvdw)/dr;
              c3 = (vdw/(dr*dr) - c2)/dr;

              drp = rij - rcLJmin[itype][jtype];
              VLJ = drp*drp*(drp*c3 + c2);
              dVLJ = drp*(3.0*drp*c3 + 2.0*c2);
      }

      fpair = -dVLJ/rij;
      f[i][0] += delij[0]*fpair;
      f[i][1] += delij[1]*fpair;
      f[i][2] += delij[2]*fpair;
      f[j][0] -= delij[0]*fpair;
      f[j][1] -= delij[1]*fpair;
      f[j][2] -= delij[2]*fpair;

      if (eflag) evdwl = VLJ;
      if (evflag) ev_tally(i,j,nlocal,newton_pair,
                           evdwl,0.0,fpair,delij[0],delij[1],delij[2]);

    }
  }
}

/* ----------------------------------------------------------------------
   Bij function

   The bond order term modified the attractive portion of the REBO
   potential based on the number of atoms around a specific pair
   and the bond angle between sets of three atoms.

   The functions G(cos(theta)) and P(N) are evaluated and their
   derivatives are also computed for use in the force calculation.
------------------------------------------------------------------------- */

double PairREBOMoS::bondorder(int i, int j, double rij[3], double rijmag,
                              double VA,double **f, int vflag_atom)
{
  int atomi,atomj,atomk,atoml;
  int k,n,l;                 
  int itype, jtype, ktype, ltype;                 
  double rik[3], rjl[3], rji[3], rki[3],rlj[3], wji, dwjl, bij;        
  double NijM,NijS,NjiM,NjiS,wik,dwik,wjl;
  double rikmag,rjlmag,cosjik,cosijl,g,tmp2;
  double Etmp,pij,tmp,wij,dwij,dS;
  double dgdc,pji;
  double dcosjikdri[3],dcosijldri[3],dcosjikdrk[3];
  double dp, Nlj;             
  double dcosjikdrj[3],dcosijldrj[3],dcosijldrl[3];
  double rjk[3], ril[3];
  double fi[3],fj[3],fk[3],fl[3];
  double PijS, PjiS;
  int *REBO_neighs,*REBO_neighs_i,*REBO_neighs_j,*REBO_neighs_k,*REBO_neighs_l;

  double **x = atom->x;
  int *type = atom->type;

  atomi = i;
  atomj = j;
  itype = map[type[i]];
  jtype = map[type[j]];
  wij = Sp(rijmag,rcmin[itype][jtype],rcmax[itype][jtype],dwij);
  NijM = nM[i];
  NijS = nS[i];
  NjiM = nM[j];
  NjiS = nS[j];
  bij = 0.0;
  tmp = 0.0;
  tmp2 = 0.0;
  dgdc = 0.0;
  Etmp = 0.0;

  REBO_neighs = REBO_firstneigh[i];
  for (k = 0; k < REBO_numneigh[i]; k++) {
    atomk = REBO_neighs[k];
    if (atomk != atomj) {
      ktype = map[type[atomk]];
      rik[0] = x[atomi][0]-x[atomk][0];
      rik[1] = x[atomi][1]-x[atomk][1];
      rik[2] = x[atomi][2]-x[atomk][2];
      rikmag = sqrt((rik[0]*rik[0])+(rik[1]*rik[1])+(rik[2]*rik[2]));
      wik = Sp(rikmag,rcmin[itype][ktype],rcmax[itype][ktype],dS);
      cosjik = ((rij[0]*rik[0])+(rij[1]*rik[1])+(rij[2]*rik[2])) / (rijmag*rikmag);
      cosjik = MIN(cosjik,1.0);
      cosjik = MAX(cosjik,-1.0);

      // evaluate g and derivative dg

      g = gSpline(cosjik,itype,&dgdc);
      Etmp = Etmp+(wik*g);
    }
  }

  PijS = 0.0;
  dp = 0.0;
  PijS = PijSpline(NijM,NijS,itype,&dp);
  pij = pow(1.0+Etmp+PijS,-0.5);
  tmp = -0.5*pow(pij,3.0);

  // derivative calculations

  REBO_neighs = REBO_firstneigh[i];
  for (k = 0; k < REBO_numneigh[i]; k++) {
    atomk = REBO_neighs[k];
    if (atomk != atomj) {
      ktype = map[type[atomk]];
      rik[0] = x[atomi][0]-x[atomk][0];
      rik[1] = x[atomi][1]-x[atomk][1];
      rik[2] = x[atomi][2]-x[atomk][2];
      rikmag = sqrt((rik[0]*rik[0])+(rik[1]*rik[1])+(rik[2]*rik[2]));
      wik = Sp(rikmag,rcmin[itype][ktype],rcmax[itype][ktype],dwik);
      cosjik = (rij[0]*rik[0] + rij[1]*rik[1] + rij[2]*rik[2]) / (rijmag*rikmag);
      cosjik = MIN(cosjik,1.0);
      cosjik = MAX(cosjik,-1.0);

      dcosjikdri[0] = ((rij[0]+rik[0])/(rijmag*rikmag)) -
        (cosjik*((rij[0]/(rijmag*rijmag))+(rik[0]/(rikmag*rikmag))));
      dcosjikdri[1] = ((rij[1]+rik[1])/(rijmag*rikmag)) -
        (cosjik*((rij[1]/(rijmag*rijmag))+(rik[1]/(rikmag*rikmag))));
      dcosjikdri[2] = ((rij[2]+rik[2])/(rijmag*rikmag)) -
        (cosjik*((rij[2]/(rijmag*rijmag))+(rik[2]/(rikmag*rikmag))));
      dcosjikdrk[0] = (-rij[0]/(rijmag*rikmag)) +
        (cosjik*(rik[0]/(rikmag*rikmag)));
      dcosjikdrk[1] = (-rij[1]/(rijmag*rikmag)) +
        (cosjik*(rik[1]/(rikmag*rikmag)));
      dcosjikdrk[2] = (-rij[2]/(rijmag*rikmag)) +
        (cosjik*(rik[2]/(rikmag*rikmag)));
      dcosjikdrj[0] = (-rik[0]/(rijmag*rikmag)) +
        (cosjik*(rij[0]/(rijmag*rijmag)));
      dcosjikdrj[1] = (-rik[1]/(rijmag*rikmag)) +
        (cosjik*(rij[1]/(rijmag*rijmag)));
      dcosjikdrj[2] = (-rik[2]/(rijmag*rikmag)) +
        (cosjik*(rij[2]/(rijmag*rijmag)));

      g = gSpline(cosjik,itype,&dgdc);
      tmp2 = VA*0.5*(tmp*wik*dgdc);
      fj[0] = -tmp2*dcosjikdrj[0];
      fj[1] = -tmp2*dcosjikdrj[1];
      fj[2] = -tmp2*dcosjikdrj[2];
      fi[0] = -tmp2*dcosjikdri[0];
      fi[1] = -tmp2*dcosjikdri[1];
      fi[2] = -tmp2*dcosjikdri[2];
      fk[0] = -tmp2*dcosjikdrk[0];
      fk[1] = -tmp2*dcosjikdrk[1];
      fk[2] = -tmp2*dcosjikdrk[2];

      // coordination forces

      // dwik forces (from partial derivative)

      tmp2 = VA*0.5*(tmp*dwik*g)/rikmag;
      fi[0] -= tmp2*rik[0];
      fi[1] -= tmp2*rik[1];
      fi[2] -= tmp2*rik[2];
      fk[0] += tmp2*rik[0];
      fk[1] += tmp2*rik[1];
      fk[2] += tmp2*rik[2];

      // PIJ forces (from coordination P(N) term)

      tmp2 = VA*0.5*(tmp*dp*dwik)/rikmag;
      fi[0] -= tmp2*rik[0];
      fi[1] -= tmp2*rik[1];
      fi[2] -= tmp2*rik[2];
      fk[0] += tmp2*rik[0];
      fk[1] += tmp2*rik[1];
      fk[2] += tmp2*rik[2];

      // dgdN forces are removed

      f[atomi][0] += fi[0]; f[atomi][1] += fi[1]; f[atomi][2] += fi[2];
      f[atomj][0] += fj[0]; f[atomj][1] += fj[1]; f[atomj][2] += fj[2];
      f[atomk][0] += fk[0]; f[atomk][1] += fk[1]; f[atomk][2] += fk[2];

      if (vflag_atom) {
        rji[0] = -rij[0]; rji[1] = -rij[1]; rji[2] = -rij[2];
        rki[0] = -rik[0]; rki[1] = -rik[1]; rki[2] = -rik[2];
        v_tally3(atomi,atomj,atomk,fj,fk,rji,rki);
      }
    }
  }

///////////////////////////////
      // PIJ force contribution additional term
      tmp2 = VA*0.5*(tmp*dp*dwij)/rijmag;
      fi[0] = -tmp2*rij[0];
      fi[1] = -tmp2*rij[1];
      fi[2] = -tmp2*rij[2];
      fj[0] = tmp2*rij[0];
      fj[1] = tmp2*rij[1];
      fj[2] = tmp2*rij[2];

      f[atomi][0] += fi[0]; f[atomi][1] += fi[1]; f[atomi][2] += fi[2];
      f[atomj][0] += fj[0]; f[atomj][1] += fj[1]; f[atomj][2] += fj[2];
///////////////////////////////

  tmp = 0.0;
  tmp2 = 0.0;
  Etmp = 0.0;

  REBO_neighs = REBO_firstneigh[j];
  for (l = 0; l < REBO_numneigh[j]; l++) {
    atoml = REBO_neighs[l];
    if (atoml != atomi) {
      ltype = map[type[atoml]];
      rjl[0] = x[atomj][0]-x[atoml][0];
      rjl[1] = x[atomj][1]-x[atoml][1];
      rjl[2] = x[atomj][2]-x[atoml][2];
      rjlmag = sqrt((rjl[0]*rjl[0])+(rjl[1]*rjl[1])+(rjl[2]*rjl[2]));
      wjl = Sp(rjlmag,rcmin[jtype][ltype],rcmax[jtype][ltype],dS);
      cosijl = -1.0*((rij[0]*rjl[0])+(rij[1]*rjl[1])+(rij[2]*rjl[2])) / (rijmag*rjlmag);
      cosijl = MIN(cosijl,1.0);
      cosijl = MAX(cosijl,-1.0);

      // evaluate g and derivative dg

      g = gSpline(cosijl,jtype,&dgdc);
      Etmp = Etmp+(wjl*g);
    }
  }

  PjiS = 0.0;
  dp = 0.0;
  PjiS = PijSpline(NjiM,NjiS,jtype,&dp);
  pji = pow(1.0+Etmp+PjiS,-0.5);
  tmp = -0.5*pow(pji,3.0);

  REBO_neighs = REBO_firstneigh[j];
  for (l = 0; l < REBO_numneigh[j]; l++) {
    atoml = REBO_neighs[l];
    if (atoml != atomi) {
      ltype = map[type[atoml]];
      rjl[0] = x[atomj][0]-x[atoml][0];
      rjl[1] = x[atomj][1]-x[atoml][1];
      rjl[2] = x[atomj][2]-x[atoml][2];
      rjlmag = sqrt((rjl[0]*rjl[0])+(rjl[1]*rjl[1])+(rjl[2]*rjl[2]));
      wjl = Sp(rjlmag,rcmin[jtype][ltype],rcmax[jtype][ltype],dwjl);
      cosijl = (-1.0*((rij[0]*rjl[0])+(rij[1]*rjl[1])+(rij[2]*rjl[2]))) / (rijmag*rjlmag);
      cosijl = MIN(cosijl,1.0);
      cosijl = MAX(cosijl,-1.0);

      dcosijldri[0] = (-rjl[0]/(rijmag*rjlmag)) -
        (cosijl*rij[0]/(rijmag*rijmag));
      dcosijldri[1] = (-rjl[1]/(rijmag*rjlmag)) -
        (cosijl*rij[1]/(rijmag*rijmag));
      dcosijldri[2] = (-rjl[2]/(rijmag*rjlmag)) -
        (cosijl*rij[2]/(rijmag*rijmag));
      dcosijldrj[0] = ((-rij[0]+rjl[0])/(rijmag*rjlmag)) +
        (cosijl*((rij[0]/pow(rijmag,2.0))-(rjl[0]/(rjlmag*rjlmag))));
      dcosijldrj[1] = ((-rij[1]+rjl[1])/(rijmag*rjlmag)) +
        (cosijl*((rij[1]/pow(rijmag,2.0))-(rjl[1]/(rjlmag*rjlmag))));
      dcosijldrj[2] = ((-rij[2]+rjl[2])/(rijmag*rjlmag)) +
        (cosijl*((rij[2]/pow(rijmag,2.0))-(rjl[2]/(rjlmag*rjlmag))));
      dcosijldrl[0] = (rij[0]/(rijmag*rjlmag))+(cosijl*rjl[0]/(rjlmag*rjlmag));
      dcosijldrl[1] = (rij[1]/(rijmag*rjlmag))+(cosijl*rjl[1]/(rjlmag*rjlmag));
      dcosijldrl[2] = (rij[2]/(rijmag*rjlmag))+(cosijl*rjl[2]/(rjlmag*rjlmag));

      // evaluate g and derivatives dg

      g = gSpline(cosijl,jtype,&dgdc);
      tmp2 = VA*0.5*(tmp*wjl*dgdc);
      fi[0] = -tmp2*dcosijldri[0];
      fi[1] = -tmp2*dcosijldri[1];
      fi[2] = -tmp2*dcosijldri[2];
      fj[0] = -tmp2*dcosijldrj[0];
      fj[1] = -tmp2*dcosijldrj[1];
      fj[2] = -tmp2*dcosijldrj[2];
      fl[0] = -tmp2*dcosijldrl[0];
      fl[1] = -tmp2*dcosijldrl[1];
      fl[2] = -tmp2*dcosijldrl[2];

      // coordination forces

      // dwik forces (from partial derivative)

      tmp2 = VA*0.5*(tmp*dwjl*g)/rjlmag;
      fj[0] -= tmp2*rjl[0];
      fj[1] -= tmp2*rjl[1];
      fj[2] -= tmp2*rjl[2];
      fl[0] += tmp2*rjl[0];
      fl[1] += tmp2*rjl[1];
      fl[2] += tmp2*rjl[2];

      // PIJ forces (coordination)

      tmp2 = VA*0.5*(tmp*dp*dwjl)/rjlmag;
      fj[0] -= tmp2*rjl[0];
      fj[1] -= tmp2*rjl[1];
      fj[2] -= tmp2*rjl[2];
      fl[0] += tmp2*rjl[0];
      fl[1] += tmp2*rjl[1];
      fl[2] += tmp2*rjl[2];

      // dgdN forces are removed

      f[atomi][0] += fi[0]; f[atomi][1] += fi[1]; f[atomi][2] += fi[2];
      f[atomj][0] += fj[0]; f[atomj][1] += fj[1]; f[atomj][2] += fj[2];
      f[atoml][0] += fl[0]; f[atoml][1] += fl[1]; f[atoml][2] += fl[2];

      if (vflag_atom) {
        rlj[0] = -rjl[0]; rlj[1] = -rjl[1]; rlj[2] = -rjl[2];
        v_tally3(atomi,atomj,atoml,fi,fl,rij,rlj);
      }
    }
  }

///////////////////////////////
      // PIJ force contribution additional term
      tmp2 = VA*0.5*(tmp*dp*dwij)/rijmag;
      fj[0] = -tmp2*(-rij[0]);
      fj[1] = -tmp2*(-rij[1]);
      fj[2] = -tmp2*(-rij[2]);
      fi[0] = tmp2*(-rij[0]);
      fi[1] = tmp2*(-rij[1]);
      fi[2] = tmp2*(-rij[2]);

      // summing over force contributions
      f[atomi][0] += fi[0]; f[atomi][1] += fi[1]; f[atomi][2] += fi[2];
      f[atomj][0] += fj[0]; f[atomj][1] += fj[1]; f[atomj][2] += fj[2];
//////////////////////////////

  bij = (0.5*(pij+pji));
  return bij;
}

/* ----------------------------------------------------------------------
   G calculation
------------------------------------------------------------------------- */

double PairREBOMoS::gSpline(double costh, int typei, double *dgdc)
{
  double g, gcos, psi, gamma;
  double dgcos, dpsi, dgamma;

  g = 0.0;
  psi = 0.0;
  gamma = 0.0;
  gcos = 0.0;
  dgcos   = 0.0;
  dpsi = 0.0;
  dgamma = 0.0;
  *dgdc = 0.0;

  if (costh >= -1.0 && costh < 0.5){
        g = b0[typei] + b1[typei]*costh + b2[typei]*pow(costh,2) + b3[typei]*pow(costh,3) + b4[typei]*pow(costh,4) + b5[typei]*pow(costh,5) + b6[typei]*pow(costh,6);
        *dgdc = b1[typei] + 2*b2[typei]*costh + 3*b3[typei]*pow(costh,2) + 4*b4[typei]*pow(costh,3) + 5*b5[typei]*pow(costh,4) + 6*b6[typei]*pow(costh,5);
        }
  else if (costh >= 0.5 && costh <= 1.0){
        gcos = b0[typei] + b1[typei]*costh + b2[typei]*pow(costh,2) + b3[typei]*pow(costh,3) + b4[typei]*pow(costh,4) + b5[typei]*pow(costh,5) + b6[typei]*pow(costh,6);
        dgcos = b1[typei] + 2*b2[typei]*costh + 3*b3[typei]*pow(costh,2) + 4*b4[typei]*pow(costh,3) + 5*b5[typei]*pow(costh,4) + 6*b6[typei]*pow(costh,5);

        psi = 0.5*(1 - cos(2*PI*(costh - 0.5)));
        dpsi = PI*sin(2*PI*(costh - 0.5));

        gamma = bg0[typei] + bg1[typei]*costh + bg2[typei]*pow(costh,2) + bg3[typei]*pow(costh,3) + bg4[typei]*pow(costh,4) + bg5[typei]*pow(costh,5) + bg6[typei]*pow(costh,6);
        dgamma = bg1[typei] + 2*bg2[typei]*costh + 3*bg3[typei]*pow(costh,2) + 4*bg4[typei]*pow(costh,3) + 5*bg5[typei]*pow(costh,4) + 6*bg6[typei]*pow(costh,5);

        g = gcos + psi*(gamma - gcos);
        *dgdc = dgcos + dpsi*(gamma - gcos) + psi*(dgamma - dgcos);
        }

return g;
}

/* ----------------------------------------------------------------------
   Pij calculation
------------------------------------------------------------------------- */

double PairREBOMoS::PijSpline(double NM, double NS, int typei, double *dp)
{
  double Pij;
  double N;

  N = NM + NS;
  *dp = 0.0;

  Pij = -a0[typei]*(N - 1) - a1[typei]*exp(-a2[typei]*N) + a3[typei];
  *dp = -a0[typei] + a1[typei]*a2[typei]*exp(-a2[typei]*N);

  return Pij;
}

/* ----------------------------------------------------------------------
   add pages to REBO neighbor list
------------------------------------------------------------------------- */

void PairREBOMoS::add_pages(int howmany)
{
  int toppage = maxpage;
  maxpage += howmany*PGDELTA;

  pages = (int **)
    memory->srealloc(pages,maxpage*sizeof(int *),"rebomos:pages");
  for (int i = toppage; i < maxpage; i++)
    memory->create(pages[i],pgsize,"rebomos:pages[i]");
}

/* ----------------------------------------------------------------------
   read REBO potential file
------------------------------------------------------------------------- */

void PairREBOMoS::read_file(char *filename)
{
  int i,j,k,l,limit;
  char s[MAXLINE];

  // REBO Parameters (Mo-S REBO)

  double rcmin_MM,rcmin_MS,rcmin_SS,rcmax_MM,rcmax_MS,rcmax_SS;
  double rcmaxp_MM,rcmaxp_MS,rcmaxp_SS;
  double Q_MM,Q_MS,Q_SS,alpha_MM,alpha_MS,alpha_SS,A_MM,A_MS,A_SS;
  double BIJc_MM1,BIJc_MS1,BIJc_SS1;
  double Beta_MM1,Beta_MS1,Beta_SS1;
  double M_bg0,M_bg1,M_bg2,M_bg3,M_bg4,M_bg5,M_bg6;
  double S_bg0,S_bg1,S_bg2,S_bg3,S_bg4,S_bg5,S_bg6;
  double M_b0,M_b1,M_b2,M_b3,M_b4,M_b5,M_b6;
  double S_b0,S_b1,S_b2,S_b3,S_b4,S_b5,S_b6;
  double M_a0,M_a1,M_a2,M_a3;
  double S_a0,S_a1,S_a2,S_a3;

  // LJ Parameters (Mo-S REBO)

  double rcLJmin_MM,rcLJmin_MS,rcLJmin_SS,rcLJmax_MM,rcLJmax_MS,rcLJmax_SS;
  double epsilon_MM,epsilon_MS,epsilon_SS;
  double sigma_MM,sigma_MS,sigma_SS;

  MPI_Comm_rank(world,&me);

  // read file on proc 0

  if (me == 0) {
    FILE *fp = fopen(filename,"r");
    if (fp == NULL) {
      char str[128];
      sprintf(str,"Cannot open MoS-REBO potential file %s",filename);
      error->one(FLERR,str);
    }

    // skip initial comment lines

    while (1) {
      fgets(s,MAXLINE,fp);
      if (s[0] != '#') break;
    }

    // read parameters

    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&rcmin_MM);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&rcmin_MS);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&rcmin_SS);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&rcmax_MM);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&rcmax_MS);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&rcmax_SS);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&Q_MM);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&Q_MS);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&Q_SS);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&alpha_MM);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&alpha_MS);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&alpha_SS);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&A_MM);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&A_MS);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&A_SS);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&BIJc_MM1);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&BIJc_MS1);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&BIJc_SS1);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&Beta_MM1);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&Beta_MS1);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&Beta_SS1);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&M_b0);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&M_b1);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&M_b2);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&M_b3);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&M_b4);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&M_b5);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&M_b6);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&M_bg0);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&M_bg1);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&M_bg2);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&M_bg3);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&M_bg4);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&M_bg5);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&M_bg6);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&S_b0);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&S_b1);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&S_b2);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&S_b3);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&S_b4);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&S_b5);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&S_b6);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&S_bg0);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&S_bg1);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&S_bg2);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&S_bg3);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&S_bg4);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&S_bg5);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&S_bg6);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&M_a0);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&M_a1);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&M_a2);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&M_a3);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&S_a0);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&S_a1);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&S_a2);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&S_a3);

    // LJ parameters

    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&epsilon_MM);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&epsilon_SS);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&sigma_MM);
    fgets(s,MAXLINE,fp);
    sscanf(s,"%lg",&sigma_SS);

    fclose(fp);
  }

  // store read-in values in arrays

  if (me == 0) {

    // REBO

    rcmin[0][0] = rcmin_MM;
    rcmin[0][1] = rcmin_MS;
    rcmin[1][0] = rcmin[0][1];
    rcmin[1][1] = rcmin_SS;

    rcmax[0][0] = rcmax_MM;
    rcmax[0][1] = rcmax_MS;
    rcmax[1][0] = rcmax[0][1];
    rcmax[1][1] = rcmax_SS;

    rcmaxsq[0][0] = rcmax[0][0]*rcmax[0][0];
    rcmaxsq[1][0] = rcmax[1][0]*rcmax[1][0];
    rcmaxsq[0][1] = rcmax[0][1]*rcmax[0][1];
    rcmaxsq[1][1] = rcmax[1][1]*rcmax[1][1];

    Q[0][0] = Q_MM;
    Q[0][1] = Q_MS;
    Q[1][0] = Q[0][1];
    Q[1][1] = Q_SS;

    alpha[0][0] = alpha_MM;
    alpha[0][1] = alpha_MS;
    alpha[1][0] = alpha[0][1];
    alpha[1][1] = alpha_SS;

    A[0][0] = A_MM;
    A[0][1] = A_MS;
    A[1][0] = A[0][1];
    A[1][1] = A_SS;

    BIJc[0][0] = BIJc_MM1;
    BIJc[0][1] = BIJc_MS1;
    BIJc[1][0] = BIJc_MS1;
    BIJc[1][1] = BIJc_SS1;

    Beta[0][0] = Beta_MM1;
    Beta[0][1] = Beta_MS1;
    Beta[1][0] = Beta_MS1;
    Beta[1][1] = Beta_SS1;

    b0[0] = M_b0;
    b1[0] = M_b1;
    b2[0] = M_b2;
    b3[0] = M_b3;
    b4[0] = M_b4;
    b5[0] = M_b5;
    b6[0] = M_b6;

    bg0[0] = M_bg0;
    bg1[0] = M_bg1;
    bg2[0] = M_bg2;
    bg3[0] = M_bg3;
    bg4[0] = M_bg4;
    bg5[0] = M_bg5;
    bg6[0] = M_bg6;

    b0[1] = S_b0;
    b1[1] = S_b1;
    b2[1] = S_b2;
    b3[1] = S_b3;
    b4[1] = S_b4;
    b5[1] = S_b5;
    b6[1] = S_b6;

    bg0[1] = S_bg0;
    bg1[1] = S_bg1;
    bg2[1] = S_bg2;
    bg3[1] = S_bg3;
    bg4[1] = S_bg4;
    bg5[1] = S_bg5;
    bg6[1] = S_bg6;

    a0[0] = M_a0;
    a1[0] = M_a1;
    a2[0] = M_a2;
    a3[0] = M_a3;

    a0[1] = S_a0;
    a1[1] = S_a1;
    a2[1] = S_a2;
    a3[1] = S_a3;

    // LJ

    sigma[0][0] = sigma_MM;
    sigma[0][1] = (sigma_MM + sigma_SS)/2;
    sigma[1][0] = sigma[0][1];
    sigma[1][1] = sigma_SS;

    epsilon[0][0] = epsilon_MM;
    epsilon[0][1] = sqrt(epsilon_MM*epsilon_SS);
    epsilon[1][0] = epsilon[0][1];
    epsilon[1][1] = epsilon_SS;

    rcLJmin[0][0] = rcmin_MM;
    rcLJmin[0][1] = rcmin_MS;
    rcLJmin[1][0] = rcmin[0][1];
    rcLJmin[1][1] = rcmin_SS;

    rcLJmax[0][0] = 2.5*sigma[0][0];
    rcLJmax[0][1] = 2.5*sigma[0][1];
    rcLJmax[1][0] = rcLJmax[0][1];
    rcLJmax[1][1] = 2.5*sigma[1][1];

    rcLJmaxsq[0][0] = rcLJmax[0][0]*rcLJmax[0][0];
    rcLJmaxsq[1][0] = rcLJmax[1][0]*rcLJmax[1][0];
    rcLJmaxsq[0][1] = rcLJmax[0][1]*rcLJmax[0][1];
    rcLJmaxsq[1][1] = rcLJmax[1][1]*rcLJmax[1][1];

  }

  // broadcast read-in and setup values

  MPI_Bcast(&rcmin[0][0],4,MPI_DOUBLE,0,world);
  MPI_Bcast(&rcmax[0][0],4,MPI_DOUBLE,0,world);
  MPI_Bcast(&rcmaxsq[0][0],4,MPI_DOUBLE,0,world);
  MPI_Bcast(&rcmaxp[0][0],4,MPI_DOUBLE,0,world);

  MPI_Bcast(&Q[0][0],4,MPI_DOUBLE,0,world);
  MPI_Bcast(&alpha[0][0],4,MPI_DOUBLE,0,world);
  MPI_Bcast(&A[0][0],4,MPI_DOUBLE,0,world);
  MPI_Bcast(&BIJc[0][0],4,MPI_DOUBLE,0,world);
  MPI_Bcast(&Beta[0][0],4,MPI_DOUBLE,0,world);

  MPI_Bcast(&b0[0],2,MPI_DOUBLE,0,world);
  MPI_Bcast(&b1[0],2,MPI_DOUBLE,0,world);
  MPI_Bcast(&b2[0],2,MPI_DOUBLE,0,world);
  MPI_Bcast(&b3[0],2,MPI_DOUBLE,0,world);
  MPI_Bcast(&b4[0],2,MPI_DOUBLE,0,world);
  MPI_Bcast(&b5[0],2,MPI_DOUBLE,0,world);
  MPI_Bcast(&b6[0],2,MPI_DOUBLE,0,world);

  MPI_Bcast(&a0[0],2,MPI_DOUBLE,0,world);
  MPI_Bcast(&a1[0],2,MPI_DOUBLE,0,world);
  MPI_Bcast(&a2[0],2,MPI_DOUBLE,0,world);
  MPI_Bcast(&a3[0],2,MPI_DOUBLE,0,world);

  MPI_Bcast(&bg0[0],1,MPI_DOUBLE,0,world);
  MPI_Bcast(&bg1[0],1,MPI_DOUBLE,0,world);
  MPI_Bcast(&bg2[0],1,MPI_DOUBLE,0,world);
  MPI_Bcast(&bg3[0],1,MPI_DOUBLE,0,world);
  MPI_Bcast(&bg4[0],1,MPI_DOUBLE,0,world);
  MPI_Bcast(&bg5[0],1,MPI_DOUBLE,0,world);
  MPI_Bcast(&bg6[0],1,MPI_DOUBLE,0,world);

  MPI_Bcast(&rcLJmin[0][0],4,MPI_DOUBLE,0,world);
  MPI_Bcast(&rcLJmax[0][0],4,MPI_DOUBLE,0,world);
  MPI_Bcast(&rcLJmaxsq[0][0],4,MPI_DOUBLE,0,world); 
  MPI_Bcast(&epsilon[0][0],4,MPI_DOUBLE,0,world);
  MPI_Bcast(&sigma[0][0],4,MPI_DOUBLE,0,world);
}

/* ----------------------------------------------------------------------
   memory usage of local atom-based arrays
------------------------------------------------------------------------- */

double PairREBOMoS::memory_usage()
{
  double bytes = 0.0;
  bytes += maxlocal * sizeof(int);
  bytes += maxlocal * sizeof(int *);
  bytes += maxpage * neighbor->pgsize * sizeof(int);
  bytes += 3 * maxlocal * sizeof(double);
  return bytes;
}
