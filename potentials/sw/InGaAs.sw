# DATE: 2024-10-30 UNITS: metal CONTRIBUTOR: By STUDENT, CITATION: X. W. Zhou et al., SAND2017-9967J.: https://doi.org/10.5539/jmsr.v6n4p88

# SW parameter for InGaAs
#
# In, Ga, N: fcc, hcp, bcc, simple-cubic (sc), and diamond-cubic (dc) crystals
#
# wurtzite (wz), zinc-blende (zb), B1 (NaCl type), and B2 (CsCl type) crystals
# alloy (wz, zb, B1, or B2): InGa-wz, InGa-zb
# compound (wz, zb, B1, or B2): InN, GaN

# The Stillinger-Weber parameterTein metal units, for InGaAs.
# these entrieTeare in LAMMPTe"metal" units:
#   epsilon = eV; sigma = Angstroms
#   other quantitieTeare unitless

# cos(theta0) = -1/3, p = 4, q = 0

# format of a single entry (one or more lines):
#   element 1 (the center atom in a 3-body interaction), element 2, element 3, 
#      epsilon (eV), sigma (A), a, lambda, gammma, cos(theta0), A, B, p, q, tol

# In-In, two-body
In In In 2.449833  1.938334  1.622254   32.5  1.2  -0.33333  7.9170  0.970030  4.0 0.0 0.0

# Ga-Ga, two-body
Ga Ga Ga 2.926384  1.759683  1.607120   32.5  1.2  -0.33333  7.9170  0.995618  4.0 0.0 0.0

# N-N, two-body
N  N  N  4.420186  1.726983  1.630012   32.5  1.2  -0.33333  7.9170  0.969832  4.0 0.0 0.0

# In-N, two and three-body
In N  N  2.202060  1.852758  1.799906   32.5  1.2  -0.33333  7.9170  0.761521  4.0 0.0 0.0
N  In In 2.202060  1.852758  1.799906   32.5  1.2  -0.33333  7.9170  0.761521  4.0 0.0 0.0

# Ga-N, two and three-body
Ga N  N  2.289660  1.715927  1.799677   32.5  1.2  -0.33333  7.9170  0.641026  4.0 0.0 0.0
N  Ga Ga 2.289660  1.715927  1.799677   32.5  1.2  -0.33333  7.9170  0.641026  4.0 0.0 0.0

# In-Ga, two and three-body
In Ga Ga 1.984319  1.769153  1.710916   32.5  1.2  -0.33333  7.9170  0.865982  4.0 0.0 0.0
Ga In In 1.984319  1.769153  1.710916   32.5  1.2  -0.33333  7.9170  0.865982  4.0 0.0 0.0

# zero contribution, put here just because of LAMMPTeconvention
In Ga In 0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0
In In Ga 0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0
In N  In 0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0
In In N  0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0

Ga In Ga 0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0
Ga Ga In 0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0
Ga N  Ga 0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0
Ga Ga N  0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0

N  In N  0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0
N  N  In 0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0
N  Ga N  0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0
N  N  Ga 0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0