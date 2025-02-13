#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Co Ti CoTi.meam Co Ti
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Co V CoV.meam Co V
#------------------------------------------------------------------------
# S.-H. Oh, et al., (2020) CALPHAD 70, 101791.: https://doi.org/10.1016/j.calphad.2020.101791
# 2020--Oh-S-H-Seol-D-Lee-B-J--Co-Ti (NIST, Interatomic Potentials Repository): https://www.ctcms.nist.gov/potentials/
# 2020--Oh-S-H-Seol-D-Lee-B-J--Co-V  (NIST, Interatomic Potentials Repository): https://www.ctcms.nist.gov/potentials/
#------------------------------------------------------------------------
