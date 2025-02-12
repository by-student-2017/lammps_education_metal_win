#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * Jelinek_2012_meamf Al Si Mg Cu Fe Jelinek_2012_meam.alsimgcufe Al Si Mg Cu Fe
#------------------------------------------------------------------------
# B. Jelinek et al., Physical Review B, 85 (2012) 245102.: https://doi.org/10.1103/physrevb.85.245102
# 2012--Jelinek-B-Groh-S-Horstemeyer-M-F-et-al--Al-Si-Mg-Cu-Fe (NIST, Interatomic Potentials Repository): https://www.ctcms.nist.gov/potentials/
#------------------------------------------------------------------------
# Here, the S after the element name has been omitted. In the case of NIST, it is necessary to add an S after the element name.
# e.g.,
# 2NN-MEAM (from NIST)
pair_style meam
pair_coeff * * Jelinek_2012_meamf AlS SiS MgS CuS FeS Jelinek_2012_meam.alsimgcufe AlS SiS MgS CuS FeS
# The S may not be necessary when specifying the element name in the second half (I have not tried this).
pair_coeff * * Jelinek_2012_meamf AlS SiS MgS CuS FeS Jelinek_2012_meam.alsimgcufe Al Si Mg Cu Fe
#------------------------------------------------------------------------
