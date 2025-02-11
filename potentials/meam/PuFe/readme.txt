#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Pu Fe PuFe.meam Pu Fe
#------------------------------------------------------------------------
# 
# 
