Usage in lammps input
#-------------------------------------------------------------
pair_style meam
pair_coeff * * ./../../library.meam Ti V N ./../../TiVN.meam Ti V
#-------------------------------------------------------------

Results [TiV BCC_B2]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 2;
The lattice constant, x (Angstoms) = 3.24457323889205;
The lattice constant, y (Angstoms) = 3.24457323889205;
The lattice constant, z (Angstoms) = 3.24457323889205;
The volume (Angstoms^3) = 34.1564514825024;
The total energy (eV) = -10.0861274570351;
The cohesive energy (eV/atom) = 5.04306372851753;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1        181.4635         100.08492         100.08492     3.7498496e-09    -1.8291804e-09    -2.3413535e-09
2       100.08492          181.4635         100.08492     2.9681261e-09    -2.2275374e-09    -3.4837694e-09
3       100.08492         100.08492          181.4635     3.2569354e-09    -1.3918048e-09    -4.5984237e-11
4   3.7498496e-09     2.9681261e-09     3.2569354e-09         53.126654     4.6494232e-10     2.3074321e-09
5  -1.8291804e-09    -2.2275374e-09    -1.3918048e-09     4.6494232e-10         53.126654      5.515594e-10
6  -2.3413535e-09    -3.4837694e-09    -4.5984237e-11     2.3074321e-09      5.515594e-10         53.126654
-------------------------------------------------------------
Voigt bulk modulus, BV:       127.21112
Reuss bulk modulus, BR:       127.21112
Hill bulk modulus, B=(BV+BR)/2:       127.21112 [GPa]

Voigt shear modulus, GV:       80.027699
Reuss shear modulus, GR:        79.02615
Hill shear modulus, G=(GV+GR)/2:       79.526925 [GPa]

Pughs modulus ratio, k=G/B:      0.62515704
-------------------------------------------------------------

Reference (S. Ding et al., J. Alloy. Comp. 814 (2020) 152151.: https://doi.org/10.1016/j.jallcom.2019.152151)
-------------------------------------------------------------
Structure	Property	MEAM	Exp.e	First-principles
Present	Previousa	Presentb	Previousc
B2-type TiV	a	3.06	3.08	–	3.10	3.28
Ec	5.208	5.085	–	5.283	5.2076d
C11	167	168	167.6	165.1	169.6
C12	108	108.9	110	119.2	122.3
C44	41.8	38.1	41.3	43.2	33.6
-------------------------------------------------------------
