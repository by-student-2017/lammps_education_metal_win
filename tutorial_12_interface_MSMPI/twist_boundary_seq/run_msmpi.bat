set ncore=4
set OMP_NUM_THREADS=1

mkdir cfg

REM %%i/20 = 0.005 [nm] * 2 step
for /l %%i in (-10,2,80) do (

  echo clear >> tmp.lmp
  echo variable x_displace equal %%i/20 >> tmp.lmp
  
  copy /b tmp.lmp + in.p1.lmp in.lmp

  "C:\Program Files\Microsoft MPI\Bin\mpiexec.exe" -np %ncore% "C:\Program Files\LAMMPS 64-bit 22Dec2022-MSMPI\bin\lmp.exe" -in in.lmp
  
  cd cfg
  move run.init.cfg   run.init.%%i.cfg
  move run.finish.cfg run.finish.%%i.cfg
  cd ..

  del tmp.lmp
)

plot.gnu.gpl