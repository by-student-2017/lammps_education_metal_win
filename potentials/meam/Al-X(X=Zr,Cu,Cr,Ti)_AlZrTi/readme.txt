#------------------------------------------------------------------------
Al-Zr-Ti: Cmin and Cmax are calculated using Assumption.
#------------------------------------------------------------------------
# High-temperature

units metal
dimension 3
boundary p p p 
atom_style atomic

# all-data
# 2NN-MEAM, Al-X(X=Li,Zr,Zn)
pair_style meam
pair_coeff * * library.meam Al Zr Cu Cr Ti AlZrCuCrTi.meam Al Zr Cu Cr Ti 
#------------------------------------------------------------------------

#------------------------------------------------------------------------
# all-data

units metal
dimension 3
boundary p p p 
atom_style atomic

# 2NN-MEAM, Al-X(X=Li,Zr,Zn)
pair_style meam
pair_coeff * * library.meam Al ZrHT ZrLT Cu Cr Ti AlZrHTZrLTCuCrTi.meam Al ZrHT ZrLT Cu Cr Ti
#------------------------------------------------------------------------
