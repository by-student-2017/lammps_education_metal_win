#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 1NN-MEAM
# Please note that the value of "rozero" is not mentioned in the paper!
# The rozero of Al, Si, Mg, and Fe used was as follows: Jelinek_2012_meamf (in AlSiMgCuFe_AA6061)
# For Al, Si, Mg, and Fe, I followed Jelinek, who is cited in the paper.
pair_style meam
pair_coeff * * library.meam Al Si Mg Fe Cr NULL Al Si Mg Fe Cr
#-------------------------------------------------------------
