#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Fe C Cr Mo FeCCrMo.meam Fe C Cr Mo
#------------------------------------------------------------------------
# H.-L. Chen et al., RSC Adv., 2015,5, 103925-103935.: https://doi.org/10.1039/C5RA18168B
#
# Table S5 shows the MEAM parameters for Fe-C, Fe-Cr, Fe-Mo, Cr-C, Cr-Mo and Mo-C. However, 
# it states that Cmin = 0.513 and Cmax = 2.191. Note that the paper does not show all the C(i-k-j) values ​​in detail. 
# There is no explanation for Cmin and Cmax in the ternary systems (Fe-Cr and Cr-Mo are a bit of a concern). 
# However, the energy and volume of Fe3C2Cr1Mo2 are compared with DFT and the results are not too bad.
#------------------------------------------------------------------------
