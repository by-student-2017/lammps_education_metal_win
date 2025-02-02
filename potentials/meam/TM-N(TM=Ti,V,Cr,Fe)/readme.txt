Usage in lammps input
#-------------------------------------------------------------
pair_style meam
pair_coeff * * ./../../library.meam Ti V Cr Fe N ./../../TiVCrFeN.meam Ti N
#-------------------------------------------------------------

Results [TiN (mp-492: TiN (cubic, Fm-3m, 225))]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 8;
The lattice constant, x (Angstoms) = 4.50643593976471;
The lattice constant, y (Angstoms) = 4.50643593976471;
The lattice constant, z (Angstoms) = 4.50643593976471;
The volume (Angstoms^3) = 91.51654279512;
The total energy (eV) = -50.9147108326446;
The cohesive energy (eV/atom) = 6.36433885408058;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       564.53961         149.10257         149.10257     1.6426136e-09     2.3050923e-09     2.5341841e-09
2       149.10257         564.53961         149.10257    -2.3719614e-09     -2.592287e-09     5.0489586e-10
3       149.10257         149.10257         564.53961    -7.5302657e-10     -2.640015e-09    -1.0292069e-09
4   1.6426136e-09    -2.3719614e-09    -7.5302657e-10         214.76181    -3.0533936e-09     1.4887032e-09
5   2.3050923e-09     -2.592287e-09     -2.640015e-09    -3.0533936e-09         214.76181    -1.2800434e-09
6   2.5341841e-09     5.0489586e-10    -1.0292069e-09     1.4887032e-09    -1.2800434e-09         214.76181
-------------------------------------------------------------
Voigt bulk modulus, BV:       287.58158
Reuss bulk modulus, BR:       287.58158
Hill bulk modulus, B=(BV+BR)/2:       287.58158 [GPa]

Voigt shear modulus, GV:       340.80158
Reuss shear modulus, GR:       381.07852
Hill shear modulus, G=(GV+GR)/2:       360.94005 [GPa]

Pughs modulus ratio, k=G/B:       1.2550875
-------------------------------------------------------------

Reference (S. Ding et al., J. Alloys Compd. 805 (2019) 1081-1089.: https://doi.org/10.1016/j.jallcom.2019.07.114)
-------------------------------------------------------------
TiN (NaCl type)
a 4.24
Ec 6.61
C11 622
C12 121
C44 169
-------------------------------------------------------------



Results [VN NaCl-type]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 8;
The lattice constant, x (Angstoms) = 4.37683075525421;
The lattice constant, y (Angstoms) = 4.37683075525421;
The lattice constant, z (Angstoms) = 4.37683075525421;
The volume (Angstoms^3) = 83.8454037710992;
The total energy (eV) = -53.4763896207499;
The cohesive energy (eV/atom) = 6.68454870259374;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       569.80378          162.1821          162.1821    -2.5625267e-10     5.1396256e-09    -1.2194149e-09
2        162.1821         569.80378          162.1821    -2.5544546e-09     1.6241211e-09    -1.1889449e-10
3        162.1821          162.1821         569.80378    -1.1251105e-09     4.4895137e-09    -2.0304813e-09
4  -2.5625267e-10    -2.5544546e-09    -1.1251105e-09         95.251091    -1.2340697e-10     9.4834183e-10
5   5.1396256e-09     1.6241211e-09     4.4895137e-09    -1.2340697e-10         95.251091     4.4146662e-10
6  -1.2194149e-09    -1.1889449e-10    -2.0304813e-09     9.4834183e-10     4.4146662e-10         95.251091
-------------------------------------------------------------
Voigt bulk modulus, BV:         298.056
Reuss bulk modulus, BR:         298.056
Hill bulk modulus, B=(BV+BR)/2:         298.056 [GPa]

Voigt shear modulus, GV:       195.82564
Reuss shear modulus, GR:       282.69436
Hill shear modulus, G=(GV+GR)/2:          239.26 [GPa]

Pughs modulus ratio, k=G/B:      0.80273507
-------------------------------------------------------------

Reference (S. Ding et al., J. Alloys Compd. 805 (2019) 1081-1089.: https://doi.org/10.1016/j.jallcom.2019.07.114)
-------------------------------------------------------------
VN (NaCl type)
a  4.12
Ec 6.92
C11 588
C12 153
C44 137
-------------------------------------------------------------



Results [CrN NaCl-type]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 8;
The lattice constant, x (Angstoms) = 4.40657624267056;
The lattice constant, y (Angstoms) = 4.40657624267056;
The lattice constant, z (Angstoms) = 4.40657624267056;
The volume (Angstoms^3) = 85.5665193186819;
The total energy (eV) = -40.3831168476938;
The cohesive energy (eV/atom) = 5.04788960596172;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       622879.74         265472.71        -111847.28         444911.78        -360827.95        -189576.33
2       265472.71           46073.4         135773.77         245446.72        -374708.61        -45137.687
3      -111847.28         135773.77         46798.116        -63220.862         48710.233         3502.8459
4       444911.78         245446.72        -63220.862        -4179.5901        -1348.8298         25198.794
5      -360827.95        -374708.61         48710.233        -1348.8298          22113.22         30901.351
6      -189576.33        -45137.687         3502.8459         25198.794         30901.351        -128916.44
-------------------------------------------------------------
Voigt bulk modulus, BV:       143838.85
Reuss bulk modulus, BR:       36995.457
Hill bulk modulus, B=(BV+BR)/2:       90417.153 [GPa]

Voigt shear modulus, GV:      -15969.654
Reuss shear modulus, GR:       222663.41
Hill shear modulus, G=(GV+GR)/2:       103346.88 [GPa]

Pughs modulus ratio, k=G/B:       1.1430008
-------------------------------------------------------------


Reference (S. Ding et al., J. Alloys Compd. 805 (2019) 1081-1089.: https://doi.org/10.1016/j.jallcom.2019.07.114)
-------------------------------------------------------------
CrN (NaCl type)
a  4.148
Ec 5.22
C11 515
C12  62
C44 100
-------------------------------------------------------------



Results [FeN NaCl-type]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 8;
The lattice constant, x (Angstoms) = 4.33433726361915;
The lattice constant, y (Angstoms) = 4.33433726361915;
The lattice constant, z (Angstoms) = 4.33433726361915;
The volume (Angstoms^3) = 81.4269382132049;
The total energy (eV) = -34.9745415270231;
The cohesive energy (eV/atom) = 4.37181769087789;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       453.21508         60.227014         59.942715         0.3862681        -3.2334473         3.9776605
2       60.227014         456.72508         58.168748        -0.2073948         4.5824286       -0.40991928
3       59.942715         58.168748         457.36921        0.36254477        0.50816956        -1.4463573
4       0.3862681        -0.2073948        0.36254477         39.669162         2.6443212       -0.12556048
5      -3.2334473         4.5824286        0.50816956         2.6443212         9.3792873         -14.44492
6       3.9776605       -0.40991928        -1.4463573       -0.12556048         -14.44492         51.215752
-------------------------------------------------------------
Voigt bulk modulus, BV:       191.55404
Reuss bulk modulus, BR:       191.41588
Hill bulk modulus, B=(BV+BR)/2:       191.48496 [GPa]

Voigt shear modulus, GV:       119.37041
Reuss shear modulus, GR:       66.899901
Hill shear modulus, G=(GV+GR)/2:       93.135154 [GPa]

Pughs modulus ratio, k=G/B:      0.48638366
-------------------------------------------------------------


Reference (S. Ding et al., J. Alloys Compd. 805 (2019) 1081-1089.: https://doi.org/10.1016/j.jallcom.2019.07.114)
-------------------------------------------------------------
FeN (NaCl type)
a  4.08
Ec 4.515
C11 360
C12 112
C44  72
-------------------------------------------------------------
