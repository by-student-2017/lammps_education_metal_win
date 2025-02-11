#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Li Si LiSi.meam Li Si
#------------------------------------------------------------------------
# J. Godet et al., Phys. Rev. Materials 4 (2020) 065402.: https://doi.org/10.1103/PhysRevMaterials.4.065402
#------------------------------------------------------------------------
