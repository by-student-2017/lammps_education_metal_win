#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.AlFe.meam Al Fe AlFe.meam Al Fe
#------------------------------------------------------------------------
# A. Mahata et al., Computational Materials Science, 201 (2022) 110902. : https://doi.org/10.1016/j.commatsci.2021.110902
# 2022--Mahata-A-Mukhopadhyay-T-Asle-Zaeem-M--Al-Fe (NIST, Interatomic Potentials Repository): https://www.ctcms.nist.gov/potentials/
#------------------------------------------------------------------------
