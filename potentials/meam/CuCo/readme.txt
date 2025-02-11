#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Cu Co CuCo.meam Cu Co
#------------------------------------------------------------------------
# Second-nearest-neighbor modified embedded-atom method interatomic potential for Cu-M (M = Co, Mo) binary systems Jaemin Wang, Sang-Ho Oh and Byeong-Joo Lee, Compu. Mater. Sci. 178, 109627 (2020).
# Home of 2NN MEAM Interatomic Potential: https://cmse.postech.ac.kr/home_2nnmeam
#------------------------------------------------------------------------
