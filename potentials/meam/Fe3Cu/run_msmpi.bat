set ncore=8
set OMP_NUM_THREADS=1

rem rmdir cfg
rem mkdir cfg

for %%1 in (Fe3Cu_in.meam) do (
  "C:\Program Files\Microsoft MPI\Bin\mpiexec.exe" -np %ncore% "C:\Program Files\LAMMPS 64-bit 22Dec2022-MSMPI\bin\lmp.exe" -in %%1
  echo input file: %%1
)

rem plot_stress_vs_strain_v2.gpl

pause