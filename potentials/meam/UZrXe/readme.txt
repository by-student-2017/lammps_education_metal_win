#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM (for alpha-U-Zr and delta-UZr2)
pair_style meam
pair_coeff * * library.meam_1 U Zr Xe UZeXe.meam_1 U Zr Xe
#------------------------------------------------------------------------
# 2NN-MEAM (for gamma-U-Zr)
pair_style meam
pair_coeff * * library.meam_2 U Zr Xe UZeXe.meam_2 U Zr Xe
#------------------------------------------------------------------------
# P. Jiang et al., J. Nucl. Mater. 588 (2024) 154824.: https://doi.org/10.1016/j.jnucmat.2023.154824
#------------------------------------------------------------------------