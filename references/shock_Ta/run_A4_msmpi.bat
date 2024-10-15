set ncore=8
set OMP_NUM_THREADS=1

rem mkdir cfg
mkdir dump

for %%1 in (in_A4_Quasi_Isentropic_Loading.lmp) do (
  "C:\Program Files\Microsoft MPI\Bin\mpiexec.exe" -np %ncore% "C:\Program Files\LAMMPS 64-bit 22Dec2022-MSMPI\bin\lmp.exe" -in %%1
  echo input file: %%1
)

plot_stress_vs_strain_v2.gpl

pause