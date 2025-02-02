Usage in lammps input
#-------------------------------------------------------------
pair_style meam
pair_coeff * * ./../../library.meam Mo Si ./../../MoSi.meam Mo Si
#-------------------------------------------------------------

Results [MoSi2, mp-2592: Si2Mo (tetragonal, I4/mmm, 139)]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 6;
The lattice constant, x (Angstoms) = 3.75106905441817;
The lattice constant, y (Angstoms) = 3.75106905441817;
The lattice constant, z (Angstoms) = 9.16579925267014;
The volume (Angstoms^3) = 128.967553002462;
The total energy (eV) = -32.5920132904254;
The cohesive energy (eV/atom) = 5.43200221507091;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       250.17046         147.24441         151.97435    -5.0930984e-09     1.6833783e-09     1.1281673e-10
2       147.24441         250.17046         151.97435    -5.6248071e-09      1.124701e-09    -2.2419154e-09
3       151.97435         151.97435         494.79601    -5.1981256e-09     3.8238069e-09    -5.7220556e-09
4  -5.0930984e-09    -5.6248071e-09    -5.1981256e-09         27.573971    -1.1132945e-08    -1.0495011e-10
5   1.6833783e-09      1.124701e-09     3.8238069e-09    -1.1132945e-08         27.573971     6.1356782e-10
6   1.1281673e-10    -2.2419154e-09    -5.7220556e-09    -1.0495011e-10     6.1356782e-10         131.85375
-------------------------------------------------------------
Voigt bulk modulus, BV:       210.83591
Reuss bulk modulus, BR:       193.10108
Hill bulk modulus, B=(BV+BR)/2:       201.96849 [GPa]

Voigt shear modulus, GV:        111.0636
Reuss shear modulus, GR:       104.45196
Hill shear modulus, G=(GV+GR)/2:       107.75778 [GPa]

Pughs modulus ratio, k=G/B:      0.53353759
-------------------------------------------------------------

Reference (M. I. Baskes, Mater. Sci. Eng. A261 (1999) 165-168.: https://doi.org/10.1016/S0921-5093(98)01062-4)
-------------------------------------------------------------
MoSi2 (Crystal structure: C11b)
a  3.59 [A]
c  8.42 [A]
-------------
B   210 [GPa]
C11 252 [GPa]
C12 145 [GPa]
C13 148 [GPa]
C33 510 [GPa]
C44  26 [GPa]
C66 133 [GPa]
G    75 [GPa]
-------------------------------------------------------------



Results [Mo3Si, mp-1275: SiMo3 (cubic, Pm-3n, 223)]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 8;
The lattice constant, x (Angstoms) = 5.51927794503277;
The lattice constant, y (Angstoms) = 5.51927794503277;
The lattice constant, z (Angstoms) = 5.51927794503277;
The volume (Angstoms^3) = 168.130612722381;
The total energy (eV) = -48.5581068828608;
The cohesive energy (eV/atom) = 6.06976336035759;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       639.65465         64.195669         64.195669     3.3507388e-08    -1.7789514e-08     1.0116768e-08
2       64.195669         639.65465         64.195669     2.3349488e-08     1.5273861e-08    -1.4608075e-08
3       64.195669         64.195669         639.65465    -3.9912723e-08    -1.1310015e-08    -7.2393664e-09
4   3.3507388e-08     2.3349488e-08    -3.9912723e-08         407.19118    -4.7829819e-08     9.3545613e-10
5  -1.7789514e-08     1.5273861e-08    -1.1310015e-08    -4.7829819e-08         407.19118      4.599326e-09
6   1.0116768e-08    -1.4608075e-08    -7.2393664e-09     9.3545613e-10      4.599326e-09         407.19118
-------------------------------------------------------------
Voigt bulk modulus, BV:       256.01533
Reuss bulk modulus, BR:       256.01533
Hill bulk modulus, B=(BV+BR)/2:       256.01533 [GPa]

Voigt shear modulus, GV:       603.72121
Reuss shear modulus, GR:        568.6432
Hill shear modulus, G=(GV+GR)/2:        586.1822 [GPa]

Pughs modulus ratio, k=G/B:       2.2896371
-------------------------------------------------------------

Reference (M. I. Baskes, Mater. Sci. Eng. A261 (1999) 165-168.: https://doi.org/10.1016/S0921-5093(98)01062-4)
-------------------------------------------------------------
Mo3Si (Crystal structure: A15)
a  5.20 [A]
-------------
B   256 [GPa]
C11 641 [GPa]
C12  63 [GPa]
C44 404 [GPa]
G   358 [GPa]
-------------------------------------------------------------



Results [Mo5Si3, mp-1332: Si3Mo5 (tetragonal, I4/mcm, 140)]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 32;
The lattice constant, x (Angstoms) = 11.0317543101226;
The lattice constant, y (Angstoms) = 11.0317543101226;
The lattice constant, z (Angstoms) = 5.61799461407182;
The volume (Angstoms^3) = 683.707715081421;
The total energy (eV) = -191.01818218773;
The cohesive energy (eV/atom) = 5.96931819336657;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       312.90185         151.26863         135.75583       -0.92906036       -0.73900035       -0.13286271
2       151.26863         310.91914         133.40736        0.45703023         1.3275304       -0.02552296
3       135.75583         133.40736         459.41133        -1.6675914         1.9567737        0.72599382
4     -0.92906036        0.45703023        -1.6675914         199.63088         2.3086309       0.061927198
5     -0.73900035         1.3275304         1.9567737         2.3086309         214.40666       -0.24626584
6     -0.13286271       -0.02552296        0.72599382       0.061927198       -0.24626584         163.48419
-------------------------------------------------------------
Voigt bulk modulus, BV:       213.78844
Reuss bulk modulus, BR:       209.27195
Hill bulk modulus, B=(BV+BR)/2:        211.5302 [GPa]

Voigt shear modulus, GV:       275.19539
Reuss shear modulus, GR:       211.28177
Hill shear modulus, G=(GV+GR)/2:       243.23858 [GPa]

Pughs modulus ratio, k=G/B:          1.1499
-------------------------------------------------------------

Reference (M. I. Baskes, Mater. Sci. Eng. A261 (1999) 165-168.: https://doi.org/10.1016/S0921-5093(98)01062-4)
-------------------------------------------------------------
Mo5Si3 (Crystal structure: D8m)
a 10.64 [A]
c  5.08 [A]
-------------
B   213 [GPa]
C11 326 [GPa]
C12 141 [GPa]
C13 134 [GPa]
C33 448 [GPa]
C44 110 [GPa]
C66 153 [GPa]
G   121 [GPa]
-------------------------------------------------------------
