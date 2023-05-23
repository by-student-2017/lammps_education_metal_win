REM "make data.pos from POSCAR"
findstr /V /I /R [a-z] < POSCAR > tmp.in

type in.map | .\latgen_cygwin\latgen.exe

del tmp.in


REM "fix phonon calculation"
mkdir data
cd data
del Phonon.*
cd ..

"C:\Program Files\LAMMPS 64-bit 18Jun2019\bin\lmp_serial.exe" -screen none -in in.lmp

type .\plot_settings\in.disp | .\phana_cygwin\phana.exe -in .\data\Phonon.bin.650000
findstr /V "post" < pdisp.gnuplot > tmp
findstr /V "pdisp.eps" < tmp > pdisp.gnuplot
echo set terminal pngcairo color enhanced font ",10" > plot.tmp
echo set out 'disp.png' >> plot.tmp
copy plot.tmp+pdisp.gnuplot plot.disp
gnuplot plot.disp

type .\plot_settings\in.dos | .\phana_cygwin\phana.exe -in .\data\Phonon.bin.650000
findstr /V "post" < pdos.gnuplot > tmp
findstr /V "pdos.eps" < tmp > pdos.gnuplot
echo set terminal pngcairo color enhanced font ",10" > plot.tmp
echo set out 'dos.png' >> plot.tmp
copy plot.tmp+pdos.gnuplot plot.dos
gnuplot plot.dos

move plot.disp .\plot_settings
move  plot.dos .\plot_settings

del plot.tmp
del pdisp.gnuplot
del pdos.gnuplot
del tmp
