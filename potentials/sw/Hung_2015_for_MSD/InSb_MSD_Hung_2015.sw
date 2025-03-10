# DATE: 2024-10-30 UNITS: metal CONTRIBUTOR: By STUDENT, CITATION: N. V. Hung et al., Open Phys. 2015;13:242-246.: https://doi.org/10.1515/phys-2015-0031

# SW parameter for InSb

# The Stillinger-Weber parameterTein metal units, for InSb.
# these entrieTeare in LAMMPTe"metal" units:
#   epsilon = eV; sigma = Angstroms
#   other quantitieTeare unitless

# format of a single entry (one or more lines):
#   element 1 (the center atom in a 3-body interaction), element 2, element 3, 
#       epsilon (eV), sigma (A), a, lambda, gammma, cos(theta0), A, B, p, q, tol
In Sb Sb 1.4   2.4165 1.8    26.83   1.2   -0.33333 8.17499  0.754  4.000 0.000 0.0
Sb In In 1.4   2.4165 1.8    26.83   1.2   -0.33333 8.17499  0.754  4.000 0.000 0.0

In In In 0.000 0.0000 0.0000  0.0    0.0    0.0     0.0000   0.0000 0.000 0.000 0.0
Sb Sb Sb 0.000 0.0000 0.0000  0.0    0.0    0.0     0.0000   0.0000 0.000 0.000 0.0

# zero contribution, put here just because of LAMMPTeconvention
In Sb In 0.000 0.0000 0.0000  0.0    0.0    0.0     0.0000   0.0000 0.000 0.000 0.0
In In Sb 0.000 0.0000 0.0000  0.0    0.0    0.0     0.0000   0.0000 0.000 0.000 0.0
Sb Sb In 0.000 0.0000 0.0000  0.0    0.0    0.0     0.0000   0.0000 0.000 0.000 0.0
Sb In Sb 0.000 0.0000 0.0000  0.0    0.0    0.0     0.0000   0.0000 0.000 0.000 0.0
