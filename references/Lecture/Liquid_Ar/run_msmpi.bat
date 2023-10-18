set ncore=4
set OMP_NUM_THREADS=1

rem mkdir cfg

Rem mpirun -np 4 lammps -in Ar_nvt.in -log Ar_nvt.log

for %%1 in (Ar_nvt.in) do (
  "C:\Program Files\Microsoft MPI\Bin\mpiexec.exe" -np %ncore% "C:\Program Files\LAMMPS 64-bit 22Dec2022-MSMPI\bin\lmp.exe" -in %%1 -log Ar_nvt.log
  echo input file: %%1
)


Rem logplot.py Ar_nvt.log -k TotEng Temp -w 200 330 -o log.png
Rem Total run: 2
Rem keywords: [Step, Temp, TotEng, Press, Volume, Density]
Rem Ar_nvt.log: TotEng = -966.261 +/- 9.10696
Rem Ar_nvt.log: Temp = 94.5187 +/- 2.50601

Rem grplot.py Ar_nvt.gr -o gr.png

Rem msdplot.py -w 10 30 Ar_nvt.msd -o msd.png
Rem Ar_nvt.msd: D=2.4e-09 m2/s

pause