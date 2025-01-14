Usage in lammps input
#-------------------------------------------------------------
pair_style meam
pair_coeff * * ./../../library.meam Ge Si ./../../GeSi.meam Ge Si
#-------------------------------------------------------------


Results [Ge-Si, zinc blend structure] (Read_2007: D. T. Read et al., Nanotechnology 18 (2007) 105402.:  doi:10.1088/0957-4484/18/10/105402)
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 8;
The lattice constant, x (Angstoms) = 5.8905257651135;
The lattice constant, y (Angstoms) = 5.8905257651135;
The lattice constant, z (Angstoms) = 5.8905257651135;
The volume (Angstoms^3) = 204.391193572327;
The total energy (eV) = -32.616213176632;
The cohesive energy (eV/atom) = -4.077026647079;
-------------------------------------------------------------
# Murnaghan equation of state
f(x) = (a*x/(b*(b-1)))*(b*(1-c/x)+(c/x)**b-1)+d

Final set of parameters            Asymptotic Standard Error
=======================            ==========================
a               = 0.527253         +/- 0.0003526    (0.06687%)
b               = 4.2547           +/- 0.02106      (0.4949%)
c               = 170.497          +/- 0.01305      (0.007657%)
d               = -33.9178         +/- 0.0004471    (0.001318%)

170.497^(1/3) = 5.5450 [A]
-33.9178/8 = -4.239725 [eV/atom]
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1        158.4679         49.375489         49.375489    -3.1237462e-07    -1.0406558e-07    -1.9492813e-07
2       49.375489          158.4679         49.375489     2.3904309e-08    -5.1908246e-07    -5.2336904e-07
3       49.375489         49.375489          158.4679    -1.6445718e-07    -2.3285602e-07     9.3842227e-07
4  -3.1237462e-07     2.3904309e-08    -1.6445718e-07         84.948748     1.1439324e-06    -2.9720901e-07
5  -1.0406558e-07    -5.1908246e-07    -2.3285602e-07     1.1439324e-06         84.948744     1.6272429e-08
6  -1.9492813e-07    -5.2336904e-07     9.3842227e-07    -2.9720901e-07     1.6272429e-08         84.948752
-------------------------------------------------------------
Voigt bulk modulus, BV:       85.739625
Reuss bulk modulus, BR:       85.739625
Hill bulk modulus, B=(BV+BR)/2:       85.739625 [GPa]

Voigt shear modulus, GV:       123.75698
Reuss shear modulus, GR:       109.90215
Hill shear modulus, G=(GV+GR)/2:       116.82956 [GPa]

Pughs modulus ratio, k=G/B:       1.3626088
-------------------------------------------------------------


Results [Ge-Si, zinc blend structure] (Swadener_2009: J. G. Swadener et al., J. Appl. Phys. 105, 044310 (2009).: https://doi.org/10.1063/1.3077293)
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 8;
The lattice constant, x (Angstoms) = 5.79239122175484;
The lattice constant, y (Angstoms) = 5.79239122175484;
The lattice constant, z (Angstoms) = 5.79239122175484;
The volume (Angstoms^3) = 194.34512900601;
The total energy (eV) = -32.3275708493094;
The cohesive energy (eV/atom) = -4.04094635616367;
-------------------------------------------------------------
# Murnaghan equation of state
f(x) = (a*x/(b*(b-1)))*(b*(1-c/x)+(c/x)**b-1)+d

Final set of parameters            Asymptotic Standard Error
=======================            ==========================
a               = 0.714811         +/- 0.0006518    (0.09118%)
b               = 5.23611          +/- 0.02786      (0.5321%)
c               = 162.133          +/- 0.01632      (0.01006%)
d               = -33.9162         +/- 0.0007737    (0.002281%)

162.133^(1/3) = 5.4529 [A]
-33.9162/8 = -4.2395 [eV/atom]
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       192.48435         78.989508         78.989508     1.4056583e-07     9.8712721e-08     3.4377881e-07
2       78.989508         192.48435         78.989508    -5.5325674e-08    -1.2410616e-07     7.4033503e-08
3       78.989508         78.989508         192.48435    -3.3765007e-07     9.1835555e-08    -2.2821856e-07
4   1.4056583e-07    -5.5325674e-08    -3.3765007e-07         84.040207    -1.1454354e-06    -2.3767557e-06
5   9.8712721e-08    -1.2410616e-07     9.1835555e-08    -1.1454354e-06         84.040208     9.4175585e-07
6   3.4377881e-07     7.4033503e-08    -2.2821856e-07    -2.3767557e-06     9.4175585e-07         84.040208
-------------------------------------------------------------
Voigt bulk modulus, BV:       116.82112
Reuss bulk modulus, BR:       116.82112
Hill bulk modulus, B=(BV+BR)/2:       116.82112 [GPa]

Voigt shear modulus, GV:       123.54722
Reuss shear modulus, GR:       113.20364
Hill shear modulus, G=(GV+GR)/2:       118.37543 [GPa]

Pughs modulus ratio, k=G/B:        1.013305
-------------------------------------------------------------


Results [Ge-Si, zinc blend structure] (Grochola_2010: G. Grochola et al., Chem. Phys. Lett. 493 (2010) 57-60.: https://doi.org/10.1016/j.cplett.2010.04.062)
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 8;
The lattice constant, x (Angstoms) = 5.87335216520849;
The lattice constant, y (Angstoms) = 5.87335216520849;
The lattice constant, z (Angstoms) = 5.87335216520849;
The volume (Angstoms^3) = 202.60871658556;
The total energy (eV) = -32.5159172088461;
The cohesive energy (eV/atom) = -4.06448965110577;
-------------------------------------------------------------
# Murnaghan equation of state
f(x) = (a*x/(b*(b-1)))*(b*(1-c/x)+(c/x)**b-1)+d

Final set of parameters            Asymptotic Standard Error
=======================            ==========================
a               = 0.541131         +/- 0.000367     (0.06783%)
b               = 4.28648          +/- 0.02134      (0.4979%)
c               = 169.011          +/- 0.01311      (0.007759%)
d               = -33.8377         +/- 0.0004612    (0.001363%)

169.011 ^(1/3) = 5.5289 [A]
-33.8377/8 = -4.2297 [eV/atom]
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       131.15112         66.449429         66.449429     1.4742548e-08     2.0579868e-08     -2.717673e-08
2       66.449429         131.15112         66.449429     2.1382209e-09    -2.5330843e-08     8.0667818e-09
3       66.449429         66.449429         131.15112    -1.9349167e-08     1.3569341e-08     6.4589855e-09
4   1.4742548e-08     2.1382209e-09    -1.9349167e-08         48.848321     4.2456877e-08    -1.4108257e-07
5   2.0579868e-08    -2.5330843e-08     1.3569341e-08     4.2456877e-08         48.848321     2.7697325e-09
6   -2.717673e-08     8.0667818e-09     6.4589855e-09    -1.4108257e-07     2.7697325e-09         48.848321
-------------------------------------------------------------
Voigt bulk modulus, BV:       88.016658
Reuss bulk modulus, BR:       88.016658
Hill bulk modulus, B=(BV+BR)/2:       88.016658 [GPa]

Voigt shear modulus, GV:       71.558322
Reuss shear modulus, GR:       64.787114
Hill shear modulus, G=(GV+GR)/2:       68.172718 [GPa]

Pughs modulus ratio, k=G/B:      0.77454337
-------------------------------------------------------------
