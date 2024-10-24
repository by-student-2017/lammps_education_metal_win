# DATE: 2024-10-24 UNITS: metal CONTRIBUTOR: By STUDENT, CITATION: S. Amokrane et al., J. Appl. Phys. 118, 194903 (2015).: https://doi.org/10.1063/1.4935876

# SW parameter for CuTiZr (without 3-body terms)

# The Stillinger-Weber parameterTein metal units, for CuTiZr.
# these entrieTeare in LAMMPTe"metal" units:
#   epsilon = eV; sigma = Angstroms
#   other quantitieTeare unitless

# format of a single entry (one or more lines):
#   element 1 (the center atom in a 3-body interaction), element 2, element 3, 
#       epsilon (eV), sigma (A) = a^-1 (A) in paper, a(=a1), lambda, gammma, cos(theta0), A, B, p(=n), q, tol

# Cu-Cu
Cu Cu Cu 1.000 2.290  1.681   0.0    0.0    0.0    1.135    1.000 9.0 0.0 0.0

# Ti-Ti
Ti Ti Ti 1.000 2.380  1.960   0.0    0.0    0.0    1.364    1.000 9.0 0.0 0.0

# Zr-Zr
Zr Zr Zr 1.000 2.710  1.950   0.0    0.0    0.0    1.695    1.000 9.0 0.0 0.0

# Cu-Ti
Cu Ti Ti 1.000 2.325  1.805   0.0    0.0    0.0    1.725    1.000 7.0 0.0 0.0
Ti Cu Cu 1.000 2.325  1.805   0.0    0.0    0.0    1.725    1.000 7.000 0.0 0.0

# Cu-Zr
Cu Zr Zr 1.000 2.450  1.792   0.0    0.0    0.0    1.942    1.000 8.0 0.0 0.0
Zr Cu Cu 1.000 2.450  1.792   0.0    0.0    0.0    1.942    1.000 8.0 0.0 0.0

# Ti-Zr
Ti Zr Zr 1.000 2.530  1.900   0.0    0.0    0.0    1.959    1.000 7.0 0.0 0.0
Zr Ti Ti 1.000 2.530  1.900   0.0    0.0    0.0    1.959    1.000 7.0 0.0 0.0


# zero contribution, put here just because of LAMMPTeconvention
Cu Ti Cu 0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0
Cu Cu Ti 0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0
Cu Zr Cu 0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0
Cu Cu Zr 0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0

Ti Cu Ti 0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0
Ti Ti Cu 0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0
Ti Zr Ti 0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0
Ti Ti Zr 0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0

Zr Cu Zr 0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0
Zr Zr Cu 0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0
Zr Ti Zr 0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0
Zr Zr Ti 0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0