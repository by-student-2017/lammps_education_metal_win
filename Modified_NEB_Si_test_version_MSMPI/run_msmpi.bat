set ncore=4
set OMP_NUM_THREADS=1

"C:\Program Files\Microsoft MPI\Bin\mpiexec.exe" -np %ncore% "C:\Program Files\LAMMPS 64-bit 22Dec2022-MSMPI\bin\lmp.exe" -partition %ncore%x1 -in in.neb.sivac

python3 neb_final.py -o dump.neb.final -r dump.neb.sivac.* -n %ncore%

pause