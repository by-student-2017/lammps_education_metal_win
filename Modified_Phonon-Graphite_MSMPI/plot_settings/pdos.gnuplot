
set xlabel "frequency (THz)"
set ylabel "Phonon DOS"
unset key
plot "dos.dat" u 1:2 w l
