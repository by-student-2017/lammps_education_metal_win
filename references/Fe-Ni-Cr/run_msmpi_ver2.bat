set ncore=1
set OMP_NUM_THREADS=1

for %%1 in (calc_fcc_ver2.in) do (
  "C:\Program Files\Microsoft MPI\Bin\mpiexec.exe" -np %ncore% "C:\Program Files\LAMMPS 64-bit 22Dec2022-MSMPI\bin\lmp.exe" -var latconst 4 -in %%1
  echo input file: %%1
)

pause