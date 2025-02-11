#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 1NN-MEAM
pair_style meam
pair_coeff * * library.meam Pt Pd PtPd.meam Pt Pd
#------------------------------------------------------------------------
# Z. Duan et al., J. Phys.: Condens. Matter 23 (2011) 475301.: DOI 10.1088/0953-8984/23/47/475301
# There is no mention of d in PtPd in the paper.
# The elastic constants were not verified in the paper.
# There is no specific statement in the paper as to whether it is C(i-k-j).
#------------------------------------------------------------------------
