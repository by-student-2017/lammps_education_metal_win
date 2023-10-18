set ncore=4
set OMP_NUM_THREADS=1

rem mkdir cfg

Rem mpirun -np 4 lammps -in emim-ntf2-1.in -log emim-ntf2-1.log

for %%1 in (emim-ntf2-1.in) do (
  "C:\Program Files\Microsoft MPI\Bin\mpiexec.exe" -np %ncore% "C:\Program Files\LAMMPS 64-bit 22Dec2022-MSMPI\bin\lmp.exe" -in %%1 -log emim-ntf2-1.log
  echo input file: %%1
)

Rem grplot.py CR-F,CT-F.gr

Rem msdplot.py CR_300K.msd F_300K.msd -w 50 100 -o msd.png
Rem CR_300K.msd: D=2.58e-11 m2/s
Rem F_300K.msd: D=1.03e-10 m2/s

pause