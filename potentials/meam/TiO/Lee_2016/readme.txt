#-----------------------------------------------------------------------------------------
# 2NNMEAM+Qeq
# E. Lee et al., hysical Review B, 93 (2016) 144110.: https://doi.org/10.1103/physrevb.93.144110
# 2016--Lee-E-Lee-K-R-Baskes-M-I-Lee-B-J--Ti-O (NIST, Interatomic Potentials Repository)
#-----------------------------------------------------------------------------------------
# https://cmse.postech.ac.kr/lammps/140341
pair_style     hybrid/overlay coul/streitz 12.0 wolf 0.20 meam
pair_coeff     * * meam library.meam Ti O library.meam_alloy Ti O
pair_coeff     * * coul/streitz library.streitz Ti O
fix qeq        all qeq/slater 1 12.0 1.e-6 50 10 coul/streitz
#-----------------------------------------------------------------------------------------
