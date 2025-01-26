#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic

# 2NN-MEAM, Al-X(X=Zn,Cr,Zr,Li)
pair_style meam
pair_coeff * * library.meam Al Zn Cr ZrLT ZrHT Li AlZnCrZrLTZrHTLi.meam Al Zn Cr ZrLT ZrHT Li 
#------------------------------------------------------------------------
