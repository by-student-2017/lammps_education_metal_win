#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Al Ni AlNi.meam Al Ni
#------------------------------------------------------------------------
# A.C. Silva et al., Calphad, 31 (2007) 53-74.: https://doi.org/10.1016/j.calphad.2006.02.006
# 2007--Silva-A-C-Agren-J-Clavaguera-Mora-M-T-et-al--Al-Ni (NIST, Interatomic Potentials Repository): https://www.ctcms.nist.gov/potentials/
#------------------------------------------------------------------------
