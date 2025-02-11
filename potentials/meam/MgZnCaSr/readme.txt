#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Mg Zn Ca Sr MgZnCaSr.meam Mg Zn Ca Sr
#------------------------------------------------------------------------
# Sun, SJ., Ju, SP., Yang, CC. et al. Effects of Strontium incorporation to 
# Mg-Zn-Ca biodegradable bulk metallic glass investigated by molecular dynamics 
# simulation and density functional theory calculation. Sci Rep 10, 2515 (2020).
# https://doi.org/10.1038/s41598-020-58789-8
#-------------------------------------------------------------------------------
