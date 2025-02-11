#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Ti Al Nb V TiAlNbV.meam Ti Al
#pair_coeff * * library.meam Ti Al Nb V TiAlNbV.meam Ti Nb
#pair_coeff * * library.meam Ti Al Nb V TiAlNbV.meam Ti V
#pair_coeff * * library.meam Ti Al Nb V TiAlNbV.meam Al Nb
#pair_coeff * * library.meam Ti Al Nb V TiAlNbV.meam Al V
3pair_coeff * * library.meam Ti Al Nb V TiAlNbV.meam Nb V
#------------------------------------------------------------------------
# J. Kundu et al., Weld World 64, 2129–2143 (2020).: https://doi.org/10.1007/s40194-020-00989-x
#------------------------------------------------------------------------
