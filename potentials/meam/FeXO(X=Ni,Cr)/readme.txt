Usage in lammps input
#-------------------------------------------------------------
pair_style meam
pair_coeff * * ./../../library.meam Fe Cr Ni O ./../../FeCrNiO.meam Fe O
#-------------------------------------------------------------

The parameters are as described in the paper, but the results are not correct.
Am I doing something wrong ?
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
