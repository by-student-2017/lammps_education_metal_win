# DATE: 2024-10-24 UNITS: metal CONTRIBUTOR: By STUDENT, CITATION: J.-W. Jiang (2016).: https://arxiv.org/abs/1605.02566v1

#Stillinger-Webber parameters for a single-layered black phosphorus (SLBP).
#Users are recommended to rename the file with suffix of ".sw" such as "BlackP.sw", 
#then use the following commands to call SW Potential in lammps:
#pair_style sw
#pair_coeff * * BlackP.sw Pt Pb

# these entries are in LAMMPS metal units:
# epsilon = eV; sigma = Angstroms
# other quantities are unitless

# format of a single entry (one or more lines):
# element 1, element 2, element 3,
# epsilon, sigma, a, lambda, gamma, costheta0, A, B, p, q, tol

# intra-group SW2 and SW3
Pt Pt Pt 1.000 0.565 4.940 19.828 1.000 -0.111 4.027 119.005 4 0 0.0
Pb Pb Pb 1.000 0.565 4.940 19.828 1.000 -0.111 4.027 119.005 4 0 0.0

# inter-group SW2Pt Pb Pb 1.000 0.565 4.940 0.000 1.000 -0.111 4.027 119.005 4 0 0.0
Pb Pt Pt 1.000 0.565 4.940 0.000 1.000 -0.111 4.027 119.005 4 0 0.0

# inter-group SW3
Pt Pt Pb 1.000 0.565 4.940 17.776 1.000 -0.210 0.000 119.005 4 0 0.0
Pt Pb Pt 1.000 0.565 4.940 17.776 1.000 -0.210 0.000 119.005 4 0 0.0

# inter-group SW3
Pb Pb Pt 1.000 0.565 4.940 17.776 1.000 -0.210 0.000 119.005 4 0 0.0
Pb Pt Pb 1.000 0.565 4.940 17.776 1.000 -0.210 0.000 119.005 4 0 0.0