#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Al V H AlVH.meam Al V H
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Al V AlV.meam Al V
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Ni V NiV.meam Ni V
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Ni V H NiVH.meam Ni V H
#------------------------------------------------------------------------
# J.-H. Shim, et al., (2013) J Memb. Sci. 430, 234-241.: https://doi.org/10.1016/j.memsci.2012.12.019
# Home of 2NN MEAM Interatomic Potential: https://cmse.postech.ac.kr/home_2nnmeam
# or
# 2013--Shim-J-H-Ko-W-S-Kim-K-H-et-al--V-Al-H (NIST, Interatomic Potentials Repository)
# 2013--Shim-J-H-Ko-W-S-Kim-K-H-et-al--V-Ni-H (NIST, Interatomic Potentials Repository)
#
# V: [16] B.-J. Lee et al., Phys. Rev B 64 (2001) 184102.: https://doi.org/10.1103/PhysRevB.64.184102
# Al, Ni: [18] B.-J. Lee et al., Phys. Rev. B 68 (2003) 144112.: https://doi.org/10.1103/PhysRevB.68.144112
# H: [19] B.-J. Lee et al., Acta Mater. 55 (2007) 6779-6788.: https://doi.org/10.1016/j.actamat.2007.08.041
# Bulk modulus B is not defined for a gaseous element.
#------------------------------------------------------------------------
