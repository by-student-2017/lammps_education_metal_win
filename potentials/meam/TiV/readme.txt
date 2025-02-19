#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Ti V TiV.meam Ti V
#------------------------------------------------------------------------
# C. Feng et al., Physica E Low Dimens. Syst. Nanostruct.: https://doi.org/10.1016/j.physe.2016.10.019
#------------------------------------------------------------------------

#------------------------------------------------------------------------
Test: check_lammps_script
#------------------------------------------------------------------------
Usage in lammps input
#-------------------------------------------------------------
pair_style meam
pair_coeff * * ./../../library.meam Ti V ./../../TiV.meam Ti V
#-------------------------------------------------------------

Results [TiV, CsCl-type]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 2;
The lattice constant, x (Angstoms) = 3.30953719337568;
The lattice constant, y (Angstoms) = 3.30953719337568;
The lattice constant, z (Angstoms) = 3.30953719337568;
The volume (Angstoms^3) = 36.2494814598373;
The total energy (eV) = -9.85876118763473;
The cohesive energy (eV/atom) = 4.92938059381737;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       163.80829         114.85535         114.85535      3.677541e-10     2.7040351e-10    -4.7119903e-10
2       114.85535         163.80829         114.85535     3.6444382e-11     -2.650491e-10    -4.6155304e-11
3       114.85535         114.85535         163.80829    -7.2278691e-10     9.8206533e-10     -8.950701e-10
4    3.677541e-10     3.6444382e-11    -7.2278691e-10         48.097264    -1.3212309e-10     3.0564222e-10
5   2.7040351e-10     -2.650491e-10     9.8206533e-10    -1.3212309e-10         48.097264    -3.7399425e-10
6  -4.7119903e-10    -4.6155304e-11     -8.950701e-10     3.0564222e-10    -3.7399425e-10         48.097264
-------------------------------------------------------------
Voigt bulk modulus, BV:         131.173
Reuss bulk modulus, BR:         131.173
Hill bulk modulus, B=(BV+BR)/2:         131.173 [GPa]

Voigt shear modulus, GV:       67.507305
Reuss shear modulus, GR:       51.385068
Hill shear modulus, G=(GV+GR)/2:       59.446186 [GPa]

Pughs modulus ratio, k=G/B:      0.45318921
-------------------------------------------------------------

#---------------------------------------------------------------------------
TiV, CsCl-type (C. Feng et al., Physica E Low Dimens. Syst. Nanostruct.: https://doi.org/10.1016/j.physe.2016.10.019)
Ec  5.085  [eV]
a   3.08   [A]
C11  168   [GPa]
C12  108.9 [GPa]
C44   38.1 [GPa]
B    128   [GPa]
#---------------------------------------------------------------------------
