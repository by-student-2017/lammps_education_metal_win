#------------------------------------------------------------------------
Al-Zr-Ti: As described in the paper, Cmin and Cmax are calculated using Assumption.
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
# J.-R. C.-Sanchez et al., Phys. Chem. Chem. Phys., 2022,24, 22605-22623.: https://doi.org/10.1039/D2CP02746A
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
