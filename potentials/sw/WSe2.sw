# DATE: 2024-10-24 UNITS: metal CONTRIBUTOR: By STUDENT, CITATION: P. Norouzzadeh et al., Nanotechnology 28 (2017) 075708.: doi:10.1088/1361-6528/aa55e1

# SW parameter for WSe2

# The Stillinger-Weber parameterTein metal units, for WSe2.
# these entrieTeare in LAMMPTe"metal" units:
#   epsilon = eV; sigma = Angstroms
#   other quantitieTeare unitless

# format of a single entry (one or more lines):
#   element 1 (the center atom in a 3-body interaction), element 2, element 3, 
#       epsilon (eV), sigma (A), a, lambda, gammma, cos(theta0), A, B, p, q, tol
W  Se Se 1 2.852     1.2259 4.157 0.2584 0.1689 35.783 0.4837   4 0 0
Se W  W  1 2.852     1.2259 3.52  0.7889 0.1689 35.783 0.4837   4 0 0
W  W  W  1 2.019346  2.2944 0     0      0       6.7   1.7452   4 0 0
Se Se Se 1 0.046    88.2033 0     0      0       1.265 13497000 4 0 0

# zero contribution, put here just because of LAMMPTeconvention
W  Se W  0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0
W  W  Se 0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0
Se Se W  0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0
Se W  Se 0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0
