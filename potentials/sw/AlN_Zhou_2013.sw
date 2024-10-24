# DATE: 2024-10-24 UNITS: metal CONTRIBUTOR: By STUDENT, CITATION: X. W. Zhou et al., Phys. Rev. B 87 (2013) 094303.: https://doi.org/10.1103/PhysRevB.87.094303

# SW parameter for Al-N

# The Stillinger-Weber parameters in metal units, for AlN.
# these entries are in LAMMPS "metal" units:
#   epsilon = eV; sigma = Angstroms
#   other quantities are unitless

# format of a single entry (one or more lines):
#   element 1 (the center atom in a 3-body interaction), element 2, element 3, 
#          epsilon, sigma, a=rcut/sigma, lambda, gamma, cos(theta0), A, B, p, q, tol

# Al-Al
Al Al Al   0.5650   2.6674  1.55   0.0  1.2  -0.33333 17.8118  0.72  4.0  0.0 0.0

# N-N
N  N  N    1.2000   1.3000  1.80  32.5  1.2  -0.33333  7.9170  0.72  4.0  0.0 0.0

# Ga-N
Al N  N    2.2614   1.7103  1.80  40.5  1.2  -0.33333  7.9170  0.72  4.0  0.0 0.0
N  Al Al   2.2614   1.7103  1.80  40.5  1.2  -0.33333  7.9170  0.72  4.0  0.0 0.0

# zero contribution, put here just because of LAMMPS convention
Al N  Al   0.000   0.00000  0.00000  0.0000000000  0.0000000000  0.00000  0.0000000000  0.0000000000  0.0  0.0 0.00000
Al Al N    0.000   0.00000  0.00000  0.0000000000  0.0000000000  0.00000  0.0000000000  0.0000000000  0.0  0.0 0.00000
N  N  Al   0.000   0.00000  0.00000  0.0000000000  0.0000000000  0.00000  0.0000000000  0.0000000000  0.0  0.0 0.00000
N  Al N    0.000   0.00000  0.00000  0.0000000000  0.0000000000  0.00000  0.0000000000  0.0000000000  0.0  0.0 0.00000

