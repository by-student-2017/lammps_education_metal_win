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


# There is no mention of d in PtPd in the paper.
# The elastic constants were not verified in the paper.
# There is no specific statement in the paper as to whether it is C(i-k-j).
#------------------------------------------------------------------------
