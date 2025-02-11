#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Mn Sn MnSn.meam Mn Sn
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Na Cu Sn NaCuSn.meam Na Cu Sn
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Na Mn Sn NaMnSn.meam Na Mn Sn
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Na Ni Sn NaNiSn.meam Na Ni Sn
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Ni Sn NiSn.meam Ni Sn
#------------------------------------------------------------------------
# "Second nearest-neighbor modified embedded atom method interatomic potentials for Na-M−Sn (M = Cu, Mn, Ni) ternary systems", Yongmin Kim, Byeong-Joo Lee, Computational Materials Science, Vol. 206, 15, 111305 (2022)
# Home of 2NN MEAM Interatomic Potential: https://cmse.postech.ac.kr/home_2nnmeam
#------------------------------------------------------------------------
