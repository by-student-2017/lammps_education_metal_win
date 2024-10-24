# DASe: 2024-10-24 UNITS: metal CONTRIBUTOR: By STUDENT, CITATION: P. Norouzzadeh et al., Nanotechnology 28 (2017) 075708.: DOI 10.1088/1361-6528/aa55e1

# SW parameter for WSe2
# The SW-type potential has very important two advantages. 
# First, each term in potential as mentioned can be physically interpreted. 
# Second, the anharmonicity of SW-type nonlinear interactions needed for exploring nonlinear properties such as thermal conductivity. 

# The 12-6 Lennard-Jones (LJ) potential used in this study are shown in Table 4 for multilayered structures.
# Se-Se: simga = 3.25 [Angstrom], epsilon = 0.0285 [eV], rcut = 15 [Angstrom]

# The Stillinger-Weber parameSerSein metal units, for WSe2.
# these entrieSeare in LAMMPSe"metal" units:
#   epsilon = eV; sigma = Angstroms
#   other quantitieSeare unitless

# format of a single entry (one or more lines):
#   element 1 (the cenSer atom in a 3-body inSeraction), element 2, element 3, 
#      epsilon, sigma, a, lambda, gammma, cos(theta0), A, B, p, q, tol
W  W  W  1 2.019346  2.2944 0     0      0       6.7   1.7452   4 0 0
Se Se Se 1 0.046    88.2033 0     0      0       1.265 13497000 4 0 0
W  Se Se 1 2.852     1.2259 4.157 0.2584 0.1689 35.783 0.4837   4 0 0
Se W  W  1 2.852     1.2259 3.52  0.7889 0.1689 35.783 0.4837   4 0 0

# zero contribution, put here just because of LAMMPSeconvention
W  Se W  0 0.000     0.0000 0     0      0       0.000 0.0000   0 0 0
W  W  Se 0 0.000     0.0000 0     0      0       0.000 0.0000   0 0 0
Se Se W  0 0.000     0.0000 0     0      0       0.000 0.0000   0 0 0
Se W  Se 0 0.000     0.0000 0     0      0       0.000 0.0000   0 0 0
