Usage in lammps input
#-------------------------------------------------------------
pair_style meam
pair_coeff * * ./../../library.meam Ni Ti Hf ./../../NiTiHf.meam Ni Ti
#-------------------------------------------------------------

Results [NiTi CsCl-type]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 2;
The lattice constant, x (Angstoms) = 3.20409273354789;
The lattice constant, y (Angstoms) = 3.20409273354789;
The lattice constant, z (Angstoms) = 3.20409273354789;
The volume (Angstoms^3) = 32.8938896476382;
The total energy (eV) = -9.6048101590758;
The cohesive energy (eV/atom) = -4.8024050795379;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       148.13627         117.98015         117.98015     1.4353736e-09    -4.6598456e-10    -2.5670736e-09
2       117.98015         148.13627         117.98015     1.8516298e-09    -1.0400222e-09     -1.761674e-09
3       117.98015         117.98015         148.13627     2.4343329e-09     9.4547507e-10    -1.5959546e-09
4   1.4353736e-09     1.8516298e-09     2.4343329e-09         90.813337     1.3506052e-09     1.0710164e-09
5  -4.6598456e-10    -1.0400222e-09     9.4547507e-10     1.3506052e-09         90.813337     7.9685217e-10
6  -2.5670736e-09     -1.761674e-09    -1.5959546e-09     1.0710164e-09     7.9685217e-10         90.813337
-------------------------------------------------------------
Voigt bulk modulus, BV:       128.03219
Reuss bulk modulus, BR:       128.03219
Hill bulk modulus, B=(BV+BR)/2:       128.03219 [GPa]

Voigt shear modulus, GV:       115.00723
Reuss shear modulus, GR:       35.485715
Hill shear modulus, G=(GV+GR)/2:       75.246471 [GPa]

Pughs modulus ratio, k=G/B:      0.58771525
-------------------------------------------------------------

Reference (S. Ataollahi et al., Comput. Mater. Sci. 227 (2023) 112278.: https://doi.org/10.1016/j.commatsci.2023.112278)
-------------------------------------------------------------
NiTi CsCl-type
a   3.008 [A]
C11 153 [GPa]
C12 122 [GPa]
C44  80 [GPa]
-------------------------------------------------------------
