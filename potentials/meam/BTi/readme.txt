Usage in lammps input
#-------------------------------------------------------------
pair_style meam
pair_coeff * * ./../../library.meam B Ti ./../../BTi.meam B Ti
#-------------------------------------------------------------

Results [TiB2 (mp-1145: TiB2 (hexagonal, P6/mmm, 191))]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 3;
The lattice constant, x (Angstoms) = 3.22229453231778;
The lattice constant, y (Angstoms) = 2.79058892349761;
The lattice constant, z (Angstoms) = 3.42199279655925;
The volume (Angstoms^3) = 30.7708994758593;
The total energy (eV) = -18.9824690588632;
The cohesive energy (eV/atom) = 6.32748968628772;
-------------------------------------------------------------
# Murnaghan equation of state
f(x) = (a*x/(b*(b-1)))*(b*(1-c/x)+(c/x)**b-1)+d

Final set of parameters            Asymptotic Standard Error
=======================            ==========================
a               = 1.7694           +/- 0.001374     (0.07766%)
b               = 4.15728          +/- 0.02451      (0.5895%)
c               = 25.6684          +/- 0.002289     (0.008917%)
d               = -19.6431         +/- 0.0002626    (0.001337%)

-19.6431/3 = -6.5477 [eV/atom]
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       661.55813         52.286665          151.1684     1.3902827e-09     5.3583048e-09     9.5769626e-09
2       52.286665         661.55813          151.1684    -4.8190763e-09     1.8163847e-09    -1.1526186e-08
3        151.1684          151.1684         462.39271     5.4812177e-09     3.4050747e-09    -4.6108798e-09
4   1.3902827e-09    -4.8190763e-09     5.4812177e-09         219.41734    -4.5800077e-09     1.3482965e-09
5   5.3583048e-09     1.8163847e-09     3.4050747e-09    -4.5800077e-09         219.41734     -5.869474e-10
6   9.5769626e-09    -1.1526186e-08    -4.6108798e-09     1.3482965e-09     -5.869474e-10         304.63573
-------------------------------------------------------------
Voigt bulk modulus, BV:        277.1951
Reuss bulk modulus, BR:       275.03364
Hill bulk modulus, B=(BV+BR)/2:       276.11437 [GPa]

Voigt shear modulus, GV:       392.78053
Reuss shear modulus, GR:       408.81136
Hill shear modulus, G=(GV+GR)/2:       400.79595 [GPa]

Pughs modulus ratio, k=G/B:       1.4515577
-------------------------------------------------------------

Reference (S. Attarian et al., Comput. Mater. 201 (2022) 110875.: https://doi.org/10.1016/j.commatsci.2021.110875)
-------------------------------------------------------------
TiB2
Lattice constant, a 3.05
Lattice constant, c 3.18
Ef -1.01
B 256
E 554
G 238
v 0.17
C11 659
C33 473
C44 217
C12 56
C13 148
Cp 74-110
Tm 2595
-------------------------------------------------------------


Appendix: Additional cases for Cmin and Cmax
-------------------------------------------------------------
There is no difference in the results. 
Files published by NIST and other organizations often include additional information such as the one shown below, but these results suggest that it may be sufficient to include only the minimum information in the paper.
-------------------------------------------------------------
# C(i,j,k) = C(j,i,k)
Cmin(2,1,1) = 1.095
Cmin(1,2,2) = 2.0
Cmax(2,1,1) = 3.263
Cmax(1,2,2) = 2.8
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 3;
The lattice constant, x (Angstoms) = 3.22229453231778;
The lattice constant, y (Angstoms) = 2.79058892349761;
The lattice constant, z (Angstoms) = 3.42199279655925;
The volume (Angstoms^3) = 30.7708994758593;
The total energy (eV) = -18.9824690588632;
The cohesive energy (eV/atom) = 6.32748968628772;
-------------------------------------------------------------
# Murnaghan equation of state
f(x) = (a*x/(b*(b-1)))*(b*(1-c/x)+(c/x)**b-1)+d

Final set of parameters            Asymptotic Standard Error
=======================            ==========================
a               = 1.7694           +/- 0.001374     (0.07766%)
b               = 4.15728          +/- 0.02451      (0.5895%)
c               = 25.6684          +/- 0.002289     (0.008917%)
d               = -19.6431         +/- 0.0002626    (0.001337%)
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       661.55813         52.286665          151.1684     1.3902827e-09     5.3583048e-09     9.5769626e-09
2       52.286665         661.55813          151.1684    -4.8190763e-09     1.8163847e-09    -1.1526186e-08
3        151.1684          151.1684         462.39271     5.4812177e-09     3.4050747e-09    -4.6108798e-09
4   1.3902827e-09    -4.8190763e-09     5.4812177e-09         219.41734    -4.5800077e-09     1.3482965e-09
5   5.3583048e-09     1.8163847e-09     3.4050747e-09    -4.5800077e-09         219.41734     -5.869474e-10
6   9.5769626e-09    -1.1526186e-08    -4.6108798e-09     1.3482965e-09     -5.869474e-10         304.63573
-------------------------------------------------------------
Voigt bulk modulus, BV:        277.1951
Reuss bulk modulus, BR:       275.03364
Hill bulk modulus, B=(BV+BR)/2:       276.11437 [GPa]

Voigt shear modulus, GV:       392.78053
Reuss shear modulus, GR:       408.81136
Hill shear modulus, G=(GV+GR)/2:       400.79595 [GPa]

Pughs modulus ratio, k=G/B:       1.4515577
-------------------------------------------------------------

Appendix: Added cases for Cmin and Cmax and changed ibar from 3 to -5
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 3;
The lattice constant, x (Angstoms) = 3.22127395978437;
The lattice constant, y (Angstoms) = 2.78970508175726;
The lattice constant, z (Angstoms) = 3.42090897513242;
The volume (Angstoms^3) = 30.7416712449431;
The total energy (eV) = -19.0322714909455;
The cohesive energy (eV/atom) = 6.34409049698184;
-------------------------------------------------------------
# Murnaghan equation of state
f(x) = (a*x/(b*(b-1)))*(b*(1-c/x)+(c/x)**b-1)+d

Final set of parameters            Asymptotic Standard Error
=======================            ==========================
a               = 1.77352          +/- 0.001382     (0.07792%)
b               = 4.15767          +/- 0.02459      (0.5915%)
c               = 25.6441          +/- 0.002294     (0.008947%)
d               = -19.6937         +/- 0.0002639    (0.00134%)
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       663.25073         43.082108         158.14398     7.2219442e-09    -5.0762346e-10     7.1389406e-09
2       43.082108         663.25073         158.14398    -1.9720729e-09    -7.8904294e-09    -1.0257249e-08
3       158.14398         158.14398         455.73426     3.6979398e-09      2.144272e-09    -6.2928233e-09
4   7.2219442e-09    -1.9720729e-09     3.6979398e-09         221.63845    -9.6000809e-09     4.5073721e-10
5  -5.0762346e-10    -7.8904294e-09      2.144272e-09    -9.6000809e-09         221.63845    -1.4998952e-09
6   7.1389406e-09    -1.0257249e-08    -6.2928233e-09     4.5073721e-10    -1.4998952e-09         310.08431
-------------------------------------------------------------
Voigt bulk modulus, BV:       277.88621
Reuss bulk modulus, BR:        275.9582
Hill bulk modulus, B=(BV+BR)/2:        276.9222 [GPa]

Voigt shear modulus, GV:       396.20219
Reuss shear modulus, GR:       402.58903
Hill shear modulus, G=(GV+GR)/2:       399.39561 [GPa]

Pughs modulus ratio, k=G/B:       1.4422665
-------------------------------------------------------------

Appendix: Added cases for Cmin and Cmax and changed ibar from 3 to 0
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 3;
The lattice constant, x (Angstoms) = 3.22127395978437;
The lattice constant, y (Angstoms) = 2.78970508175726;
The lattice constant, z (Angstoms) = 3.42090897513242;
The volume (Angstoms^3) = 30.7416712449431;
The total energy (eV) = -19.0322714909455;
The cohesive energy (eV/atom) = 6.34409049698184;
-------------------------------------------------------------
# Murnaghan equation of state
f(x) = (a*x/(b*(b-1)))*(b*(1-c/x)+(c/x)**b-1)+d

Final set of parameters            Asymptotic Standard Error
=======================            ==========================
a               = 1.77352          +/- 0.001382     (0.07792%)
b               = 4.15767          +/- 0.02459      (0.5915%)
c               = 25.6441          +/- 0.002294     (0.008947%)
d               = -19.6937         +/- 0.0002639    (0.00134%)

-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       663.25073         43.082108         158.14398     7.2219442e-09    -5.0762346e-10     7.1389406e-09
2       43.082108         663.25073         158.14398    -1.9720729e-09    -7.8904294e-09    -1.0257249e-08
3       158.14398         158.14398         455.73426     3.6979398e-09      2.144272e-09    -6.2928233e-09
4   7.2219442e-09    -1.9720729e-09     3.6979398e-09         221.63845    -9.6000809e-09     4.5073721e-10
5  -5.0762346e-10    -7.8904294e-09      2.144272e-09    -9.6000809e-09         221.63845    -1.4998952e-09
6   7.1389406e-09    -1.0257249e-08    -6.2928233e-09     4.5073721e-10    -1.4998952e-09         310.08431
-------------------------------------------------------------
Voigt bulk modulus, BV:       277.88621
Reuss bulk modulus, BR:        275.9582
Hill bulk modulus, B=(BV+BR)/2:        276.9222 [GPa]

Voigt shear modulus, GV:       396.20219
Reuss shear modulus, GR:       402.58903
Hill shear modulus, G=(GV+GR)/2:       399.39561 [GPa]

Pughs modulus ratio, k=G/B:       1.4422665
-------------------------------------------------------------
