#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * MgAlZn.library.meam Mg Al Zn MgAlZn.parameter.meam Mg Al Zn
#------------------------------------------------------------------------
# Modified embedded-atom method interatomic potentials for Mg-Al-Ca and Mg-Al-Zn ternary systems
# Hyo-Sun Jang, Donghyuk Seol and Byeong-Joo Lee, J. Magnesium and Alloys (2021)
# Home of 2NN MEAM Interatomic Potential: https://cmse.postech.ac.kr/home_2nnmeam
#------------------------------------------------------------------------
