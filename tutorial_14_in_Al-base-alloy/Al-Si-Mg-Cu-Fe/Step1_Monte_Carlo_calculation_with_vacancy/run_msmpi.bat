set ncore=10
set OMP_NUM_THREADS=1

mkdir cfg

for %%1 in (in.lmp) do (
  "C:\Program Files\Microsoft MPI\Bin\mpiexec.exe" -np %ncore% "C:\Program Files\LAMMPS 64-bit 22Dec2022-MSMPI\bin\lmp.exe" -in %%1
  echo input file: %%1
)

rem call plot_rdf.bat

pause