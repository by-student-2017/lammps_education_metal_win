#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 1NN-MEAM
# Note: Zn (b1=b2=b3=t1=t2=t3=0) from EAM
# Note that the value of "rozero" is not mentioned in the paper !
# The rozero of Al, Si, Mg, and Fe used was as follows: J.-W. Hong, CE-Theses_Ph.D. (2021).: https://koasas.kaist.ac.kr/handle/10203/307792
# Note: ibar = 0 -> -5 for t(h) < 0 and Gamma < -1
pair_style meam
pair_coeff * * library.meam Al Si Mg Cu Zn NULL Al Si Mg Cu Zn
#-------------------------------------------------------------
# H. W. Jang et al., Comput. Mater. Sci. 159 (2019) 66-72.: https://doi.org/10.1016/j.commatsci.2018.11.050
# Related paper: H. W. Jang et al., Materials 2020, 13(9), 2062; https://doi.org/10.3390/ma13092062 (Open Access)
# Note that the value of "rozero" is not mentioned in the paper !
# rozero data get from J.-W. Hong, CE-Theses_Ph.D. (2021).: https://koasas.kaist.ac.kr/handle/10203/307792
#-------------------------------------------------------------
