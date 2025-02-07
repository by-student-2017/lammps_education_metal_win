Usage in lammps input
#-------------------------------------------------------------
pair_style meam
pair_coeff * * ./../../library.meam Al Zr ./../../AlZr.meam Al Zr
#-------------------------------------------------------------

Results [AlZr3-L12]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 4;
The lattice constant, x (Angstoms) = 4.66617860259456;
The lattice constant, y (Angstoms) = 4.66617860259456;
The lattice constant, z (Angstoms) = 4.66617860259456;
The volume (Angstoms^3) = 101.597746111694;
The total energy (eV) = -20.2326878564442;
The cohesive energy (eV/atom) = 5.05817196411104;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       140.04388         85.848064         85.848064    -5.7862635e-10    -3.9399783e-10    -1.3556423e-10
2       85.848064         140.04388         85.848064    -2.9864964e-10     8.0659749e-10    -8.7460595e-11
3       85.848064         85.848064         140.04388    -1.3830381e-09     1.0393609e-09      5.072716e-10
4  -5.7862635e-10    -2.9864964e-10    -1.3830381e-09         56.083759     3.5848783e-10     2.2768541e-10
5  -3.9399783e-10     8.0659749e-10     1.0393609e-09     3.5848783e-10         56.083759     1.6789137e-10
6  -1.3556423e-10    -8.7460595e-11      5.072716e-10     2.2768541e-10     1.6789137e-10         56.083759
-------------------------------------------------------------
Voigt bulk modulus, BV:       103.91334
Reuss bulk modulus, BR:       103.91334
Hill bulk modulus, B=(BV+BR)/2:       103.91334 [GPa]

Voigt shear modulus, GV:       78.139674
Reuss shear modulus, GR:       57.353071
Hill shear modulus, G=(GV+GR)/2:       67.746373 [GPa]

Pughs modulus ratio, k=G/B:       0.6519507
-------------------------------------------------------------

#---------------------------------------------------------------------------
AlZr3-L12 (reference: J.-P. Harvey et al., Phys. Rev. B 86 (2012) 224202.: https://doi.org/10.1103/PhysRevB.86.224202)
a   4.392 [A]
dE -0.320 [eV]
C11 143.8 [GPa]
C12  84.4 [GPa]
C44  60.7 [GPa]
B   104.2 [GPa]
#---------------------------------------------------------------------------
