#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Ag Ti AgTi.meam Ag Ti
#------------------------------------------------------------------------


# There is no mention of d in AgTi in the paper.
# "For our AgTi binary system, the ordered bcc AgTi structure is first chose nas a reference."
# From the above, the reference structure of AgTi is estimated to be BCC B2.
# The elastic constants were not verified in the paper.
#------------------------------------------------------------------------
