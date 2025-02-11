#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Co Mn CoMn.meam Co Mn
#------------------------------------------------------------------------
# "Modified embedded-atom method interatomic potentials for the Co-Cr, Co-Fe, Co-Mn, Cr-Mn and Mn-Ni binary systems"
# Won-Mi Choi, Yongmin Kim, Donghyuk Seol and Byeong-Joo Lee, Compu. Mater. Sci. 130 (2017) 121-129.
# Home of 2NN MEAM Interatomic Potential: https://cmse.postech.ac.kr/home_2nnmeam
#------------------------------------------------------------------------
