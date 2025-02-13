#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Ni Ti NiTi.meam Ni Ti
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Ni Al Ti NiAlTi.meam Ni Al Ti
#------------------------------------------------------------------------
# Y.-K. Kim, H.-K. Kim, W.-S. Jung, B.-J. Lee, Development and application of Ni-Ti and Ni-Al-Ti 2NN-MEAM interatomic potentials for Ni-base superalloys, Comput. Mater. Sci. (2017).
# Home of 2NN MEAM Interatomic Potential: https://cmse.postech.ac.kr/home_2nnmeam
#------------------------------------------------------------------------
