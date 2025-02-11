#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Nb Al Ti NbAlTi.meam Nb Al Ti
#------------------------------------------------------------------------
# H. Xiang et al., Acta Mech. Sin., Vol.38., 121451 (2022).: https://doi.org/10.1007/s10409-022-09007-x
# researchgate.net

# Nb-Ti is very different from the description in the literature. Check is required.
#------------------------------------------------------------------------
