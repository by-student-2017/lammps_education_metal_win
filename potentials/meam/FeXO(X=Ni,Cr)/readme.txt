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
The lattice constant, x (Angstoms) = 9.12198119023532;
The lattice constant, y (Angstoms) = 9.12198119023532;
The lattice constant, z (Angstoms) = 9.12198119023532;
The volume (Angstoms^3) = 759.044988326242;
The total energy (eV) = -410.631252304872;
The cohesive energy (eV/atom) = -7.33270093401557;
-------------------------------------------------------------
# Murnaghan equation of state
f(x) = (a*x/(b*(b-1)))*(b*(1-c/x)+(c/x)**b-1)+d

Final set of parameters            Asymptotic Standard Error
=======================            ==========================
a               = 0.851972         +/- 0.0003492    (0.04099%)
b               = 3.36214          +/- 0.01313      (0.3907%)
c               = 633.132          +/- 0.03037      (0.004796%)
d               = -418.85          +/- 0.001659     (0.000396%)

633.132^(1/3) = 8.5868 [A]
-418.85/56 = -7.4795 [eV/atom]
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       246.26685         29.416794         29.416794     3.6963643e-10     2.0313161e-10     3.1138935e-10
2       29.416794         246.26685         29.416794     9.8276797e-10     -6.081338e-10    -1.5663428e-09
3       29.416794         29.416794         246.26685    -6.0203909e-09    -2.1917385e-09     2.1703919e-09
4   3.6963643e-10     9.8276797e-10    -6.0203909e-09         74.783007     1.1083189e-09      1.289478e-09
5   2.0313161e-10     -6.081338e-10    -2.1917385e-09     1.1083189e-09         74.783007    -3.1004834e-09
6   3.1138935e-10    -1.5663428e-09     2.1703919e-09      1.289478e-09    -3.1004834e-09         74.783007
-------------------------------------------------------------
Voigt bulk modulus, BV:       101.70015
Reuss bulk modulus, BR:       101.70015
Hill bulk modulus, B=(BV+BR)/2:       101.70015 [GPa]

Voigt shear modulus, GV:       133.10962
Reuss shear modulus, GR:       175.59298
Hill shear modulus, G=(GV+GR)/2:        154.3513 [GPa]

Pughs modulus ratio, k=G/B:       1.5177097
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
