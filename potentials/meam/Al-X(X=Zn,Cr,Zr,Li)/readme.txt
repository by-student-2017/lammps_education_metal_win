#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM, Al-X(X=Zn,Cr,Zr,Li)
pair_style meam
pair_coeff * * library.meam Al Zn Cr ZrLT ZrHT Li AlZnCrZrLTZrHTLi.meam Al Zn Cr ZrLT ZrHT Li 
#------------------------------------------------------------------------
# For example, the low-temperature case
# 2NN-MEAM, Al-X(X=Zn,Cr,Zr,Li)
pair_style meam
pair_coeff * * library.meam Al Zn Cr ZrLT Li AlZnCrZrLTZrHTLi.meam Al Zn Cr ZrLT Li 
#------------------------------------------------------------------------
# For example, the high-temperature case
# 2NN-MEAM, Al-X(X=Zn,Cr,Zr,Li)
pair_style meam
pair_coeff * * library.meam Al Zn Cr ZrHT Li AlZnCrZrLTZrHTLi.meam Al Zn Cr ZrHT Li 
#------------------------------------------------------------------------
