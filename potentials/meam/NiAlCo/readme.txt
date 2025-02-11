#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Ni Al Co NiAlCo.meam Ni Al Co
#------------------------------------------------------------------------
# Y.-K. Kim et al., Modelling and Simulation in Materials Science and Engineering, 23 (2015) 055004.: https://doi.org/10.1088/0965-0393/23/5/055004
# 2015--Kim-Y-K-Jung-W-S-Lee-B-J--Ni-Al-Co (NIST, Interatomic Potentials Repository): https://www.ctcms.nist.gov/potentials/
#------------------------------------------------------------------------
