#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Pd Cu PdCu.meam Pd Cu
#------------------------------------------------------------------------
# G.-U. Jeong et al., Calphad, 62 (2018) 172-186.: https://doi.org/10.1016/j.calphad.2018.06.006
# 2018--Jeong-G-U-Park-C-S-Do-H-S-et-al--Pd-Cu (NIST, Interatomic Potentials Repository): https://www.ctcms.nist.gov/potentials/
#------------------------------------------------------------------------
