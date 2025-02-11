#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * ./../../library.meam Al Hf Nb Ta Ti Zr ./../../AlHfNbTaTiZr.meam Al Hf Nb Ta Ti Zr
#------------------------------------------------------------------------
