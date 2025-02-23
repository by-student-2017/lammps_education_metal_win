#---------------------------------------------------------------------
This is a test version.

pip install ase
sudo apt install quantum-espresso

gedit run_fcc_b1_pbe_v1.py
   (elements = ['Fe', 'Cr', 'Al'] # <- Enter the element you want to calculate)

python3 run_v1.py
#---------------------------------------------------------------------

#---------------------------------------------------------------------
## pseudopotentials
Enter the pseudopotentials of the "pslibrary" to PBE or PBEsol directory. The list is in PSlibrary_PBE.json or PSlibrary_PBEsol.json .
PBE: https://pseudopotentials.quantum-espresso.org/legacy_tables/ps-library
PBEsol: generate on q-e-qe-6.3 with pslibrary.1.0.0.tar.gz (https://dalcorso.github.io/pslibrary/)
Note: https://dalcorso.github.io/pslibrary/PP_list.html <- The potential version was selected based on the description on this page.

I tried to add pseudopotentials, but github said it was full and wouldn't let me.
So I uploaded it on "Zenodo".
STUDENT, B. (2025). SUGGESTED PSEUDOPOTENTIALS for PBEsol v.1.0.0 [Data set]. Zenodo. https://doi.org/10.5281/zenodo.14912399
STUDENT, B. (2025). SUGGESTED PSEUDOPOTENTIALS for PBE v.1.0.0 [Data set]. Zenodo. https://doi.org/10.5281/zenodo.14912402
#---------------------------------------------------------------------

#---------------------------------------------------------------------
Potfit: https://www.potfit.net/wiki/doku.php?id=config:main
Note: potfit fits the stress tensor, not the elastic constants. I also have a very hard time calculating the elastic constants correctly, so I've decided to comment out the calculation and output of the elastic constants.
#---------------------------------------------------------------------
potfit format

 #N natoms useforce
 #C type_0 type_1 type_2 ...
 #X boxx.x boxx.y boxx.z
 #Y boxy.x boxy.y boxy.z
 #Z boxz.x boxz.y boxz.z
 #B_S x y z r
 #B_O x y z
 #B_A x y z
 #B_B x y z
 #B_C x y z
 #W weight
 #E coh_eng
 #S stress_xx stress_yy stress_zz stress_xy stress_yz stress_xz
 #F 

The lines starting with #N, #X, #Y, #Z, #E and #F are mandatory, while the lines starting with #C, #W, #B and #S are optional. All other lines are ignored. #N must head the first line specifying the number of atoms in the configuration and an integer flag to control whether to use or to ignore force and stress information in this configuration. #F signifies the last header line. All parameters except the type_i are numbers and have the following meaning:
#---------------------------------------------------------------------
Potfit: https://www.potfit.net/wiki/doku.php?id=examples:configurations

#N 4 1
#C Al
## force file generated from file OUTCAR
#X    4.04836934    0.00000000    0.00000000
#Y    0.00000000    4.04836934    0.00000000
#Z    0.00000000    0.00000000    4.04836934
#W 1.000000
#E -3.6884100000
## type x y z f_x f_y f_z
#F
0           0           0           0           0           0           0
0           0     2.02418     2.02418           0           0           0
0     2.02418           0     2.02418           0           0           0
0     2.02418     2.02418           0           0           0           0
#N 4 1
#C Al
## force file generated from file OUTCAR
#X    4.04836934    0.00000000    0.00000000
#Y    0.00000000    4.04836934    0.00000000
#Z    0.00000000    0.00000000    4.04836934
#W 1.000000
#E -3.0536245000
#S   0.0954432   0.1134831   0.1081461  0.02513733  0.04822722 -0.001235955
## type x y z f_x f_y f_z
#F
0     0.40484     0.60726      0.4858   -3.544691   -5.412783   -4.538642
0           0     2.02418     2.02418   -1.035276    3.504476    3.673407
0     2.02418           0     2.02418    1.799793   -0.736215    1.791375
0     2.02418     2.02418           0    2.780173    2.644523   -0.926139
#---------------------------------------------------------------------


#---------------------------------------------------------------------
MPC v4: https://www.cavs.msstate.edu/icme/code/lammps/tutorials/MEAM/MPC.php
#---------------------------------------------------------------------


#---------------------------------------------------------------------
Zenodo
Figshare
OSF (Open Science Framework)
#---------------------------------------------------------------------
