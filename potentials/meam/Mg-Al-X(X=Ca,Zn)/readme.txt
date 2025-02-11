#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.AlFe.meam Al Fe AlFe.meam Al Fe
#------------------------------------------------------------------------
# H.-S. Jang et al., Journal of Magnesium and Alloys 9 (2021) 704.: https://doi.org/10.1016/j.jma.2021.03.001
# Home of 2NN MEAM Interatomic Potential: https://cmse.postech.ac.kr/home_2nnmeam
#------------------------------------------------------------------------
