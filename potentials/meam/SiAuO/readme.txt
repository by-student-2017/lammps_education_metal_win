Usage in lammps input
#-------------------------------------------------------------
pair_style meam
pair_coeff * * ./../../library.meam Si Al ./../../SiAl.meam Si
#-------------------------------------------------------------

The thermal conductivity results in the literature are calculated using the BCC reference interatomic potential for the interface Si-Al alloy.

Results [SiO2,  P3_221, alpha-quartz, mp-6930]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 9;
The lattice constant, x (Angstoms) = 2.84449198507118;
The lattice constant, y (Angstoms) = 2.46340231993773;
The lattice constant, z (Angstoms) = 3.12235452156586;
The volume (Angstoms^3) = 21.87873827817;
The total energy (eV) = -255.210434978457;
The cohesive energy (eV/atom) = -28.3567149976064;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       91785.217        -75312.609        -12962.677        -30502.925       -0.39726746        0.70976322
2      -75312.609         91791.771        -12966.113         30505.116       -0.48096194       -0.68714177
3      -12962.677        -12966.113         57543.788       -0.84668716       -0.24680487       -0.77855931
4      -30502.925         30505.116       -0.84668716         59026.012        0.57394408        0.48497291
5     -0.39726746       -0.48096194       -0.24680487        0.57394408         59029.319        -30504.833
6      0.70976322       -0.68714177       -0.77855931        0.48497291        -30504.833         83550.235
-------------------------------------------------------------
Voigt bulk modulus, BV:       4293.1087
Reuss bulk modulus, BR:       3336.2243
Hill bulk modulus, B=(BV+BR)/2:       3814.6665 [GPa]

Voigt shear modulus, GV:       103466.37
Reuss shear modulus, GR:       70447.688
Hill shear modulus, G=(GV+GR)/2:        86957.03 [GPa]

Pughs modulus ratio, k=G/B:       22.795447
-------------------------------------------------------------
