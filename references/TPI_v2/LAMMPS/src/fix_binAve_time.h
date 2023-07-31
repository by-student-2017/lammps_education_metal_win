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

#ifdef FIX_CLASS

FixStyle(binAve/time,FixBinAveTime)

#else

#ifndef LMP_FIX_BIN_AVE_TIME_H
#define LMP_FIX_BIN_AVE_TIME_H

#include "stdio.h"
#include "fix.h"

namespace LAMMPS_NS {

class FixBinAveTime : public Fix {
 public:
  FixBinAveTime(class LAMMPS *, int, char **);
  ~FixBinAveTime();
  int setmask();
  void init();
  void setup(int);
  void end_of_step();
  double compute_scalar();
  double compute_vector(int);
  double compute_array(int,int);
  void reset_timestep(bigint);

 private:
  int me,nvalues;
  int nrepeat,nfreq,irepeat;
  bigint nvalid;
  int *which,*argindex,*value2index,*offcol;
  char **ids;
  FILE *fp;
  int nrows;

  int ave,nwindow,nsum,startstep,mode;
  int noff,overwrite;
  int *offlist;
  char *title1,*title2,*title3;
  long filepos;

  int norm,iwindow,window_limit;
  double *vector;
  double *vector_total;
  double **vector_list;
  double *column;
  double **array;
  double **array_total;
  double ***array_list;
  char strone[128];
  int nlayers, ncols;

  void invoke_scalar(bigint);
  void invoke_vector(bigint);
  void options(int, char **);
  void allocate_values(int);
  bigint nextvalid();
};

}

#endif
#endif

/* ERROR/WARNING messages:

E: Illegal ... command

Self-explanatory.  Check the input script syntax and compare to the
documentation for the command.  You can use -echo screen as a
command-line option when running LAMMPS to see the offending line.

E: Compute ID for fix binAve/time does not exist

Self-explanatory.

E: Fix ID for fix binAve/time does not exist

Self-explanatory.

E: Invalid fix binAve/time off column

Self-explantory.

E: Fix binAve/time compute does not calculate a scalar

Self-explantory.

E: Fix binAve/time compute does not calculate a vector

Self-explantory.

E: Fix binAve/time compute vector is accessed out-of-range

The index for the vector is out of bounds.

E: Fix binAve/time compute does not calculate an array

Self-explanatory.

E: Fix binAve/time compute array is accessed out-of-range

An index for the array is out of bounds.

E: Fix binAve/time fix does not calculate a scalar

Self-explanatory.

E: Fix binAve/time fix does not calculate a vector

Self-explanatory.

E: Fix binAve/time fix vector is accessed out-of-range

The index for the vector is out of bounds.

E: Fix for fix binAve/time not computed at compatible time

Fixes generate their values on specific timesteps.  Fix binAve/time
is requesting a value on a non-allowed timestep.

E: Fix binAve/time fix does not calculate an array

Self-explanatory.

E: Fix binAve/time fix array is accessed out-of-range

An index for the array is out of bounds.

E: Variable name for fix binAve/time does not exist

Self-explanatory.

E: Fix binAve/time variable is not equal-style variable

Self-explanatory.

E: Fix binAve/time cannot use variable with vector mode

Variables produce scalar values.

E: Fix binAve/time columns are inconsistent lengths

Self-explanatory.

E: Fix binAve/time cannot set output array intensive/extensive from these inputs

One of more of the vector inputs has individual elements which are
flagged as intensive or extensive.  Such an input cannot be flagged as
all intensive/extensive when turned into an array by fix binAve/time.

E: Cannot open fix binAve/time file %s

The specified file cannot be opened.  Check that the path and name are
correct.

E: Fix binAve/time missed timestep

You cannot reset the timestep to a value beyond where the fix
expects to next perform averaging.

*/
