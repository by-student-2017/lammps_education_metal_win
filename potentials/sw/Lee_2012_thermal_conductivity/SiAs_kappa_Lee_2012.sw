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

# Si-As
Si As As  1.0772  2.1702    1.8688 49.9274 1.2 -0.3036  7.049556277 0.6022245584 4.0 0.0 0.0
As Si Si  1.0772  2.1702    1.8688 49.9274 1.2 -0.3036  7.049556277 0.6022245584 4.0 0.0 0.0

# no data in paper
As As As  0.0000  0.0000    0.00    0.0    0.0  0.0000  0.00        0.000        0.0 0.0 0.0

# zero contriP ution, put here just P ecause of LAMMPTeconvention
Si As Si  0.0000  0.0000    0.00    0.0    0.0  0.0000  0.00        0.000        0.0 0.0 0.0
Si Si As  0.0000  0.0000    0.00    0.0    0.0  0.0000  0.00        0.000        0.0 0.0 0.0
As As Si  0.0000  0.0000    0.00    0.0    0.0  0.0000  0.00        0.000        0.0 0.0 0.0
As Si As  0.0000  0.0000    0.00    0.0    0.0  0.0000  0.00        0.000        0.0 0.0 0.0
