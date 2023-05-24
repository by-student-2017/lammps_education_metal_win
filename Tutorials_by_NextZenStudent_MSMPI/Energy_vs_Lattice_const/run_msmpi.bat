set ncore=4

for %%i in (2.7 2.8 2.9 3.0 3.1 3.2 3.3 3.4 3.5 3.6 3.7 3.8 3.9 4.0 4.1 4.2 4.3 4.4 4.5 4.6) do (

  copy lattice_vs_energy.p1.lmp tmp.lmp

  echo variable latconst equal %%i >> tmp.lmp

  copy /b tmp.lmp + lattice_vs_energy.p2.lmp y.txt

  "C:\Program Files\Microsoft MPI\Bin\mpiexec.exe" -np %ncore% "C:\Program Files\LAMMPS 64-bit 22Dec2022-MSMPI\bin\lmp.exe" -in y.txt

  del tmp.lmp
)

plot.gnu.gpl

pause