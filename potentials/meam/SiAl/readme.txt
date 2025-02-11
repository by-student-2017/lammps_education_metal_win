#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 1NN-MEAM
pair_style meam
pair_coeff * * library.meam Si Al SiAl.meam Si Al
#-------------------------------------------------------------
# The thermal conductivity results in the literature are calculated using the BCC reference interatomic potential for the interface Si-Al alloy.
# W. I. Choi et al., J. Appl. Phys. 112, 054305 (2012).: https://doi.org/10.1063/1.4748872
# Note: Not all parameters are listed in the paper. (e.g., augt1, delr, and ialloy, etc)
#-------------------------------------------------------------
