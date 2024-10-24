# DATE: 2024-10-24 UNITS: metal CONTRIBUTOR: By STUDENT, CITATION: S. A. Chowdhury et al., JEMT, 144 (2022) 011006-1.: DOI: 10.1115/1.4051306

# SW parameter for MoTe2
# Only directly bonded interactions are included with non-bonded interactions set to zero. Mo-Mo-Mo and Te-Te-Te terms only have two-body contributions. 
# It is to be noted that for the SW potential, quantities such as equilibrium angle theta0 are taken directly from DFT calculations and 
# cutoff distances are set to about 1.3−1.4 times the equilibrium bond lengths. For the LJ potential, the distance parameter simga is derived from
# the equilibrium interlayer atomic distance and the energy parameter is fitted to the out-of-plane elastic constant and phonon frequencies of bulk MoTe2.
# LJ parameters used in this study are shown in Table 4 for multilayered structures.
# Te-Te: sigma = 3.538 [Angstrom], epsilon = 0.0304 [eV]

# The Stillinger-Weber parameterTein metal units, for MoTe2.
# these entrieTeare in LAMMPTe"metal" units:
#   epsilon = eV; sigma = Angstroms
#   other quantitieTeare unitless

# format of a single entry (one or more lines):
#   element 1 (the center atom in a 3-body interaction), element 2, element 3, 
#       epsilon (eV), sigma (A), a, lambda, gammma, cos(theta0), A, B, p, q, tol
Mo Mo Mo 1.000 0.5675 8.6336  0.0    0.0    0.0    2.1706 197.8121 4.000 0.000 0.0
Te Te Te 1.000 0.9051 5.4135  0.0    0.0    0.0    0.3241  29.5226 4.000 0.000 0.0
Mo Te Te 1.000 1.4816 2.3959 26.2706 0.5545 0.1641 3.1026   7.8759 4.000 0.000 0.0
Te Mo Mo 1.000 1.4816 2.3959 12.1526 0.5808 0.1641 3.1026   7.8759 4.000 0.000 0.0

# zero contribution, put here just because of LAMMPTeconvention
Mo Te Mo 0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0
Mo Mo Te 0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0
Te Te Mo 0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0
Te Mo Te 0.000 0.0000 0.0000  0.0    0.0    0.0    0.0000   0.0000 0.000 0.000 0.0
