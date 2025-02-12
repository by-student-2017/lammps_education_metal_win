#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# High-temperature
# 2NN-MEAM, Al-X(X=Li,Zr,Zn)
pair_style meam
pair_coeff * * library.meam Al Zr Cu Cr Ti AlZrCuCrTi.meam Al Zr Cu Cr Ti 
#------------------------------------------------------------------------
# Al-Zr-Ti: As described in the paper, Cmin and Cmax are calculated using Assumption.
#------------------------------------------------------------------------
# Note: Calculations that take into account additive elements in Al-based alloys. When the concentration of additive elements is high and different additive elements are adjacent to each other, it is necessary to optimize the parameters between the additive elements in order to handle the interactions between the different additive elements (especially the elastic constants) more accurately. However, the interaction between Al-Zr-Ti is taken into account, although it is calculated using "Assumption".
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
