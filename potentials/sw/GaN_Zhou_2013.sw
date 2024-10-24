# DATE: 2024-10-24 UNITS: metal CONTRIBUTOR: By STUDENT, CITATION: X. W. Zhou et al., Phys. Rev. B 87 (2013) 094303.: https://doi.org/10.1103/PhysRevB.87.094303

# SW parameter for Ga-N

# The Stillinger-Weber parameters in metal units, for GaN.
# these entries are in LAMMPS "metal" units:
#   epsilon = eV; sigma = Angstroms
#   other quantities are unitless

# format of a single entry (one or more lines):
#   element 1 (the center atom in a 3-body interaction), element 2, element 3, 
#          epsilon, sigma, a=rcut/sigma, lambda, gamma, cos(theta0), A, B, p, q, tol

# Ga-Ga
Ga Ga Ga   1.2000   2.1000  1.60  32.5  1.2  -0.33333  7.9170  0.72  4.0  0.0 0.0

# N-N
N  N  N    1.2000   1.3000  1.80  32.5  1.2  -0.33333  7.9170  0.72  4.0  0.0 0.0

# Ga-N
Ga N  N    2.1700   1.6950  1.80  32.5  1.2  -0.33333  7.9170  0.72  4.0  0.0 0.0
N  Ga Ga   2.1700   1.6950  1.80  32.5  1.2  -0.33333  7.9170  0.72  4.0  0.0 0.0

# zero contribution, put here just because of LAMMPS convention
Ga N  Ga   0.000   0.00000  0.00000  0.0000000000  0.0000000000  0.00000  0.0000000000  0.0000000000  0.0  0.0 0.00000
Ga Ga N    0.000   0.00000  0.00000  0.0000000000  0.0000000000  0.00000  0.0000000000  0.0000000000  0.0  0.0 0.00000
N  N  Ga   0.000   0.00000  0.00000  0.0000000000  0.0000000000  0.00000  0.0000000000  0.0000000000  0.0  0.0 0.00000
N  Ga N    0.000   0.00000  0.00000  0.0000000000  0.0000000000  0.00000  0.0000000000  0.0000000000  0.0  0.0 0.00000

