type .\plot_settings\in.disp | .\phana_cygwin\phana.exe -in .\data\Phonon.bin.650000
findstr /V "post" < pdisp.gnuplot > tmp
findstr /V "pdisp.eps" < tmp > pdisp.gnuplot
echo set terminal pngcairo color enhanced font ",10" > plot.tmp
echo set out 'disp.png' >> plot.tmp
copy plot.tmp+pdisp.gnuplot plot.disp
"C:\Program Files\gnuplot\bin\gnuplot.exe" plot.disp

type .\plot_settings\in.dos | .\phana_cygwin\phana.exe -in .\data\Phonon.bin.650000
findstr /V "post" < pdos.gnuplot > tmp
findstr /V "pdos.eps" < tmp > pdos.gnuplot
echo set terminal pngcairo color enhanced font ",10" > plot.tmp
echo set out 'dos.png' >> plot.tmp
copy plot.tmp+pdos.gnuplot plot.dos
"C:\Program Files\gnuplot\bin\gnuplot.exe" plot.dos

move plot.disp .\plot_settings
move  plot.dos .\plot_settings

del plot.tmp
del pdisp.gnuplot
del pdos.gnuplot
del tmp
