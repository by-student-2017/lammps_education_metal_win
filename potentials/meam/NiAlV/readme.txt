#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Ni Al V NiAlV.meam Ni Al V
#------------------------------------------------------------------------
# Ni,Al: [12] B. J. Lee, J. H. Shim, and M. I.Baskes, Phys. Rev. B 68, 144112 (2003).
# V: [10]  B. J. Lee, M. I. Baskes, and H. Kim, and Y. K. Cho, Phys. Rev. B 64, 184102 (2001).
# NiAlCo: 2015--Kim-Y-K-Jung-W-S-Lee-B-J--Ni-Al-Co
# W.-P. Dong et al., Met. Mater. Int. 20, 423–429 (2014). https://doi.org/10.1007/s12540-014-3004-7
# NiV, AlV: J.-H. Shim, et al., (2013) J Memb. Sci. 430, 234-241.
# The formula for Ec (sign of delta) is incorrect in the literature.
#------------------------------------------------------------------------
