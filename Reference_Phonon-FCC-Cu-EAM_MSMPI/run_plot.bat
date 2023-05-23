type .\plot_settings\in.disp | .\phana_cygwin\phana.exe -in .\data\Phonon.bin.650000
"C:\Program Files\gnuplot\bin\gnuplot.exe" .\plot_settings\plot.disp

type .\plot_settings\in.dos | .\phana_cygwin\phana.exe -in .\data\Phonon.bin.650000
"C:\Program Files\gnuplot\bin\gnuplot.exe" .\plot_settings\plot.dos

del pdisp.gnuplot
del  pdos.gnuplot