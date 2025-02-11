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


# Nb-Ti is very different from the description in the literature. Check is required.
#------------------------------------------------------------------------
