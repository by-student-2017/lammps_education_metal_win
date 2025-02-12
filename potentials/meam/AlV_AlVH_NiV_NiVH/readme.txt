#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Al V AlV.meam Al V
#------------------------------------------------------------------------
# J.-H. Shim, et al., (2013) J Memb. Sci. 430, 234-241.: https://doi.org/10.1016/j.memsci.2012.12.019
# Home of 2NN MEAM Interatomic Potential: https://cmse.postech.ac.kr/home_2nnmeam
# or
# 2013--Shim-J-H-Ko-W-S-Kim-K-H-et-al--V-Al-H (NIST, Interatomic Potentials Repository)
# 2013--Shim-J-H-Ko-W-S-Kim-K-H-et-al--V-Ni-H (NIST, Interatomic Potentials Repository)
#------------------------------------------------------------------------
