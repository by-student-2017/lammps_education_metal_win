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
# S.-P. Ju et al., materialstoday communications 33 (2022) 104858.: https://doi.org/10.1016/j.mtcomm.2022.104858
#------------------------------------------------------------------------
