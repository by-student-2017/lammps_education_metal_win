#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Mg Ce MgCe.meam Mg Ce
#------------------------------------------------------------------------
# The origin of activation of non-basal slip in Mg-Ce dilute alloy - An atomistic simulation study, Jong-Kwan Lee and Byeong-Joo Lee, Metal. Mater. Trans. A (2020).: https://doi.org/10.1007/s11661-020-06128-x
# Home of 2NN MEAM Interatomic Potential: https://cmse.postech.ac.kr/home_2nnmeam
#------------------------------------------------------------------------
