Usage in lammps input
#-------------------------------------------------------------
pair_style meam
pair_coeff * * ./../../library.meam Fe Cr Ni O ./../../FeCrNiO.meam Fe O
#-------------------------------------------------------------

The parameters are as described in the paper, but the results are not correct.
Am I doing something wrong ?
Fe3O4 (using mp-19306: Fe3O4 (cubic, Fd-3m, 227))
#-------------------------------------------------------------
#Show results of 1st step (Running Minimization)
#The number of atoms = 56;
#The lattice constant, x (Angstoms) = 9.25664749600992;
#The lattice constant, y (Angstoms) = 9.25664749600992;
#The lattice constant, z (Angstoms) = 9.25664749600992;
#The volume (Angstoms^3) = 793.160680676182;
#The total energy (eV) = -313.942174847806;
#The cohesive energy (eV/atom) = -5.60611026513939;
#-------------------------------------------------------------
#C tensor [GPa] (elastic stiffness constants)
#          1                 2                 3                 4                 5                 6
#1       140.90062         75.477162         75.477162    -3.4246261e-09     -1.282695e-09    -1.4305792e-09
#2       75.477162         140.90062         75.477162     3.3795389e-09     1.0817068e-09      9.993598e-10
#3       75.477162         75.477162         140.90062     1.6160408e-09     1.1001916e-09    -5.1193052e-10
#4  -3.4246261e-09     3.3795389e-09     1.6160408e-09         32.426715    -2.0043634e-09    -8.7005588e-10
#5   -1.282695e-09     1.0817068e-09     1.1001916e-09    -2.0043634e-09         32.426715     -3.747416e-09
#6  -1.4305792e-09      9.993598e-10    -5.1193052e-10    -8.7005588e-10     -3.747416e-09         32.426715
#-------------------------------------------------------------
#Voigt bulk modulus, BV:       97.284981
#Reuss bulk modulus, BR:       97.284981
#Hill bulk modulus, B=(BV+BR)/2:       97.284981 [GPa]
#-------------------------------------------------------------

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
