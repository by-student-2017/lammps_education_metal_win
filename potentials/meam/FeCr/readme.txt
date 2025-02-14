#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Fe Cr FeCr.meam Fe Cr
#------------------------------------------------------------------------
# B.-J. Lee et al., Calphad, 25 (2001) 527-534.: https://doi.org/10.1016/s0364-5916(02)00005-6
# 2001--Lee-B-J-Shim-J-H-Park-H-M--Fe-Cr (NIST, Interatomic Potentials Repository): https://www.ctcms.nist.gov/potentials/
#------------------------------------------------------------------------