# H.-K. Kim et al., Journal of Materials Research, 25 (2010) 1288-1297.: https://doi.org/10.1557/jmr.2010.0182
# Home of 2NN MEAM Interatomic Potential: https://cmse.postech.ac.kr/home_2nnmeam

# Fe-N: B.-J. Lee et al., Acta Materialia, 54 (2006) 4597-4607.: https://doi.org/10.1016/j.actamat.2006.06.003
# 2006--Lee-B-J-Lee-T-H-Kim-S-J--Fe-N (NIST, Interatomic Potentials Repository) 

# Nb-Fe: The parameters d, Cmin, and Cmax all agree with the calculated values ​​of "Assumption".
# If they happen to match "Assumption", that's good, but if not, you'll need to refit.

# Note: n the paper, the Cmax value for Nb-N is 2.00, but it is 2.8. If the Cmax value for Nb-N is set to 2.00 and 
# the Cmax value for Fe-N in other literature is corrected to 1.44, the Cmax value for Nb-Fe-N becomes 1.71. 
# It is likely that the original Cmax value was mistakenly written as replus. Based on these facts, 
# the value for Fe-N in other literature and the value in the paper for Nb-N have been corrected.

#-------------------------------------------------------------------------------------------------------------
# original directory

# The replus value related to "d = a3" differs from that described in the paper and is abnormally high.
# d is related to the shape of the Rose universal curve. It usually takes a value in the range of about 0.0-0.05, 
# but it is necessary to verify whether large values ​​such as 1.44 or 2.00 are really correct.

# Nb-N
repuls(1,3) =	2.00 # It is 2.00, not 0.0000. Why ?
attrac(1,3) =	0.0000

# Fe-N
repuls(2,3) =	1.44 # It is 1.44, not 0.0250. Why ?
attrac(2,3) =	0.0250
#-------------------------------------------------------------------------------------------------------------
