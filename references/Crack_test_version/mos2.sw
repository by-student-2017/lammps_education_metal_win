# by Jin-Wu Jiang, jwjiang5918@hotmail.com, 05/04/15/Sun

# (1). SW parameters for MoS2, used by LAMMPS, derived from VFF model analytically.

# The Stillinger-Weber parameters in metal units, for MoS2.
# these entries are in LAMMPS "metal" units:
#   epsilon = eV; sigma = Angstroms
#   other quantities are unitless

# format of a single entry (one or more lines):
#   element 1, element 2, element 3, 
#   epsilon, sigma, a, lambda, gamma, costheta0, A, B, p, q, tol

# SW2 Mo-S, SW3 Mo-S-S
Mo S  S    1.000   1.252   2.523  67.883   1.000   0.143   6.918   7.223  4  0 0.0

# SW2 Mo-S, SW3 S-Mo-Mo
S  Mo Mo   1.000   1.252   2.523  62.449   1.000   0.143   6.918   7.223  4  0 0.0

# zero contribution, put here just because of LAMMPS convention
Mo Mo Mo   0.000   1.252   2.523  62.449   1.000   0.143   6.918   7.223  4  0 0.0
Mo Mo S    0.000   1.252   2.523  62.449   1.000   0.143   6.918   7.223  4  0 0.0
Mo S  Mo   0.000   1.252   2.523  62.449   1.000   0.143   6.918   7.223  4  0 0.0
S  Mo S    0.000   1.252   2.523  62.449   1.000   0.143   6.918   7.223  4  0 0.0
S  S  Mo   0.000   1.252   2.523  62.449   1.000   0.143   6.918   7.223  4  0 0.0
S  S  S    0.000   1.252   2.523  62.449   1.000   0.143   6.918   7.223  4  0 0.0
