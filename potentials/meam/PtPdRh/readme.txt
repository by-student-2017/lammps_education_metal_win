# Pt-Pd (Pt3Pd, L12 structure)
# It does not correspond to "f0(Pt) = 1.05 and f0(Pd) = 0.95". 
# In other words, it is "f0(A) = 1.00 and f0(B) = 1.00". Please note that.


Usage in lammps input
#-------------------------------------------------------------
pair_style meam
pair_coeff * * ./../../library.meam V Nb Ta Ti Zr ./../../VNbTaTiZr.meam V Nb
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

Pd
C11 247 [GPa]
C12 123 [GPa]
C44  62 [GPa]

Rh
C11 363 [GPa]
C12 194 [GPa]
C44 132 [GPa]
-------------------------------------------------------------