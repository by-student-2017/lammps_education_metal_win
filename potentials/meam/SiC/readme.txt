#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Si C SiC.meam Si C
#------------------------------------------------------------------------
# K.-H. Kang, et al., (2014) J Crys. Growth 389, 120-133.
# 2014--Kang-K-H-Eun-T-Jun-M-C-Lee-B-J--Si-C (NIST, Interatomic Potentials Repository): https://www.ctcms.nist.gov/potentials/
#------------------------------------------------------------------------
