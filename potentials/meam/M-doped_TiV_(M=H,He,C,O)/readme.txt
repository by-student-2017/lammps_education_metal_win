Usage in lammps input
#-------------------------------------------------------------
pair_style hybrid meam lj/cut 4.8
pair_coeff 1*2 1*2 meam ./../../library.meam Ti V ./../../TiV.meam Ti V

#pair_coeff 1 3 lj/cut 0.19209 2.18263 # Ti-C
pair_coeff 1 3 lj/cut 0.11513 2.17625 # Ti-H
#pair_coeff 1 3 lj/cut 0.08272 2.25545 # Ti-He
#pair_coeff 1 3 lj/cut 0.15500 2.28942 # Ti-O

#pair_coeff 2 3 lj/cut 0.31752 2.16585 # V-C
pair_coeff 2 3 lj/cut 0.13152 2.06793 # V-H
#pair_coeff 2 3 lj/cut 0.19041 2.12510 # V-He
#pair_coeff 2 3 lj/cut 0.19571 2.24278 # V-O

#pair_coeff 3 3 lj/cut 0.00455 3.43085 # C-C (from UFF)
pair_coeff 3 3 lj/cut 0.00191 2.57113 # H-H (from UFF)
#pair_coeff 3 3 lj/cut 0.00243 2.10430 # He-He (from UFF)
#pair_coeff 3 3 lj/cut 0.00260 3.11815 # O-O (from UFF)

#-------------------------------------------------------------
#-------------------------------------------------------------
#Pair	epsilon [eV]	sigma [A]	r0 = 2^(1/6)*sigma [A]
#------------------------------
#Ti-C	0.19209	2.18263	2.44992
#Ti-H	0.11513	2.17625	2.44276
#Ti-He	0.08272	2.25545	2.53166
#Ti-O	0.15500	2.28942	2.56979
#------------------------------
# V-C	0.31752	2.16585	2.43109
# V-H	0.13152	2.06793	2.32117
# V-He	0.19041	2.12510	2.38534
# V-O	0.19571	2.24278	2.51744
#------------------------------
#-------------------------------------------------------------
# The Lennard-Jones potential (E_LJ) parameters for V-M and Ti-M (M=H, He, C, O).
# E_LJ = m/(r^12) - n/(r^6)
# m = 4*epsilon*sigma^12
# n = 4*epsilon*sigma^6
# sigma = (m/n)^(1/6)
# epsilon = n/(4*sigma^6) = n^2/(4*m)
#
#Atomic interaction  m(1.0e-10 eV nm^-12)  n(1.0e-5 eV nm^-6)
# V-C    9.666  13.110
# V-H    2.298   4.114
# V-He   4.615   7.015
# V-O    9.057   9.963
# Ti-C   6.415   8.307
# Ti-H   3.712   4.892
# Ti-He  4.096   4.356
# Ti-O   9.183   8.928
#-------------------------------------------------------------
