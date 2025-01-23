# Pt-Pd (Pt3Pd, L12 structure)
# It does not correspond to "f0(Pt) = 1.05 and f0(Pd) = 0.95". 
# In other words, it is "f0(A) = 1.00 and f0(B) = 1.00". Please note that.


Usage in lammps input
#-------------------------------------------------------------
pair_style meam
#pair_coeff * * ./../../library.meam Pt Pd Rh ./../../PtPdRh.meam Pt
#pair_coeff * * ./../../library.meam Pt Pd Rh ./../../PtPdRh.meam Pd
pair_coeff * * ./../../library.meam Pt Pd Rh ./../../PtPdRh.meam Rh
#-------------------------------------------------------------

Results [FCC Pt]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 4;
The lattice constant, x (Angstoms) = 4.2366895572111;
The lattice constant, y (Angstoms) = 4.2366895572111;
The lattice constant, z (Angstoms) = 4.2366895572111;
The volume (Angstoms^3) = 76.0466219137558;
The total energy (eV) = -20.6009117667366;
The cohesive energy (eV/atom) = -5.15022794168414;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       297.97481         208.52154         208.52154      3.653026e-10     -6.405902e-10    -5.2901477e-10
2       208.52154         297.97481         208.52154     5.9249462e-10    -2.9385004e-10     4.9481051e-10
3       208.52154         208.52154         297.97481    -1.6478823e-10    -1.1140915e-09    -5.8839194e-11
4    3.653026e-10     5.9249462e-10    -1.6478823e-10         75.172302     4.0474904e-11    -4.3142056e-10
5   -6.405902e-10    -2.9385004e-10    -1.1140915e-09     4.0474904e-11         75.172302    -4.5645888e-11
6  -5.2901477e-10     4.9481051e-10    -5.8839194e-11    -4.3142056e-10    -4.5645888e-11         75.172302
-------------------------------------------------------------
Voigt bulk modulus, BV:        238.3393
Reuss bulk modulus, BR:        238.3393
Hill bulk modulus, B=(BV+BR)/2:        238.3393 [GPa]

Voigt shear modulus, GV:       108.09742
Reuss shear modulus, GR:        91.41911
Hill shear modulus, G=(GV+GR)/2:       99.758264 [GPa]

Pughs modulus ratio, k=G/B:      0.41855567
-------------------------------------------------------------

J. Luyten et al., Calphad 33 (2009) 370-376.: https://doi.org/10.1016/j.calphad.2008.10.007
-------------------------------------------------------------
Pt
C11 302 [GPa]
C12 206 [GPa]
C44  80 [GPa]
-------------------------------------------------------------



Results [FCC Pd]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 4;
The lattice constant, x (Angstoms) = 4.20664213062632;
The lattice constant, y (Angstoms) = 4.20664213062632;
The lattice constant, z (Angstoms) = 4.20664213062632;
The volume (Angstoms^3) = 74.4400577313126;
The total energy (eV) = -13.8570619062826;
The cohesive energy (eV/atom) = -3.46426547657065;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       238.12454         127.43987         127.43987    -4.1859501e-10    -5.3180077e-10     2.0299055e-09
2       127.43987         238.12454         127.43987    -2.1511306e-10     8.7028885e-10     2.1400039e-09
3       127.43987         127.43987         238.12454    -7.2069043e-10    -4.8904759e-10     4.1132545e-10
4  -4.1859501e-10    -2.1511306e-10    -7.2069043e-10         95.605406      2.151177e-10    -1.4300519e-10
5  -5.3180077e-10     8.7028885e-10    -4.8904759e-10      2.151177e-10         95.605406     1.0908285e-09
6   2.0299055e-09     2.1400039e-09     4.1132545e-10    -1.4300519e-10     1.0908285e-09         95.605406
-------------------------------------------------------------
Voigt bulk modulus, BV:       164.33476
Reuss bulk modulus, BR:       164.33476
Hill bulk modulus, B=(BV+BR)/2:       164.33476 [GPa]

Voigt shear modulus, GV:       136.86342
Reuss shear modulus, GR:       113.67913
Hill shear modulus, G=(GV+GR)/2:       125.27127 [GPa]

Pughs modulus ratio, k=G/B:      0.76229322
-------------------------------------------------------------

J. Luyten et al., Calphad 33 (2009) 370-376.: https://doi.org/10.1016/j.calphad.2008.10.007
-------------------------------------------------------------
Pd
C11 247 [GPa]
C12 123 [GPa]
C44  62 [GPa]
-------------------------------------------------------------



Results [FCC Rh]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 4;
The lattice constant, x (Angstoms) = 4.08645235840654;
The lattice constant, y (Angstoms) = 4.08645235840654;
The lattice constant, z (Angstoms) = 4.08645235840654;
The volume (Angstoms^3) = 68.2400474726174;
The total energy (eV) = -21.6680006149907;
The cohesive energy (eV/atom) = -5.41700015374767;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       352.82641         195.97241         195.97241     1.3618597e-09     5.1887243e-10     1.1658889e-09
2       195.97241         352.82641         195.97241    -2.7950476e-10     7.5123411e-10     4.4630796e-11
3       195.97241         195.97241         352.82641     9.8483456e-10     2.3126661e-09      2.096016e-10
4   1.3618597e-09    -2.7950476e-10     9.8483456e-10         132.14282    -2.2205307e-10     2.0460274e-10
5   5.1887243e-10     7.5123411e-10     2.3126661e-09    -2.2205307e-10         132.14282    -1.0319183e-09
6   1.1658889e-09     4.4630796e-11      2.096016e-10     2.0460274e-10    -1.0319183e-09         132.14282
-------------------------------------------------------------
Voigt bulk modulus, BV:       248.25708
Reuss bulk modulus, BR:       248.25708
Hill bulk modulus, B=(BV+BR)/2:       248.25708 [GPa]

Voigt shear modulus, GV:       189.94218
Reuss shear modulus, GR:       160.37413
Hill shear modulus, G=(GV+GR)/2:       175.15816 [GPa]

Pughs modulus ratio, k=G/B:      0.70555151
-------------------------------------------------------------

J. Luyten et al., Calphad 33 (2009) 370-376.: https://doi.org/10.1016/j.calphad.2008.10.007
-------------------------------------------------------------
Rh
C11 363 [GPa]
C12 194 [GPa]
C44 132 [GPa]
-------------------------------------------------------------