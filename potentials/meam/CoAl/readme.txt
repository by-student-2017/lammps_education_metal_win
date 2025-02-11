#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Co Al CoAl.meam Co Al
#------------------------------------------------------------------------
# W.-P. Dong et al., Calphad, 38, 7-16.: https://doi.org/10.1016/j.calphad.2012.04.001
# 2012--Dong-W-P-Kim-H-K-Ko-W-S-et-al--Co-Al (NIST, Interatomic Potentials Repository): https://www.ctcms.nist.gov/potentials/
#------------------------------------------------------------------------
