set ncore=4

rem mkdir cfg

Rem mpirun -np 4 lammps -in NaCl_kappa.in -log NaCl_kappa.log

for %%1 in (NaCl_kappa.in) do (
  "C:\Program Files\Microsoft MPI\Bin\mpiexec.exe" -np %ncore% "C:\Program Files\LAMMPS 64-bit 22Dec2022-MSMPI\bin\lmp.exe" -in %%1 -log NaCl_kappa.log
  echo input file: %%1
)


Rem corrplot.py NaCl_1200K.flux -s 1 -w 0.3
Rem kappa    = 0.610108 W/m/K
Rem kappa_xx = 0.859257 W/m/K
Rem kappa_yy = 0.546289 W/m/K
Rem kappa_zz = 0.424778 W/m/K

pause