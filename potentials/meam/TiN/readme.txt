#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Ti N TiN.meam Ti N
#------------------------------------------------------------------------
# Y.-M. Kim et al., Acta Materialia, 56 (2008) 3481-3489.: https://doi.org/10.1016/j.actamat.2008.03.027
# 2008--Kim-Y-M-Lee-B-J--Ti-N (NIST, Interatomic Potentials Repository): https://www.ctcms.nist.gov/potentials/
#------------------------------------------------------------------------
