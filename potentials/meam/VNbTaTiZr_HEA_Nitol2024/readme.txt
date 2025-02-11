#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * VNbTaTiZr.library V Nb Ta Ti Zr VNbTaTiZr.meam V Nb Ta Ti Zr
#------------------------------------------------------------------------
# M.S. Nitol et al., Computational Materials Science, 237 (2024) 112886. DOI: 10.1016/j.commatsci.2024.112886.
# 2024--Nitol-M-S-Echeverria-M-J-Dang-K-et-al--V-Nb-Ta-Ti-Zr (NIST, Interatomic Potentials Repository): https://www.ctcms.nist.gov/potentials/
#------------------------------------------------------------------------
