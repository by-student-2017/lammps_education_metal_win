set ncore=8
set OMP_NUM_THREADS=1

rem mkdir cfg
rem mkdir dump

for %%1 in (in.lmp) do (
  "C:\Program Files\Microsoft MPI\Bin\mpiexec.exe" -np %ncore% "C:\Program Files\LAMMPS 64-bit 22Dec2022-MSMPI\bin\lmp.exe" -in %%1
  echo input file: %%1
)

fit_eos.gpl

pause