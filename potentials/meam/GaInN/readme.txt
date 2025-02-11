#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * GaInN.library.meam Ga In N GaInN.meam Ga In N
#------------------------------------------------------------------------
# X.W. Zhou et al., Journal of Applied Physics, 122 (2017) 235703.: https://doi.org/10.1063/1.5001339
# 2017--Zhou-X-W-Jones-R-E-Chu-K--In-Ga-N
#------------------------------------------------------------------------
