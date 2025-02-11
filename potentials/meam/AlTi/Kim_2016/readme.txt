#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * ./../../library.meam Al Ti ./../../AlTi.meam Al Ti
#------------------------------------------------------------------------
# Y.-K. Kim et al., Computational Materials Science, 119 (2016) 1-8.:  https://doi.org/10.1016/j.commatsci.2016.03.038
# 2016--Kim-Y-K-Kim-H-K-Jung-W-S-Lee-B-J--Al-Ti (NIST, Interatomic Potentials Repository): https://www.ctcms.nist.gov/potentials/
#------------------------------------------------------------------------
