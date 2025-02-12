#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Co Fe Mo CoFeMo.meam Co Fe Mo
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Co Fe Nb CoFeNb.meam Co Fe Nb
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Co Fe V CoFeV.meam Co Fe V
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Co Fe W CoFeW.meam Co Fe W
#------------------------------------------------------------------------
# M. Muralles et al., Comput. Mater. Sci. 241 (2024) 113030.: https://doi.org/10.1016/j.commatsci.2024.113030
#------------------------------------------------------------------------
