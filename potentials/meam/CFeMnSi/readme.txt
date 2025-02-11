#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * CFeMnSi.library.meam Fe Mn Si C CFeMnSi.meam Fe Mn Si C
#-------------------------------------------------------------
# I. Aslam et al., Materialia, 8 (2019) 100473.: https://doi.org/10.1016/j.mtla.2019.100473
# 2019--Aslam-I-Baskes-M-I-Dickel-D-E-et-al--Fe-Mn-Si-C (NIST, Interatomic Potentials Repository): https://www.ctcms.nist.gov/potentials/
#-------------------------------------------------------------
