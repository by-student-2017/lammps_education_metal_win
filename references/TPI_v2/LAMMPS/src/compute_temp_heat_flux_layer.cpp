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
This is a modification to compute_heat_flux in which the system is divided into 
'nlayer' layers or bins along x-direction, and then temperature and x-component 
of heat current (heat flux * volume of layer) vector for each layer (bins) is 
computed. 
   
Contributing author: Amit Singh (University of Minnesota) 
------------------------------------------------------------------------- */

#include "mpi.h"
#include "stdlib.h"
#include "string.h"
#include "math.h"
#include "compute_temp_heat_flux_layer.h"
#include "neighbor.h"
#include "neigh_list.h"
#include "neigh_request.h"
#include "atom.h"
#include "atom_vec.h"
#include "force.h"
#include "pair.h"
#include "domain.h"
#include "lattice.h"
#include "modify.h"
#include "fix.h"
#include "group.h"
#include "comm.h"
#include "region.h"
#include "memory.h"
#include "error.h"
#include "update.h"
#include "input.h"

using namespace LAMMPS_NS;

#define INVOKED_PERATOM 8
#define OUTDIM 2 
/* ---------------------------------------------------------------------- */

ComputeTempHeatFluxLayer::ComputeTempHeatFluxLayer(LAMMPS *lmp, int narg, char **arg) : 
  Compute(lmp, narg, arg)
{
  if (narg < 6) error->all(FLERR,"Illegal compute/temp/heat/flux/layer command");

  MPI_Comm_rank(world,&me);

  nlayers  = force->numeric(FLERR,arg[5]);
  vector_flag = 1;
  size_vector = OUTDIM*nlayers;
  extvector = 1;

  // store pe/atom ID used by heat flux computation
  // insure it is valid for pe/atom computation

  int n = strlen(arg[3]) + 1;
  id_pe = new char[n];
  strcpy(id_pe,arg[3]);

  n = strlen(arg[4]) + 1;
  id_stress = new char[n];
  strcpy(id_stress,arg[4]);

  int ipe = modify->find_compute(id_pe);
  int istress = modify->find_compute(id_stress);
  if (ipe < 0 || istress < 0)
    error->all(FLERR,"Could not find compute temp/heat/flux/layer compute ID");
  if (modify->compute[ipe]->peatomflag == 0)
    error->all(FLERR,"Compute temp/heat/flux/layer compute ID does not compute pe/atom");
  if (modify->compute[istress]->pressatomflag == 0)
    error->all(FLERR,"Compute temp/heat/flux/layer compute ID does not compute stress/atom");

  dim = 0;

  // optional args
  
  angmomflag = 0;
  
  int iarg = 6; 
  while (iarg < narg) {
    if (strcmp(arg[iarg],"angmom") == 0) {
      if (iarg+2 > narg) error->all(FLERR,"Illegal compute/temp/heat/flux/layer command");
      if (strcmp(arg[iarg+1],"no") == 0) angmomflag = 0;
      else if (strcmp(arg[iarg+1],"yes") == 0) angmomflag = 1;
      else error->all(FLERR,"Illegal compute/temp/heat/flux/layer command");
      iarg += 2;
    } else error->all(FLERR,"Illegal compute/temp/heat/flux/layer command");
  }
  
  totalatom = (int)atom->natoms;
  vector = new double[size_vector];

  count_one = new double[nlayers];
  count_many = new double[nlayers];
  layer = new int[totalatom]; 
}

/* ---------------------------------------------------------------------- */

ComputeTempHeatFluxLayer::~ComputeTempHeatFluxLayer()
{
  delete [] id_pe;
  delete [] id_stress;
  delete [] vector;
  delete [] layer;
  delete [] count_one;
  delete [] count_many;
}

/* ---------------------------------------------------------------------- */

void ComputeTempHeatFluxLayer::init()
{

  int ipe = modify->find_compute(id_pe);
  int istress = modify->find_compute(id_stress);
  if (ipe < 0 || istress < 0)
    error->all(FLERR,"Could not find compute temp/heat/flux/layer compute ID");

  c_pe = modify->compute[ipe];
  c_stress = modify->compute[istress];

  fix_dof = 0;
  for (int i = 0; i < modify->nfix; i++)
    fix_dof += modify->fix[i]->dof(igroup);
  
  // Divide into nlayers
  triclinic = domain->triclinic;

  if (triclinic) {
    boxlo = domain->boxlo_lamda;
    boxhi = domain->boxhi_lamda;
    prd = domain->prd_lamda;
  } else {
    boxlo = domain->boxlo;
    boxhi = domain->boxhi;
    prd = domain->prd;
  }
}
/* ---------------------------------------------------------------------- */

void ComputeTempHeatFluxLayer::dof_compute()
{
  double natoms = group->count(igroup);
  dof = domain->dimension * natoms;
  if (dof > 0.0) tfactor = force->mvv2e / (dof * force->boltz);
  else tfactor = 0.0;
}

/* ---------------------------------------------------------------------- */

void ComputeTempHeatFluxLayer::xvcm(int ilayer, double *cmx, double *cmv, int *layer)
{
  double **x = atom->x;
  double **v = atom->v;
  int *image = atom->image;
  int *type = atom->type;
  double *mass = atom->mass;
  double *rmass = atom->rmass;
  int nlocal = atom->nlocal;

  double cmone[3],p[3];
  cmone[0] = cmone[1] = cmone[2] = 0.0;
  p[0] = p[1] = p[2] = 0.0;
  double xprd = domain->xprd;
  double yprd = domain->yprd;
  double zprd = domain->zprd;

  int xbox,ybox,zbox;
  double massone;

  double one = 0.0;

  if (mass) {
    for (int i = 0; i < nlocal; i++)
      if (layer[i]==ilayer) {
        xbox = (image[i] & 1023) - 512;
        ybox = (image[i] >> 10 & 1023) - 512;
        zbox = (image[i] >> 20) - 512;
        massone = mass[type[i]];
        cmone[0] += (x[i][0] + xbox*xprd) * massone;
        cmone[1] += (x[i][1] + ybox*yprd) * massone;
        cmone[2] += (x[i][2] + zbox*zprd) * massone;
        p[0] += v[i][0]*massone;
        p[1] += v[i][1]*massone;
        p[2] += v[i][2]*massone;
        one += massone;
      }
  } else {
    for (int i = 0; i < nlocal; i++)
      if (layer[i]==ilayer) {
        xbox = (image[i] & 1023) - 512;
        ybox = (image[i] >> 10 & 1023) - 512;
        zbox = (image[i] >> 20) - 512;
        massone = rmass[i];
        cmone[0] += (x[i][0] + xbox*xprd) * massone;
        cmone[1] += (x[i][1] + ybox*yprd) * massone;
        cmone[2] += (x[i][2] + zbox*zprd) * massone;
        p[0] += v[i][0]*massone;
        p[1] += v[i][1]*massone;
        p[2] += v[i][2]*massone;
        one += massone;
      }
  }

  MPI_Allreduce(cmone,cmx,3,MPI_DOUBLE,MPI_SUM,world);
  MPI_Allreduce(p,cmv,3,MPI_DOUBLE,MPI_SUM,world);

// masstotal
  double masstotal;
  MPI_Allreduce(&one,&masstotal,1,MPI_DOUBLE,MPI_SUM,world);

// xcm 
  cmx[0] /= masstotal;
  cmx[1] /= masstotal;
  cmx[2] /= masstotal;

// vcm
  cmv[0] /= masstotal;
  cmv[1] /= masstotal;
  cmv[2] /= masstotal;
}

/* ---------------------------------------------------------------------- */

void ComputeTempHeatFluxLayer::angmom(int ilayer, double *cm, double *lmom, int *layer)
{
  double **x = atom->x;
  double **v = atom->v;
  int *image = atom->image;
  int *type = atom->type;
  double *mass = atom->mass;
  double *rmass = atom->rmass;
  int nlocal = atom->nlocal;

  int xbox,ybox,zbox;
  double dx,dy,dz,massone;
  double xprd = domain->xprd;
  double yprd = domain->yprd;
  double zprd = domain->zprd;
  double p[3];
  p[0] = p[1] = p[2] = 0.0;

  for (int i = 0; i < nlocal; i++)
    if (layer[i]==ilayer) {
      xbox = (image[i] & 1023) - 512;
      ybox = (image[i] >> 10 & 1023) - 512;
      zbox = (image[i] >> 20) - 512;
      dx = (x[i][0] + xbox*xprd) - cm[0];
      dy = (x[i][1] + ybox*yprd) - cm[1];
      dz = (x[i][2] + zbox*zprd) - cm[2];
      if (mass) massone = mass[type[i]];
      else massone = rmass[i];
      p[0] += massone * (dy*v[i][2] - dz*v[i][1]);
      p[1] += massone * (dz*v[i][0] - dx*v[i][2]);
      p[2] += massone * (dx*v[i][1] - dy*v[i][0]);
    }

  MPI_Allreduce(p,lmom,3,MPI_DOUBLE,MPI_SUM,world);
}

/* ---------------------------------------------------------------------- */

void ComputeTempHeatFluxLayer::inertia(int ilayer, double *cm, double itensor[3][3], int *layer)
{
  int i,j;

  double **x = atom->x;
  int *image = atom->image;
  int *type = atom->type;
  double *mass = atom->mass;
  double *rmass = atom->rmass;
  int nlocal = atom->nlocal;

  int xbox,ybox,zbox;
  double dx,dy,dz,massone;
  double xprd = domain->xprd;
  double yprd = domain->yprd;
  double zprd = domain->zprd;
  double ione[3][3];
  for (i = 0; i < 3; i++)
    for (j = 0; j < 3; j++)
      ione[i][j] = 0.0;

  for (i = 0; i < nlocal; i++)
    if (layer[i]==ilayer) {
      xbox = (image[i] & 1023) - 512;
      ybox = (image[i] >> 10 & 1023) - 512;
      zbox = (image[i] >> 20) - 512;
      dx = (x[i][0] + xbox*xprd) - cm[0];
      dy = (x[i][1] + ybox*yprd) - cm[1];
      dz = (x[i][2] + zbox*zprd) - cm[2];
      if (mass) massone = mass[type[i]];
      else massone = rmass[i];
      ione[0][0] += massone * (dy*dy + dz*dz);
      ione[1][1] += massone * (dx*dx + dz*dz);
      ione[2][2] += massone * (dx*dx + dy*dy);
      ione[0][1] -= massone * dx*dy;
      ione[1][2] -= massone * dy*dz;
      ione[0][2] -= massone * dx*dz;
    }
  ione[1][0] = ione[0][1];
  ione[2][1] = ione[1][2];
  ione[2][0] = ione[0][2];

  MPI_Allreduce(&ione[0][0],&itensor[0][0],9,MPI_DOUBLE,MPI_SUM,world);
}

/* ---------------------------------------------------------------------- */

void ComputeTempHeatFluxLayer::omega(double *angmom, double inertia[3][3], double *w)
{
  double inverse[3][3];

  inverse[0][0] = inertia[1][1]*inertia[2][2] - inertia[1][2]*inertia[2][1];
  inverse[0][1] = -(inertia[0][1]*inertia[2][2] - inertia[0][2]*inertia[2][1]);
  inverse[0][2] = inertia[0][1]*inertia[1][2] - inertia[0][2]*inertia[1][1];

  inverse[1][0] = -(inertia[1][0]*inertia[2][2] - inertia[1][2]*inertia[2][0]);
  inverse[1][1] = inertia[0][0]*inertia[2][2] - inertia[0][2]*inertia[2][0];
  inverse[1][2] = -(inertia[0][0]*inertia[1][2] - inertia[0][2]*inertia[1][0]);

  inverse[2][0] = inertia[1][0]*inertia[2][1] - inertia[1][1]*inertia[2][0];
  inverse[2][1] = -(inertia[0][0]*inertia[2][1] - inertia[0][1]*inertia[2][0]);
  inverse[2][2] = inertia[0][0]*inertia[1][1] - inertia[0][1]*inertia[1][0];

  double determinant = inertia[0][0]*inertia[1][1]*inertia[2][2] +
    inertia[0][1]*inertia[1][2]*inertia[2][0] +
    inertia[0][2]*inertia[1][0]*inertia[2][1] -
    inertia[0][0]*inertia[1][2]*inertia[2][1] -
    inertia[0][1]*inertia[1][0]*inertia[2][2] -
    inertia[2][0]*inertia[1][1]*inertia[0][2];

  int i,j;
  for (i = 0; i < 3; i++)
    for (j = 0; j < 3; j++)
      inverse[i][j] /= determinant;

  w[0] = inverse[0][0]*angmom[0] + inverse[0][1]*angmom[1] +
    inverse[0][2]*angmom[2];
  w[1] = inverse[1][0]*angmom[0] + inverse[1][1]*angmom[1] +
    inverse[1][2]*angmom[2];
  w[2] = inverse[2][0]*angmom[0] + inverse[2][1]*angmom[1] +
    inverse[2][2]*angmom[2];
}

/* ---------------------------------------------------------------------- */

void ComputeTempHeatFluxLayer::compute_vector()
{
  int i,j,m,n,ilayer;
  double lo,hi;

  invoked_vector = update->ntimestep;
  
  // Divide into nlayers
  
  double *boxlo,*boxhi,*prd;
  boxlo = domain->boxlo;
  boxhi = domain->boxhi;
  prd = domain->prd;
  
  for (m = 0; m < nlayers; m++){
    count_many[m] = 0.0;
    count_one[m] = 0.0;
  }
  
  // assign each atom to a layer
  // remap each atom's relevant coord back into box via PBC if necessary
  
  double **x = atom->x;
  int *mask = atom->mask;
  int nlocal = atom->nlocal;
  
  double xremap;
  periodicity = domain->periodicity[0];
  
  if (triclinic) domain->x2lamda(nlocal);
  
  invdelta = ((double) nlayers)/prd[0];
  
  for (i = 0; i < nlocal; i++)
    if (mask[i] & groupbit) {
      xremap = x[i][0];
      if (periodicity) {
	if (xremap < boxlo[0]) xremap += prd[0];
	if (xremap >= boxhi[0]) xremap -= prd[0];
      }
      ilayer = static_cast<int> ((xremap - boxlo[0]) * invdelta);
      if (ilayer < 0) ilayer = 0;
      if (ilayer >= nlayers) ilayer = nlayers-1;
      layer[i] = ilayer;
      count_one[ilayer] += 1.0;
    }
  
  if (triclinic) domain->lamda2x(nlocal);
  
  MPI_Allreduce(count_one,count_many,nlayers,MPI_DOUBLE,MPI_SUM,world);
    
  int itype;
  double delvx,delvy,delvz;
  int ilayeri;

  int *image = atom->image;
  int xbox,ybox,zbox;
  double dx,dy,dz;
  double xprd = domain->xprd;
  double yprd = domain->yprd;
  double zprd = domain->zprd;
  double **v = atom->v;
  double **f = atom->f;
  int *type = atom->type;
  double *mass = atom->mass;
  
  /*
  double **x = atom->x;
  int *mask = atom->mask;
  int nlocal = atom->nlocal;
  */

  if (!(c_pe->invoked_flag & INVOKED_PERATOM)) {
    c_pe->compute_peratom();
    c_pe->invoked_flag |= INVOKED_PERATOM;
  }
  if (!(c_stress->invoked_flag & INVOKED_PERATOM)) {
    c_stress->compute_peratom();
    c_stress->invoked_flag |= INVOKED_PERATOM;
  }

  double t[size_vector],ke;
  for (i = 0; i < size_vector; i++) t[i] = 0.0;

  double xcm[3],vcm[3],aangmom[3],iinertia[3][3],oomega[3];

  double *pe = c_pe->vector_atom;
  double **stress = c_stress->array_atom;

  for (int ilayer=0; ilayer < nlayers; ilayer++) {

    ilayeri = OUTDIM*ilayer; 
    xvcm(ilayer,xcm,vcm,layer);
   
    /*  The angular velocity part, \omega x r, does not contribute much and
     *  can be dropped. In that case the computation of angular momentum,
     *  inertia tensor and angular velocity can be dropped as well.
    */
    if (angmomflag) { 
        angmom(ilayer,xcm,aangmom,layer);
        inertia(ilayer,xcm,iinertia,layer);
        omega(aangmom,iinertia,oomega);
    }

    for (int i = 0; i < nlocal; i++) { 
      if (layer[i]==ilayer) {
        xbox = (image[i] & 1023) - 512;
        ybox = (image[i] >> 10 & 1023) - 512;
        zbox = (image[i] >> 20) - 512;
        dx = (x[i][0] + xbox*xprd) - xcm[0];
        dy = (x[i][1] + ybox*yprd) - xcm[1];
        dz = (x[i][2] + zbox*zprd) - xcm[2];
        
        if (angmomflag) { 
            delvx = v[i][0] - vcm[0] - (oomega[1]*dz - oomega[2]*dy);
            delvy = v[i][1] - vcm[1] - (oomega[2]*dx - oomega[0]*dz);
            delvz = v[i][2] - vcm[2] - (oomega[0]*dy - oomega[1]*dx);
        }
        else {
            delvx = v[i][0] - vcm[0];
            delvy = v[i][1] - vcm[1];
            delvz = v[i][2] - vcm[2];
        }

        ke = (0.5 * force->mvv2e) * mass[type[i]] * (delvx*delvx+delvy*delvy+delvz*delvz);
       
        t[ilayeri]   +=   ke;
        t[ilayeri+1] +=   delvx * (ke + pe[i]);
        t[ilayeri+1] -=   (stress[i][0]*delvx + stress[i][3]*delvy + stress[i][4]*delvz)/force->nktv2p;  
      }
    }
  }

   MPI_Allreduce(t,vector,size_vector,MPI_DOUBLE,MPI_SUM,world);
  
  int natom; 
  for (int i = 0; i < nlayers; i++) {
    int j = i*OUTDIM;
    if (angmomflag) 
        natom = count_many[i]-2; ////3 rot + 3 linear momentum are conserved, so 6 dof will be subtracted
    else    
        natom = count_many[i]-1; ////3 linear momentum are conserved, so 6 dof will be subtracted
    vector[j] /= (1.5 * natom * force->boltz); 
  }

}

