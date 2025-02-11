#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Fe H FeH.meam Fe H
#------------------------------------------------------------------------
# B.-J. Lee et al., Acta Materialia, 55(20), 6779-6788.: https://doi.org/10.1016/j.actamat.2007.08.041
# 2007--Lee-B-J-Jang-J-W--Fe-H (NIST, Interatomic Potentials Repository): https://www.ctcms.nist.gov/potentials/entry/2007--Lee-B-J-Jang-J-W--Fe-H/
#------------------------------------------------------------------------
