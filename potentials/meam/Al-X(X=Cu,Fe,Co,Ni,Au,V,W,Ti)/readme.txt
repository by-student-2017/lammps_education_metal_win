#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM, Al-M(M=Cu,Fe,Co,Ni,Au,V,W,Ti)
pair_style meam
pair_coeff * * library.meam Al Ni Cu Au V Fe W Ti Co AlNiCuAuVFeWTiCo.meam Al Ni Cu Au V Fe W Ti Co
#------------------------------------------------------------------------
# According to the paper, if the parameters are set appropriately, the difference between the experimental and calculated values ​​of Young's modulus (E) and thermal expansion coefficient (alpha) is approximately 15%.
#------------------------------------------------------------------------
# Note: Calculations that take into account additive elements in Al-based alloys. When the concentration of additive elements is high and different additive elements are adjacent to each other, it is necessary to optimize the parameters between the additive elements in order to handle the interactions between the different additive elements (especially the elastic constants) more accurately.
#------------------------------------------------------------------------
# In the paper, d, Cmin and Cmax are all calculated using the "Assumption" formula. (A-M (M=Cu,Fe,Co))
# For "Al-M (M = Ni, Au, V, W, Ti)", only Ec, re, and B are provided. There is no mention of d, Cmin, or Cmax in the paper. I don't know if I need to apply the "Assumption" formula. This is because the paper only shows Cu, Fe, and Co being deposited on the Al surface. 
#------------------------------------------------------------------------
# From the "Assumption", it can be inferred that C(i-k-j) = C(i,j,k).
# C(i-k-j) = C(A-B-A), C(B-A-B), C(A-A-B), C(A-B-B): Perhaps the last C(M-Al-Al) in the "Reference state" is a mistake, instead of C(A-B-B). In addition, the last four Cs are inferred to be errors in Cmax based on the assumptions and values.
# C(A,A,B), C(B,B,A), C(A,B,A), C(A,B,B) in lammps
# For "Al-M (M = Ni, Au, V, W, Ti)", we added Cmin and Cmax in "Assumpiton", just like for "A-X (X = Cu, Fe, Co)". If you don't need them, just delete d, Cmin, and Cmax, or put # at the beginning of the line.
# Fe in library.meam: The paper contains many errors, so it is difficult to assume that the numerical values ​​are reliable. Here, we use the publicly available data from [27].
# For AlCo, the reference structure was chosen to be B2 rather than B1, taking into account the values ​​of Ec, B, and re.
# The Ec values ​​of L12-Al3Au and B1-AlCu were calculated by referring to the cited paper, but they did not match the values ​​in the paper. On the other hand, the Ec values ​​of B1-AlW and L12-Al3Ti were almost the same as those in the paper.
#------------------------------------------------------------------------
# Al-Co
# Although the literature states that "During the parameterization, the parameter Cmin for Cu is reduced from 1.21 originally to 0.8, 
# and Cmax for Co is increased from 2.0 originally to 2.8," the calculation was performed with Cmax,Co = 2.0. Here, we decided to follow the values ​​in Table 3.
# Note: The Ec calculation for Co-Al agrees with the value published by NIST, but the reference structure cited is the B2 structure, not the B1.
#------------------------------------------------------------------------
# Co-Al (B2 structure) (see CoAl.meam in CoAl directory)
# Mistake !!!: dEc(Ec(B2) - 0.5*Ec(Co) - 0.5*Ec(Al) = -0.565
# #delta(1,2) = -0.565 # Ec_IJ = (Ec_II + Ec_JJ)/2 - delta_IJ
# Ec(B2) = 0.5*Ec(Co) + 0.5*Ec(Al) + 0.565 = 0.5*4.4100 + 0.5*3.3600 + 0.565 = 4.45
# re = 2.4768, B = 1.62 [10^12 dyn/cm2] (162 [GPa])
# C(i-k-j) = C(i,j,k)
# Cmin(Co-Al-Co) = Cmin(1,1,2) = 0.49 = Cmin(1,1,1)
# Cmin(Al-Co-Al) = Cmin(2,2,1) = 1.10
# Cmin(Co-Co-Al) = Cmin(1,2,1) = [0.5*Cmin(1,1,1)^0.5+0.5*Cmin(2,2,2)^0.5]^2 = 0.49
# Cmin(Co-Al-Al) = Cmin(1,2,2) = [0.5*Cmin(1,1,1)^0.5+0.5*Cmin(2,2,2)^0.5]^2 = 0.49
# Cmax(Co-Al-Co) = Cmax(1,1,2) = 2.0 = Cmax(1,1,1)
# Cmax(Al-Co-Al) = Cmax(2,2,1) = 2.8 = Cmax(2,2,2)
# Cmax(Co-Co-Al) = Cmax(1,2,1) = 2.8 (default value)
# Cmax(Co-Al-Al) = Cmax(1,2,2) = 2.8 (default value)
# Ref. [32] W.-P. Dong et al., CALPHAD 38 (2012) 7-16.
#------------------------------------------------------------------------
# Al-Cu (B1 structure)
# AlCu(B1): Ec = 3.42 [eV], alpha = 4.85 (B = 89.5 [GPa]), re = 2.52 (885 K), 2.54 (1000 K), and 2.59 (1345 K) 
# Ref. [31] M. E. Trybula et al., Comput. Mater. Sci. 122 (2016) 341-352.
#------------------------------------------------------------------------
# In my environment, I cannot immediately obtain the papers cited in the MEAM parameters, so I cannot check thoroughly. 
# In particular, I cannot check whether the B1 structure is the correct reference structure for Al-Co, not the B2 structure.
#------------------------------------------------------------------------
