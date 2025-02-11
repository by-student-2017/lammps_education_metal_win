#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Fe Nb FeNb.meam Fe Nb
#------------------------------------------------------------------------
# I. Sa et al., Scripta Materialia, 59(6), 595-598.: https://doi.org/10.1016/j.scriptamat.2008.05.007
# 2008--Sa-I-Lee-B--Fe-Nb (NIST, Interatomic Potentials Repository): https://www.ctcms.nist.gov/potentials/
#------------------------------------------------------------------------
