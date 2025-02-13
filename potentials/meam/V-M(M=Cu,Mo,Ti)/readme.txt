#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam V Cu VCu.meam V Cu
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam V Mo VMo.meam V Mo
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam V Ti VTi.meam V Ti
#------------------------------------------------------------------------
# Wang, J., & Lee, B. J. (2021). Second-nearest-neighbor modified embedded-atom method interatomic potential for V-M (M= Cu, Mo, Ti) binary systems. Computational Materials Science, 188, 110177.: https://doi.org/10.1016/j.commatsci.2020.110177
# Home of 2NN MEAM Interatomic Potential: https://cmse.postech.ac.kr/home_2nnmeam
#------------------------------------------------------------------------
