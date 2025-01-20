Usage in lammps input
#-------------------------------------------------------------
pair_style meam
pair_coeff * * ./../../library.meam Ti Cr N ./../../TiCrN.meam Ti Cr
#-------------------------------------------------------------

Results [TiCr BCC_B2]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 2;
The lattice constant, x (Angstoms) = 3.18935167018866;
The lattice constant, y (Angstoms) = 3.18935167018866;
The lattice constant, z (Angstoms) = 3.18935167018866;
The volume (Angstoms^3) = 32.4419706153207;
The total energy (eV) = -8.90272730860833;
The cohesive energy (eV/atom) = -4.45136365430416;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1      -9810417.7        -5525503.6        -1951680.8        -1183487.6         6094220.7         5362341.1
2      -5525503.6        -20568.786           5324844         5446348.4        -157188.44        -331393.99
3      -1951680.8           5324844          12994332          12482584        -6184308.6        -5777256.7
4      -1183487.6         5446348.4          12482584          11892926        -6404089.4        -6022905.6
5       6094220.7        -157188.44        -6184308.6        -6404089.4         96353.025         183265.77
6       5362341.1        -331393.99        -5777256.7        -6022905.6         183265.77         306441.21
-------------------------------------------------------------
Voigt bulk modulus, BV:      -126815.03
Reuss bulk modulus, BR:      -38956.197
Hill bulk modulus, B=(BV+BR)/2:      -82885.611 [GPa]

Voigt shear modulus, GV:       5272667.3
Reuss shear modulus, GR:        52134.94
Hill shear modulus, G=(GV+GR)/2:       2662401.1 [GPa]

Pughs modulus ratio, k=G/B:      -32.121391
-------------------------------------------------------------

Reference (S. Ding et al., Front. Chem. 9:773015. doi: 10.3389/fchem.2021.773015)
-------------------------------------------------------------
B2-type TiCr
a 3.02
Ec 4.604
C11 183.3
C12 96.5
C44 70.2
-------------------------------------------------------------
