#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * CFeMnSi.library.meam Fe Mn Si C CFeMnSi.meam Fe Mn Si C
#-------------------------------------------------------------
# 
# 2019--Aslam-I-Baskes-M-I-Dickel-D-E-et-al--Fe-Mn-Si-C
#-------------------------------------------------------------
