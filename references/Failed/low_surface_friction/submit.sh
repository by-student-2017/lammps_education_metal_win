#!/bin/bash
## submit.sh
## SUBMISSION SCRIPT FOR LAMMPS RUNS

SERIES=RUNS

## Here we give a list of the approximants used
## the file name for each approximant should
## be $APPROX.struct
APPROXS="big-t11-A big-t11-B big-t11-C"
SLIDING_VELOCITY=0.01

## For each approximant
for sample in $APPROXS; do
## set the file name for the struct file
struct=$sample.struct
## create a subdirectory for this approximant
mkdir $sample
cd $sample
## we will be sliding in the y and z directions
for direction in y z; do
if [ "$direction" = "y" ]; then
## Set the sliding velocity
## and turn the thermostat off along
## the y-axis
vel="$SLIDING_VELOCITY 0"
therm="0 1"
fi
if [ "$direction" = "z" ]; then
vel="0 0.01"
therm="1 0"
fi
## For each compression (in timesteps)
for compression in 20000 40000 60000 80000 100000; do
## if the directory already exists, skip it
if [ -d $direction\_$compression ]; then
continue
echo $direction\_$compression skipped
fi
## if it does not, make a directory for the
## sliding direction and compression
mkdir $direction\_$compression
cd $direction\_$compression
## prepare the input file by replacing
## angle bracketed variables
sed -e "s|<DIRECTION>|$therm|" \
-e "s|<velocities>|$vel|" \
-e "s|<SAMPLE>|$struct|" \
-e "s|<LOWER>|$compression|"\
< $CWD/template.in > run.in
## submit to the grid engine via mpi_sub.sh
echo -e "MD$direction\_$compression\n8\nlmp<run.in\n200\n"\
| mpi_sub.sh
cd ..
done
done
cd ..
done

