Usage in lammps input
#-------------------------------------------------------------
pair_style meam
pair_coeff * * ./../../library.meam Si Au ./../../SiAu.meam Si Au
#-------------------------------------------------------------

The thermal conductivity results in the literature are calculated using the BCC reference interatomic potential for the interface Si-Al alloy.

Results [Si, diamond, mp-149]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 8;
The lattice constant, x (Angstoms) = 5.76540421616536;
The lattice constant, y (Angstoms) = 5.76540421616536;
The lattice constant, z (Angstoms) = 5.76540421616536;
The volume (Angstoms^3) = 191.641377596521;
The total energy (eV) = -35.6422534091204;
The cohesive energy (eV/atom) = 4.45528167614005;
-------------------------------------------------------------
# Murnaghan equation of state
f(x) = (a*x/(b*(b-1)))*(b*(1-c/x)+(c/x)**b-1)+d

Final set of parameters            Asymptotic Standard Error
=======================            ==========================
a               = 0.601763         +/- 0.0003965    (0.06589%)
b               = 4.2222           +/- 0.02076      (0.4918%)
c               = 159.861          +/- 0.01207      (0.007552%)
d               = -37.0377         +/- 0.0004717    (0.001273%)

-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       149.54667         71.979924         71.979924     4.3924714e-08     4.4141995e-08     1.0968746e-07
2       71.979924         149.54667         71.979924     1.1202704e-08    -1.1619836e-07     3.2272424e-08
3       71.979924         71.979924         149.54667     8.0739263e-08    -3.6701271e-08    -1.1891474e-07
4   4.3924714e-08     1.1202704e-08     8.0739263e-08         42.700118    -2.5498625e-07    -2.2281075e-07
5   4.4141995e-08    -1.1619836e-07    -3.6701271e-08    -2.5498625e-07         42.700118    -1.0178212e-07
6   1.0968746e-07     3.2272424e-08    -1.1891474e-07    -2.2281075e-07    -1.0178212e-07         42.700118
-------------------------------------------------------------
Voigt bulk modulus, BV:       97.835506
Reuss bulk modulus, BR:       97.835506
Hill bulk modulus, B=(BV+BR)/2:       97.835506 [GPa]

Voigt shear modulus, GV:       66.753491
Reuss shear modulus, GR:       72.324522
Hill shear modulus, G=(GV+GR)/2:       69.539007 [GPa]

Pughs modulus ratio, k=G/B:      0.71077474
-------------------------------------------------------------

[Si, diamond, mp-149]
-------------------------------------------------------------
C11 144 [GPa]
C12  53 [GPa]
C13  53 [GPa]
C33 144 [GPa]
C44  75 [GPa]
C66  75 [GPa]

BV   83 [GPa]
BR   83 [GPa]
BVRH 83 [GPa]

GV   63 [GPa]
GR   63 [GPa]
GVRH 61 [GPa]
-------------------------------------------------------------



Usage in lammps input
#-------------------------------------------------------------
pair_style meam
pair_coeff * * ./../../library.meam Si Al ./../../SiAl.meam Au
#-------------------------------------------------------------

Results [Au, FCC, mp-81]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 4;
The lattice constant, x (Angstoms) = 4.32683188614974;
The lattice constant, y (Angstoms) = 4.32683188614974;
The lattice constant, z (Angstoms) = 4.32683188614974;
The volume (Angstoms^3) = 81.0046713988205;
The total energy (eV) = -14.7865780265417;
The cohesive energy (eV/atom) = 3.69664450663543;
-------------------------------------------------------------
# Murnaghan equation of state
f(x) = (a*x/(b*(b-1)))*(b*(1-c/x)+(c/x)**b-1)+d

Final set of parameters            Asymptotic Standard Error
=======================            ==========================
a               = 1.01729          +/- 0.0009987    (0.09817%)
b               = 5.45481          +/- 0.02975      (0.5454%)
c               = 67.5802          +/- 0.00725      (0.01073%)
d               = -15.7176         +/- 0.000492     (0.00313%)

-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       185.75541         156.85035         156.85035     9.3219769e-10     3.6599243e-10     4.4541604e-10
2       156.85035         185.75541         156.85035      1.496647e-09    -2.5843735e-10     8.7751512e-10
3       156.85035         156.85035         185.75541     1.4763297e-09    -4.1967995e-10     1.0242676e-09
4   9.3219769e-10      1.496647e-09     1.4763297e-09         20.289943     6.5196085e-10     2.2869901e-10
5   3.6599243e-10    -2.5843735e-10    -4.1967995e-10     6.5196085e-10         20.289943     1.0299538e-09
6   4.4541604e-10     8.7751512e-10     1.0242676e-09     2.2869901e-10     1.0299538e-09         20.289943
-------------------------------------------------------------
Voigt bulk modulus, BV:       166.48537
Reuss bulk modulus, BR:       166.48537
Hill bulk modulus, B=(BV+BR)/2:       166.48537 [GPa]

Voigt shear modulus, GV:       30.128944
Reuss shear modulus, GR:       28.514694
Hill shear modulus, G=(GV+GR)/2:       29.321819 [GPa]

Pughs modulus ratio, k=G/B:       0.1761225
-------------------------------------------------------------

Results [Au, FCC, mp-81]
-------------------------------------------------------------
C11 144 [GPa]
C12 134 [GPa]
C13 134 [GPa]
C33 144 [GPa]
C44  29 [GPa]
C66  29 [GPa]

BV   137 [GPa]
BR   137 [GPa]
BVRH 137 [GPa]

GV   19 [GPa]
GR   10 [GPa]
GVRH 15 [GPa]
-------------------------------------------------------------
