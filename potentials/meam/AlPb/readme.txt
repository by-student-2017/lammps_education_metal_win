#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Al Pb AlPb.meam Al Pb
#------------------------------------------------------------------------
# Y. Purohit et al., Mater. Sci. Eng. A 493 (2008) 97-100.: https://doi.org/10.1016/j.msea.2009.11.034
# Note: Since d was not mentioned in the paper, we used the value calculated using "Assumption" for d here.
# Note: Since calculation conditions such as cutoff (=rc) were not stated, we followed the reference in Lee's paper. For cutoff (=rc), we used the maximum value for the elements used.
#------------------------------------------------------------------------
