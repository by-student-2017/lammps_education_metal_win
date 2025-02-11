#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Co Ni V Cr Fe Mn CoNiVCrFeMn.meam Co Ni V Cr Fe Mn
#------------------------------------------------------------------------
Binary parameters of the Co-Fe and V-Fe systems are revised based on the "Won-Mi Choi et al., CALPHAD 74 (2021) 102317".
The details of the modification are attached by ppt file, and modified binary LAMMPS parameters of the Co-Fe and V-Fe system are attached. 
Ternary parameters of Co-Fe or V-Fe containing systems also need to be changed due to modification of binary parameters. 
Therefore, the modified LAMMPS parameter of the V + Cantor system is also attached. 

Home of 2NN MEAM Interatomic Potential: https://cmse.postech.ac.kr/home_2nnmeam
#------------------------------------------------------------------------
