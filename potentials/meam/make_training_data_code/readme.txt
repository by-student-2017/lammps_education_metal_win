#---------------------------------------------------------------------
This is a test version.

pip install ase
sudo apt install quantum-espresso

gedit run_fcc_b1_pbe_v1.py
   (elements = ['Fe', 'Cr', 'Al'] # <- Enter the element you want to calculate)

python3 run_v1.py
#---------------------------------------------------------------------

#---------------------------------------------------------------------
Enter the pseudopotentials of the "pslibrary" here. The list is in PSlibrary_PBE.json.

I tried to add pseudopotentials, but github said it was full and wouldn't let me.
#---------------------------------------------------------------------

#---------------------------------------------------------------------
https://www.potfit.net/wiki/doku.php?id=config:main
#---------------------------------------------------------------------
potfit old format

 natoms
 boxx.x boxx.y boxx.z
 boxy.x boxy.y boxy.z
 boxz.x boxz.y boxz.z
 coh_eng
 stress_xx stress_yy stress_zz stress_yz stress_zx stress_xy
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
