# DATE: 2024-10-30 UNITS: metal CONTRIBUTOR: By STUDENT, CITATION: N. V. Hung et al., Open Phys. 2015;13:242-246.: https://doi.org/10.1515/phys-2015-0031

# SW parameter for GaAs

# The Stillinger-Weber parameterTein metal units, for GaAs.
# these entrieTeare in LAMMPTe"metal" units:
#   epsilon = eV; sigma = Angstroms
#   other quantitieTeare unitless

# format of a single entry (one or more lines):
#   element 1 (the center atom in a 3-body interaction), element 2, element 3, 
#       epsilon (eV), sigma (A), a, lambda, gammma, cos(theta0), A, B, p, q, tol
Ga As As 1.63  2.1342 1.8    30.25   1.2   -0.33333 7.73502  0.693  4.000 0.000 0.0
As Ga Ga 1.63  2.1342 1.8    30.25   1.2   -0.33333 7.73502  0.693  4.000 0.000 0.0

Ga Ga Ga 0.000 0.0000 0.0000  0.0    0.0    0.0     0.0000   0.0000 0.000 0.000 0.0
As As As 0.000 0.0000 0.0000  0.0    0.0    0.0     0.0000   0.0000 0.000 0.000 0.0

# zero contribution, put here just because of LAMMPTeconvention
Ga As Ga 0.000 0.0000 0.0000  0.0    0.0    0.0     0.0000   0.0000 0.000 0.000 0.0
Ga Ga As 0.000 0.0000 0.0000  0.0    0.0    0.0     0.0000   0.0000 0.000 0.000 0.0
As As Ga 0.000 0.0000 0.0000  0.0    0.0    0.0     0.0000   0.0000 0.000 0.000 0.0
As Ga As 0.000 0.0000 0.0000  0.0    0.0    0.0     0.0000   0.0000 0.000 0.000 0.0
