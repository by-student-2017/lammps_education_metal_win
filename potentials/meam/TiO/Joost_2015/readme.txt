#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Ti O TiO.meam Ti O
#------------------------------------------------------------------------

# A Modified Embedded Atom Method Potential for the Titanium-Oxygen System
# https://materialsdata.nist.gov/handle/11115/244

# Atomistic Simulations
# https://materialsdata.nist.gov/handle/11256/9

# Computational File Repository (TDB, Mobility Database)
# https://materialsdata.nist.gov/handle/11256/2
#------------------------------------------------------------------------
