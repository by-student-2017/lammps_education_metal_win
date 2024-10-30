# DATE: 2024-10-30 UNITS: metal CONTRIBUTOR: By STUDENT, CITATION: N. V. Hung et al., Open Phys. 2015;13:242-246.: https://doi.org/10.1515/phys-2015-0031

# SW parameter for GaP

# The Stillinger-Weber parameterTein metal units, for GaP.
# these entrieTeare in LAMMPTe"metal" units:
#   epsilon = eV; sigma = Angstroms
#   other quantitieTeare unitless

# format of a single entry (one or more lines):
#   element 1 (the center atom in a 3-body interaction), element 2, element 3, 
#       epsilon (eV), sigma (A), a, lambda, gammma, cos(theta0), A, B, p, q, tol
Ga P  P  1.78  2.0642 1.8    29.57   1.2   -0.33333 7.62333  0.681  4.000 0.000 0.0
P  Ga Ga 1.78  2.0642 1.8    29.57   1.2   -0.33333 7.62333  0.681  4.000 0.000 0.0

Ga Ga Ga 0.000 0.0000 0.0000  0.0    0.0    0.0     0.0000   0.0000 0.000 0.000 0.0
P  P  P  0.000 0.0000 0.0000  0.0    0.0    0.0     0.0000   0.0000 0.000 0.000 0.0

# zero contribution, put here just because of LAMMPTeconvention
Ga P  Ga 0.000 0.0000 0.0000  0.0    0.0    0.0     0.0000   0.0000 0.000 0.000 0.0
Ga Ga P  0.000 0.0000 0.0000  0.0    0.0    0.0     0.0000   0.0000 0.000 0.000 0.0
P  P  Ga 0.000 0.0000 0.0000  0.0    0.0    0.0     0.0000   0.0000 0.000 0.000 0.0
P  Ga P  0.000 0.0000 0.0000  0.0    0.0    0.0     0.0000   0.0000 0.000 0.000 0.0
