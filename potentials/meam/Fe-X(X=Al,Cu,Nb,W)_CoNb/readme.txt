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
# M. Muralles et al., Comput. Mater. Sci. 230 (2023) 112488.: https://doi.org/10.1016/j.commatsci.2023.112488
# https://dr.ntu.edu.sg/handle/10356/175396
# https://dr.ntu.edu.sg/bitstream/10356/175396/2/MarioHernandez_Thesis_PhD_Final.pdf
#------------------------------------------------------------------------
