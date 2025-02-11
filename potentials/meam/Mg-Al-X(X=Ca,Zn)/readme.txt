#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Al Ca AlCa.meam Al Ca
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Al Ca Mg AlCaMg.meam Al Ca Mg
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Al Zn AlZn.meam Al Zn
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Al Zn Mg AlZnMg.meam Al Zn Mg
#------------------------------------------------------------------------
# H.-S. Jang et al., Journal of Magnesium and Alloys 9 (2021) 704.: https://doi.org/10.1016/j.jma.2021.03.001
# Home of 2NN MEAM Interatomic Potential: https://cmse.postech.ac.kr/home_2nnmeam
#------------------------------------------------------------------------
