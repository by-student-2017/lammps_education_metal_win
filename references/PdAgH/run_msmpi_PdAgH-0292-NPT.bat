set ncore=4
set OMP_NUM_THREADS=1

mkdir cfg
mkdir xlength_vs_cohesive_energy

for %%1 in (PdAgH-0292-NPT.in) do (
  "C:\Program Files\Microsoft MPI\Bin\mpiexec.exe" -np %ncore% "C:\Program Files\LAMMPS 64-bit 22Dec2022-MSMPI\bin\lmp.exe" -in %%1
  echo input file: %%1
)

pause