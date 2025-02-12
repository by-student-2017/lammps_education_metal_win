#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Fe Cr Ni N FeCrNiN.meam Fe Ni
#------------------------------------------------------------------------
# Wang, J., & Lee, B. J. (2021). Second-nearest-neighbor modified embedded-atom method interatomic potential for V-M (M= Cu, Mo, Ti) binary systems. Computational Materials Science, 188, 110177.
# Home of 2NN MEAM Interatomic Potential: https://cmse.postech.ac.kr/home_2nnmeam
#------------------------------------------------------------------------
