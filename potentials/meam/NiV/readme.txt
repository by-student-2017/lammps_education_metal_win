#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Ni V NiV.meam Ni V
#------------------------------------------------------------------------
# J.-H. Shim, et al., (2013) J Memb. Sci. 430, 234-241.
# 2013--Shim-J-H-Ko-W-S-Kim-K-H-et-al--V-Ni (NIST, Interatomic Potentials Repository): https://www.ctcms.nist.gov/potentials/
#------------------------------------------------------------------------


