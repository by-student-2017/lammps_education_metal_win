#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Cu H CuH.meam Cu H
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Zr Cu H ZrCuH.meam Zr Cu H
#------------------------------------------------------------------------
# B.-M. Lee et al., Metallurgical and Materials Transactions A, 45 (2014) 2906-2915.: https://doi.org/10.1007/s11661-014-2230-4
# Home of 2NN MEAM Interatomic Potential: https://cmse.postech.ac.kr/home_2nnmeam
#------------------------------------------------------------------------
