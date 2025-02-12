#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# Ti-C case: Ti2C, Ti3N2, Ti4C3
pair_style meam
pair_coeff * * library.meam Ti C N TiCN.meam Ti C
#-------------------------------------------------------------
# Ti-N case: Ti2N, Ti3N2, Ti4N3
pair_style meam
pair_coeff * * library.meam Ti C N TiCN.meam Ti N
#-------------------------------------------------------------
