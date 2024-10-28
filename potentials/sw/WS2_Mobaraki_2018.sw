# DATE: 2024-10-28 UNITS: metal CONTRIBUTOR: By STUDENT, CITATION: A. Mobaraki et al., Comput. Mater. Sci. 144 (2018) 92-98.: https://doi.org/10.1016/j.commatsci.2017.12.005

# SW parameter for WS2

# The Stillinger-Weber parameterTein metal units, for WS2.
# these entrieTeare in LAMMPTe"metal" units:
#   epsilon = eV; sigma = Angstroms
#   other quantitieTeare unitless
# sigma = rho, rmax = a*sigma, B(lammps) = B/sigma^4, lambda = K, epsilon = 1.0
# Since K of "W-Su-Sd" is only 0.1/19.5209 = 0.005 times that of "W-Su,d-Su,d", the contribution of "W-Su,d-Su,d" was ignored.

# format of a single entry (one or more lines):
#   element 1 (the center atom in a 3-body interaction), element 2, element 3, 
#        epsilon (eV), sigma (A), a, lambda, gammma, cos(theta0), A, B, p, q, tol
W  S  S  1.0000       1.3972 2.29745 19.5209 0.75437 0.13321 8.8208 4.240796 4 0 0.0
S  W  W  1.0000       1.3972 2.29745 19.5209 0.75437 0.13321 8.8208 4.240796 4 0 0.0
W  W  W  1.0000       0.7340 5.92643 0       0       0.0     1.4797 230.6599 4 0 0.0
S  S  S  1.0000       0.1284 29.5950 0       0       0.0     0.7701 65120.18 4 0 0.0

# zero contribution, put here just because of LAMMPTeconvention
W  S  W  0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0
W  W  S  0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0
S  S  W  0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0
S  W  S  0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0
