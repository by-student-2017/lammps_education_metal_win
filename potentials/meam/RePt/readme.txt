Usage in lammps input
#-------------------------------------------------------------
pair_style meam
pair_coeff * * ./../../library.meam Re Pt ./../../RePt.meam Re Pt
#-------------------------------------------------------------

Results [Pt3Re, L12 structure]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 4;
The lattice constant, x (Angstoms) = 4.13960711436088;
The lattice constant, y (Angstoms) = 4.13960711436088;
The lattice constant, z (Angstoms) = 4.13960711436088;
The volume (Angstoms^3) = 70.937744208979;
The total energy (eV) = -19.7717989375411;
The cohesive energy (eV/atom) = -4.94294973438527;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       404.82071         268.15913         268.15913    -4.8403791e-10    -6.3879969e-10     8.2124937e-10
2       268.15913         404.82071         268.15913    -2.3753658e-09     4.4062351e-10     2.4678587e-09
3       268.15913         268.15913         404.82071    -9.1591871e-10    -7.5210652e-10     6.2963835e-10
4  -4.8403791e-10    -2.3753658e-09    -9.1591871e-10         126.31276    -4.5339227e-10     8.0215929e-10
5  -6.3879969e-10     4.4062351e-10    -7.5210652e-10    -4.5339227e-10         126.31276     1.1179177e-09
6   8.2124937e-10     2.4678587e-09     6.2963835e-10     8.0215929e-10     1.1179177e-09         126.31276
-------------------------------------------------------------
(C11-C12)/2 = (404.82071-268.15913)/2 = 68.33 [GPa]
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
Pt3Re, L12 structure
B   352.5 [GPa]
(C11-C22)/2 82.0 [GPa]
C44 153.2 [GPa]
Note: Is "(C11-C22)/2" a mistake for shear modulus = "(C11-C12)/2"?
-------------------------------------------------------------
