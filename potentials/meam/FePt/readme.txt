#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Pt Fe PtFe.meam Pt Fe
#------------------------------------------------------------------------
# J. Kim et al., Journal of Materials Research, 21 (2006) 199-208. 
# 2006--Kim-J-Koo-Y-Lee-B-J--Fe-Pt
# or
# Home of 2NN MEAM Interatomic Potential: https://cmse.postech.ac.kr/home_2nnmeam
#------------------------------------------------------------------------
