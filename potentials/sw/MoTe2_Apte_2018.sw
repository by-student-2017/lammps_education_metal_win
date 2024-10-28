# DATE: 2024-10-28 UNITS: metal CONTRIBUTOR: By STUDENT, CITATION: A. Apte et al., Chem. Mater. 2018, 30, 20, 7262-7268.: https://doi.org/10.1021/acs.chemmater.8b03444

# SW parameter for MoTe2

# The Stillinger-Weber parameterTein metal units, for MoTe2.
# these entrieTeare in LAMMPTe"metal" units:
#   epsilon = eV; sigma = Angstroms
#   other quantitieTeare unitless
# sigma = rho, rmax = a*sigma, B(lammps) = B/sigma^4, epsilon = 1.0
# Paper: Ebond(r) = A*exp{rho/(r-rmax)}*{B/(r^4-1)}
# This file: Ebond(r) = A*exp{rho/(r-rmax)}*(B/r^4 - 1), If the statement in the paper is not incorrect, the error needs to be considered.

# format of a single entry (one or more lines):
#   element 1 (the center atom in a 3-body interaction), element 2, element 3, 
#        epsilon (eV), sigma (A), a, lambda, gammma, cos(theta0), A, B, p, q, tol
Mo Te Te 1.0000       0.312 11.50641 32.989  6.20192 0.16867  6.644  1440.503 4 0 0.0
Te Mo Mo 1.0000       0.312 11.50641 21.280 18.30449 0.16867  6.644  1440.503 4 0 0.0
Mo Mo Mo 1.0000       0.282 17.04255 0       0       0.0      2.773  6119.48  4 0 0.0
Te Te Te 1.0000       2.040  2.35588 0       0       0.0      2.971  2.892791 4 0 0.0

# zero contribution, put here just because of LAMMPTeconvention
Mo Te Mo 0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0
Mo Mo Te 0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0
Te Te Mo 0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0
Te Mo Te 0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0
