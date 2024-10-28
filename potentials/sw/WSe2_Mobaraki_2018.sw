# DATE: 2024-10-28 UNITS: metal CONTRIBUTOR: By STUDENT, CITATION: A. Mobaraki et al., Comput. Mater. Sci. 144 (2018) 92-98.: https://doi.org/10.1016/j.commatsci.2017.12.005

# SW parameter for WSe2

# The Stillinger-Weber parameterTein metal units, for WSe2.
# these entrieTeare in LAMMPTe"metal" units:
#   epsilon = eV; sigma = Angstroms
#   other quantitieTeare unitless
# sigma = rho, rmax = a*sigma, B(lammps) = B/sigma^4, lambda = K, epsilon = 1.0
# Since K of "W-Seu-Sed" is only 0.1/20.0 = 0.005 times that of "W-Seu,d-Seu,d", the contribution of "W-Seu,d-Seu,d" was ignored.

# format of a single entry (one or more lines):
#   element 1 (the center atom in a 3-body interaction), element 2, element 3, 
#        epsilon (eV), sigma (A), a, lambda, gammma, cos(theta0), A, B, p, q, tol
W  Se Se 1.0000       1.7403 1.93070 20.0000 0.74740 0.15135 10.0106 2.102481 4 0 0.0
Se W  W  1.0000       1.7403 1.93070 20.0000 0.74740 0.15135 10.0106 2.102481 4 0 0.0
W  W  W  1.0000       0.1098 41.2568 0       0       0.0      0.6120 688003.5 4 0 0.0
Se Se Se 1.0000       0.1000 40.2    0       0       0.0      1.6103 200000.0 4 0 0.0

# zero contribution, put here just because of LAMMPTeconvention
W  Se W  0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0
W  W  Se 0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0
Se Se W  0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0
Se W  Se 0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0
