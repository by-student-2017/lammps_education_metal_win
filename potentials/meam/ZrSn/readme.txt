#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Zr Sn ZrSn.meam Zr Sn
#------------------------------------------------------------------------
# H. Mei et al., J. Nucl. Mater. 588 (2024) 154794.: https://doi.org/10.1016/j.jnucmat.2023.154794
#------------------------------------------------------------------------