#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Nb Fe C NbFeC.meam Nb Fe C
#------------------------------------------------------------------------
# H.-K. Kim et al., Journal of Materials Research, 25 (2010) 1288-1297.: https://doi.org/10.1557/jmr.2010.0182
#
# 2010--Kim-H-K-Jung-W-S-Lee-B-J--Fe-Nb-C (NIST, Interatomic Potentials Repository)
# or
# Home of 2NN MEAM Interatomic Potential: https://cmse.postech.ac.kr/home_2nnmeam
#------------------------------------------------------------------------
# Fe-C: B.-J. Lee, Acta Materialia, 54 (2006) 701-711.: https://doi.org/10.1016/j.actamat.2005.09.034
# 2006--Lee-B-J--Fe-C (NIST, Interatomic Potentials Repository)

# Nb-Fe: The parameters d, Cmin, and Cmax all agree with the calculated values ​​of "Assumption".
# If they happen to match "Assumption", that's good, but if not, you'll need to refit.

# Nb-Fe-C: The parameters d, Cmin, and Cmax all agree with the calculated values ​​of "Assumption".
# If they happen to match "Assumption", that's good, but if not, you'll need to refit.
#------------------------------------------------------------------------
