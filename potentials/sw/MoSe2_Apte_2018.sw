# DATE: 2024-10-28 UNITS: metal CONTRIBUTOR: By STUDENT, CITATION: A. Apte et al., Chem. Mater. 2018, 30, 20, 7262-7268.: https://doi.org/10.1021/acs.chemmater.8b03444

# SW parameter for MoSe2

# The Stillinger-Weber parameterTein metal units, for MoSe2.
# these entrieTeare in LAMMPTe"metal" units:
#   epsilon = eV; sigma = Angstroms
#   other quantitieTeare unitless
# sigma = rho, rmax = a*sigma, B(lammps) = B/sigma^4, epsilon = 1.0
# Paper: Ebond(r) = A*exp{rho/(r-rmax)}*{B/(r^4-1)}
# This file: Ebond(r) = A*exp{rho/(r-rmax)}*(B/r^4 - 1), If the statement in the paper is not incorrect, the error needs to be considered.

# format of a single entry (one or more lines):
#   element 1 (the center atom in a 3-body interaction), element 2, element 3, 
#        epsilon (eV), sigma (A), a, lambda, gammma, cos(theta0), A, B, p, q, tol
Mo Se Se 1.0000       0.3390 8.57692 66.026  4.37949 0.15931  6.02   544.6432 4 0 0.0
Se Mo Mo 1.0000       0.3390 8.57692 23.488 14.64359 0.15931  6.02   544.6432 4 0 0.0
Mo Mo Mo 1.0000       0.3390 13.2537 0       0       0.0      3.19   2521.421 4 0 0.0
Se Se Se 1.0000       1.6750 2.68239 0       0       0.0      2.42   3.741330 4 0 0.0

# zero contribution, put here just because of LAMMPTeconvention
Mo Se Mo 0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0
Mo Mo Se 0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0
Se Se Mo 0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0
Se Mo Se 0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0
