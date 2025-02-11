#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Al Nb AlNb.meam Al Nb
#------------------------------------------------------------------------
# W.-M. Choi et al., npj Computational Materials, 4 (2018) 1.: https://doi.org/10.1038/s41524-017-0060-9
# 2018--Choi-W-M-Jo-Y-H-Sohn-S-S-et-al--Co-Ni-Cr-Fe-Mn (NIST, Interatomic Potentials Repository): https://www.ctcms.nist.gov/potentials/
# related information: https://github.com/CMMAi/HEA_Mechanisms/tree/master/src
#------------------------------------------------------------------------
