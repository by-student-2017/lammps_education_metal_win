Usage in lammps input
#-------------------------------------------------------------
pair_style meam
pair_coeff * * ./../../library.meam Co Al W ./../../CoAlW.meam Co Al
#-------------------------------------------------------------

Results [CoAl, B2 = CsCl-type]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 2;
The lattice constant, x (Angstoms) = 3.15369330247794;
The lattice constant, y (Angstoms) = 3.15369330247794;
The lattice constant, z (Angstoms) = 3.15369330247794;
The volume (Angstoms^3) = 31.3659443344566;
The total energy (eV) = -6.91190025564663;
The cohesive energy (eV/atom) = 3.45595012782331;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1        237.6226         143.01902         143.01902     8.6303403e-10     8.4604055e-10     2.3207909e-09
2       143.01902          237.6226         143.01902    -1.3848959e-09    -1.8509338e-09     8.7816672e-10
3       143.01902         143.01902          237.6226    -6.0221279e-10     1.9273085e-11     3.3689641e-09
4   8.6303403e-10    -1.3848959e-09    -6.0221279e-10          128.5338    -7.5456203e-10     6.6732866e-10
5   8.4604055e-10    -1.8509338e-09     1.9273085e-11    -7.5456203e-10          128.5338    -1.2375902e-09
6   2.3207909e-09     8.7816672e-10     3.3689641e-09     6.6732866e-10    -1.2375902e-09          128.5338
-------------------------------------------------------------
Voigt bulk modulus, BV:       174.55354
Reuss bulk modulus, BR:       174.55354
Hill bulk modulus, B=(BV+BR)/2:       174.55354 [GPa]

Voigt shear modulus, GV:       173.16127
Reuss shear modulus, GR:       103.91394
Hill shear modulus, G=(GV+GR)/2:       138.53761 [GPa]

Pughs modulus ratio, k=G/B:      0.79366825
-------------------------------------------------------------

-------------------------------------------------------------
# W.-P. Dong et al., CALPHAD 38 (2012) 7-16.

Phase     | C11   | C12   | C44   | B   |
B2-CoAl   | 265.9 | 109.9 | 139.1 | 162 |
L12-Co3Al | 313   | 144   | 142   | 200 |
L12-CoAl3 | 182   |  85   |  69   | 117 |

B2-CoAl, 2.86 [A]
-------------------------------------------------------------



Results [Al12W, mp-11227: Al12W (cubic, Im-3, 204)]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 26;
The lattice constant, x (Angstoms) = 7.99107695106126;
The lattice constant, y (Angstoms) = 7.99107695106126;
The lattice constant, z (Angstoms) = 7.99107695106126;
The volume (Angstoms^3) = 510.288684792558;
The total energy (eV) = -101.766817312063;
The cohesive energy (eV/atom) = 3.91410835815627;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       129.66043         59.799337         59.799337     1.1181147e-06    -6.9679943e-08     6.4048953e-08
2       59.799337         129.66043         59.799337     1.2152085e-06    -7.1216885e-08     6.5890845e-08
3       59.799337         59.799337         129.66043     1.2880708e-06    -6.8741586e-08     6.4436618e-08
4   1.1181147e-06     1.2152085e-06     1.2880708e-06         37.333194     6.8248399e-08    -8.2702334e-08
5  -6.9679943e-08    -7.1216885e-08    -6.8741586e-08     6.8248399e-08         37.333194    -3.4413029e-10
6   6.4048953e-08     6.5890845e-08     6.4436618e-08    -8.2702334e-08    -3.4413029e-10         37.333194
-------------------------------------------------------------
Voigt bulk modulus, BV:       83.086369
Reuss bulk modulus, BR:       83.086369
Hill bulk modulus, B=(BV+BR)/2:       83.086369 [GPa]

Voigt shear modulus, GV:       58.772052
Reuss shear modulus, GR:       64.644723
Hill shear modulus, G=(GV+GR)/2:       61.708388 [GPa]

Pughs modulus ratio, k=G/B:       0.7427017
-------------------------------------------------------------

-------------------------------------------------------------
# W.-P. Dong et al., Trans. Nonferrous Met. Soc. China 25 (2015) 907-914.

Phase     | C11   | C12   | C44   | B   |
Al12W     | 131   | 72    | 47    | 92  |
-------------------------------------------------------------



Results [Co3Al0.5W0.5, https://www.osti.gov/servlets/purl/957714]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 32;
The lattice constant, x (Angstoms) = 7.72865128967282;
The lattice constant, y (Angstoms) = 7.72865128967282;
The lattice constant, z (Angstoms) = 7.72865128967282;
The volume (Angstoms^3) = 461.648191120683;
The total energy (eV) = -137.36564804327;
The cohesive energy (eV/atom) = 4.29267650135218;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       298.13295         148.87393         148.87393     1.1587262e-09     -4.591179e-10    -1.3737176e-09
2       148.87393         298.13295         148.87393     6.2363157e-10    -7.8609427e-10    -1.2803649e-09
3       148.87393         148.87393         298.13295     2.4252202e-10    -3.1740498e-10    -1.7346184e-09
4   1.1587262e-09     6.2363157e-10     2.4252202e-10         94.461374    -5.3581646e-10     3.6571217e-10
5   -4.591179e-10    -7.8609427e-10    -3.1740498e-10    -5.3581646e-10         94.461374     -4.159976e-09
6  -1.3737176e-09    -1.2803649e-09    -1.7346184e-09     3.6571217e-10     -4.159976e-09         94.461374
-------------------------------------------------------------
Voigt bulk modulus, BV:       198.62694
Reuss bulk modulus, BR:       198.62694
Hill bulk modulus, B=(BV+BR)/2:       198.62694 [GPa]

Voigt shear modulus, GV:       143.20545
Reuss shear modulus, GR:       143.93127
Hill shear modulus, G=(GV+GR)/2:       143.56836 [GPa]

Pughs modulus ratio, k=G/B:      0.72280409
-------------------------------------------------------------

-------------------------------------------------------------
# W.-P. Dong et al., J. Nanosci. Adv. Tech. 1(4): 10-16.: https://doi.org/10.24218/jnat.2016.17

Phase            | C11 | C12 | C44 | B   | 
Co3Al0.5W0.5     | 328 | 147 | 147 | 207 | The above paper
Co0.79Al0.1W0.11 | 271 | 172 | 162 | 205 | Exp.
Co3Al0.5W0.5     | 363 | 190 | 212 | 248 | FP cal.
Co3Al0.5W0.5     | 264 | 162 | 153 | 196 | FP cal.
Co3Al0.5W0.5     | 301 | 169 | 172 | 213 | FP cal.

Co3Al0.5W0.5 (Co3(Al,W) L12 structure), 3.648 [A], The above paper
-------------------------------------------------------------