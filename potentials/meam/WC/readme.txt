Usage in lammps input
#-------------------------------------------------------------
pair_style meam
pair_coeff * * ./../../library.meam W C ./../../WC.meam W C
#-------------------------------------------------------------

Results [NaCl-type = B1 structure, WC]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 8;
The lattice constant, x (Angstoms) = 4.62114554632951;
The lattice constant, y (Angstoms) = 4.62114554632951;
The lattice constant, z (Angstoms) = 4.62114554632951;
The volume (Angstoms^3) = 98.684499186881;
The total energy (eV) = -60.0210743224997;
The cohesive energy (eV/atom) = 7.50263429031246;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       779.29139         396.66625         396.66625       5.89069e-09     4.2910132e-09     1.1075232e-09
2       396.66625         779.29139         396.66625     1.5028299e-08     1.1167419e-09    -1.4469847e-08
3       396.66625         396.66625         779.29139       1.31445e-08    -1.4511596e-09    -1.4069102e-09
4     5.89069e-09     1.5028299e-08       1.31445e-08         341.59898     3.8839504e-09    -3.0386739e-09
5   4.2910132e-09     1.1167419e-09    -1.4511596e-09     3.8839504e-09         341.59898     3.0083021e-09
6   1.1075232e-09    -1.4469847e-08    -1.4069102e-09    -3.0386739e-09     3.0083021e-09         341.59898
-------------------------------------------------------------
Voigt bulk modulus, BV:       524.20797
Reuss bulk modulus, BR:       524.20797
Hill bulk modulus, B=(BV+BR)/2:       524.20797 [GPa]

Voigt shear modulus, GV:        486.4438
Reuss shear modulus, GR:       395.26775
Hill shear modulus, G=(GV+GR)/2:       440.85578 [GPa]

Pughs modulus ratio, k=G/B:      0.84099405
-------------------------------------------------------------

Reference: BCC_B2, WC (P. H. Chen et al., Phys. Rev. B 88 (2013) 214101.: https://doi.org/10.1103/PhysRevB.88.214101)
-------------------------------------------------------------
B 525 [GPa]
-------------------------------------------------------------



Results [BCC_B2, WC]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 2;
The lattice constant, x (Angstoms) = 2.90343573373733;
The lattice constant, y (Angstoms) = 2.90343573373733;
The lattice constant, z (Angstoms) = 2.90343573373733;
The volume (Angstoms^3) = 24.4757862998662;
The total energy (eV) = -13.6933720865775;
The cohesive energy (eV/atom) = 6.84668604328874;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       762.04916         355.81536          384.8896         8.0968923        -19.798021        -29.014586
2       355.81536         889.55123         287.19872         24.964407          28.47186        -0.6274766
3        384.8896         287.19872         521.08876         2.8177208        -28.460771        -42.069378
4       8.0968923         24.964407         2.8177208         22.341408         1.7314442         14.143247
5      -19.798021          28.47186        -28.460771         1.7314442         70.282568        -5.7676204
6      -29.014586        -0.6274766        -42.069378         14.143247        -5.7676204          41.93709
-------------------------------------------------------------
Voigt bulk modulus, BV:       469.83294
Reuss bulk modulus, BR:       391.10737
Hill bulk modulus, B=(BV+BR)/2:       430.47016 [GPa]

Voigt shear modulus, GV:       130.14346
Reuss shear modulus, GR:        120.5698
Hill shear modulus, G=(GV+GR)/2:       125.35663 [GPa]

Pughs modulus ratio, k=G/B:      0.29120864
-------------------------------------------------------------

Reference: BCC_B2, WC (P. H. Chen et al., Phys. Rev. B 88 (2013) 214101.: https://doi.org/10.1103/PhysRevB.88.214101)
-------------------------------------------------------------
B 491 [GPa]
-------------------------------------------------------------



Results [WC, mp-1008635: WC (cubic, F-43m, 216)]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 8;
The lattice constant, x (Angstoms) = 4.70603967247574;
The lattice constant, y (Angstoms) = 4.70603967247574;
The lattice constant, z (Angstoms) = 4.70603967247574;
The volume (Angstoms^3) = 104.223763650055;
The total energy (eV) = -59.1502835776665;
The cohesive energy (eV/atom) = 7.39378544720832;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1        443.5815         297.36979         297.36979    -5.6350343e-10      4.408982e-11    -9.8294414e-10
2       297.36979          443.5815         297.36979    -2.9350219e-09    -1.4862325e-09      1.247432e-09
3       297.36979         297.36979          443.5815    -5.9940385e-09    -5.0448563e-09     3.9212992e-10
4  -5.6350343e-10    -2.9350219e-09    -5.9940385e-09         85.485111    -3.7893807e-08    -8.2842525e-12
5    4.408982e-11    -1.4862325e-09    -5.0448563e-09    -3.7893807e-08          85.48511      1.569512e-10
6  -9.8294414e-10      1.247432e-09     3.9212992e-10    -8.2842525e-12      1.569512e-10          85.48511
-------------------------------------------------------------
Voigt bulk modulus, BV:       346.10703
Reuss bulk modulus, BR:       346.10703
Hill bulk modulus, B=(BV+BR)/2:       346.10703 [GPa]

Voigt shear modulus, GV:       131.82447
Reuss shear modulus, GR:       138.38514
Hill shear modulus, G=(GV+GR)/2:       135.10481 [GPa]

Pughs modulus ratio, k=G/B:      0.39035557
-------------------------------------------------------------

Reference: WC, mp-1008635: WC (cubic, F-43m, 216)
-------------------------------------------------------------
C11  309 [GPa]
C12  219 [GPa]
C44    2 [GPa]
BVRH 249 [GPa]
GVRH  11 [GPa]
-------------------------------------------------------------
