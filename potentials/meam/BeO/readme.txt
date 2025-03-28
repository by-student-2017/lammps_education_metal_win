#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Be O BeO.meam Be O
#------------------------------------------------------------------------
# J. Wei et al., ACS Omega 2019, 4, 4, 6339-6346.: https://doi.org/10.1021/acsomega.9b00174
# Note: not all parameters are detailed in the paper.
# CABC denotes the screening parameter of the type A element to the type B and type C elements.
#------------------------------------------------------------------------


#------------------------------------------------------------------------
Test
#------------------------------------------------------------------------
Usage in lammps input
#-------------------------------------------------------------
pair_style meam
pair_coeff * * ./../../library.meam Be O ./../../BeO.meam Be O
#-------------------------------------------------------------

Results [BeO, mp-2542: BeO (hexagonal, P6_3mc, 186)]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 4;
The lattice constant, x (Angstoms) = 2.82367697440438;
The lattice constant, y (Angstoms) = 2.44537599194452;
The lattice constant, z (Angstoms) = 4.58717776072425;
The volume (Angstoms^3) = 31.6742417129677;
The total energy (eV) = -14.7902746641211;
The cohesive energy (eV/atom) = 3.69756866603028;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       489.00825        -105.05473          33.69253     -7.988086e-07     4.8783319e-07        -3.2433305
2      -105.05473         453.91855          20.66364     1.0826597e-06    -7.3612267e-07         -75.36784
3        33.69253          20.66364          532.1994     4.2881767e-07    -3.4487979e-07          34.84977
4   -7.988086e-07     1.0826597e-06     4.2881767e-07         405.59039        -18.522955    -3.1447695e-07
5   4.8783319e-07    -7.3612267e-07    -3.4487979e-07        -18.522955         326.84735     1.7051305e-07
6      -3.2433305         -75.36784          34.84977    -3.1447695e-07     1.7051305e-07         250.93795
-------------------------------------------------------------
Voigt bulk modulus, BV:       152.63657
Reuss bulk modulus, BR:        143.9505
Hill bulk modulus, B=(BV+BR)/2:       148.29353 [GPa]

Voigt shear modulus, GV:       495.07192
Reuss shear modulus, GR:       457.01186
Hill shear modulus, G=(GV+GR)/2:       476.04189 [GPa]

Pughs modulus ratio, k=G/B:       3.2101325
-------------------------------------------------------------

Reference
-------------------------------------------------------------
wurtzite  BeO
C11 340
C12 110
C13  43
C33 543
C44 125
C66 114

DFT
C11 430
C12 113
C13  80
C33 467
C44 138
C66 158
-------------------------------------------------------------
