#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Zr Ag Cu ZrAgCu.meam Zr Ag Cu
#------------------------------------------------------------------------
# An atomistic modeling of the Cu-Zr-Ag bulk metallic glass system
# Kyung-Han Kang, Inyoung Sa, Jae-Chul Lee, Eric Fleury and Byeong-Joo Lee, Scripta Materialia 61, 801-804 (2009).
# Home of 2NN MEAM Interatomic Potential: https://cmse.postech.ac.kr/home_2nnmeam
#------------------------------------------------------------------------
