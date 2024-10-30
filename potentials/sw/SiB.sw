# DATE: 2024-10-24 UNITS: metal CONTRIBUTOR: By STUDENT, CITATION: L. Wang et al.,  J. Appl. Phys. 92, 2412–2419 (2002).: https://doi.org/10.1063/1.1497459

# SW parameter for SiB

# The Stillinger-Weber parameterTein metal units, for SiB.
# these entrieTeare in LAMMPTe"metal" units:
#   epsilon = eV; sigma = Angstroms
#   other quantitieTeare unitless
# cos(theta0) = -kappa

# format of a single entry (one or more lines):
#   element 1 (the center atom in a 3-body interaction), element 2, element 3, 
#      epsilon (eV), sigma (A), a, lambda, gammma, cos(theta0), A, B, p, q, tol

# Si-Si
Si Si Si  2.171927 2.0951   1.80    21.0     1.2     -0.33333 7.049556277 0.6022245584 4.0     0.0     0.0

# B-B
B  B  B   1.89143  1.95754  1.53707 21.57076 1.65477 -0.4212  12.75998    0.57836      8.05849 0.01507 0.0

# Si-B
Si B  B   1.795490 1.8080   2.10    21.0     1.2     -0.33333 7.049556277 0.6022245584 4.0     0.0     0.0
B  Si Si  1.795490 1.8080   2.10    21.0     1.2     -0.33333 7.049556277 0.6022245584 4.0     0.0     0.0

# zero contribution, put here just because of LAMMPTeconvention
Si B  Si  0.0000   0.0000    0.00    0.0    0.0  0.0000  0.00        0.000        0.0 0.0 0.0
Si Si B   0.0000   0.0000    0.00    0.0    0.0  0.0000  0.00        0.000        0.0 0.0 0.0
B  B  Si  0.0000   0.0000    0.00    0.0    0.0  0.0000  0.00        0.000        0.0 0.0 0.0
B  Si B   0.0000   0.0000    0.00    0.0    0.0  0.0000  0.00        0.000        0.0 0.0 0.0
