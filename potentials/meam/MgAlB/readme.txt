#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Mg Al B MgAlB.meam Mg Al B
#------------------------------------------------------------------------
# D. A. Andersson et al., J. Phys. Chem. B 2009, 113, 35, 11965-11976.: https://doi.org/10.1021/jp902505r
# Mg1-xAlxB2 (0 < x < 0.5)
# Note: not all parameters are detailed in the paper. In particular, the value of d in the Rose function, and the formulas for G (gamma) and dr(=delr).
# the screening parameters, C(i,j,k), specify how the i-j atom pair is screened by atom k.
# The Cmin(Mg,Al,Mg), Cmin(Mg,B,Mg), and Cmin(Al,B,Al) NTC and TC screening parameters were set to 0.00, 1.20, and 1.00, respectively. 
# For the TC set complete screening was induced for the (Mg,Mg,Al) and (Mg,Al,Al) triplets, as further discussed under Results and Discussion. (Note: The specific parameters are not listed in the paper. It is a shame that this is peer-reviewed.)
# The remaining screening parameters were set to the default values of Cmin = 2.0 and Cmax = 2.8.

# The specific values ​​of (Mg,Mg,Al) and (Mg,Al,Al) are not described in the literature.
#------------------------------------------------------------------------
