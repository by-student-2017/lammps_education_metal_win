#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Mg Mn MgMn.meam Mg Mn
#------------------------------------------------------------------------
# Hyo-Sun Jang, B.-J. Lee, A Modified Embedded-Atom Method Interatomic Potential for the Mg Mn Binary System, Mater. Trans. (2022), accepted. 
# Home of 2NN MEAM Interatomic Potential: https://cmse.postech.ac.kr/home_2nnmeam
#------------------------------------------------------------------------
