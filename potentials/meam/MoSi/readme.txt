Usage in lammps input
#-------------------------------------------------------------
pair_style meam
pair_coeff * * ./../../library.meam Mo Si ./../../MoSi.meam Mo Si
#-------------------------------------------------------------

Results [MoSi2, mp-2592: Si2Mo (tetragonal, I4/mmm, 139)]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 6;
The lattice constant, x (Angstoms) = 3.76271808534617;
The lattice constant, y (Angstoms) = 3.76271808534617;
The lattice constant, z (Angstoms) = 9.19426385234162;
The volume (Angstoms^3) = 130.172823335696;
The total energy (eV) = -32.9231267714274;
The cohesive energy (eV/atom) = -5.48718779523791;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       294.43741          140.3198         117.70392    -2.8882694e-07    -3.7627833e-08    -1.3232133e-09
2        140.3198         294.43741         117.70392    -2.8389199e-07    -3.6974059e-08     3.4293235e-10
3       117.70392         117.70392         572.41308     -1.011131e-09    -2.1359786e-09      1.222599e-09
4  -2.8882694e-07    -2.8389199e-07     -1.011131e-09         50.312288     1.3340962e-07     2.0739497e-09
5  -3.7627833e-08    -3.6974059e-08    -2.1359786e-09     1.3340962e-07         50.312287     4.5093506e-09
6  -1.3232133e-09     3.4293235e-10      1.222599e-09     2.0739497e-09     4.5093506e-09         113.73892
-------------------------------------------------------------
Voigt bulk modulus, BV:       212.52702
Reuss bulk modulus, BR:       199.45773
Hill bulk modulus, B=(BV+BR)/2:       205.99238 [GPa]

Voigt shear modulus, GV:       138.11608
Reuss shear modulus, GR:       161.92213
Hill shear modulus, G=(GV+GR)/2:       150.01911 [GPa]

Pughs modulus ratio, k=G/B:      0.72827504
-------------------------------------------------------------

Reference (M. I. Baskes, Mater. Sci. Eng. A261 (1999) 165-168.: https://doi.org/10.1016/S0921-5093(98)01062-4)
-------------------------------------------------------------
MoSi2 (Crystal structure: C11b)
a  3.59 [A]
c  8.42 [A]
-------------
B   210 [GPa]
C11 252 [GPa]
C12 145 [GPa]
C13 148 [GPa]
C33 510 [GPa]
C44  26 [GPa]
C66 133 [GPa]
G    75 [GPa]
-------------------------------------------------------------



Results [Mo3Si, mp-1275: SiMo3 (cubic, Pm-3n, 223)]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 8;
The lattice constant, x (Angstoms) = 5.51682852046125;
The lattice constant, y (Angstoms) = 5.51682852046125;
The lattice constant, z (Angstoms) = 5.51682852046125;
The volume (Angstoms^3) = 167.906865782845;
The total energy (eV) = -48.7282620714691;
The cohesive energy (eV/atom) = -6.09103275893363;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       758.05244         8.4143055         8.4142995    -3.1604328e-07     2.8494421e-07     3.8685761e-07
2       8.4143055         758.05244         8.4142976      2.700045e-07    -2.7151016e-07    -2.6409916e-07
3       8.4142995         8.4142976         758.05245      3.858072e-08    -7.8094216e-08    -1.1199342e-07
4  -3.1604328e-07      2.700045e-07      3.858072e-08         719.83648    -5.6413846e-07    -4.2255267e-06
5   2.8494421e-07    -2.7151016e-07    -7.8094216e-08    -5.6413846e-07         719.83648     3.6845862e-06
6   3.8685761e-07    -2.6409916e-07    -1.1199342e-07    -4.2255267e-06     3.6845862e-06         719.83649
-------------------------------------------------------------
Voigt bulk modulus, BV:       258.29368
Reuss bulk modulus, BR:       258.29368
Hill bulk modulus, B=(BV+BR)/2:       258.29368 [GPa]

Voigt shear modulus, GV:       1013.7314
Reuss shear modulus, GR:       783.96803
Hill shear modulus, G=(GV+GR)/2:       898.84972 [GPa]

Pughs modulus ratio, k=G/B:       3.4799524
-------------------------------------------------------------

Reference (M. I. Baskes, Mater. Sci. Eng. A261 (1999) 165-168.: https://doi.org/10.1016/S0921-5093(98)01062-4)
-------------------------------------------------------------
Mo3Si (Crystal structure: A15)
a  5.20 [A]
-------------
B   256 [GPa]
C11 641 [GPa]
C12  63 [GPa]
C44 404 [GPa]
G   358 [GPa]
-------------------------------------------------------------



Results [Mo5Si3, mp-1332: Si3Mo5 (tetragonal, I4/mcm, 140)]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 32;
The lattice constant, x (Angstoms) = 11.0382745727618;
The lattice constant, y (Angstoms) = 11.0382745727618;
The lattice constant, z (Angstoms) = 5.62131510139957;
The volume (Angstoms^3) = 684.920737720149;
The total energy (eV) = -187.099757856846;
The cohesive energy (eV/atom) = -5.84686743302644;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       300.49451         193.46431         170.28439    -1.5815244e-08    -3.7328834e-07    -3.1409481e-08
2       193.46431         300.49451         170.28439    -3.2884305e-08     2.4358072e-07    -2.2704642e-08
3       170.28439         170.28439         340.15369    -1.6709494e-07    -2.2217947e-07     5.5620973e-08
4  -1.5815244e-08    -3.2884305e-08    -1.6709494e-07         27.161331     7.3013959e-09      2.537637e-07
5  -3.7328834e-07     2.4358072e-07    -2.2217947e-07     7.3013959e-09         27.161332     2.6743673e-07
6  -3.1409481e-08    -2.2704642e-08     5.5620973e-08      2.537637e-07     2.6743673e-07         61.217829
-------------------------------------------------------------
Voigt bulk modulus, BV:       223.24543
Reuss bulk modulus, BR:       223.12305
Hill bulk modulus, B=(BV+BR)/2:       223.18424 [GPa]

Voigt shear modulus, GV:       73.356838
Reuss shear modulus, GR:        93.71632
Hill shear modulus, G=(GV+GR)/2:       83.536579 [GPa]

Pughs modulus ratio, k=G/B:      0.37429425
-------------------------------------------------------------

Reference (M. I. Baskes, Mater. Sci. Eng. A261 (1999) 165-168.: https://doi.org/10.1016/S0921-5093(98)01062-4)
-------------------------------------------------------------
Mo5Si3 (Crystal structure: D8m)
a 10.64 [A]
c  5.08 [A]
-------------
B   213 [GPa]
C11 326 [GPa]
C12 141 [GPa]
C13 134 [GPa]
C33 448 [GPa]
C44 110 [GPa]
C66 153 [GPa]
G   121 [GPa]
-------------------------------------------------------------