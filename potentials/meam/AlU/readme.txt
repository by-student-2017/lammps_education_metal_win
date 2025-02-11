#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Al U AlU.meam Al U
#------------------------------------------------------------------------
# M.I. Pascuet et al., Journal of Nuclear Materials, 467 (2015) 229-239.: https://doi.org/10.1016/j.jnucmat.2015.09.030
# 2015--Pascuet-M-I-Fernandez-J-R--Al-U (NIST, Interatomic Potentials Repository): https://www.ctcms.nist.gov/potentials/
#------------------------------------------------------------------------
