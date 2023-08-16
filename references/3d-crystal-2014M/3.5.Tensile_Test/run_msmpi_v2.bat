set ncore=4

mkdir cfg

for %%1 in (in_v2.lmp) do (
  "C:\Program Files\Microsoft MPI\Bin\mpiexec.exe" -np %ncore% "C:\Program Files\LAMMPS 64-bit 22Dec2022-MSMPI\bin\lmp.exe" -in %%1
  echo input file: %%1
)

plot_stress_vs_strain.gpl

plot_rdf_all.gpl

pause