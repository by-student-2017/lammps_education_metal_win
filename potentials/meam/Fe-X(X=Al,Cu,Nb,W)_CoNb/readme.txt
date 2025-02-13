#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Co Nb CoNb.meam Co Nb
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Fe Al FeAl.meam Fe Al
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Fe Cu FeCu.meam Fe Cu
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Fe Nb FeNb.meam Fe Nb
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Fe W FeW.meam Fe W
#------------------------------------------------------------------------
# M. Muralles et al., Comput. Mater. Sci. 230 (2023) 112488.: https://doi.org/10.1016/j.commatsci.2023.112488
# https://dr.ntu.edu.sg/handle/10356/175396
# https://dr.ntu.edu.sg/bitstream/10356/175396/2/MarioHernandez_Thesis_PhD_Final.pdf
#------------------------------------------------------------------------
# It says, "The screening parameters Cmin and Cmax, which are expressed as (i-j-k). These parameters account for the screening of atom k by atoms i and j." However, when comparing the paper with the supplementary materials, the paper writes C(i-k-j)=C(i,j,k).
# For Fe-Nb, the values ​​of Cmin(A-B-A) and Cmin(B-A-B) are different between the paper and the supplementary data. Here, the supplementary data was used.
#------------------------------------------------------------------------
