type .\plot_settings\in.disp | .\phana_cygwin\phana.exe -in .\data\Phonon.bin.1200000
gnuplot .\plot_settings\plot.disp

type .\plot_settings\in.dos | .\phana_cygwin\phana.exe -in .\data\Phonon.bin.1200000
gnuplot .\plot_settings\plot.dos

del pdisp.gnuplot
del  pdos.gnuplot