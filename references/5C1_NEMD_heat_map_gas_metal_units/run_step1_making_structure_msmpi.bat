set ncore=4

rem mkdir cfg

for %%1 in (making_structure.in) do (
  "C:\Program Files\Microsoft MPI\Bin\mpiexec.exe" -np %ncore% "C:\Program Files\LAMMPS 64-bit 22Dec2022-MSMPI\bin\lmp.exe" -in %%1
  echo input file: %%1
)

pause