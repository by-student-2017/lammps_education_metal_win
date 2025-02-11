#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Fe C FeC.meam Fe C
#------------------------------------------------------------------------
# B.-J. Lee, Acta Materialia, 54 (2006) 701-711.: https://doi.org/10.1016/j.actamat.2005.09.034
# 2006--Lee-B-J--Fe-C (NIST, Interatomic Potentials Repository): https://www.ctcms.nist.gov/potentials/
#------------------------------------------------------------------------
