set ncore=4

rem mkdir cfg

Rem make_il.py --c2c1im 27 --ntf2 27 -o emim-ntf2
Rem (You can get "emim-ntf2.data")

Rem mpirun -np 4 lammps -in emim-ntf2.in -log emim-ntf2.log

for %%1 in (emim-ntf2.in) do (
  "C:\Program Files\Microsoft MPI\Bin\mpiexec.exe" -np %ncore% "C:\Program Files\LAMMPS 64-bit 22Dec2022-MSMPI\bin\lmp.exe" -in %%1 -log emim-ntf2.log
  echo input file: %%1
)


Rem logplot.py emim-ntf2.log -k TotEng Temp Density -w 130 180 -o log.png
Rem TotEng = 492.565 +/- 27.09
Rem Temp = 297.951 +/- 7.64848
Rem Density = 1.46358 +/- 0.0136792

pause