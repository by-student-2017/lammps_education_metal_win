#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 1NN-MEAM
# Please note that the value of "rozero" is not mentioned in the paper!
# The rozero of Al, Si, Mg, and Fe used was as follows: Jelinek_2012_meamf (in AlSiMgCuFe_AA6061)
# For Al, Si, Mg, and Fe, I followed Jelinek, who is cited in the paper.
pair_style meam
pair_coeff * * library.meam Al Si Mg Fe Cr NULL Al Si Mg Fe Cr
#-------------------------------------------------------------
# D. T. H. Hue et al., Vacuum 201 (2022) 111104.: https://doi.org/10.1016/j.vacuum.2022.111104
# Si, Cr: M. I. Baskes, Phys. Rev. B 46 (1992) 2727.: https://doi.org/10.1103/PhysRevB.46.2727
# Al, Si, Mg, Fe: B. Jelinek et al., Phys. Rev. B 85, 245102.: http://dx.doi.org/10.1103/PhysRevB.85.245102
# Please note that the value of "rozero" is not mentioned in the paper!
# The rozero of Al, Si, Mg, and Fe used was as follows: Jelinek_2012_meamf (in AlSiMgCuFe_AA6061)
# For Al, Si, Mg, and Fe, I followed Jelinek, who is cited in the paper.
#-------------------------------------------------------------
