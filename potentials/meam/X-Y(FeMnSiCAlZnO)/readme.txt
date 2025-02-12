#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Fe Cr Ni N FeCrNiN.meam Fe Ni
#------------------------------------------------------------------------
# I. Aslam, Theses (2018).: https://scholarsjunction.msstate.edu/td/351 
# C-Fe-Mn-Si: 2019--Aslam-I-Baskes-M-I-Dickel-D-E-et-al--Fe-Mn-Si-C in NIST (Interatomic Potentials Repository)
#------------------------------------------------------------------------
