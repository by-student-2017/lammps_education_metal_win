# DATE: 2024-10-23 UNITS: metal CONTRIBUTOR: By STUDENT, CITATION: M. Wen et al., J. Appl. Phys. 122, 244301 (2017).: https://doi.org/10.1063/1.5007842

# equ.(1)-(4): SW parameters for MoS2, used by LAMMPS, derived from VFF model analytically.
# a = rcut/simga, gamma(lammps) = gamma(paper)/simga, A(lammps)=A(paper)/epsilon, lambda(lammps)=lambda(paper)/epsilon
# 

# The Stillinger-Weber parameters in metal units, for MoS2.
# these entries are in LAMMPS "metal" units:
#   epsilon = eV; sigma = Angstroms
#   other quantities are unitless

# format of a single entry (one or more lines):
#   element 1 (the center atom in a 3-body interaction), element 2, element 3, 
#          epsilon, sigma, a=rcut/sigma, lambda,      gamma,  cos(theta0),     A,            B,        p,   q,  tol

# two-body, Mo-Mo
Mo Mo Mo   1.000   2.85295  1.94416  0.0000000000  0.0000000000  0.00000  3.9781804791  0.4446021306  5.0  0.0 5.54660

# two-body, S-S
S  S  S    1.000   2.84133  1.59065  0.0000000000  0.0000000000  0.00000  1.1907355764  0.9015152673  5.0  0.0 4.51956

# two and three-body, S-Mo-S (Mo is the species of the vertex atom)
Mo S  S    1.000   2.17517  1.85131  7.4767529158  0.6236901958  0.14285 11.3797414404  0.5266688197  5.0  0.0 4.20269

# two and three-body, Mo-S-Mo (S is the species of the vertex atom)
S  Mo Mo   1.000   2.17517  1.85131  8.1595181220  0.6236901958  0.14285 11.3797414404  0.5266688197  5.0  0.0 4.20269

# zero contribution, put here just because of LAMMPS convention
Mo S  Mo   0.000   0.00000  0.00000  0.0000000000  0.0000000000  0.00000  0.0000000000  0.0000000000  0.0  0.0 0.00000
Mo Mo S    0.000   0.00000  0.00000  0.0000000000  0.0000000000  0.00000  0.0000000000  0.0000000000  0.0  0.0 0.00000
S  S  Mo   0.000   0.00000  0.00000  0.0000000000  0.0000000000  0.00000  0.0000000000  0.0000000000  0.0  0.0 0.00000
S  Mo S    0.000   0.00000  0.00000  0.0000000000  0.0000000000  0.00000  0.0000000000  0.0000000000  0.0  0.0 0.00000
