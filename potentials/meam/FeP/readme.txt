#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Fe P FeP.meam Fe P
#------------------------------------------------------------------------
# "Atomistic Modeling of an impurity element and a metal-impurity system: pure P and Fe-P system"
# Won-Seok Ko, Nack. J. Kim and Byeong-Joo Lee, Journal of Physics: Condensed Matter 24, 225002 (2012.06).
# Home of 2NN MEAM Interatomic Potential: https://cmse.postech.ac.kr/home_2nnmeam
#------------------------------------------------------------------------
