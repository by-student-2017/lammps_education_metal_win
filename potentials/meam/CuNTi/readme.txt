#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam.0 Cu N Ti CuNTi.meam.0 Cu N Ti
#------------------------------------------------------------------------
# A.S.M. Miraz et al., Materials & Design, 196 (2020) 109123.: https://doi.org/10.1016/j.matdes.2020.109123
# 2020--Miraz-A-S-M-Dhariwal-N-Meng-W-J-et-al--Cu-N-Ti (NIST, Interatomic Potentials Repository): https://www.ctcms.nist.gov/potentials/
#------------------------------------------------------------------------
