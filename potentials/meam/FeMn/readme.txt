#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Fe Mn FeMn-para.meam Fe Mn
#------------------------------------------------------------------------
# Modified embedded-atom method interatomic potentials for pure Mn and Fe-Mn system
# Young-Min Kim, Young-Han Shin and Byeong-Joo Lee, Acta Materialia 57, 474-482 (2009).
# Home of 2NN MEAM Interatomic Potential: https://cmse.postech.ac.kr/home_2nnmeam
#------------------------------------------------------------------------
