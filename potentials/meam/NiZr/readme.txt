#-------------------------------------------------------------
# There is no mention of d in NiZr in the paper.
# There is no specific statement in the paper as to whether it is C(i-k-j).
#-------------------------------------------------------------

Usage in lammps input
#-------------------------------------------------------------
pair_style meam
pair_coeff * * ./../../library.meam Ni Zr ./../../NiZr.meam Ni Zr
#-------------------------------------------------------------

Results [Zr2Ni, mp-328, tI12]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 12;
The lattice constant, x (Angstoms) = 6.94755928032989;
The lattice constant, y (Angstoms) = 6.94755928032989;
The lattice constant, z (Angstoms) = 5.61930811964988;
The volume (Angstoms^3) = 271.236023257785;
The total energy (eV) = -70.82075169326;
The cohesive energy (eV/atom) = 5.90172930777167;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       168.37477         88.559366         94.189587     5.8432544e-10    -1.2986147e-09     1.1440078e-09
2       88.559366         168.37477         94.189587     2.9902968e-10    -2.6619874e-09    -1.0103679e-09
3       94.189587         94.189587         150.80222    -9.1974617e-09     2.5766388e-08     1.3261719e-08
4   5.8432544e-10     2.9902968e-10    -9.1974617e-09         51.047723    -1.7989408e-08    -5.2030477e-09
5  -1.2986147e-09    -2.6619874e-09     2.5766388e-08    -1.7989408e-08         51.047724    -3.1278815e-09
6   1.1440078e-09    -1.0103679e-09     1.3261719e-08    -5.2030477e-09    -3.1278815e-09         46.851956
-------------------------------------------------------------
Voigt bulk modulus, BV:       115.71432
Reuss bulk modulus, BR:       115.53997
Hill bulk modulus, B=(BV+BR)/2:       115.62714 [GPa]

Voigt shear modulus, GV:       73.619842
Reuss shear modulus, GR:        68.26383
Hill shear modulus, G=(GV+GR)/2:       70.941836 [GPa]

Pughs modulus ratio, k=G/B:      0.61353966
-------------------------------------------------------------

#---------------------------------------------------------------------------
NiZr2 (Pearsonsymbol tI12) (reference: F. J. Cherne et al., LA-UR-03-0368.: https://www.osti.gov/servlets/purl/976517)
C11 165.9 [GPa]
C12 127.8 [GPa]
C13  79.7 [GPa]
C33 141.8 [GPa]
C44  29.3 [GPa]
C66  75.0 [GPa]
B   117.9 [GPa]
#---------------------------------------------------------------------------