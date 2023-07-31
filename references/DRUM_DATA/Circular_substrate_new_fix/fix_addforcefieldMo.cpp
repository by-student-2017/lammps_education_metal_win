/* ----------------------------------------------------------------------
   LAMMPS - Large-scale Atomic/Molecular Massively Parallel Simulator
   https://lammps.sandia.gov/, Sandia National Laboratories
   Steve Plimpton, sjplimp@sandia.gov

   Copyright (2003) Sandia Corporation.  Under the terms of Contract
   DE-AC04-94AL85000 with Sandia Corporation, the U.S. Government retains
   certain rights in this software.  This software is distributed under
   the GNU General Public License.

   See the README file in the top-level LAMMPS directory.
------------------------------------------------------------------------- */
#include <cmath>
#include "fix_addforcefieldMo.h"

#include "atom.h"
#include "atom_masks.h"
#include "domain.h"
#include "error.h"
#include "input.h"
#include "memory.h"
#include "modify.h"
#include "region.h"
#include "respa.h"
#include "update.h"
#include "variable.h"

#include <cstring>

using namespace LAMMPS_NS;
using namespace FixConst;

enum{NONE,CONSTANT,EQUAL,ATOM};

/* ---------------------------------------------------------------------- */

FixAddForceFieldMo::FixAddForceFieldMo(LAMMPS *lmp, int narg, char **arg) :
  Fix(lmp, narg, arg),
  xstr(nullptr), ystr(nullptr), zstr(nullptr), estr(nullptr), idregion(nullptr), sforce(nullptr)

{
  //if (narg < 6) error->all(FLERR,"Illegal fix addforce command");

  dynamic_group_allow = 1;
  scalar_flag = 1;
  vector_flag = 1;
  size_vector = 3;
  global_freq = 1;
  extscalar = 1;
  extvector = 1;
  respa_level_support = 1;
  ilevel_respa = 0;
  virial_flag = 1;

  /*xstr = ystr = zstr = nullptr;

  if (strstr(arg[3],"v_") == arg[3]) {
    int n = strlen(&arg[3][2]) + 1;
    xstr = new char[n];
    strcpy(xstr,&arg[3][2]);
  } else {
    xvalue = utils::numeric(FLERR,arg[3],false,lmp);
    xstyle = CONSTANT;
  }
  if (strstr(arg[4],"v_") == arg[4]) {
    int n = strlen(&arg[4][2]) + 1;
    ystr = new char[n];
    strcpy(ystr,&arg[4][2]);
  } else {
    yvalue = utils::numeric(FLERR,arg[4],false,lmp);
    ystyle = CONSTANT;
  }
  if (strstr(arg[5],"v_") == arg[5]) {
    int n = strlen(&arg[5][2]) + 1;
    zstr = new char[n];
    strcpy(zstr,&arg[5][2]);
  } else {
    zvalue = utils::numeric(FLERR,arg[5],false,lmp);
    zstyle = CONSTANT;
  }*/

  // optional args

  nevery = 1;
  iregion = -1;

  if (strcmp(arg[3],"region") == 0) {
    iregion = domain->find_region(arg[4]);
    int n = strlen(arg[4]) + 1;
    idregion = new char[n];
    strcpy(idregion,arg[4]);}
  if (iregion == -1)
        error->all(FLERR,"Region ID for fix addforce does not exist");




  /*int iarg = 6;
  while (iarg < narg) {
    if (strcmp(arg[iarg],"every") == 0) {
      if (iarg+2 > narg) error->all(FLERR,"Illegal fix addforce command");
      nevery = atoi(arg[iarg+1]);
      if (nevery <= 0) error->all(FLERR,"Illegal fix addforce command");
      iarg += 2;
    } else if (strcmp(arg[iarg],"region") == 0) {
      if (iarg+2 > narg) error->all(FLERR,"Illegal fix addforce command");
      iregion = domain->find_region(arg[iarg+1]);
      if (iregion == -1)
        error->all(FLERR,"Region ID for fix addforce does not exist");
      int n = strlen(arg[iarg+1]) + 1;
      idregion = new char[n];
      strcpy(idregion,arg[iarg+1]);
      iarg += 2;
    } else if (strcmp(arg[iarg],"energy") == 0) {
      if (iarg+2 > narg) error->all(FLERR,"Illegal fix addforce command");
      if (strstr(arg[iarg+1],"v_") == arg[iarg+1]) {
        int n = strlen(&arg[iarg+1][2]) + 1;
        estr = new char[n];
        strcpy(estr,&arg[iarg+1][2]);
      } else error->all(FLERR,"Illegal fix addforce command");
      iarg += 2;
    } else error->all(FLERR,"Illegal fix addforce command");
  }*/

  force_flag = 0;
  foriginal[0] = foriginal[1] = foriginal[2] = foriginal[3] = 0.0;

  maxatom = 1;
  memory->create(sforce,maxatom,4,"addforce:sforce");
}

/* ---------------------------------------------------------------------- */

FixAddForceFieldMo::~FixAddForceFieldMo()
{
  /*delete [] xstr;
  delete [] ystr;
  delete [] zstr;
  delete [] estr;*/
  delete [] idregion;
  memory->destroy(sforce);
}

/* ---------------------------------------------------------------------- */

int FixAddForceFieldMo::setmask()
{
  datamask_read = datamask_modify = 0;

  int mask = 0;
  mask |= POST_FORCE;
  mask |= THERMO_ENERGY;
  mask |= POST_FORCE_RESPA;
  mask |= MIN_POST_FORCE;
  return mask;
}

/* ---------------------------------------------------------------------- */

void FixAddForceFieldMo::init()
{
  // check variables

  /*if (xstr) {
    xvar = input->variable->find(xstr);
    if (xvar < 0)
      error->all(FLERR,"Variable name for fix addforce does not exist");
    if (input->variable->equalstyle(xvar)) xstyle = EQUAL;
    else if (input->variable->atomstyle(xvar)) xstyle = ATOM;
    else error->all(FLERR,"Variable for fix addforce is invalid style");
  }
  if (ystr) {
    yvar = input->variable->find(ystr);
    if (yvar < 0)
      error->all(FLERR,"Variable name for fix addforce does not exist");
    if (input->variable->equalstyle(yvar)) ystyle = EQUAL;
    else if (input->variable->atomstyle(yvar)) ystyle = ATOM;
    else error->all(FLERR,"Variable for fix addforce is invalid style");
  }
  if (zstr) {
    zvar = input->variable->find(zstr);
    if (zvar < 0)
      error->all(FLERR,"Variable name for fix addforce does not exist");
    if (input->variable->equalstyle(zvar)) zstyle = EQUAL;
    else if (input->variable->atomstyle(zvar)) zstyle = ATOM;
    else error->all(FLERR,"Variable for fix addforce is invalid style");
  }
  if (estr) {
    evar = input->variable->find(estr);
    if (evar < 0)
      error->all(FLERR,"Variable name for fix addforce does not exist");
    if (input->variable->atomstyle(evar)) estyle = ATOM;
    else error->all(FLERR,"Variable for fix addforce is invalid style");
  } else estyle = NONE;*/

  // set index and check validity of region

  if (iregion >= 0) {
    iregion = domain->find_region(idregion);
    if (iregion == -1)
      error->all(FLERR,"Region ID for fix addforce does not exist");
  }

  /*if (xstyle == ATOM || ystyle == ATOM || zstyle == ATOM)
    varflag = ATOM;
  else if (xstyle == EQUAL || ystyle == EQUAL || zstyle == EQUAL)
    varflag = EQUAL;
  else varflag = CONSTANT;

  if (varflag == CONSTANT && estyle != NONE)
    error->all(FLERR,"Cannot use variable energy with "
               "constant force in fix addforce");
  if ((varflag == EQUAL || varflag == ATOM) &&
      update->whichflag == 2 && estyle == NONE)
    error->all(FLERR,"Must use variable energy with fix addforce");

  if (strstr(update->integrate_style,"respa")) {
    ilevel_respa = ((Respa *) update->integrate)->nlevels-1;
    if (respa_level >= 0) ilevel_respa = MIN(respa_level,ilevel_respa);
  }*/
}

/* ---------------------------------------------------------------------- */

void FixAddForceFieldMo::setup(int vflag)
{
  if (strstr(update->integrate_style,"verlet"))
    post_force(vflag);
  else {
    ((Respa *) update->integrate)->copy_flevel_f(ilevel_respa);
    post_force_respa(vflag,ilevel_respa,0);
    ((Respa *) update->integrate)->copy_f_flevel(ilevel_respa);
  }
}

/* ---------------------------------------------------------------------- */

void FixAddForceFieldMo::min_setup(int vflag)
{
  post_force(vflag);
}

/* ---------------------------------------------------------------------- */

void FixAddForceFieldMo::post_force(int vflag)
{
  double **x = atom->x;
  double **f = atom->f;
  int *mask = atom->mask;
  imageint *image = atom->image;
  double v[6];
  int nlocal = atom->nlocal;


  // energy and virial setup

  if (vflag) v_setup(vflag);
  else evflag = 0;


  // update region if necessary

  Region *region = nullptr;
  if (iregion >= 0) {
    region = domain->regions[iregion];
    region->prematch();
  }

  // reallocate sforce array if necessary

  if (atom->nmax > maxatom) {
    maxatom = atom->nmax;
    memory->destroy(sforce);
    memory->create(sforce,maxatom,4,"addforce:sforce");
  }

  // foriginal[0] = "potential energy" for added force
  // foriginal[123] = force on atoms before extra force added

  foriginal[0] = foriginal[1] = foriginal[2] = foriginal[3] = 0.0;
  force_flag = 0;

  // constant force
  // potential energy = - x dot f in unwrapped coords

  // variable force, wrap with clear/add
  // potential energy = evar if defined, else 0.0
  // wrap with clear/add

  double unwrap[3];

  modify->addstep_compute(update->ntimestep + 1);

/* Calculate external energy and force for atoms (unit: Angstrom)*/ 

  radius = 100.0; // the radius of hole =  10 nm
  dr = 0.1;
  dz = 0.1;
  double xclist[9] = {radius,radius*5.0,radius*3.0,-radius,-radius*5.0,-radius*3.0,-radius,3.0*radius,radius*7.0};
  double yclist[9] = {pow(3.0,0.5)*radius,pow(3.0,0.5)*radius,3.0*pow(3.0,0.5)*radius,3.0*pow(3.0,0.5)*radius,3.0*pow(3.0,0.5)*radius,pow(3.0,0.5)*radius,-pow(3.0,0.5)*radius,-pow(3.0,0.5)*radius,-pow(3.0,0.5)*radius};

  for (int i = 0; i < nlocal; i++) {
    if (mask[i] & groupbit) {
      if (region && !region->match(x[i][0],x[i][1],x[i][2])) continue;
      domain->unmap(x[i],image[i],unwrap);
      atomx = x[i][0];
      atomy = x[i][1];
      atomz = x[i][2];
 
      xforcesum = 0.0;
      yforcesum = 0.0; 
      zforcesum = 0.0;
      Urzsum    = 0.0;
      
      foriginal[1] += f[i][0];
      foriginal[2] += f[i][1];
      foriginal[3] += f[i][2];


      
      xc = xclist[0]; /* X position of the center of k_th hole*/
      yc = yclist[0]; /* Y position of the center of k_th hole*/      
      R0 = sqrt((atomx-xc)*(atomx-xc) + (atomy-yc)*(atomy-yc)); 
      z0 = atomz;
 
      
 
      /* Error message when atom is not on the range 
       if ((z0 < 1.11)  || (z0 > 3.97)) {
             fprintf(screen,"print: S %d Atom is not on the region with energy grid! (R0: %f, z9: %f)\n",i,R0,z0);
	     error->all(FLERR,"Atom is not on the region with energy grid !! ");
      } */

      Ri = floor((R0)/dr);
      xr = R0/dr - double(floor(R0/dr)); /* mod(R0,dr) */
      zi = floor((z0)/dz);
      xz = z0/dz - double(floor(z0/dz));

      /* Bi-cubic interpolation */

      //fprintf(screen,"Ri %d xr: %f zi: %d xz: %f\n",Ri,xr,zi,xz); 
      
      f00 = U_Mo[Ri][zi];f01 = U_Mo[Ri][zi+1];f10 = U_Mo[Ri+1][zi];f11 = U_Mo[Ri+1][zi+1];

      //fprintf(screen,"f00 %f f01: %f f10: %f f11: %f\n",f00,f01,f10,f11);

      fr00 = (U_Mo[Ri+1][zi]-U_Mo[Ri-1][zi])/2;
      fr10 = (U_Mo[Ri+2][zi]-U_Mo[Ri][zi])/2;
      fr01 = (U_Mo[Ri+1][zi+1]-U_Mo[Ri-1][zi+1])/2;
      fr11 = (U_Mo[Ri+2][zi+1]-U_Mo[Ri][zi+1])/2;

      fz00 = (U_Mo[Ri][zi+1]-U_Mo[Ri][zi-1])/2;
      fz10 = (U_Mo[Ri+1][zi+1]-U_Mo[Ri+1][zi-1])/2;
      fz01 = (U_Mo[Ri][zi+2]-U_Mo[Ri][zi])/2;
      fz11 = (U_Mo[Ri+1][zi+2]-U_Mo[Ri+1][zi])/2;

      frz00 = (U_Mo[Ri+1][zi+1]-U_Mo[Ri+1][zi-1]-U_Mo[Ri-1][zi+1]+U_Mo[Ri-1][zi-1])/2/2;
      frz10 = (U_Mo[Ri+2][zi+1]-U_Mo[Ri+2][zi-1]-U_Mo[Ri][zi+1]+U_Mo[Ri][zi-1])/2/2;
      frz01 = (U_Mo[Ri+1][zi+2]-U_Mo[Ri+1][zi]-U_Mo[Ri-1][zi+2]+U_Mo[Ri-1][zi])/2/2;
      frz11 = (U_Mo[Ri+2][zi+2]-U_Mo[Ri+2][zi]-U_Mo[Ri][zi+2]+U_Mo[Ri][zi])/2/2;

      
      mf[0][0] = f00; mf[0][1] =  f01; mf[0][2] = fz00; mf[0][3] =  fz01;
      mf[1][0] = f10; mf[1][1] =  f11; mf[1][2] = fz10; mf[1][3] =  fz11;
      mf[2][0] = fr00; mf[2][1] =  fr01; mf[2][2] = frz00; mf[2][3] = frz01;
      mf[3][0] = fr10; mf[3][1] =  fr11; mf[3][2] = frz10; mf[3][3] =  frz11;

      /* ar = m1 :ㅂ
      * mf * m2; */


        /* m1*mf */
      for (int a = 0; a < 4; a++) {
	      for (int j = 0; j < 4; j++){
		      temp[a][j] = 0.0;
		      for (int k = 0; k < 4; k++){
			      temp[a][j] += m1[a][k]*mf[k][j]; 
		      }

	      }

      }
      



      for (int a = 0; a < 4; a++) {
	      for (int j = 0; j < 4; j++){
		      ar[a][j] = 0.0;
		      for (int k = 0; k < 4; k++){
			      ar[a][j] += temp[a][k]*m2[k][j]; 
		      }

	      }

      }

      a00 = ar[0][0];a10 = ar[1][0];a20 = ar[2][0];a30 = ar[3][0];
      a01 = ar[0][1];a11 = ar[1][1];a21 = ar[2][1];a31 = ar[3][1];
      a02 = ar[0][2];a12 = ar[1][2];a22 = ar[2][2];a32 = ar[3][2];
      a03 = ar[0][3];a13 = ar[1][3];a23 = ar[2][3];a33 = ar[3][3];
     

      Urz =  a00 + a01*xz + a02*xz*xz + a03*xz*xz*xz + 
             a10*xr + a11*xr*xz + a12*xr*xz*xz + a13*xr*xz*xz*xz + 
             a20*xr*xr + a21*xr*xr*xz + a22*xr*xr*xz*xz + a23*xr*xr*xz*xz*xz + 
             a30*xr*xr*xr + a31*xr*xr*xr*xz + a32*xr*xr*xr*xz*xz + a33*xr*xr*xr*xz*xz*xz;
      /*
      flu = 0.0000001;
      xz_temp = xz;
      xz = xz_temp + flu;

      Urz1 = a00 + a01*xz + a02*xz*xz + a03*xz*xz*xz +
             a10*xr + a11*xr*xz + a12*xr*xz*xz + a13*xr*xz*xz*xz +
             a20*xr*xr + a21*xr*xr*xz + a22*xr*xr*xz*xz + a23*xr*xr*xz*xz*xz +
             a30*xr*xr*xr + a31*xr*xr*xr*xz + a32*xr*xr*xr*xz*xz + a33*xr*xr*xr*xz*xz*xz;

      xz = xz_temp - flu;
      Urz2 = a00 + a01*xz + a02*xz*xz + a03*xz*xz*xz +
             a10*xr + a11*xr*xz + a12*xr*xz*xz + a13*xr*xz*xz*xz +
             a20*xr*xr + a21*xr*xr*xz + a22*xr*xr*xz*xz + a23*xr*xr*xz*xz*xz +
             a30*xr*xr*xr + a31*xr*xr*xr*xz + a32*xr*xr*xr*xz*xz + a33*xr*xr*xr*xz*xz*xz;

      nuforce = (Urz1 - Urz2) / 2 / flu;
      xz = xz_temp;
      */

      /* ?Should fr fz have minus sign? -> YES */
      /* fix the force unit */
      fr  = a10 + a11*xz + a12*xz*xz + a13*xz*xz*xz + 
          2.0*(a20*xr + a21*xr*xz + a22*xr*xz*xz + a23*xr*xz*xz*xz) + 
          3.0*(a30*xr*xr + a31*xr*xr*xz + a32*xr*xr*xz*xz + a33*xr*xr*xz*xz*xz);
      fz  = a01 + a11*xr + a21*xr*xr + a31*xr*xr*xr + 
          2.0*(a02*xz + a12*xr*xz + a22*xr*xr*xz + a32*xr*xr*xr*xz) + 
          3.0*(a03*xz*xz + a13*xr*xz*xz + a23*xr*xr*xz*xz + a33*xr*xr*xr*xz*xz);




      //fprintf(screen,"Urz  %17.16f fr: %17.16f fz: %17.16f\n",Urz,-fr,-fz);

      //fprintf(screen,"Urz  %17.16f fr: %17.16f fz: %17.16f atomz: %17.16f R0: %17.16f \n",Urz,-fr/0.1,-fz/0.1,atomz,R0);



      costh = (atomx - xc)/R0;
      sinth = (atomy - yc)/R0;

      /* Change the direction of force */
      xforcesum += - costh * fr /dr;
      yforcesum += - sinth * fr/dr; 
      zforcesum += - fz/dz;
      Urzsum    += Urz;
 


      
      
      
         
    
      sforce[i][0] = xforcesum;
      sforce[i][1] = yforcesum;
      sforce[i][2] = zforcesum;
      sforce[i][3] = Urzsum;
      foriginal[0] += sforce[i][3];
      f[i][0] += xforcesum;
      f[i][1] += yforcesum;
      f[i][2] += zforcesum;

      /* End of Bi-cubic interpolation  */
      xvalue = xforcesum; yvalue = yforcesum; zvalue = zforcesum; 

      if (evflag) {
        v[0] = xstyle ? xvalue*unwrap[0] : 0.0;
        v[1] = ystyle ? yvalue*unwrap[1] : 0.0;
        v[2] = zstyle ? zvalue*unwrap[2] : 0.0;
        v[3] = xstyle ? xvalue*unwrap[1] : 0.0;
        v[4] = xstyle ? xvalue*unwrap[2] : 0.0;
        v[5] = ystyle ? yvalue*unwrap[2] : 0.0;
        v_tally(i, v);
      }
  }
  }
}

/* ---------------------------------------------------------------------- */

void FixAddForceFieldMo::post_force_respa(int vflag, int ilevel, int /*iloop*/)
{
  if (ilevel == ilevel_respa) post_force(vflag);
}

/* ---------------------------------------------------------------------- */

void FixAddForceFieldMo::min_post_force(int vflag)
{
  post_force(vflag);
}

/* ----------------------------------------------------------------------
   potential energy of added force
------------------------------------------------------------------------- */

double FixAddForceFieldMo::compute_scalar()
{
  // only sum across procs one time

  if (force_flag == 0) {
    MPI_Allreduce(foriginal,foriginal_all,4,MPI_DOUBLE,MPI_SUM,world);
    force_flag = 1;
  }
  return foriginal_all[0];
}

/* ----------------------------------------------------------------------
   return components of total force on fix group before force was changed
------------------------------------------------------------------------- */

double FixAddForceFieldMo::compute_vector(int n)
{
  // only sum across procs one time

  if (force_flag == 0) {
    MPI_Allreduce(foriginal,foriginal_all,4,MPI_DOUBLE,MPI_SUM,world);
    force_flag = 1;
  }
  return foriginal_all[n+1];
}

/* ----------------------------------------------------------------------
   memory usage of local atom-based array
------------------------------------------------------------------------- */

double FixAddForceFieldMo::memory_usage()
{
  double bytes = 0.0;
  if (varflag == ATOM) bytes = maxatom*4 * sizeof(double);
  return bytes;
}
