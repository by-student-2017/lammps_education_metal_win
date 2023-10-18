set ncore=4
set OMP_NUM_THREADS=1

rem mkdir cfg

Rem mpirun -np 4 lammps -in NaCl.in -log NaCl.log

for %%1 in (NaCl.in) do (
  "C:\Program Files\Microsoft MPI\Bin\mpiexec.exe" -np %ncore% "C:\Program Files\LAMMPS 64-bit 22Dec2022-MSMPI\bin\lmp.exe" -in %%1 -log NaCl.log
  echo input file: %%1
)


Rem logplot.py NaCl.log -k TotEng Temp Density

Rem grplot.py  NaCl_300K.gr NaCl_1200K.gr  -o gr.png

Rem msdplot.py Na_1200K.msd Cl_1200K.msd -w 15 20
Rem Na_1200K.msd: D=1.26e-08 m2/s
Rem Cl_1200K.msd: D=1.08e-08 m2/s

pause