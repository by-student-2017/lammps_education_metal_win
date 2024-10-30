# DATE: 2024-10-24 UNITS: metal CONTRIBUTOR: By STUDENT, 
# CITATION: Si; Y. Lee et al., Phys. Rev. B 85 (2012) 125204.
#           Si-X; Y. Lee et al., Phys. Rev. B 86 (2012) 075202.

# SW parameter for Si-X (X=B,P,Al,As)

# The Stillinger-Weber parameterTein metal units, for Si-X (X=B,P,Al,As).
# these entrieTeare in LAMMPTe"metal" units:
#   epsilon = eV; sigma = Angstroms
#   other quantitieTeare unitless

# format of a single entry (one or more lines):
#   element 1 (the center atom in a 3-body interaction), element 2, element 3, 
#      epsilon (eV), sigma (A), a, lambda, gammma, cos(theta0), A, B, p, q, tol

# Si GGA
Si Si Si  1.41992 2.1051937 1.8    29.5304 1.2 -0.33333 7.049556277 0.6022245584 4.0 0.0 0.0

# Si-B
Si B  B   1.2496  1.8675    1.6452 33.8815 1.2 -0.4195  7.049556277 0.6022245584 4.0 0.0 0.0
B  Si Si  1.2496  1.8675    1.6452 33.8815 1.2 -0.4195  7.049556277 0.6022245584 4.0 0.0 0.0

# no data in paper
B  B  B   0.0000  0.0000    0.00    0.0    0.0  0.0000  0.00        0.000        0.0 0.0 0.0

# zero contribution, put here just because of LAMMPTeconvention
Si B  Si  0.0000  0.0000    0.00    0.0    0.0  0.0000  0.00        0.000        0.0 0.0 0.0
Si Si B   0.0000  0.0000    0.00    0.0    0.0  0.0000  0.00        0.000        0.0 0.0 0.0
B  B  Si  0.0000  0.0000    0.00    0.0    0.0  0.0000  0.00        0.000        0.0 0.0 0.0
B  Si B   0.0000  0.0000    0.00    0.0    0.0  0.0000  0.00        0.000        0.0 0.0 0.0
