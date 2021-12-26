mkdir cfg

REM %%i/10 = 0.01 [nm] step
for /l %%i in (0, 1, 40) do (

  echo clear >> tmp.lmp
  echo variable x_displace equal %%i/10 >> tmp.lmp
  
  copy /b tmp.lmp + in.p1.lmp in.lmp

  "C:\Program Files\LAMMPS 64-bit 18Jun2019\bin\lmp_serial.exe" -in in.lmp
  
  cd cfg
  move run.init.cfg   run.init.%%i.cfg
  move run.finish.cfg run.finish.%%i.cfg
  cd ..

  del tmp.lmp
)

plot.gnu.gpl