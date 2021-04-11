REM "make data.pos from POSCAR"
findstr /V /I /R [a-z] < POSCAR > tmp.in

type in.map | .\latgen_cygwin\latgen.exe

del tmp.in


REM "fix phonon calculation"
cd data
del Phonon.*
cd ..

"C:\Program Files\LAMMPS 64-bit 18Jun2019\bin\lmp_serial.exe" -screen none -in in.lmp

type .\plot_settings\in.disp | .\phana_cygwin\phana.exe -in .\data\Phonon.bin.1200000
gnuplot .\plot_settings\plot.disp

type .\plot_settings\in.dos | .\phana_cygwin\phana.exe -in .\data\Phonon.bin.1200000
gnuplot .\plot_settings\plot.dos

del pdisp.gnuplot
del  pdos.gnuplot