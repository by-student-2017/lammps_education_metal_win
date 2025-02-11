#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Nb C NbC.meam Nb C
#------------------------------------------------------------------------
# H.-K. Kim et al., Journal of Materials Research, 25 (2010) 1288-1297.: https://doi.org/10.1557/jmr.2010.0182
# 2010--Kim-H-K-Jung-W-S-Lee-B-J--Nb-C (NIST, Interatomic Potentials Repository): https://www.ctcms.nist.gov/potentials/
#------------------------------------------------------------------------
