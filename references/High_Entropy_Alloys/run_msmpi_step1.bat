set ncore=4
set OMP_NUM_THREADS=1

mkdir cfg

for %%1 in (in.lmp_step1_Relaxation) do (
  "C:\Program Files\Microsoft MPI\Bin\mpiexec.exe" -np %ncore% "C:\Program Files\LAMMPS 64-bit 22Dec2022-MSMPI\bin\lmp.exe" -in %%1 -var pistvel %pistvel% -var system_size 10 -var temp_equil %temp% -var press_equil 0.0
  echo input file: %%1
)

pause