#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Ti Al N TiAlN.meam Ti Al N
#------------------------------------------------------------------------
# Development and application of a ternary Ti-Al-N interatomic potential for Ti2AlN/TiAl composite
# P. Liu et al., J. Alloys. Compd. 745 (2018) 63-74.: https://doi.org/10.1016/j.jallcom.2018.02.168
#------------------------------------------------------------------------
