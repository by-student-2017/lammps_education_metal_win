Usage in lammps input
#-------------------------------------------------------------
pair_style meam
pair_coeff * * ./../../library.meam Ni Re ./../../NiRe.meam Ni Re
#-------------------------------------------------------------

Results [CsCl NiRe, B2 structure]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 2;
The lattice constant, x (Angstoms) = 3.13375339623503;
The lattice constant, y (Angstoms) = 3.13375339623503;
The lattice constant, z (Angstoms) = 3.13375339623503;
The volume (Angstoms^3) = 30.7747442817657;
The total energy (eV) = -11.6909029367186;
The cohesive energy (eV/atom) = -5.84545146835929;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       474.39709         201.34216         201.34216     8.4074826e-10     1.8560396e-09     2.8417306e-09
2       201.34216         474.39709         201.34216    -4.9265874e-09     6.7988549e-10     2.9050251e-09
3       201.34216         201.34216         474.39709     -3.826232e-09     6.5191418e-10     4.8964265e-09
4   8.4074826e-10    -4.9265874e-09     -3.826232e-09         310.56377     1.0383232e-09     6.3573288e-10
5   1.8560396e-09     6.7988549e-10     6.5191418e-10     1.0383232e-09         310.56377    -1.9226785e-09
6   2.8417306e-09     2.9050251e-09     4.8964265e-09     6.3573288e-10    -1.9226785e-09         310.56377
-------------------------------------------------------------
Voigt bulk modulus, BV:       292.36047
Reuss bulk modulus, BR:       292.36047
Hill bulk modulus, B=(BV+BR)/2:       292.36047 [GPa]

Voigt shear modulus, GV:       427.28751
Reuss shear modulus, GR:       293.01402
Hill shear modulus, G=(GV+GR)/2:       360.15076 [GPa]

Pughs modulus ratio, k=G/B:       1.2318723
-------------------------------------------------------------

Reference (Masud Alam et al., 2022 Modelling Simul. Mater. Sci. Eng. 30 015002.: DOI 10.1088/1361-651X/ac3a15 (Open Access))
-------------------------------------------------------------
CsCl NiRe, B2 structure
B   291 [GPa]
C11 193 [GPa]
C12 342 [GPa]
C44 250 [GPa]
Note: Aren't C11 and C12 in the literature put in the wrong place ?
-------------------------------------------------------------



Results [Ni3Re, Cu3Au type = L12]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 4;
The lattice constant, x (Angstoms) = 3.93380962374476;
The lattice constant, y (Angstoms) = 3.93380962374476;
The lattice constant, z (Angstoms) = 3.93380962374476;
The volume (Angstoms^3) = 60.8751459396343;
The total energy (eV) = -17.7783630641175;
The cohesive energy (eV/atom) = -4.44459076602936;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       358.55247         163.88264         174.11057         8.8793244         8.8750776         -13.49375
2       163.88264         320.84823         112.21633        -6.6981884        -1.4422052         16.149621
3       174.11057         112.21633         340.49676        -3.2991782       -0.87022025          9.952286
4       8.8793244        -6.6981884        -3.2991782          189.2079         1.4284989         14.938518
5       8.8750776        -1.4422052       -0.87022025         1.4284989         196.29294         2.6051717
6       -13.49375         16.149621          9.952286         14.938518         2.6051717         194.06937
-------------------------------------------------------------
Voigt bulk modulus, BV:        213.3685
Reuss bulk modulus, BR:       209.52024
Hill bulk modulus, B=(BV+BR)/2:       211.44437 [GPa]

Voigt shear modulus, GV:       269.80728
Reuss shear modulus, GR:       192.27708
Hill shear modulus, G=(GV+GR)/2:       231.04218 [GPa]

Pughs modulus ratio, k=G/B:       1.0926854
-------------------------------------------------------------

Reference (Masud Alam et al., 2022 Modelling Simul. Mater. Sci. Eng. 30 015002.: DOI 10.1088/1361-651X/ac3a15 (Open Access))
-------------------------------------------------------------
Ni3Re, Cu3Au type = L12
B   274 [GPa]
C11 395 [GPa]
C12 215 [GPa]
C44 221 [GPa]
-------------------------------------------------------------



Results [Re3Ni, mp-862604, (HCP)]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 8;
The lattice constant, x (Angstoms) = 5.43859582911309;
The lattice constant, y (Angstoms) = 4.70996214892552;
The lattice constant, z (Angstoms) = 4.38953898558848;
The volume (Angstoms^3) = 112.440589236325;
The total energy (eV) = -55.7108323096421;
The cohesive energy (eV/atom) = -6.96385403870526;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       675.49062         335.96745         261.49785    -2.7897187e-09    -8.3895845e-10     1.9130555e-10
2       335.96745         675.49062         261.49785    -1.5805369e-09     2.2081791e-09     5.8578676e-09
3       261.49785         261.49785         745.06307    -2.7405089e-09    -2.1250437e-09     -5.243967e-09
4  -2.7897187e-09    -1.5805369e-09    -2.7405089e-09         139.19252    -2.3704141e-09     -1.019507e-09
5  -8.3895845e-10     2.2081791e-09    -2.1250437e-09    -2.3704141e-09         139.19252     8.2561732e-10
6   1.9130555e-10     5.8578676e-09     -5.243967e-09     -1.019507e-09     8.2561732e-10         169.76159
-------------------------------------------------------------
Voigt bulk modulus, BV:       423.77451
Reuss bulk modulus, BR:       423.77085
Hill bulk modulus, B=(BV+BR)/2:       423.77268 [GPa]

Voigt shear modulus, GV:       261.73073
Reuss shear modulus, GR:       331.62035
Hill shear modulus, G=(GV+GR)/2:       296.67554 [GPa]

Pughs modulus ratio, k=G/B:       0.7000818
-------------------------------------------------------------

Reference
-------------------------------------------------------------
[Re3Ni, mp-862604, (HCP)]
BVRH 326 [GPa]
C11  571 [GPa]
C12  220 [GPa]
C13  178 [GPa]
C44  153 [GPa]
C66  175 [GPa]
-------------------------------------------------------------