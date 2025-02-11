#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Fe Cr Si FeCrSi.meam Fe Cr Si
#------------------------------------------------------------------------
# Fe-Cr - MEAM CoCrFeMnNi alloy potential, npj Computational Materials vol 4, 1 (2018)
# https://doi.org/10.1038/s41524-017-0060-9
# Fe-Si refitted - MEAM Al, Si, Mg, Cu, Fe alloy potential, Phys. Rev. B 85, 245102 (2012)
# http://dx.doi.org/10.1103/PhysRevB.85.245102
# Cr-Si fully developed potential
#------------------------------------------------------------------------
