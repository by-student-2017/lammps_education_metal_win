Usage in lammps input
#-------------------------------------------------------------
# 1NN-MEAM
pair_style meam
pair_coeff * * ./../../library.meam Fe Cr Ni O ./../../FeCrNiO.meam Fe O
#-------------------------------------------------------------

The parameters are as described in the paper, but the results are not correct.
Am I doing something wrong ?

Fe3O4 (using mp-19306: Fe3O4 (cubic, Fd-3m, 227))
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 56;
The lattice constant, x (Angstoms) = 9.23588362790623;
The lattice constant, y (Angstoms) = 9.23588362790623;
The lattice constant, z (Angstoms) = 9.23588362790623;
The volume (Angstoms^3) = 787.835155722105;
The total energy (eV) = -353.136820792438;
The cohesive energy (eV/atom) = 6.30601465700783;
-------------------------------------------------------------
# Murnaghan equation of state
f(x) = (a*x/(b*(b-1)))*(b*(1-c/x)+(c/x)**b-1)+d

Final set of parameters            Asymptotic Standard Error
=======================            ==========================
a               = 0.817578         +/- 0.0003374    (0.04127%)
b               = 3.3908           +/- 0.01322      (0.3898%)
c               = 657.148          +/- 0.03172      (0.004827%)
d               = -361.31          +/- 0.001663     (0.0004603%)

657.148^(1/3) = 8.6940 [A]
-361.31/56 = -6.45196 [eV/atom]
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       265.01775         70.707573         70.707573     1.6981871e-09    -4.5923135e-09     4.0345156e-08
2       70.707573         265.01775         70.707573    -1.0570303e-08    -6.5737582e-09      3.170579e-08
3       70.707573         70.707573         265.01775    -3.5881118e-09    -4.2485646e-09      3.427476e-08
4   1.6981871e-09    -1.0570303e-08    -3.5881118e-09         58.848166    -1.3624484e-08     2.3457897e-07
5  -4.5923135e-09    -6.5737582e-09    -4.2485646e-09    -1.3624484e-08         58.848166     8.7873267e-09
6   4.0345156e-08      3.170579e-08      3.427476e-08     2.3457897e-07     8.7873267e-09         58.848165
-------------------------------------------------------------
Voigt bulk modulus, BV:       135.47763
Reuss bulk modulus, BR:       135.47763
Hill bulk modulus, B=(BV+BR)/2:       135.47763 [GPa]

Voigt shear modulus, GV:       109.47983
Reuss shear modulus, GR:       150.01363
Hill shear modulus, G=(GV+GR)/2:       129.74673 [GPa]

Pughs modulus ratio, k=G/B:      0.95769854
-------------------------------------------------------------

#-------------------------------------------------------------
# Reference: T. Ohira et al., Mat. Res. Soc. Symp. Proc. 492 (1997) 401-406.: https://link.springer.com/journal/43582/aims-and-scope
# Calculation (Expt.)
# Property  Fe3O4  NiFe2O4  Cr2O3  FeCr2O4
# Cohesive energy (eV/atom)  4.91(4.95)  4.38  5.52(5.52)  5.15
# Lattice constant, a0 (A)  8.399(8.396)  8.342(8.340)  4.964(4.961)  8.381(8.377)
# Lattice constant, c0 (A)  --  --  13.606(13.599)
# Bulk modulus (GPa)  156(161)  120(146)  267(234)  40(140-170)
# Elastic shear constants C44 (GPa)  133(97)  82(81)  --  190(80-110)
# Elastic shear constants (C11-C12)/2  --  --  110(113)  --
# (001) Fracture energy (J/m^2)  3.5(about 3.9)  3.3(about 4.1)  5.1(about 5.0)  7.0(about 6.2)  
#-------------------------------------------------------------
