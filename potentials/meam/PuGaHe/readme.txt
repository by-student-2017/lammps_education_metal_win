#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 1NN-MEAM
pair_style meam
pair_coeff * * library.meam Pu Ga He PuGaHe.meam Pu Ga He
#------------------------------------------------------------------------
# Ga-Pu-Ga: Cmin(2,2,1) = 2.80 # not match Baskes (2007).
#------------------------------------------------------------------------
# a/(astar+a) = 1/((R/R0-1)+1) = R0/R
# The statement "1/(astar+a) = R0/R" in the paper is incorrect.
# The only information available is the coordination number (Z). Z=1 is taken as the reference structure for the dimer.
#------------------------------------------------------------------------
