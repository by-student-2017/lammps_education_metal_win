#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.AlFe.meam Al Fe AlFe.meam Al Fe
#------------------------------------------------------------------------
# E. Lee et al., Journal of Physics: Condensed Matter, 22 (2010) 175702.: https://doi.org/10.1088/0953-8984/22/17/175702
# 2010--Lee-E-Lee-B-J--Fe-Al (NIST, Interatomic Potentials Repository): https://www.ctcms.nist.gov/potentials/
#------------------------------------------------------------------------