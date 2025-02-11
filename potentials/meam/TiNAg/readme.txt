#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Al Nb AlNb.meam Al Nb
#------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------
Diffusion of silver in titanium nitride: Insights from density functional theory and molecular dynamics
V. Lenzi et al., Applied Surface Science 556 (2021) 149738.: https://doi.org/10.1016/j.apsusc.2021.149738
Supplementary data: https://ars.els-cdn.com/content/image/1-s2.0-S016943322100814X-mmc1.zip
#-----------------------------------------------------------------------------------------
