Usage in lammps input
#-------------------------------------------------------------
pair_style meam
pair_coeff * * ./../../library.meam Ni Ti C ./../../NiTiC.meam Ni Ti
#-------------------------------------------------------------

Results [NiTi CsCl-type]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 2;
The lattice constant, x (Angstoms) = 3.20173869943222;
The lattice constant, y (Angstoms) = 3.20173869943222;
The lattice constant, z (Angstoms) = 3.20173869943222;
The volume (Angstoms^3) = 32.8214418733409;
The total energy (eV) = -9.6528050343694;
The cohesive energy (eV/atom) = -4.8264025171847;
-------------------------------------------------------------
# Murnaghan equation of state
f(x) = (a*x/(b*(b-1)))*(b*(1-c/x)+(c/x)**b-1)+d

Final set of parameters            Asymptotic Standard Error
=======================            ==========================
a               = 0.967761         +/- 0.0006453    (0.06668%)
b               = 4.24836          +/- 0.021        (0.4943%)
c               = 27.3786          +/- 0.002091     (0.007636%)
d               = -10.0366         +/- 0.0001314    (0.001309%)

27.3786^(1/3) = 3.01395 [A]
-10.0366/2 = -5.0183 [eV/atom]
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       175.72259         148.18877         148.18877     1.7523672e-10     9.7505793e-10    -1.2149093e-09
2       148.18877         175.72259         148.18877     1.2985612e-09    -2.8490316e-10    -3.4666359e-10
3       148.18877         148.18877         175.72259     1.8900465e-09    -8.8622448e-11    -4.6489752e-10
4   1.7523672e-10     1.2985612e-09     1.8900465e-09         107.32125    -6.0089773e-10       6.12848e-10
5   9.7505793e-10    -2.8490316e-10    -8.8622448e-11    -6.0089773e-10         107.32125     2.6079088e-10
6  -1.2149093e-09    -3.4666359e-10    -4.6489752e-10       6.12848e-10     2.6079088e-10         107.32125
-------------------------------------------------------------
Voigt bulk modulus, BV:       157.36671
Reuss bulk modulus, BR:       157.36671
Hill bulk modulus, B=(BV+BR)/2:       157.36671 [GPa]

Voigt shear modulus, GV:       134.29226
Reuss shear modulus, GR:       32.837643
Hill shear modulus, G=(GV+GR)/2:       83.564951 [GPa]

Pughs modulus ratio, k=G/B:      0.53102051
-------------------------------------------------------------

Reference (J. Chun et al.,  J. Mech. Sci. Technol. 27, 775-781 (2013).: https://doi.org/10.1007/s12206-013-0131-x)
-------------------------------------------------------------
NiTi CsCl-type
C11 177 [GPa]
C12 148 [GPa]
C44 106 [GPa]
-------------------------------------------------------------
Note: For the second moment approximation (SMA) [28], C11 is large, but C44 is closer to the experimental value.
[28] W. S. Lai et al., J. Phys.: Condens. Matter 12 (2000) L53-L60.



Results [TiC NaCl-type]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 8;
The lattice constant, x (Angstoms) = 4.7269623795898;
The lattice constant, y (Angstoms) = 4.7269623795898;
The lattice constant, z (Angstoms) = 4.7269623795898;
The volume (Angstoms^3) = 105.62006677203;
The total energy (eV) = -49.8031737499139;
The cohesive energy (eV/atom) = -6.22539671873924;
-------------------------------------------------------------
# Murnaghan equation of state
f(x) = (a*x/(b*(b-1)))*(b*(1-c/x)+(c/x)**b-1)+d

Final set of parameters            Asymptotic Standard Error
=======================            ==========================
a               = 1.40859          +/- 0.0009565    (0.06791%)
b               = 4.16626          +/- 0.02144      (0.5145%)
c               = 88.1002          +/- 0.006871     (0.007799%)
d               = -51.6109         +/- 0.0006276    (0.001216%)

88.1002^(1/3) = 4.4496 [A]
-51.6109/8 = -6.45136 [eV/atom]
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       446.73144         118.60756         118.60756     6.2414197e-10     1.3136587e-09     1.2177807e-09
2       118.60756         446.73144         118.60756     1.3749948e-09    -1.3381215e-10     5.2160688e-10
3       118.60756         118.60756         446.73144     1.1031571e-09    -1.0883675e-09     6.5326878e-09
4   6.2414197e-10     1.3749948e-09     1.1031571e-09         304.55196     2.2780314e-09     2.2878082e-09
5   1.3136587e-09    -1.3381215e-10    -1.0883675e-09     2.2780314e-09         304.55196    -3.6748635e-09
6   1.2177807e-09     5.2160688e-10     6.5326878e-09     2.2878082e-09    -3.6748635e-09         304.55196
-------------------------------------------------------------
Voigt bulk modulus, BV:       227.98218
Reuss bulk modulus, BR:       227.98218
Hill bulk modulus, B=(BV+BR)/2:       227.98218 [GPa]

Voigt shear modulus, GV:       431.08713
Reuss shear modulus, GR:       341.22352
Hill shear modulus, G=(GV+GR)/2:       386.15532 [GPa]

Pughs modulus ratio, k=G/B:       1.6937961
-------------------------------------------------------------

Reference (J. Chun et al.,  J. Mech. Sci. Technol. 27, 775-781 (2013).: https://doi.org/10.1007/s12206-013-0131-x)
-------------------------------------------------------------
TiC NaCl-type
C11 489 [GPa]
C12 110 [GPa]
C44 126 [GPa]
-------------------------------------------------------------



Results [NiC NaCl-type]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 8;
The lattice constant, x (Angstoms) = 4.33433725289619;
The lattice constant, y (Angstoms) = 4.33433725289619;
The lattice constant, z (Angstoms) = 4.33433725289619;
The volume (Angstoms^3) = 81.4269376088649;
The total energy (eV) = -38.0009651840498;
The cohesive energy (eV/atom) = -4.75012064800623;
-------------------------------------------------------------
# Murnaghan equation of state
f(x) = (a*x/(b*(b-1)))*(b*(1-c/x)+(c/x)**b-1)+d

Final set of parameters            Asymptotic Standard Error
=======================            ==========================
a               = 1.54196          +/- 0.001031     (0.06687%)
b               = 4.2547           +/- 0.02106      (0.4949%)
c               = 67.9239          +/- 0.005201     (0.007657%)
d               = -39.5174         +/- 0.0005209    (0.001318%)

67.9239^(1/3) = 4.0801 [A]
-39.5174/8 = -4.939675 [eV/atom]
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       675.81221         38.214393         38.214393     1.2017769e-09     2.4701973e-09    -2.0213529e-09
2       38.214393         675.81221         38.214393     1.5166787e-09    -8.9285157e-11    -9.2562472e-10
3       38.214393         38.214393         675.81221     4.1073253e-09     -8.331489e-10    -7.6013831e-10
4   1.2017769e-09     1.5166787e-09     4.1073253e-09         28.863314     8.9339616e-11     8.3084825e-12
5   2.4701973e-09    -8.9285157e-11     -8.331489e-10     8.9339616e-11         28.863314    -4.3826747e-11
6  -2.0213529e-09    -9.2562472e-10    -7.6013831e-10     8.3084825e-12    -4.3826747e-11         28.863314
-------------------------------------------------------------
Voigt bulk modulus, BV:         250.747
Reuss bulk modulus, BR:         250.747
Hill bulk modulus, B=(BV+BR)/2:         250.747 [GPa]

Voigt shear modulus, GV:       162.15554
Reuss shear modulus, GR:       154.99988
Hill shear modulus, G=(GV+GR)/2:       158.57771 [GPa]

Pughs modulus ratio, k=G/B:      0.63242117
-------------------------------------------------------------

Reference (J. Chun et al.,  J. Mech. Sci. Technol. 27, 775-781 (2013).: https://doi.org/10.1007/s12206-013-0131-x)
-------------------------------------------------------------
NiC NaCl-type
C11 512 [GPa]
C12 120 [GPa]
C44 6.6 [GPa]
-------------------------------------------------------------
