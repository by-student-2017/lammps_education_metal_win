#!/bin/bash
#------------ Script for running energy minimization in LAMMPS for various values of sigma -
#------------ Using for loop to change the sigma values from 1.15 to 1.80 -----------------------------
for i in 1.15 1.16 1.17 1.18 1.19 1.20 1.21 1.22 1.23 1.24 1.25
1.26 1.27 1.28 1.29 1.30 1.31 1.32 1.33 1.34 1.35 1.36 1.37
1.38 1.39 1.40 1.41 1.418 1.42 1.43 1.44 1.45 1.46 1.47 1.48
1.49 1.50 1.51 1.52 1.53 1.54 1.55 1.56 1.57 1.58 1.59 1.60
1.61 1.62 1.63 1.64 1.65 1.66 1.67 1.68 1.69 1.70 1.71 1.72
1.73 1.74 1.75 1.76 1.77 1.78 1.79 1.80
do
cat >B4C_Dugan_et.al_Original_SW.sw <<! 
# eps sigma a lambda gamma cos(theta) A B p q tol
B B B 1.0000 $i 1.8179 1.0007 0.3241 -0.33333 13.4487 0.0848 4.0000 0.0000 0.0000
!
#--------------------------------------------- Run LAMMPS --------------------------------------------------
echo `lmp_daily -in in.BC >> logfile.dat` # Execute LAMMPS in ubuntu 
mv dump_minimized.dat dump_minimized.$i.dat # Renaming each dump file 
mv xyz_minimized.lmp xyz_minimized_$i.lmp # Renaming each minimized structures 
echo "Minimization process sigma=$i complete" # Displaying no. of minimization process
done
mkdir DUMP # Make a DUMP directory 
mkdir Minimized_Structures # Make a Minimized_Structures directory
mv dump* DUMP # Move all the dump files to DUMP 
mv xyz_minimized* Minimized_Structures # Move all the minimized structures 
#------------------------------------------------ The End -------------------------------------------------------
