# DATE: 2024-10-30 UNITS: metal CONTRIBUTOR: By STUDENT, CITATION: N. V. Hung et al., Open Phys. 2015;13:242-246.: https://doi.org/10.1515/phys-2015-0031

# SW parameter for InP

# The Stillinger-Weber parameterTein metal units, for InP.
# these entrieTeare in LAMMPTe"metal" units:
#   epsilon = eV; sigma = Angstroms
#   other quantitieTeare unitless

# format of a single entry (one or more lines):
#   element 1 (the center atom in a 3-body interaction), element 2, element 3, 
#       epsilon (eV), sigma (A), a, lambda, gammma, cos(theta0), A, B, p, q, tol
In P  P  1.74  2.2046 1.8    22.11   1.2   -0.33333 7.90793  0.719  4.000 0.000 0.0
P  In In 1.74  2.2046 1.8    22.11   1.2   -0.33333 7.90793  0.719  4.000 0.000 0.0

In In In 0.000 0.0000 0.0000  0.0    0.0    0.0     0.0000   0.0000 0.000 0.000 0.0
P  P  P  0.000 0.0000 0.0000  0.0    0.0    0.0     0.0000   0.0000 0.000 0.000 0.0

# zero contribution, put here just because of LAMMPTeconvention
In P  In 0.000 0.0000 0.0000  0.0    0.0    0.0     0.0000   0.0000 0.000 0.000 0.0
In In P  0.000 0.0000 0.0000  0.0    0.0    0.0     0.0000   0.0000 0.000 0.000 0.0
P  P  In 0.000 0.0000 0.0000  0.0    0.0    0.0     0.0000   0.0000 0.000 0.000 0.0
P  In P  0.000 0.0000 0.0000  0.0    0.0    0.0     0.0000   0.0000 0.000 0.000 0.0
