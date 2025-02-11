#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Fe C H FeCH.meam Fe C H
#------------------------------------------------------------------------
# A Modified Embedded Atom Method (MEAM) Interatomic Potential for the Fe-C-H System
# S. Mun et al., arXiv:2109.01712
# https://doi.org/10.48550/arXiv.2109.01712
#------------------------------------------------------------------------
