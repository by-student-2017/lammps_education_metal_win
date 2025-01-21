Usage in lammps input
#-------------------------------------------------------------
pair_style meam
pair_coeff * * ./../../library.meam Zr N ./../../ZrN.meam Zr N
#-------------------------------------------------------------
Note: Since rho0(N)/rho0(Zr) = 11.565, care must be taken when stacking on other potentials.

Results [ZrN NaCl-type]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 8;
The lattice constant, x (Angstoms) = 4.89737616872078;
The lattice constant, y (Angstoms) = 4.89737616872078;
The lattice constant, z (Angstoms) = 4.89737616872078;
The volume (Angstoms^3) = 117.460106616905;
The total energy (eV) = -57.1826401005248;
The cohesive energy (eV/atom) = -7.1478300125656;
-------------------------------------------------------------
# Murnaghan equation of state
f(x) = (a*x/(b*(b-1)))*(b*(1-c/x)+(c/x)**b-1)+d

Final set of parameters            Asymptotic Standard Error
=======================            ==========================
a               = 1.32476          +/- 0.0007741    (0.05844%)
b               = 3.96496          +/- 0.01853      (0.4672%)
c               = 97.9793          +/- 0.006611     (0.006747%)
d               = -59.0932         +/- 0.0005661    (0.000958%)

97.9793^(1/3) = 4.610 [A]
-59.0932/8 = -7.38665 [eV/atom]
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1        480.3677         82.371238         82.371238     1.8716205e-09     1.8118072e-09     1.3616964e-10
2       82.371238          480.3677         82.371238     3.6584336e-09     4.6619193e-10     -5.484588e-10
3       82.371238         82.371238          480.3677     2.9065957e-09    -3.7512739e-09    -1.9139336e-09
4   1.8716205e-09     3.6584336e-09     2.9065957e-09         122.43693    -1.2182821e-09      1.220426e-09
5   1.8118072e-09     4.6619193e-10    -3.7512739e-09    -1.2182821e-09         122.43693     1.4241035e-09
6   1.3616964e-10     -5.484588e-10    -1.9139336e-09      1.220426e-09     1.4241035e-09         122.43693
-------------------------------------------------------------
Voigt bulk modulus, BV:       215.03673
Reuss bulk modulus, BR:       215.03673
Hill bulk modulus, B=(BV+BR)/2:       215.03673 [GPa]

Voigt shear modulus, GV:       226.52361
Reuss shear modulus, GR:       309.10098
Hill shear modulus, G=(GV+GR)/2:       267.81229 [GPa]

Pughs modulus ratio, k=G/B:       1.2454258
-------------------------------------------------------------

Reference (N. Dhariwal et al., Mater. Des. 210 (2021) 110120.: https://pubs.acs.org/doi/pdf/10.1021/acs.jpcc.6b05296)
-------------------------------------------------------------
ZrN NaCl-type
a   4.61 [A]
C11 480 [GPa]
C12  83 [GPa]
C44 125 [GPa]
-------------------------------------------------------------
