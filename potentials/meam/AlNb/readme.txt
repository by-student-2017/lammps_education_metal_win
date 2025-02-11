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
# R. Fereidonnejad et al., Comput. Mater. Sci. 213 (2022) 111685.: https://doi.org/10.1016/j.commatsci.2022.111685
# 2022--Fereidonnejad-R-Moghaddam-A-O-Moaddeli-M--Al-Nb (NIST, Interatomic Potentials Repository): https://www.ctcms.nist.gov/potentials/
#------------------------------------------------------------------------
