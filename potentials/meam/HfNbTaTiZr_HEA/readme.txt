#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Hf Nb Ta Ti Zr HfNbTaTiZr.meam Hf Nb Ta Ti Zr
#------------------------------------------------------------------------
# X. Huang et al., Materials & Design, 202 (2021) 109560.: https://doi.org/10.1016/j.matdes.2021.109560
# 2021--Huang-X-Liu-L-Duan-X-et-al--Hf-Nb-Ta-Ti-Zr (NIST, Interatomic Potentials Repository): https://www.ctcms.nist.gov/potentials/
#------------------------------------------------------------------------
