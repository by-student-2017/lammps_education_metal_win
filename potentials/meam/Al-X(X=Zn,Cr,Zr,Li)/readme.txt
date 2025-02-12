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
# C. rincent et al., Phys. Chem. Chem. Phys., 2023,25, 10866-10884.: https://doi.org/10.1039/D3CP00912B
# Note: Not all parameters are listed in the paper. (e.g., augt1, delr, and ialloy, etc)
# Cmin,max(i-k-j) (with the ij pair screened by k)
# C(i-k-j) = C(i,j,k)
# The Al-Cr and Al-Zr (with the Zr-BCC reference) force fields were obtained from the literature.[37]
# [37] https://doi.org/10.1039/D2CP02746A
#------------------------------------------------------------------------
