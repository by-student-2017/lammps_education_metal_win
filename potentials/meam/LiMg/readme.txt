#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Li Mg LiMg.meam Li Mg
#------------------------------------------------------------------------
# Y.-M. Kim et al., Modelling and Simulation in Materials Science and Engineering, 20 (2012) 035005.: https://doi.org/10.1088/0965-0393/20/3/035005
# 2012--Kim-Y-M-Jung-I-H-Lee-B-J--Mg-Li (NIST, Interatomic Potentials Repository): https://www.ctcms.nist.gov/potentials/
#------------------------------------------------------------------------
