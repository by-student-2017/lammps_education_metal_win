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


# The specific values ​​of (Mg,Mg,Al) and (Mg,Al,Al) are not described in the literature.
#------------------------------------------------------------------------
