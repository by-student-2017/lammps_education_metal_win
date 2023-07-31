#$ -S /bin/tcsh
#$ -N tpi 
#$ -pe orte 24 
#$ -cwd
#$ -o out_run.log -j y
/opt/openmpi/bin/mpirun -bycore -bind-to-core  --mca btl openib,self -np $NSLOTS  lmp_linux < in.sinusoidal 
