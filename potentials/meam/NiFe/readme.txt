#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Ni Fe NiFe.meam Ni Fe
#------------------------------------------------------------------------
# Modified embedded-atom method interatomic potential for Fe-Ni, Cr-Ni and Fe-Cr-Ni systems Changjun Wu, Byeong-Joo Lee, Xuping Su, CALPHAD 57, 98-106 (2017).
# Home of 2NN MEAM Interatomic Potential: https://cmse.postech.ac.kr/home_2nnmeam
#------------------------------------------------------------------------
