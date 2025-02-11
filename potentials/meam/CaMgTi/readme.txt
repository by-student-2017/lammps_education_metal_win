#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Ca Mg Ti CaMgTi.meam Ca Mg Ti
#------------------------------------------------------------------------
# H. H. Nersisyan et al., J. Alloys Comp. 985 (2024) 174036.: https://doi.org/10.1016/j.jallcom.2024.174036 
# [2] 2015--Kim-K-H-Jeon-J-B-Lee-B-J--Mg-Ca (NIST, Interatomic Potentials Repository): https://www.ctcms.nist.gov/potentials/
#------------------------------------------------------------------------
