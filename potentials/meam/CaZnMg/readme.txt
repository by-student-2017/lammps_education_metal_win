#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Ca Zn Mg CaZnMg.meam Ca Zn Mg
#------------------------------------------------------------------------
# H.-S. Jang et al., Calphad, 67 (2019) 101674.: https://doi.org/10.1016/j.calphad.2019.101674
# 2019--Jang-H-S-Seol-D-Lee-B-J--Mg-Zn-Ca  (NIST, Interatomic Potentials Repository): https://www.ctcms.nist.gov/potentials/
#------------------------------------------------------------------------
