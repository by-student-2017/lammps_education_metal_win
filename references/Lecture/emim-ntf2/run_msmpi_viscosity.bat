set ncore=4

rem mkdir cfg

for %%1 in (emim-ntf2_viscosity.in) do (
  "C:\Program Files\Microsoft MPI\Bin\mpiexec.exe" -np %ncore% "C:\Program Files\LAMMPS 64-bit 22Dec2022-MSMPI\bin\lmp.exe" -in %%1 -log emim-ntf2_viscosity.log
  echo input file: %%1
)

Rem corrplot.py emim-ntf2.flux -w 2500
Rem eta    = 0.233233 Pa·s
Rem eta_xy = 0.280396 Pa·s
Rem eta_xz = 0.139562 Pa·s
Rem eta_yz = 0.27974 Pa·s

pause