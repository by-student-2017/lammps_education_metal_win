#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Nb Ti Zr Mo V NbTiZrMoV.meam Nb Ti Zr Mo V
#------------------------------------------------------------------------
High-Entropy alloy (HEA)
BCC structure (Lattice constant of unit cell: 3.1 [Angstrom])
20 x 20 x 20 supercell
16,000 atoms
time-step 1 fs
NPT
10,000 steps
300 K
duration 10 ps
#-------------------------------------------------------------
related information: https://github.com/Riaz-404/LAMMPS-HEA-tensile-script/tree/main
#-------------------------------------------------------------
