#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM (Note: 1NN-MEAM for Pu only)
pair_style meam
pair_coeff * * library.meam Pu Fe PuFe.meam Pu Fe
#------------------------------------------------------------------------
# T. ITO et al., ICONE19-43987.: https://doi.org/10.1299/jsmeicone.2011.19._ICONE1943_369
#------------------------------------------------------------------------
