#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * ./../../library.meam Al Hf Nb Ta Ti Zr ./../../AlHfNbTaTiZr.meam Al Hf Nb Ta Ti Zr
#------------------------------------------------------------------------
# R. Fereidonnejad et al., Comput. Mater. Sci. 213 (2022) 111685.: https://doi.org/10.1016/j.commatsci.2022.111685
# 2022--Fereidonnejad-R-Moghaddam-A-O-Moaddeli-M--Al-Hf-Nb-Ta-Ti-Zr (NIST, Interatomic Potentials Repository): https://www.ctcms.nist.gov/potentials/
#------------------------------------------------------------------------
