#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Fe Cu FeCu.meam Fe Cu
#------------------------------------------------------------------------
# An MEAM Interatomic Potential for the Fe-Cu Alloy System and Cascade Simulation on pure Fe and Fe-Cu Alloy Byeong-Joo Lee, Brian D. Wirth, Jae-Hyeok Shim, Junhyun Kwon, Sang Chul Kwon, Jun-Hwa Hong, Phys. Rev. B. 71, 184205 (2005).
# Home of 2NN MEAM Interatomic Potential: https://cmse.postech.ac.kr/home_2nnmeam
#------------------------------------------------------------------------
