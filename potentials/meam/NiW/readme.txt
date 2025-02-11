#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Ni W NiW.meam Ni W
#------------------------------------------------------------------------
# J.-H. Shim, et al., (2003) J Mater. Res. 18, 1863-1867.
# 2003--Shim-J-H-Park-S-I-Cho-Y-W-Lee-B-J--Ni-W (NIST, Interatomic Potentials Repository): https://www.ctcms.nist.gov/potentials/
#------------------------------------------------------------------------

