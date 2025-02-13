#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Co Cr CoCr.meam Co Cr
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Co Fe CoFe.meam Co Fe
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Co Mn CoMn.meam Co Mn
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Cr Mn CrMn.meam Cr Mn
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Ni Mn NiMn.meam Ni Mn
#------------------------------------------------------------------------
# "Modified embedded-atom method interatomic potentials for the Co-Cr, Co-Fe, Co-Mn, Cr-Mn and Mn-Ni binary systems"
# Won-Mi Choi, Yongmin Kim, Donghyuk Seol and Byeong-Joo Lee, Compu. Mater. Sci. 130 (2017) 121-129.: https://doi.org/10.1016/j.commatsci.2017.01.002
# Home of 2NN MEAM Interatomic Potential: https://cmse.postech.ac.kr/home_2nnmeam
#------------------------------------------------------------------------
