#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Ni Cu NiCu.meam Ni Cu
#------------------------------------------------------------------------
# B.-J. Lee et al., Calphad 28 (2004) 125-132. https://doi.org/10.1016/j.calphad.2004.06.001
# 2004--Lee-B-J-Shim-J-H--Cu-Ni (NIST, Interatomic Potentials Repository): https://www.ctcms.nist.gov/potentials/
#------------------------------------------------------------------------
