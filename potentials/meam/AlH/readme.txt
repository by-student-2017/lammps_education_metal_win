#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Al H AlH.meam Al H
#------------------------------------------------------------------------
# W.-S. Ko et al., J. Mater. Res. 26 (2011) 1552-1560.: https://doi.org/10.1557/jmr.2011.95
# 2011--Ko-W-S-Shim-J-H-Lee-B-J--Al-H (NIST, Interatomic Potentials Repository): https://www.ctcms.nist.gov/potentials/
# or 
# Home of 2NN MEAM Interatomic Potential: https://cmse.postech.ac.kr/home_2nnmeam
#------------------------------------------------------------------------
