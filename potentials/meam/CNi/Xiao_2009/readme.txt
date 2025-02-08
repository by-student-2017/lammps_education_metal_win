Usage in lammps input
#-------------------------------------------------------------
pair_style meam
pair_coeff * * ./../../library.meam Ni C ./../../NiC.meam Ni C
#-------------------------------------------------------------

Results [NiC, NaCl-type = FCC B1]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 8;
The lattice constant, x (Angstoms) = 4.33433724400022;
The lattice constant, y (Angstoms) = 4.33433724400022;
The lattice constant, z (Angstoms) = 4.33433724400022;
The volume (Angstoms^3) = 81.4269371074929;
The total energy (eV) = -38.0296403133925;
The cohesive energy (eV/atom) = 4.75370503917406;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       545.20787         103.95871         103.95871    -3.6185306e-10    -1.0741989e-09    -1.3977429e-11
2       103.95871         545.20787         103.95871      9.657873e-10     3.2239106e-10    -1.7340911e-10
3       103.95871         103.95871         545.20787      3.867631e-09    -8.9337159e-10     1.3976304e-09
4  -3.6185306e-10      9.657873e-10      3.867631e-09         7.6291013     1.5205521e-11       5.18184e-12
5  -1.0741989e-09     3.2239106e-10    -8.9337159e-10     1.5205521e-11         7.6291013     1.4810618e-11
6  -1.3977429e-11    -1.7340911e-10     1.3976304e-09       5.18184e-12     1.4810618e-11         7.6291013
-------------------------------------------------------------
Voigt bulk modulus, BV:       251.04176
Reuss bulk modulus, BR:       251.04176
Hill bulk modulus, B=(BV+BR)/2:       251.04176 [GPa]

Voigt shear modulus, GV:       97.404754
Reuss shear modulus, GR:       46.566663
Hill shear modulus, G=(GV+GR)/2:       71.985708 [GPa]

Pughs modulus ratio, k=G/B:      0.28674794
-------------------------------------------------------------

#---------------------------------------------------------------------------
NiC, NaCl-type = FCC B1 (reference: W. Xiao et al., Surf. Sci. 603 (2009) 1985-1998.: https://doi.org/10.1016/j.susc.2009.03.009)
a   4.08 [A]
Ec  9.89 [eV]
C11  512 [GPa]
C12  121 [GPa]
C44  6.6 [GPa]
B    250 [GPa]
#---------------------------------------------------------------------------
