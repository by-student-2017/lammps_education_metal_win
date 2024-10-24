# DATE: 2024-10-23 UNITS: metal CONTRIBUTOR: By STUDENT, CITATION: J.-W. Jiang et al., Nanotechnology 26 (2015) 315706.: doi:10.1088/0957-4484/26/31/315706

# The Stillinger-Weber parameters in metal units, for MoS2.
# these entries are in LAMMPS "metal" units:
#   epsilon = eV; sigma = Angstroms
#   other quantities are unitless

# format of a single entry (one or more lines):
#   element 1 (the center atom in a 3-body interaction), element 2, element 3, 
#          epsilon, sigma, a=rcut/sigma, lambda,      gamma,  cos(theta0),     A,            B,        p,   q,  tol

# two-body, Mo-Mo
Mo Mo Mo   0.000   0.00000  0.00000  0.0000000000  0.0000000000  0.00000  0.0000000000  0.0000000000  0.0  0.0 0.00000

# two-body, S-S
S  S  S    0.000   0.00000  0.00000  0.0000000000  0.0000000000  0.00000  0.0000000000  0.0000000000  0.0  0.0 0.00000

# two and three-body, S-Mo-S (Mo is the species of the vertex atom)
Mo S  S    1.000 1.252 2.523 67.883 1.000 0.143 6.918 7.223 4 0 0.0

# two and three-body, Mo-S-Mo (S is the species of the vertex atom)
S  Mo Mo   1.000 1.252 2.523 62.449 1.000 0.143 6.918 7.223 4 0 0.0

# zero contribution, put here just because of LAMMPS convention
Mo S  Mo   0.000   0.00000  0.00000  0.0000000000  0.0000000000  0.00000  0.0000000000  0.0000000000  0.0  0.0 0.00000
Mo Mo S    0.000   0.00000  0.00000  0.0000000000  0.0000000000  0.00000  0.0000000000  0.0000000000  0.0  0.0 0.00000
S  S  Mo   0.000   0.00000  0.00000  0.0000000000  0.0000000000  0.00000  0.0000000000  0.0000000000  0.0  0.0 0.00000
S  Mo S    0.000   0.00000  0.00000  0.0000000000  0.0000000000  0.00000  0.0000000000  0.0000000000  0.0  0.0 0.00000
