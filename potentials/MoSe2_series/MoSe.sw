# S-W parameters for MoSe2
# multiple entries can be added to this file, LAMMPS reads the
# ones it needs these entries are in LAMMPS metal units:
#   epsilon = eV; sigma = Angstrom;
#   other quantities are unitless

# format of a single entry (one or more lines):
#   element 1, element 2, element 3,
#   epsilon, sigma, a, lambda, gamma, costheta0, A, B, p, q, tol

Mo Mo Mo 1 1.7034707795667612 2.681498446550725 0 0 0 2.259232273571551 8.641668798543233 5 0 0
Mo Mo Se 1 0 0 0 0 0 0 0 0 0 0
Mo Se Mo 1 0 0 0 0 0 0 0 0 0 0
Mo Se Se 1 1.6736021541354618 2.597953051732073 29.89203647110673 1.0717245267372222 -0.05780305292041443 6.247957225470649 0.8733167409570036 5 0 0
Se Mo Mo 1 1.6736021541354618 2.597953051732073 2.1437482868109696 1.0717245267372222 -0.05780305292041443 6.247957225470649 0.8733167409570036 5 0 0
Se Mo Se 1 0 0 0 0 0 0 0 0 0 0
Se Se Mo 1 0 0 0 0 0 0 0 0 0 0
Se Se Se 1 1.2325538692543965 1.288404529185639 0 0 0 5.343292506286849 27.359820357976744 5 0 0
