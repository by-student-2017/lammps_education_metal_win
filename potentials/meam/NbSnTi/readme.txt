#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Nb Sn Ti NbSnTi.meam Nb Sn Ti
#------------------------------------------------------------------------
# "Atomic behavior of Ti in A15 Nb3Sn and its effects on diffusional growth of Nb3Sn layer"
# Sang-Ho Oh, Yang-Jin Jeong, Sin-Hye Na, Jiman Kim, Alireza Zargaran and Byeong-Joo Lee, J. Alloys Compds. (2023), accepted for publication.
# Home of 2NN MEAM Interatomic Potential: https://cmse.postech.ac.kr/home_2nnmeam
#------------------------------------------------------------------------
