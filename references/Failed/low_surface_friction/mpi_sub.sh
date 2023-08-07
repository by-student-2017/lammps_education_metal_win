#!/bin/bash
## mpi_sub.sh
## generates and submits submission scipts for Grid Engine

EMAIL={EMAIL ADDRESS}
SHELL=/bin/bash
LOG=sub.log

## Is qstat in the path?
which qstat 2> /dev/null > /dev/null
if [ ! $? -eq 0 ]; then
echo "error: qstat not found" 1>&2
exit 1
fi

## Check command line arguments
if [ $# -eq 4 ]; then
JOBNAME=$1
NUMPROC=$2
EXECUTE=$3
HOWLONG=$4
else
echo "JOBNAME?"
read JOBNAME
echo "Number of Processors?"
read NUMPROC
echo "Which Binary?"
read EXECUTE
echo "How long? (int) (hours)"
read HOWLONG
fi

## create the input file
tmp=$( mktemp )
cat > $tmp << EOF
#!/bin/bash
#$ -N $JOBNAME
#$ -cwd

### Do merge stderr with stout
#$ -j y

### Send me mail
#$ -M $EMAIL
#$ -notify
#$ -m abe

### Which shell?
#$ -S $SHELL

#$ -o out.$JOBNAME.\$JOB_ID
#$ -pe ompi* $NUMPROC
#$ -l h_rt=$HOWLONG:00:00

export DEBUG_MPI=true
sge_mpirun $EXECUTE
EOF

## Submit to grid
qsub < $tmp

## Write the a log in pwd
echo -ne ‘date‘":$JOBNAME:" >> $LOG
tail -n 1 $tmp >> $LOG

## Move the temp file to pwd
mv $tmp .
