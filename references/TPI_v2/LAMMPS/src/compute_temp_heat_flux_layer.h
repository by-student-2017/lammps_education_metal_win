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

#ifdef COMPUTE_CLASS

ComputeStyle(temp/heat/flux/layer,ComputeTempHeatFluxLayer)

#else

#ifndef COMPUTE_TEMP_HEAT_FLUX_LAYER_H
#define COMPUTE_TEMP_HEAT_FLUX_LAYER_H

#include "stdio.h"
#include "compute.h"

namespace LAMMPS_NS {

class ComputeTempHeatFluxLayer : public Compute {
 public:
  ComputeTempHeatFluxLayer(class LAMMPS *, int, char **);
  ~ComputeTempHeatFluxLayer();
  void init();
  void compute_vector();

  void xvcm(int, double *, double *, int *);         // center-of-mass coords of group
  void angmom(int, double *, double *, int *);       // angular momentum of group
  void inertia(int, double *, double [3][3], int *); // inertia tensor
  void omega(double *, double [3][3], double *);     // angular velocity

 private:
  int me;
  int dim,angmomflag;
  double origin,delta;

  int nlayers;      // Number of layers or bins along x co-ordinate length of the system
  int maxlayer;
  double xscale,yscale,zscale;
  double *coord;
  double *count_one,*count_many;
  double offset,invdelta; 

  int triclinic;
  int periodicity;
  double *boxlo,*boxhi,*prd;

  int totalatom;
  int *layer;

  int fix_dof;
  double tfactor;
  void dof_compute();

  //double *eatom;
  char *id_ke,*id_pe,*id_stress;
  class Compute *c_ke,*c_pe,*c_stress;

};

}

#endif
#endif
