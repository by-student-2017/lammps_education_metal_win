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
   Contributing authors: Carolyn Phillips (U Mich), reservoir energy tally
                         Aidan Thompson (SNL) GJF formulation
------------------------------------------------------------------------- */
/* ----------------------------------------------------------------------
This is a modification to fix_langevin in which the system is divided into 
'nlayer' layers or bins along x-direction, and then each layer is thermostatted
by Langevin dynamics to achieve a sinusoidal temperature distribution along 
the length of the system:

\theta_i = \theta_0 + \Delta\theta_0 \cos(2 \pi i/(\nlayers-1));  

0 \le i \le {nbins-1},

where \theta_0 is the base temperature and \Delta\theta_0 is the amplitude of
the sinusoidal temperature distribution, and $i$ varies from 0 to (nbins-1). 
------------------------------------------------------------------------- */
/* ----------------------------------------------------------------------
   Contributing author: Amit Singh (University of Minnesota) 
------------------------------------------------------------------------- */

#include "mpi.h"
#include "math.h"
#include "string.h"
#include "stdlib.h"
#include "fix_langevin_layer.h"
#include "math_extra.h"
#include "atom.h"
#include "atom_vec_ellipsoid.h"
#include "force.h"
#include "update.h"
#include "modify.h"
#include "compute.h"
#include "domain.h"
#include "region.h"
#include "respa.h"
#include "comm.h"
#include "input.h"
#include "variable.h"
#include "random_mars.h"
#include "memory.h"
#include "error.h"
#include "group.h"

using namespace LAMMPS_NS;
using namespace FixConst;

enum{NOBIAS,BIAS};
enum{CONSTANT,EQUAL,ATOM};

#define SINERTIA 0.4          // moment of inertia prefactor for sphere
#define EINERTIA 0.2          // moment of inertia prefactor for ellipsoid

#define PI 3.141592653589793
/* ---------------------------------------------------------------------- */

FixLangevinLayer::FixLangevinLayer(LAMMPS *lmp, int narg, char **arg) :
  Fix(lmp, narg, arg)
{
  if (narg < 8) error->all(FLERR,"Illegal fix langevin/layer command");
  
  scalar_flag = 1;
  global_freq = 1;
  extscalar = 1;
  nevery = 1;

  t_base = force->numeric(FLERR,arg[3]);
  dt_base = force->numeric(FLERR,arg[4]);
  t_period = force->numeric(FLERR,arg[5]);
  int seed = force->inumeric(FLERR,arg[6]);
  nlayers = force->numeric(FLERR,arg[7]);

  if (t_period <= 0.0) error->all(FLERR,"Fix langevin/layer period must be > 0.0");
  if (seed <= 0) error->all(FLERR,"Illegal fix langevin/layer command");

  // initialize Marsaglia RNG with processor-unique seed

  random = new RanMars(lmp,seed + comm->me);

  // allocate per-type arrays for force prefactors

  gfactor1 = new double[atom->ntypes+1];
  gfactor2 = new double[atom->ntypes+1];
  ratio = new double[atom->ntypes+1];

  // optional args

  for (int i = 1; i <= atom->ntypes; i++) ratio[i] = 1.0;
  ascale = 0.0;
  gjfflag = 0;
  oflag = 0;
  tallyflag = 0;
  zeroflag = 0;

  int iarg = 8;
  while (iarg < narg) {
    if (strcmp(arg[iarg],"angmom") == 0) {
      if (iarg+2 > narg) error->all(FLERR,"Illegal fix langevin/layer command");
      if (strcmp(arg[iarg+1],"no") == 0) ascale = 0.0;
      else ascale = force->numeric(FLERR,arg[iarg+1]);
      iarg += 2;
    } else if (strcmp(arg[iarg],"gjf") == 0) {
      if (iarg+2 > narg) error->all(FLERR,"Illegal fix langevin/layer command");
      if (strcmp(arg[iarg+1],"no") == 0) gjfflag = 0;
      else if (strcmp(arg[iarg+1],"yes") == 0) gjfflag = 1;
      else error->all(FLERR,"Illegal fix langevin/layer command");
      iarg += 2;
    } else if (strcmp(arg[iarg],"omega") == 0) {
      if (iarg+2 > narg) error->all(FLERR,"Illegal fix langevin/layer command");
      if (strcmp(arg[iarg+1],"no") == 0) oflag = 0;
      else if (strcmp(arg[iarg+1],"yes") == 0) oflag = 1;
      else error->all(FLERR,"Illegal fix langevin/layer command");
      iarg += 2;
    } else if (strcmp(arg[iarg],"scale") == 0) {
      if (iarg+3 > narg) error->all(FLERR,"Illegal fix langevin/layer command");
      int itype = force->inumeric(FLERR,arg[iarg+1]);
      double scale = force->numeric(FLERR,arg[iarg+2]);
      if (itype <= 0 || itype > atom->ntypes)
        error->all(FLERR,"Illegal fix langevin/layer command");
      ratio[itype] = scale;
      iarg += 3;
    } else if (strcmp(arg[iarg],"tally") == 0) {
      if (iarg+2 > narg) error->all(FLERR,"Illegal fix langevin/layer command");
      if (strcmp(arg[iarg+1],"no") == 0) tallyflag = 0;
      else if (strcmp(arg[iarg+1],"yes") == 0) tallyflag = 1;
      else error->all(FLERR,"Illegal fix langevin/layer command");
      iarg += 2;
    } else if (strcmp(arg[iarg],"zero") == 0) {
      if (iarg+2 > narg) error->all(FLERR,"Illegal fix langevin/layer command");
      if (strcmp(arg[iarg+1],"no") == 0) zeroflag = 0;
      else if (strcmp(arg[iarg+1],"yes") == 0) zeroflag = 1;
      else error->all(FLERR,"Illegal fix langevin/layer command");
      iarg += 2;
    } else error->all(FLERR,"Illegal fix langevin/layer command");
  }

  // set temperature = NULL, user can override via fix_modify if wants bias

  id_temp = NULL;
  temperature = NULL;

  // flangevin is unallocated until first call to setup()
  // compute_scalar checks for this and returns 0.0 if flangevin is NULL

  energy = 0.0;
  flangevin = NULL;
  franprev = NULL;
  tforce = NULL;
  maxatom1 = maxatom2 = 0;
  
  totalatom = (int)atom->natoms;
  count_one = new double[nlayers];
  count_many = new double[nlayers];
  layer = new int[totalatom]; 
  t_target = new double[nlayers];
  
  // Setup atom-based array for franprev
  // register with Atom class
  // No need to set peratom_flag
  // as this data is for internal use only

  if (gjfflag) {
    nvalues = 3;
    grow_arrays(atom->nmax);
    atom->add_callback(0);

  // initialize franprev to zero

    int nlocal = atom->nlocal;
    for (int i = 0; i < nlocal; i++) {
      franprev[i][0] = 0.0;
      franprev[i][1] = 0.0;
      franprev[i][2] = 0.0;
    }
  }

}

/* ---------------------------------------------------------------------- */

FixLangevinLayer::~FixLangevinLayer()
{
  delete random;
  delete [] gfactor1;
  delete [] gfactor2;
  delete [] ratio;
  delete [] id_temp;
  memory->destroy(flangevin);
  memory->destroy(tforce);
  delete [] layer;
  delete [] count_one;
  delete [] count_many;
  delete [] t_target;

  if (gjfflag) {
    memory->destroy(franprev);
    atom->delete_callback(id,0);
  }
}

/* ---------------------------------------------------------------------- */

int FixLangevinLayer::setmask()
{
  int mask = 0;
  mask |= POST_FORCE;
  mask |= POST_FORCE_RESPA;
  mask |= END_OF_STEP;
  mask |= THERMO_ENERGY;
  return mask;
}

/* ---------------------------------------------------------------------- */

void FixLangevinLayer::init()
{
  int i,m,ilayer;
  double *boxlo,*boxhi,*prd;

  int triclinic = domain->triclinic;
  if (triclinic) {
    boxlo = domain->boxlo_lamda;
    boxhi = domain->boxhi_lamda;
    prd = domain->prd_lamda;
  } else {
    boxlo = domain->boxlo;
    boxhi = domain->boxhi;
    prd = domain->prd;
  }
    
  for (m = 0; m < nlayers; m++){
    count_many[m] = 0.0;
    count_one[m] = 0.0;
  }
  
  double **x = atom->x;
  int *mask = atom->mask;
  int nlocal = atom->nlocal;
  
  double xremap;
  int periodicity = domain->periodicity[0];
  
  invdelta = ((double) nlayers)/prd[0];
  
  if (triclinic) domain->x2lamda(nlocal);
  
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
  
  for (i=0; i < nlayers; i++) 
      t_target[i] = t_base + dt_base*cos(2*PI*i/(nlayers-1));

  if(comm->me == 0){ 
  printf("Start printing number of atoms in each layer and corresponding temperature\n"); 
  for (i=0; i < nlayers; i++) 
     printf("%f\t %f\n",count_many[i], t_target[i]);
  }
  
  if (oflag && !atom->sphere_flag)
    error->all(FLERR,"Fix langevin omega requires atom style sphere");
  if (ascale && !atom->ellipsoid_flag)
    error->all(FLERR,"Fix langevin angmom requires atom style ellipsoid");

  // if oflag or ascale set, check that all group particles are finite-size

  if (oflag) {
    double *radius = atom->radius;
    int *mask = atom->mask;
    int nlocal = atom->nlocal;

    for (int i = 0; i < nlocal; i++)
      if (mask[i] & groupbit)
        if (radius[i] == 0.0)
          error->one(FLERR,"Fix langevin omega requires extended particles");
  }

  if (ascale) {
    avec = (AtomVecEllipsoid *) atom->style_match("ellipsoid");
    if (!avec)
      error->all(FLERR,"Fix langevin angmom requires atom style ellipsoid");

    int *ellipsoid = atom->ellipsoid;
    int *mask = atom->mask;
    int nlocal = atom->nlocal;

    for (int i = 0; i < nlocal; i++)
      if (mask[i] & groupbit)
        if (ellipsoid[i] < 0)
          error->one(FLERR,"Fix langevin angmom requires extended particles");
  }

  // set force prefactors

  if (!atom->rmass) {
    for (int i = 1; i <= atom->ntypes; i++) {
      gfactor1[i] = -atom->mass[i] / t_period / force->ftm2v;
      gfactor2[i] = sqrt(atom->mass[i]) *
        sqrt(24.0*force->boltz/t_period/update->dt/force->mvv2e) /
        force->ftm2v;
      gfactor1[i] *= 1.0/ratio[i];
      gfactor2[i] *= 1.0/sqrt(ratio[i]);
    }
  }

  if (temperature && temperature->tempbias) tbiasflag = BIAS;
  else tbiasflag = NOBIAS;

  if (strstr(update->integrate_style,"respa"))
    nlevels_respa = ((Respa *) update->integrate)->nlevels;

  if (gjfflag) gjffac = 1.0/(1.0+update->dt/2.0/t_period);

}

/* ---------------------------------------------------------------------- */

void FixLangevinLayer::setup(int vflag)
{
  if (strstr(update->integrate_style,"verlet"))
    post_force(vflag);
  else {
    ((Respa *) update->integrate)->copy_flevel_f(nlevels_respa-1);
    post_force_respa(vflag,nlevels_respa-1,0);
    ((Respa *) update->integrate)->copy_f_flevel(nlevels_respa-1);
  }
}

/* ---------------------------------------------------------------------- */

void FixLangevinLayer::post_force(int vflag)
{
  double *rmass = atom->rmass;

  // enumerate all 2^6 possibilities for template parameters
  // this avoids testing them inside inner loop: 
  // GJF, TALLY, BIAS, RMASS, ZERO

#ifdef TEMPLATED_FIX_LANGEVIN
  for (int ilayer=0; ilayer < nlayers; ilayer++) { 
    if (gjfflag)
      if (tallyflag)
	if (tbiasflag == BIAS)
	  if (rmass)
	    if (zeroflag) post_force_templated<1,1,1,1,1>(ilayer);
            else          post_force_templated<1,1,1,1,0>(ilayer);
	  else
	    if (zeroflag) post_force_templated<1,1,1,0,1>(ilayer);
            else          post_force_templated<1,1,1,0,0>(ilayer);
	else
	  if (rmass)
	    if (zeroflag) post_force_templated<1,1,0,1,1>(ilayer);
	    else          post_force_templated<1,1,0,1,0>(ilayer);
	  else
	    if (zeroflag) post_force_templated<1,1,0,0,1>(ilayer);
	    else          post_force_templated<1,1,0,0,0>(ilayer);
      else
	if (tbiasflag == BIAS)
	  if (rmass)
	    if (zeroflag) post_force_templated<1,0,1,1,1>(ilayer);
	    else          post_force_templated<1,0,1,1,0>(ilayer);
	  else
	    if (zeroflag) post_force_templated<1,0,1,0,1>(ilayer);
	    else          post_force_templated<1,0,1,0,0>(ilayer);
	else
	  if (rmass)
	    if (zeroflag) post_force_templated<1,0,0,1,1>(ilayer);
	    else          post_force_templated<1,0,0,1,0>(ilayer);
	  else
	    if (zeroflag) post_force_templated<1,0,0,0,1>(ilayer);
	    else          post_force_templated<1,0,0,0,0>(ilayer);
    else
      if (tallyflag)
	if (tbiasflag == BIAS)
	  if (rmass)
	    if (zeroflag) post_force_templated<0,1,1,1,1>(ilayer);
	    else          post_force_templated<0,1,1,1,0>(ilayer);
	  else
	    if (zeroflag) post_force_templated<0,1,1,0,1>(ilayer);
	    else          post_force_templated<0,1,1,0,0>(ilayer);
	else
	  if (rmass)
	    if (zeroflag) post_force_templated<0,1,0,1,1>(ilayer);
	    else          post_force_templated<0,1,0,1,0>(ilayer);
	  else
	    if (zeroflag) post_force_templated<0,1,0,0,1>(ilayer);
	    else          post_force_templated<0,1,0,0,0>(ilayer);
      else
	if (tbiasflag == BIAS)
	  if (rmass)
	    if (zeroflag) post_force_templated<0,0,1,1,1>(ilayer);
	    else          post_force_templated<0,0,1,1,0>(ilayer);
	  else
	    if (zeroflag) post_force_templated<0,0,1,0,1>(ilayer);
	    else          post_force_templated<0,0,1,0,0>(ilayer);
	else
	  if (rmass)
	    if (zeroflag) post_force_templated<0,0,0,1,1>(ilayer);
	    else          post_force_templated<0,0,0,1,0>(ilayer);
	  else
	    if (zeroflag) post_force_templated<0,0,0,0,1>(ilayer);
	    else          post_force_templated<0,0,0,0,0>(ilayer);
  }	    
#else
 for (int ilayer=0; ilayer < nlayers; ilayer++) { 
  post_force_untemplated(gjfflag, tallyflag, 
			 int(tbiasflag==BIAS), int(rmass!=NULL), zeroflag, ilayer);
 }			 
#endif
}

/* ---------------------------------------------------------------------- */

void FixLangevinLayer::post_force_respa(int vflag, int ilevel, int iloop)
{
  if (ilevel == nlevels_respa-1) post_force(vflag);
}

/* ----------------------------------------------------------------------
   modify forces using one of the many Langevin styles
------------------------------------------------------------------------- */

#ifdef TEMPLATED_FIX_LANGEVIN
template < int Tp_GJF, int Tp_TALLY, 
	   int Tp_BIAS, int Tp_RMASS, int Tp_ZERO >
void FixLangevinLayer::post_force_templated(int ilayer)
#else
void FixLangevinLayer::post_force_untemplated
  (int Tp_GJF, int Tp_TALLY, 
   int Tp_BIAS, int Tp_RMASS, int Tp_ZERO, int ilayer)
#endif
{
  double gamma1,gamma2;

  double **v = atom->v;
  double **f = atom->f;
  double *rmass = atom->rmass;
  int *type = atom->type;
  int *mask = atom->mask;
  int nlocal = atom->nlocal;

  double tsqrt = sqrt(t_target[ilayer]);
  
  // apply damping and thermostat to atoms in group

  // for Tp_GJF:
  //   use Gronbech-Jensen/Farago algorithm
  //   else use regular algorithm
  // for Tp_TALLY:
  //   store drag plus random forces in flangevin[nlocal][3]
  // for Tp_BIAS:
  //   calculate temperature since some computes require temp
  //   computed on current nlocal atoms to remove bias
  //   test v = 0 since some computes mask non-participating atoms via v = 0
  //   and added force has extra term not multiplied by v = 0
  // for Tp_RMASS:
  //   use per-atom masses
  //   else use per-type masses
  // for Tp_ZERO:
  //   sum random force over all atoms in group
  //   subtract sum/count from each atom in group

  double fdrag[3],fran[3],fsum[3],fsumall[3];
  bigint count;
  double fswap;

  double boltz = force->boltz;
  double dt = update->dt;
  double mvv2e = force->mvv2e;
  double ftm2v = force->ftm2v;

  if (Tp_ZERO) {
    fsum[0] = fsum[1] = fsum[2] = 0.0;
    count = group->count(igroup);
    if (count == 0)
      error->all(FLERR,"Cannot zero Langevin force of 0 atoms");
  }

  // reallocate flangevin if necessary

  if (Tp_TALLY) {
    if (atom->nlocal > maxatom1) {
      memory->destroy(flangevin);
      maxatom1 = atom->nmax;
      memory->create(flangevin,maxatom1,3,"langevin:flangevin");
    }
  }

  if (Tp_BIAS) temperature->compute_scalar();

  for (int i = 0; i < nlocal; i++) {
    if (layer[i]==ilayer) {
      if (Tp_RMASS) {
	gamma1 = -rmass[i] / t_period / ftm2v;
	gamma2 = sqrt(rmass[i]) * sqrt(24.0*boltz/t_period/dt/mvv2e) / ftm2v;
	gamma1 *= 1.0/ratio[type[i]];
	gamma2 *= 1.0/sqrt(ratio[type[i]]) * tsqrt;
      } else {
	gamma1 = gfactor1[type[i]];
	gamma2 = gfactor2[type[i]] * tsqrt;
      }

      fran[0] = gamma2*(random->uniform()-0.5);
      fran[1] = gamma2*(random->uniform()-0.5);
      fran[2] = gamma2*(random->uniform()-0.5);

      if (Tp_BIAS) {
	temperature->remove_bias(i,v[i]);
	fdrag[0] = gamma1*v[i][0];
	fdrag[1] = gamma1*v[i][1];
	fdrag[2] = gamma1*v[i][2];
	if (v[i][0] == 0.0) fran[0] = 0.0;
	if (v[i][1] == 0.0) fran[1] = 0.0;
	if (v[i][2] == 0.0) fran[2] = 0.0;
	temperature->restore_bias(i,v[i]);
      } else {
	fdrag[0] = gamma1*v[i][0];
	fdrag[1] = gamma1*v[i][1];
	fdrag[2] = gamma1*v[i][2];
      }

      if (Tp_GJF) {
	fswap = 0.5*(fran[0]+franprev[i][0]);
	franprev[i][0] = fran[0];
	fran[0] = fswap;
	fswap = 0.5*(fran[1]+franprev[i][1]);
	franprev[i][1] = fran[1];
	fran[1] = fswap;
	fswap = 0.5*(fran[2]+franprev[i][2]);
	franprev[i][2] = fran[2];
	fran[2] = fswap;

	fdrag[0] *= gjffac;
	fdrag[1] *= gjffac;
	fdrag[2] *= gjffac;
	fran[0] *= gjffac;
	fran[1] *= gjffac;
	fran[2] *= gjffac;
	f[i][0] *= gjffac;
	f[i][1] *= gjffac;
	f[i][2] *= gjffac;
      }

      f[i][0] += fdrag[0] + fran[0];
      f[i][1] += fdrag[1] + fran[1];
      f[i][2] += fdrag[2] + fran[2];

      if (Tp_TALLY) {
	flangevin[i][0] = fdrag[0] + fran[0];
	flangevin[i][1] = fdrag[1] + fran[1];
	flangevin[i][2] = fdrag[2] + fran[2];
      }

      if (Tp_ZERO) {
	fsum[0] += fran[0];
	fsum[1] += fran[1];
	fsum[2] += fran[2];
      }
    }
  }

  // set total force to zero

  if (Tp_ZERO) {
    MPI_Allreduce(fsum,fsumall,3,MPI_DOUBLE,MPI_SUM,world);
    fsumall[0] /= count;
    fsumall[1] /= count;
    fsumall[2] /= count;
    for (int i = 0; i < nlocal; i++) {
      if (layer[i]==ilayer) {
        f[i][0] -= fsumall[0];
        f[i][1] -= fsumall[1];
        f[i][2] -= fsumall[2];
      }
    }
  }

  // thermostat omega and angmom

  if (oflag) omega_thermostat(ilayer);
  if (ascale) angmom_thermostat(ilayer);
}

/* ----------------------------------------------------------------------
   thermostat rotational dof via omega
------------------------------------------------------------------------- */

void FixLangevinLayer::omega_thermostat(int ilayer)
{
  double gamma1,gamma2;

  double boltz = force->boltz;
  double dt = update->dt;
  double mvv2e = force->mvv2e;
  double ftm2v = force->ftm2v;

  double **torque = atom->torque;
  double **omega = atom->omega;
  double *radius = atom->radius;
  double *rmass = atom->rmass;
  int *mask = atom->mask;
  int *type = atom->type;
  int nlocal = atom->nlocal;

  // rescale gamma1/gamma2 by 10/3 & sqrt(10/3) for spherical particles
  // does not affect rotational thermosatting
  // gives correct rotational diffusivity behavior

  double tendivthree = 10.0/3.0;
  double tran[3];
  double inertiaone;
  
  double tsqrt = sqrt(t_target[ilayer]);
  
  for (int i = 0; i < nlocal; i++) {
    if (layer[i]==ilayer) {
      inertiaone = SINERTIA*radius[i]*radius[i]*rmass[i];
      gamma1 = -tendivthree*inertiaone / t_period / ftm2v;
      gamma2 = sqrt(inertiaone) * sqrt(80.0*boltz/t_period/dt/mvv2e) / ftm2v;
      gamma1 *= 1.0/ratio[type[i]];
      gamma2 *= 1.0/sqrt(ratio[type[i]]) * tsqrt;
      tran[0] = gamma2*(random->uniform()-0.5);
      tran[1] = gamma2*(random->uniform()-0.5);
      tran[2] = gamma2*(random->uniform()-0.5);
      torque[i][0] += gamma1*omega[i][0] + tran[0];
      torque[i][1] += gamma1*omega[i][1] + tran[1];
      torque[i][2] += gamma1*omega[i][2] + tran[2];
    }
  }
}

/* ----------------------------------------------------------------------
   thermostat rotational dof via angmom
------------------------------------------------------------------------- */

void FixLangevinLayer::angmom_thermostat(int ilayer)
{
  double gamma1,gamma2;

  double boltz = force->boltz;
  double dt = update->dt;
  double mvv2e = force->mvv2e;
  double ftm2v = force->ftm2v;

  AtomVecEllipsoid::Bonus *bonus = avec->bonus;
  double **torque = atom->torque;
  double **angmom = atom->angmom;
  double *rmass = atom->rmass;
  int *ellipsoid = atom->ellipsoid;
  int *mask = atom->mask;
  int *type = atom->type;
  int nlocal = atom->nlocal;

  // rescale gamma1/gamma2 by ascale for aspherical particles
  // does not affect rotational thermosatting
  // gives correct rotational diffusivity behavior if (nearly) spherical
  // any value will be incorrect for rotational diffusivity if aspherical

  double inertia[3],omega[3],tran[3];
  double *shape,*quat;
  
  double tsqrt = sqrt(t_target[ilayer]);

  for (int i = 0; i < nlocal; i++) {
    if (layer[i]==ilayer) {
      shape = bonus[ellipsoid[i]].shape;
      inertia[0] = EINERTIA*rmass[i] * (shape[1]*shape[1]+shape[2]*shape[2]);
      inertia[1] = EINERTIA*rmass[i] * (shape[0]*shape[0]+shape[2]*shape[2]);
      inertia[2] = EINERTIA*rmass[i] * (shape[0]*shape[0]+shape[1]*shape[1]);
      quat = bonus[ellipsoid[i]].quat;
      MathExtra::mq_to_omega(angmom[i],quat,inertia,omega);

      gamma1 = -ascale / t_period / ftm2v;
      gamma2 = sqrt(ascale*24.0*boltz/t_period/dt/mvv2e) / ftm2v;
      gamma1 *= 1.0/ratio[type[i]];
      gamma2 *= 1.0/sqrt(ratio[type[i]]) * tsqrt;
      tran[0] = sqrt(inertia[0])*gamma2*(random->uniform()-0.5);
      tran[1] = sqrt(inertia[1])*gamma2*(random->uniform()-0.5);
      tran[2] = sqrt(inertia[2])*gamma2*(random->uniform()-0.5);
      torque[i][0] += inertia[0]*gamma1*omega[0] + tran[0];
      torque[i][1] += inertia[1]*gamma1*omega[1] + tran[1];
      torque[i][2] += inertia[2]*gamma1*omega[2] + tran[2];
    }
  }
}

/* ----------------------------------------------------------------------
   tally energy transfer to thermal reservoir
------------------------------------------------------------------------- */

void FixLangevinLayer::end_of_step()
{
  if (!tallyflag) return;

  double **v = atom->v;
  int *mask = atom->mask;
  int nlocal = atom->nlocal;

  energy_onestep = 0.0;

  for (int i = 0; i < nlocal; i++)
    if (mask[i] & groupbit)
      energy_onestep += flangevin[i][0]*v[i][0] + flangevin[i][1]*v[i][1] +
        flangevin[i][2]*v[i][2];

  energy += energy_onestep*update->dt;
}

/* ---------------------------------------------------------------------- */

void FixLangevinLayer::reset_target(double t_new)
{
  t_base = t_new;
}

/* ---------------------------------------------------------------------- */

void FixLangevinLayer::reset_dt()
{
  if (atom->mass) {
    for (int i = 1; i <= atom->ntypes; i++) {
      gfactor2[i] = sqrt(atom->mass[i]) *
        sqrt(24.0*force->boltz/t_period/update->dt/force->mvv2e) /
        force->ftm2v;
      gfactor2[i] *= 1.0/sqrt(ratio[i]);
    }
  }
}

/* ---------------------------------------------------------------------- */

int FixLangevinLayer::modify_param(int narg, char **arg)
{
  if (strcmp(arg[0],"temp") == 0) {
    if (narg < 2) error->all(FLERR,"Illegal fix_modify command");
    delete [] id_temp;
    int n = strlen(arg[1]) + 1;
    id_temp = new char[n];
    strcpy(id_temp,arg[1]);

    int icompute = modify->find_compute(id_temp);
    if (icompute < 0)
      error->all(FLERR,"Could not find fix_modify temperature ID");
    temperature = modify->compute[icompute];

    if (temperature->tempflag == 0)
      error->all(FLERR,
                 "Fix_modify temperature ID does not compute temperature");
    if (temperature->igroup != igroup && comm->me == 0)
      error->warning(FLERR,"Group for fix_modify temp != fix group");
    return 2;
  }
  return 0;
}

/* ---------------------------------------------------------------------- */

double FixLangevinLayer::compute_scalar()
{
  if (!tallyflag || flangevin == NULL) return 0.0;

  // capture the very first energy transfer to thermal reservoir

  double **v = atom->v;
  int *mask = atom->mask;
  int nlocal = atom->nlocal;

  if (update->ntimestep == update->beginstep) {
    energy_onestep = 0.0;
    for (int i = 0; i < nlocal; i++)
      if (mask[i] & groupbit)
        energy_onestep += flangevin[i][0]*v[i][0] + flangevin[i][1]*v[i][1] +
          flangevin[i][2]*v[i][2];
    energy = 0.5*energy_onestep*update->dt;
  }

  // convert midstep energy back to previous fullstep energy

  double energy_me = energy - 0.5*energy_onestep*update->dt;

  double energy_all;
  MPI_Allreduce(&energy_me,&energy_all,1,MPI_DOUBLE,MPI_SUM,world);
  return -energy_all;
}

/* ----------------------------------------------------------------------
   extract thermostat properties
------------------------------------------------------------------------- */

void *FixLangevinLayer::extract(const char *str, int &dim)
{
  dim = 0;
  if (strcmp(str,"t_base") == 0) {
    return &t_base;
  }
  return NULL;
}

/* ----------------------------------------------------------------------
   memory usage of tally array
------------------------------------------------------------------------- */

double FixLangevinLayer::memory_usage()
{
  double bytes = 0.0;
  if (gjfflag) bytes += atom->nmax*3 * sizeof(double);
  if (tallyflag) bytes += atom->nmax*3 * sizeof(double);
  if (tforce) bytes += atom->nmax * sizeof(double);
  return bytes;
}

/* ----------------------------------------------------------------------
   allocate atom-based array for franprev 
------------------------------------------------------------------------- */

void FixLangevinLayer::grow_arrays(int nmax)
{
  memory->grow(franprev,nmax,3,"fix_langevin:franprev");
}

/* ----------------------------------------------------------------------
   copy values within local atom-based array
------------------------------------------------------------------------- */

void FixLangevinLayer::copy_arrays(int i, int j, int delflag)
{
  for (int m = 0; m < nvalues; m++)
    franprev[j][m] = franprev[i][m];
}

/* ----------------------------------------------------------------------
   pack values in local atom-based array for exchange with another proc
------------------------------------------------------------------------- */

int FixLangevinLayer::pack_exchange(int i, double *buf)
{
  for (int m = 0; m < nvalues; m++) buf[m] = franprev[i][m];
  return nvalues;
}

/* ----------------------------------------------------------------------
   unpack values in local atom-based array from exchange with another proc
------------------------------------------------------------------------- */

int FixLangevinLayer::unpack_exchange(int nlocal, double *buf)
{
  for (int m = 0; m < nvalues; m++) franprev[nlocal][m] = buf[m];
  return nvalues;
}
