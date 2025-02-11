#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Fe Tc FeTc.meam Fe Tc
#------------------------------------------------------------------------
# C. D. Taylor, J. Metall. 2011.:  doi:10.1155/2011/954170
# Note: the paper does not provide all the details.
# Fe: [20] B.-J. Lee et al., Physical Review B, vol. 62, no. 13, pp. 8564–8567, 2000. (This means 2NN-MEAM.)
#------------------------------------------------------------------------
