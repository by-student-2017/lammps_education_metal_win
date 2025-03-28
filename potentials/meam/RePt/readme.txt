#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 1NN-MEAM
pair_style meam
pair_coeff * * library.meam Re Pt RePt.meam Re Pt
#------------------------------------------------------------------------


#------------------------------------------------------------------------
Test
#------------------------------------------------------------------------
Usage in lammps input
#-------------------------------------------------------------
pair_style meam
pair_coeff * * ./../../library.meam Re Pt ./../../RePt.meam Re Pt
#-------------------------------------------------------------

Results [Pt3Re, L12 structure]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 4;
The lattice constant, x (Angstoms) = 4.13960713037692;
The lattice constant, y (Angstoms) = 4.13960713037692;
The lattice constant, z (Angstoms) = 4.13960713037692;
The volume (Angstoms^3) = 70.9377450323482;
The total energy (eV) = -19.7717987633557;
The cohesive energy (eV/atom) = 4.94294969083892;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       404.81502         268.15628         268.15628     1.4221222e-09     1.7377422e-09    -1.1205089e-09
2       268.15628         404.81502         268.15628     2.1376654e-09     1.3564582e-09    -5.2110952e-10
3       268.15628         268.15628         404.81502     1.3830382e-09     1.9482299e-09    -3.1667856e-10
4   1.4221222e-09     2.1376654e-09     1.3830382e-09         126.30992     2.5254524e-10    -8.5341073e-10
5   1.7377422e-09     1.3564582e-09     1.9482299e-09     2.5254524e-10         126.30992    -1.2593579e-09
6  -1.1205089e-09    -5.2110952e-10    -3.1667856e-10    -8.5341073e-10    -1.2593579e-09         126.30992
-------------------------------------------------------------
(C11-C12)/2 = (404.81502-268.15628)/2 = 68.33 [GPa]
-------------------------------------------------------------
Voigt bulk modulus, BV:       313.70919
Reuss bulk modulus, BR:       313.70919
Hill bulk modulus, B=(BV+BR)/2:       313.70919 [GPa]

Voigt shear modulus, GV:       178.90365
Reuss shear modulus, GR:       142.01412
Hill shear modulus, G=(GV+GR)/2:       160.45888 [GPa]

Pughs modulus ratio, k=G/B:      0.51148926
-------------------------------------------------------------

Reference (Masud Alam et al., 2022 Modelling Simul. Mater. Sci. Eng. 30 015002.: DOI 10.1088/1361-651X/ac3a15 (Open Access))
-------------------------------------------------------------
Pt3Re, L12 structure
B   352.5 [GPa]
(C11-C22)/2 82.0 [GPa]
C44 153.2 [GPa]
Note: Is "(C11-C22)/2" a mistake for shear modulus = "(C11-C12)/2"?
-------------------------------------------------------------
