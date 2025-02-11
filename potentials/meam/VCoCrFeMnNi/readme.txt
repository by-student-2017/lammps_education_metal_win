#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * CoNiVCrFeMn.library.meam Al Nb AlNb.meam Al Nb
#------------------------------------------------------------------------
# "Computational design of V-CoCrFeMnNi high-entropy alloys: An Atomistic Simulation Study," Won-Mi Choi, Jin-Soo Kim, Won-Seok Ko, Dong Geun Kim, Yong Hee Jo, Seok Su Sohn, Sunghak Lee, Byeong-Joo Lee, CALPHAD 74, 102317 (2021).
# Home of 2NN MEAM Interatomic Potential: https://cmse.postech.ac.kr/home_2nnmeam
#------------------------------------------------------------------------
