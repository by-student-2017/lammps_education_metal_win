#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.NAlTi Ti Al N meam.NAlTi Ti Al N
#------------------------------------------------------------------------
# Semi-Empirical Force-Field Model for the Ti1-xAlxN (0 =< x =< 1) System (Open Access)
# G. A. Almyras et al., Materials 2019, 12(2), 215; https://doi.org/10.3390/ma12020215
# Ti-Al-N: https://doi.org/10.3390/ma12020215 (Supplementary Materials: https://www.mdpi.com/1996-1944/12/2/215/s1)
#------------------------------------------------------------------------
