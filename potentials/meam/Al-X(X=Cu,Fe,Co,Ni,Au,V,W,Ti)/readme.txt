#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic

# 2NN-MEAM, Al-X(X=Cu,Fe,Co,Ni,Au,V,W,Ti)
pair_style meam
pair_coeff * * library.meam Al Ni Cu Au V Fe W Ti Co AlNiCuAuVFeWTiCo.meam Al Ni Cu Au V Fe W Ti Co
#------------------------------------------------------------------------
# From the "Assumption", it can be inferred that C(i-k-j) = C(i,j,k).
# I was unable to obtain the cited papers for Co and Cu. I used data with similar values ​​from library.meam, but there are differences from the papers as noted in the comments.
# C(i-k-j) = C(A-B-A), C(B-A-B), C(A-A-B), C(A-B-B): Perhaps the last C(M-Al-Al) in the "Reference state" is a mistake, instead of C(A-B-B). In addition, the last four Cs are inferred to be errors in Cmax based on the assumptions and values.
# C(A,A,B), C(B,B,A), C(A,B,A), C(A,B,B) in lammps
# Although there is no description of Cmin and Cmax for "Al-Y (Y = Ni, Au, V, W, Ti)" in the table, the "Assumption" was applied as with "Al-X (X = Cu, Fe, Co)".
# Although "Al-Co" is written as B1 in the literature, they are B2 in the structure of the cited source, so we decided to use B2.
# Fe in library.meam: The paper contains many errors, so it is difficult to assume that the numerical values ​​are reliable. Here, we use the publicly available data from [27].
#------------------------------------------------------------------------
