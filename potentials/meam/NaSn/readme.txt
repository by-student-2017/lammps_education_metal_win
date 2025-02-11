#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Na Sn NaSn.meam Na Sn
#------------------------------------------------------------------------
# Second nearest-neighbor modified embedded atom method interatomic potentials for the Na unary and Na-Sn binary systems
# Yongmin Kim, Won-Seok Ko, and Byeong-Joo Lee, Computational Materials Science 185, 109953 (2020).
# Home of 2NN MEAM Interatomic Potential: https://cmse.postech.ac.kr/home_2nnmeam
#------------------------------------------------------------------------
