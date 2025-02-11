#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Al Ni AlNi.meam Al Ni
#------------------------------------------------------------------------
# A. Mahata et al., omputational Materials Science, 201 (2022) 110902.: https://doi.org/10.1016/j.commatsci.2021.110902
# 2022--Mahata-A-Mukhopadhyay-T-Asle-Zaeem-M--Al-Ni (NIST, Interatomic Potentials Repository): https://www.ctcms.nist.gov/potentials/
#------------------------------------------------------------------------
