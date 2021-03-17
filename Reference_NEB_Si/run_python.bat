set LAMMPS_PYTHON_TOOLS=c:\users\inukai\appdata\local\programs\python\python38\lib\site-packages\pizza

python3 neb_combine.py -o dump.hop1.combine -b dump.nonneb.1 -r dump.neb.*

python3 neb_final.py -o dump.hop1.final -b dump.nonneb.1 -r dump.neb.*

pause