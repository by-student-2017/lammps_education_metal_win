#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Cu C CuC.meam Cu C
#------------------------------------------------------------------------
# A. Agrawal et al., Computational Materials Science, 188 (2021) 110204.: https://doi.org/10.1016/j.commatsci.2020.110204
# 2021--Agrawal-A-Mirzaeifar-R--Cu-C (NIST, Interatomic Potentials Repository): https://www.ctcms.nist.gov/potentials/
#------------------------------------------------------------------------
