#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Pd C PdC.meam Pd C
#------------------------------------------------------------------------
# Interatomic potentials for Pt-C and Pd-C systems and a study of structure-adsorption relationship in large Pt/Graphene system
# Ga-Un Jeong, Byeong-Joo Lee, Compu. Mater. Sci. (2020).
# Home of 2NN MEAM Interatomic Potential: https://cmse.postech.ac.kr/home_2nnmeam
#------------------------------------------------------------------------

