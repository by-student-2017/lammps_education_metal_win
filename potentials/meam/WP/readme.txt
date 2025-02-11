#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Al Nb AlNb.meam Al Nb
#------------------------------------------------------------------------
# Par A.T. Olsson et al., Comput. Mater. Sci. 219 (2023) 112017.: https://doi.org/10.1016/j.commatsci.2023.112017
# Home of 2NN MEAM Interatomic Potential: https://cmse.postech.ac.kr/home_2nnmeam
#------------------------------------------------------------------------
