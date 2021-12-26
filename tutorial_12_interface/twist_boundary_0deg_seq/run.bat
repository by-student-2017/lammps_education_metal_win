mkdir cfg

for %%i in (0.0 0.2 0.4 0.6 0.8 1.0 1.2 1.4 1.6 1.8 2.0 2.2 2.4 2.6 2.8 3.0 3.2 3.4 3.6 3.8 4.0) do (

  echo clear >> tmp.lmp
  echo variable x_displace equal %%i >> tmp.lmp
  
  copy /b tmp.lmp + in.p1.lmp in.lmp

  "C:\Program Files\LAMMPS 64-bit 18Jun2019\bin\lmp_serial.exe" -in in.lmp
  
  cd cfg
  move run.init.cfg   run.init.%%i.cfg
  move run.finish.cfg run.finish.%%i.cfg
  cd ..

  del tmp.lmp
)

plot.gnu.gpl