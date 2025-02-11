#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Al Nb AlNb.meam Al Nb
#------------------------------------------------------------------------
LAMMPS potential parameter files for Mo-Co-Ni-V-Fe-Al-Cr system
Jaemin Wang, Hyeonseok Kwon, Hyoung Seop Kim, and Byeong-Joo Lee, A Neural Network Model for High Entropy Alloy Design, npj Computational Materials (2023), accepted.
https://www.nature.com/articles/s41524-023-01010-x (Open Access) (see Supplementary Information)
#-----------------------------------------------------------------------------------------------
related information: https://github.com/Asia-liu/molecular-dynamics-and-crystal-plasticity/tree/main/MD
#-----------------------------------------------------------------------------------------------
