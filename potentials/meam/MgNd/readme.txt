#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Mg Nd MgNd.meam Mg Nd
#------------------------------------------------------------------------
# K.-H. Kim et al., Calphad, 57 (2017) 55-61.: https://doi.org/10.1016/j.calphad.2017.03.003
# 2017--Kim-K-H-Lee-B-J--Mg-Nd (NIST, Interatomic Potentials Repository): https://www.ctcms.nist.gov/potentials/
#------------------------------------------------------------------------
