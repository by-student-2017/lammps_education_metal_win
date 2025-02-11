#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * CaMgZn.library.meam Ca Mg Zn CaMgZn.meam Ca Mg Zn
#------------------------------------------------------------------------
# H.-S. Jang et al., Calphad, 67 (2019) 101674.: https://doi.org/10.1016/j.calphad.2019.101674
# Home of 2NN MEAM Interatomic Potential: https://cmse.postech.ac.kr/home_2nnmeam
#------------------------------------------------------------------------
