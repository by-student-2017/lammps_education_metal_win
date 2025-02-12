#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Ag Au AgAu.meam Ag Au
#------------------------------------------------------------------------
# The Cmin and Cmax values ​​are almost identical to the "Assumption" values, and 
# I don't know whether this was a coincidence or whether they were intentionally calculated as "Assumption".
#------------------------------------------------------------------------
