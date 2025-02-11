#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Pt C PtC.meam Pt C
#------------------------------------------------------------------------
#Interatomic potentials for Pt-C and Pd-C systems and a study of structure-adsorption relationship in large Pt/Graphene system
# Ga-Un Jeong, Byeong-Joo Lee, Compu. Mater. Sci. (2020).
# 
#------------------------------------------------------------------------
