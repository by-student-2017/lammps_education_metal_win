REM mkdir cfg

REM 4 core case
"C:\Program Files\MPICH2\bin\mpiexec.exe" -np 4 "C:\Program Files\LAMMPS 64-bit 18Jun2019-MPI\bin\lmp_mpi.exe" -partition 4x1 -in in.neb.hop1
"C:\Program Files\MPICH2\bin\mpiexec.exe" -np 4 "C:\Program Files\LAMMPS 64-bit 18Jun2019-MPI\bin\lmp_mpi.exe" -partition 4x1 -in in.neb.hop2
"C:\Program Files\MPICH2\bin\mpiexec.exe" -np 4 "C:\Program Files\LAMMPS 64-bit 18Jun2019-MPI\bin\lmp_mpi.exe" -partition 4x1 -in in.neb.hop1.end
"C:\Program Files\MPICH2\bin\mpiexec.exe" -np 3 "C:\Program Files\LAMMPS 64-bit 18Jun2019-MPI\bin\lmp_mpi.exe" -partition 3x1 -in in.neb.sivac

REM 8 core case
REM "C:\Program Files\MPICH2\bin\mpiexec.exe" -np 8 "C:\Program Files\LAMMPS 64-bit 18Jun2019-MPI\bin\lmp_mpi.exe" -partition 4x2 -in in.neb.hop1
REM "C:\Program Files\MPICH2\bin\mpiexec.exe" -np 8 "C:\Program Files\LAMMPS 64-bit 18Jun2019-MPI\bin\lmp_mpi.exe" -partition 4x2 -in in.neb.hop2
REM "C:\Program Files\MPICH2\bin\mpiexec.exe" -np 8 "C:\Program Files\LAMMPS 64-bit 18Jun2019-MPI\bin\lmp_mpi.exe" -partition 4x2 -in in.neb.hop1.end
REM "C:\Program Files\MPICH2\bin\mpiexec.exe" -np 8 "C:\Program Files\LAMMPS 64-bit 18Jun2019-MPI\bin\lmp_mpi.exe" -partition 4x2 -in in.neb.sivac

set LAMMPS_PYTHON_TOOLS=c:\users\inukai\appdata\local\programs\python\python38\lib\site-packages\pizza

python3 neb_combine.py -o dump.hop1.combine -b dump.nonneb.1 -r dump.neb.*

python3 neb_final.py -o dump.hop1.final -b dump.nonneb.1 -r dump.neb.*

pause