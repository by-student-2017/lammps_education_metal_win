#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Ni Mn NiMn.meam Ni Mn
#------------------------------------------------------------------------
# W.-M. Choi et al., omputational Materials Science, 130 (2017) 121-129.: https://doi.org/10.1016/j.commatsci.2017.01.002
# 2017--Choi-W-M-Kim-Y-Seol-D-Lee-B-J--Mn-Ni (NIST, Interatomic Potentials Repository): https://www.ctcms.nist.gov/potentials/
#------------------------------------------------------------------------
