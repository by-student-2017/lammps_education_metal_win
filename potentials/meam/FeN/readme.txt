#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Fe N FeN.meam Fe N
#------------------------------------------------------------------------
# B.-J. Lee et al., Acta Materialia, 54(17), 4597-4607.: https://doi.org/10.1016/j.actamat.2006.06.003
# Comment: N. Razmara et al., J. Mol. Model. 23, 8 (2017).: https://doi.org/10.1007/s00894-016-3174-y
# 2006--Lee-B-J-Lee-T-H-Kim-S-J--Fe-N (NIST, Interatomic Potentials Repository): https://www.ctcms.nist.gov/potentials/
#------------------------------------------------------------------------
