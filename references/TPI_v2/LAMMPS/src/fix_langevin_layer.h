/* -*- c++ -*- ----------------------------------------------------------
   LAMMPS - Large-scale Atomic/Molecular Massively Parallel Simulator
   http://lammps.sandia.gov, Sandia National Laboratories
   Steve Plimpton, sjplimp@sandia.gov

   Copyright (2003) Sandia Corporation.  Under the terms of Contract
   DE-AC04-94AL85000 with Sandia Corporation, the U.S. Government retains
   certain rights in this software.  This software is distributed under
   the GNU General Public License.

   See the README file in the top-level LAMMPS directory.
------------------------------------------------------------------------- */

#ifdef FIX_CLASS

FixStyle(langevin/layer,FixLangevinLayer)

#else

#ifndef LMP_FIX_LANGEVIN_LAYER_H
#define LMP_FIX_LANGEVIN_LAYER_H

#include "fix.h"

namespace LAMMPS_NS {

class FixLangevinLayer : public Fix {
 public:
  FixLangevinLayer(class LAMMPS *, int, char **);
  virtual ~FixLangevinLayer();
  int setmask();
  void init();
  void setup(int);
  virtual void post_force(int);
  void post_force_respa(int, int, int);
  virtual void end_of_step();
  void reset_target(double);
  void reset_dt();
  int modify_param(int, char **);
  virtual double compute_scalar();
  double memory_usage();
  virtual void *extract(const char *, int &);
  void grow_arrays(int);
  void copy_arrays(int, int, int);
  int pack_exchange(int, double *);
  int unpack_exchange(int, double *);

 protected:
  int gjfflag,oflag,tallyflag,zeroflag,tbiasflag;
  double ascale;
  double t_base,dt_base,t_period;
  double *gfactor1,*gfactor2,*ratio;
  double energy,energy_onestep;
  double tsqrt;
  int tstyle,tvar;
  double gjffac;
  char *tstr;

  class AtomVecEllipsoid *avec;

  int maxatom1,maxatom2;
  double **flangevin;
  double *tforce;
  double **franprev;
  int nvalues;

  char *id_temp;
  class Compute *temperature;

  int nlevels_respa;
  class RanMars *random;

  // comment next line to turn off templating
#define TEMPLATED_FIX_LANGEVIN
#ifdef TEMPLATED_FIX_LANGEVIN
  template < int Tp_GJF, int Tp_TALLY, 
	     int Tp_BIAS, int Tp_RMASS, int Tp_ZERO > 
  void post_force_templated(int);
#else
  void post_force_untemplated(int int, int, 
			      int, int, int);
#endif
  void omega_thermostat(int);
  void angmom_thermostat(int);

  int nlayers;
  double *count_one,*count_many;
  double offset,invdelta;
  int maxatomlayer,totalatom;
  int *layer;
  double *t_target;
};

}

#endif
#endif

/* ERROR/WARNING messages:

E: Illegal ... command

Self-explanatory.  Check the input script syntax and compare to the
documentation for the command.  You can use -echo screen as a
command-line option when running LAMMPS to see the offending line.

E: Fix langevin period must be > 0.0

The time window for temperature relaxation must be > 0

E: Fix langevin omega requires atom style sphere

Self-explanatory.

E: Fix langevin angmom requires atom style ellipsoid

Self-explanatory.

E: Variable name for fix langevin does not exist

Self-explanatory.

E: Variable for fix langevin is invalid style

It must be an equal-style variable.

E: Fix langevin omega requires extended particles

One of the particles has radius 0.0.

E: Fix langevin angmom requires extended particles

This fix option cannot be used with point paritlces.

E: Cannot zero Langevin force of 0 atoms

The group has zero atoms, so you cannot request its force
be zeroed.

E: Fix langevin variable returned negative temperature

Self-explanatory.

E: Could not find fix_modify temperature ID

The compute ID for computing temperature does not exist.

E: Fix_modify temperature ID does not compute temperature

The compute ID assigned to the fix must compute temperature.

W: Group for fix_modify temp != fix group

The fix_modify command is specifying a temperature computation that
computes a temperature on a different group of atoms than the fix
itself operates on.  This is probably not what you want to do.

*/
