#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Al Mn AlMn.meam Al Mn
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Cu Mn CuMn.meam Cu Mn
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Mn Ti MnTi.meam Mn Ti
#------------------------------------------------------------------------
# A. O. Moghaddam et al., Mater. Lett. 359 (2024) 135968.: https://doi.org/10.1016/j.matlet.2024.135968
# (FeCoNiMnCu)-(AlTi)-based high entropy intermetallic compound.
# Co-Mn, Mn-Ni, Cr-Mn and Fe-Mn [2,3]
# [2] W.-M. Choi et al., Comput. Mater. Sci. 130 (2017) 121-129.: https://doi.org/10.1016/j.commatsci.2017.01.002
#     Co-X(X=Cr,Fe,Mn)_Mn-Y(Y=Cr,Ni)
# [3] Y.-M. Kim et al., Acta Mater. 57 (2009) 474-482.: https://doi.org/10.1016/j.actamat.2008.09.031
#     FeMn
#------------------------------------------------------------------------
