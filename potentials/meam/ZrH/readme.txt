#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Zr H ZrH.meam Zr H
#------------------------------------------------------------------------
# B.-M. Lee et al., Metallurgical and Materials Transactions A, 45 (2014) 2906-2915.: https://doi.org/10.1007/s11661-014-2230-4
# 2014--Lee-B-M-Lee-B-J--Zr-H (NIST, Interatomic Potentials Repository)
# or
# Home of 2NN MEAM Interatomic Potential: https://cmse.postech.ac.kr/home_2nnmeam
#------------------------------------------------------------------------
