#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam V H VH.meam V H
#------------------------------------------------------------------------
# J.-H. Shim et al., Calphad, 35 (2011) 302-307.: https://doi.org/10.1016/j.calphad.2011.04.007
# 2011--Shim-J-H-Lee-Y-S-Fleury-E-et-al--V-H (NIST, Interatomic Potentials Repository): https://www.ctcms.nist.gov/potentials/
#------------------------------------------------------------------------
