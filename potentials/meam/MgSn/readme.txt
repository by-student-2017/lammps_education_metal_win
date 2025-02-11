#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Mg Sn MgSn.meam Mg Sn
#------------------------------------------------------------------------
# K.-H. Kim et al., Calphad, 48 (2015) 27-34.: https://doi.org/10.1016/j.calphad.2014.10.001
# 2015--Kim-K-H-Jeon-J-B-Lee-B-J--Mg-Sn (NIST, Interatomic Potentials Repository): https://www.ctcms.nist.gov/potentials/
#------------------------------------------------------------------------
