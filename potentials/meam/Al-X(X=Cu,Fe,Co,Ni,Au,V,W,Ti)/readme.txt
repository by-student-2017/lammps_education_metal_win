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
# C(i-k-j) = C(A-B-A), C(B-A-B), C(A-A-B), C(A-B-B): Perhaps the last C(M-Al-Al) in the "Reference state" is a mistake, instead of C(A-B-B). In addition, the last four Cs are inferred to be errors in Cmax based on the assumptions and values.
# C(A,A,B), C(B,B,A), C(A,B,A), C(A,B,B) in lammps
# Although there is no description of Cmin and Cmax for "Al-Y (Y = Ni, Au, V, W, Ti)" in the table, the "Assumption" was applied as with "Al-X (X = Cu, Fe, Co)".
# Fe in library.meam: The paper contains many errors, so it is difficult to assume that the numerical values ​​are reliable. Here, we use the publicly available data from [27].
#------------------------------------------------------------------------
# Al-Co
# Although the literature states that "During the parameterization, the parameter Cmin for Cu is reduced from 1.21 originally to 0.8, 
# and Cmax for Co is increased from 2.0 originally to 2.8," the calculation was performed with Cmax,Co = 2.0. Here, we decided to follow the values ​​in Table 3.
#------------------------------------------------------------------------
# Co-Al (B2 structure)
# dEc(Ec(B2) - 0.5*Ec(Co) - 0.5*Ec(Al) = -0.565
# re = 2.4768, B = 1.62 [10^12 dyn/cm2]
# Ref. [32] W.-P. Dong et al., CALPHAD 38 (2012) 7-16.
#------------------------------------------------------------------------
# Al-Cu (B1 structure)
# AlCu(B1): Ec = 3.42 [eV], alpha = 4.85 (B = 89.5 [GPa]), re = 2.52 (885 K), 2.54 (1000 K), and 2.59 (1345 K) 
# Ref. [31] M. E. Trybula et al., Comput. Mater. Sci. 122 (2016) 341-352.
#------------------------------------------------------------------------
# In my environment, I cannot immediately obtain the papers cited in the MEAM parameters, so I cannot check thoroughly. 
# In particular, I cannot check whether the B1 structure is the correct reference structure for Al-Co, not the B2 structure.
#------------------------------------------------------------------------
