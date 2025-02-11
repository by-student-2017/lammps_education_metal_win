#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Cu Ni Ti CuNiTi.meam Cu Ni Ti
#------------------------------------------------------------------------
# W.-S. Ko et al., Int. J. Mol. Sci. 274 (2024) 109256.: https://doi.org/10.1016/j.ijmecsci.2024.109256
# 2003--Shim-J-H-Park-S-I-Cho-Y-W-Lee-B-J--Ni-W (NIST, Interatomic Potentials Repository): https://www.ctcms.nist.gov/potentials/
#------------------------------------------------------------------------

