Note: please use "VNbTaTiZr_HEA_Nitol2024"

Usage in lammps input
#-------------------------------------------------------------
pair_style meam
pair_coeff * * ./../../library.meam V Nb Ta Ti Zr ./../../VNbTaTiZr.meam V Nb
#-------------------------------------------------------------

Results [VNb, B2 = CsCl-type]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 2;
The lattice constant, x (Angstoms) = 3.36459916329106;
The lattice constant, y (Angstoms) = 3.36459916329106;
The lattice constant, z (Angstoms) = 3.36459916329106;
The volume (Angstoms^3) = 38.0890374541692;
The total energy (eV) = -12.7145754423625;
The cohesive energy (eV/atom) = 6.35728772118123;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       196.05372         164.69083          138.9826    -4.8413585e-08    -6.9439922e-09    -1.6523852e-08
2       164.69083         173.20295         164.69083     8.1775353e-08       9.81804e-09     3.2726162e-08
3        138.9826         164.69083         196.05372    -4.8051651e-08    -4.3678747e-09    -1.9836207e-08
4  -4.8413585e-08     8.1775353e-08    -4.8051651e-08         15.561251     -8.677749e-10     6.9804876e-10
5  -6.9439922e-09       9.81804e-09    -4.3678747e-09     -8.677749e-10         13.969021     6.8573032e-10
6  -1.6523852e-08     3.2726162e-08    -1.9836207e-08     6.9804876e-10     6.8573032e-10         15.318997
-------------------------------------------------------------
Voigt bulk modulus, BV:       166.89321
Reuss bulk modulus, BR:        166.8132
Hill bulk modulus, B=(BV+BR)/2:       166.85321 [GPa]

Voigt shear modulus, GV:       24.402784
Reuss shear modulus, GR:        14.28507
Hill shear modulus, G=(GV+GR)/2:       19.343927 [GPa]

Pughs modulus ratio, k=G/B:       0.1159338
-------------------------------------------------------------

Reference (https://www.osti.gov/servlets/purl/2007348)
-------------------------------------------------------------
VNb, B2 = CsCl-type
C11 195.02 [GPa]
C12 154.85 [GPa]
C44   9.41 [GPa]
-------------------------------------------------------------



Results [VTa, B2 = CsCl-type]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 2;
The lattice constant, x (Angstoms) = 3.36110800527096;
The lattice constant, y (Angstoms) = 3.36110800527096;
The lattice constant, z (Angstoms) = 3.36110800527096;
The volume (Angstoms^3) = 37.9705951852524;
The total energy (eV) = -15.0724856867249;
The cohesive energy (eV/atom) = 7.53624284336243;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1        249.1083         140.27153         140.27153     3.8722755e-10    -1.7321002e-09     1.5781531e-09
2       140.27153          249.1083         140.27153     -1.239565e-09    -1.0494253e-09     1.2071047e-09
3       140.27153         140.27153          249.1083    -1.3664467e-09    -7.8103581e-10     2.1293386e-10
4   3.8722755e-10     -1.239565e-09    -1.3664467e-09         72.752664    -4.9911685e-10    -9.7798155e-10
5  -1.7321002e-09    -1.0494253e-09    -7.8103581e-10    -4.9911685e-10         72.752664     6.8256624e-10
6   1.5781531e-09     1.2071047e-09     2.1293386e-10    -9.7798155e-10     6.8256624e-10         72.752664
-------------------------------------------------------------
Voigt bulk modulus, BV:       176.55046
Reuss bulk modulus, BR:       176.55046
Hill bulk modulus, B=(BV+BR)/2:       176.55046 [GPa]

Voigt shear modulus, GV:       109.07055
Reuss shear modulus, GR:       106.24467
Hill shear modulus, G=(GV+GR)/2:       107.65761 [GPa]

Pughs modulus ratio, k=G/B:      0.60978381
-------------------------------------------------------------

Reference (https://www.osti.gov/servlets/purl/2007348)
-------------------------------------------------------------
VTa, B2 = CsCl-type
C11 247.42 [GPa]
C12 140.40 [GPa]
C44  73.29 [GPa]
-------------------------------------------------------------



Results [VTi, B2 = CsCl-type]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 2;
The lattice constant, x (Angstoms) = 3.31204073494087;
The lattice constant, y (Angstoms) = 3.31204073494087;
The lattice constant, z (Angstoms) = 3.31204073494087;
The volume (Angstoms^3) = 36.331807851225;
The total energy (eV) = -11.0048122248073;
The cohesive energy (eV/atom) = 5.50240611240366;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1        158.3199         113.75602         113.75602    -1.1856054e-09    -5.8709404e-11     -4.664063e-10
2       113.75602          158.3199         113.75602    -3.4896581e-10     1.2457481e-10    -3.2253476e-10
3       113.75602         113.75602          158.3199      -2.10192e-11    -5.2791395e-10     3.8364058e-10
4  -1.1856054e-09    -3.4896581e-10      -2.10192e-11         63.256497    -8.1048064e-10    -5.6560058e-11
5  -5.8709404e-11     1.2457481e-10    -5.2791395e-10    -8.1048064e-10         63.256497     5.5867582e-10
6   -4.664063e-10    -3.2253476e-10     3.8364058e-10    -5.6560058e-11     5.5867582e-10         63.256497
-------------------------------------------------------------
Voigt bulk modulus, BV:       128.61065
Reuss bulk modulus, BR:       128.61065
Hill bulk modulus, B=(BV+BR)/2:       128.61065 [GPa]

Voigt shear modulus, GV:       84.820574
Reuss shear modulus, GR:       49.205202
Hill shear modulus, G=(GV+GR)/2:       67.012888 [GPa]

Pughs modulus ratio, k=G/B:      0.52105242
-------------------------------------------------------------

Reference (https://www.osti.gov/servlets/purl/2007348)
-------------------------------------------------------------
VTi, B2 = CsCl-type
C11 157.12 [GPa]
C12 113.91 [GPa]
C44  62.87 [GPa]
-------------------------------------------------------------



Results [VZr, B2 = CsCl-type]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 2;
The lattice constant, x (Angstoms) = 3.49843076318658;
The lattice constant, y (Angstoms) = 3.49843076318658;
The lattice constant, z (Angstoms) = 3.49843076318658;
The volume (Angstoms^3) = 42.8173563995363;
The total energy (eV) = -11.508212294004;
The cohesive energy (eV/atom) = 5.75410614700199;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       147.23617         105.59132         105.59132    -4.2248538e-10     1.5131664e-09     2.2568913e-09
2       105.59132         147.23617         105.59132    -5.8895878e-10     1.5850386e-09    -4.7501807e-11
3       105.59132         105.59132         147.23617    -7.1654613e-10     1.6154489e-09     1.4283057e-09
4  -4.2248538e-10    -5.8895878e-10    -7.1654613e-10         18.285259     1.6240462e-09    -1.0252577e-09
5   1.5131664e-09     1.5850386e-09     1.6154489e-09     1.6240462e-09         18.285259    -3.1466573e-10
6   2.2568913e-09    -4.7501807e-11     1.4283057e-09    -1.0252577e-09    -3.1466573e-10         18.285259
-------------------------------------------------------------
Voigt bulk modulus, BV:       119.47294
Reuss bulk modulus, BR:       119.47294
Hill bulk modulus, B=(BV+BR)/2:       119.47294 [GPa]

Voigt shear modulus, GV:       30.271281
Reuss shear modulus, GR:       36.478528
Hill shear modulus, G=(GV+GR)/2:       33.374904 [GPa]

Pughs modulus ratio, k=G/B:      0.27935116
-------------------------------------------------------------

Reference (https://www.osti.gov/servlets/purl/2007348)
-------------------------------------------------------------
VZr, B2 = CsCl-type
C11 149.49 [GPa]
C12 107.74 [GPa]
C44  20.52 [GPa]
-------------------------------------------------------------



Results [NbTa, B2 = CsCl-type]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 2;
The lattice constant, x (Angstoms) = 3.51984879771775;
The lattice constant, y (Angstoms) = 3.51984879771775;
The lattice constant, z (Angstoms) = 3.51984879771775;
The volume (Angstoms^3) = 43.6085878711466;
The total energy (eV) = -14.982764208778;
The cohesive energy (eV/atom) = 7.49138210438899;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       262.06002         147.67101         147.67101     6.3179722e-10     1.9133693e-09     2.2515315e-09
2       147.67101         262.06002         147.67101     1.1311959e-09     2.6603552e-09    -2.3195875e-11
3       147.67101         147.67101         262.06002     8.0283013e-10     2.0555846e-09      3.675839e-09
4   6.3179722e-10     1.1311959e-09     8.0283013e-10         52.836435     1.1471869e-09    -9.2261624e-10
5   1.9133693e-09     2.6603552e-09     2.0555846e-09     1.1471869e-09         52.836435     1.1298489e-10
6   2.2515315e-09    -2.3195875e-11      3.675839e-09    -9.2261624e-10     1.1298489e-10         52.836435
-------------------------------------------------------------
Voigt bulk modulus, BV:       185.80068
Reuss bulk modulus, BR:       185.80068
Hill bulk modulus, B=(BV+BR)/2:       185.80068 [GPa]

Voigt shear modulus, GV:       86.281524
Reuss shear modulus, GR:        101.7022
Hill shear modulus, G=(GV+GR)/2:       93.991862 [GPa]

Pughs modulus ratio, k=G/B:      0.50587469
-------------------------------------------------------------

Reference (https://www.osti.gov/servlets/purl/2007348)
-------------------------------------------------------------
NbTa, B2 = CsCl-type
C11 261.52 [GPa]
C12 147.26 [GPa]
C44  51.22 [GPa]
-------------------------------------------------------------



Results [NbTi, B2 = CsCl-type]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 2;
The lattice constant, x (Angstoms) = 3.46574017051848;
The lattice constant, y (Angstoms) = 3.46574017051848;
The lattice constant, z (Angstoms) = 3.46574017051848;
The volume (Angstoms^3) = 41.628235281681;
The total energy (eV) = -11.8855883757561;
The cohesive energy (eV/atom) = 5.94279418787805;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       156.41193         112.59963         112.59963    -1.2294546e-09     -1.329917e-10     1.1173465e-10
2       112.59963         156.41193         112.59963     -9.947437e-10     9.4418522e-11     2.0120405e-10
3       112.59963         112.59963         156.41193    -5.7497885e-10     4.3307413e-10    -5.9193178e-10
4  -1.2294546e-09     -9.947437e-10    -5.7497885e-10         28.465088       2.13896e-10     1.4199814e-10
5   -1.329917e-10     9.4418522e-11     4.3307413e-10       2.13896e-10         28.465088     3.9430753e-11
6   1.1173465e-10     2.0120405e-10    -5.9193178e-10     1.4199814e-10     3.9430753e-11         28.465088
-------------------------------------------------------------
Voigt bulk modulus, BV:       127.20373
Reuss bulk modulus, BR:       127.20373
Hill bulk modulus, B=(BV+BR)/2:       127.20373 [GPa]

Voigt shear modulus, GV:       42.920567
Reuss shear modulus, GR:       42.500161
Hill shear modulus, G=(GV+GR)/2:       42.710364 [GPa]

Pughs modulus ratio, k=G/B:      0.33576346
-------------------------------------------------------------

Reference (https://www.osti.gov/servlets/purl/2007348)
-------------------------------------------------------------
NbTi, B2 = CsCl-type
C11 154.78 [GPa]
C12 112.93 [GPa]
C44  28.97 [GPa]
-------------------------------------------------------------



Results [NbZr, B2 = CsCl-type]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 2;
The lattice constant, x (Angstoms) = 3.55195040961069;
The lattice constant, y (Angstoms) = 3.55195040961069;
The lattice constant, z (Angstoms) = 3.55195040961069;
The volume (Angstoms^3) = 44.8126556324155;
The total energy (eV) = -11.832161208783;
The cohesive energy (eV/atom) = 5.91608060439149;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       281.72421         95.876214         86.632478         1.9427444        -17.169573        -3.0572911
2       95.876214         201.68965         99.367507         7.2321757         23.201881         3.6489491
3       86.632478         99.367507         278.68265        -6.5788273         2.7036422        0.14476549
4       1.9427444         7.2321757        -6.5788273         76.062806         2.2477207         5.0972211
5      -17.169573         23.201881         2.7036422         2.2477207         124.55433         2.6822939
6      -3.0572911         3.6489491        0.14476549         5.0972211         2.6822939         101.56969
-------------------------------------------------------------
Voigt bulk modulus, BV:       147.31654
Reuss bulk modulus, BR:        144.2384
Hill bulk modulus, B=(BV+BR)/2:       145.77747 [GPa]

Voigt shear modulus, GV:       152.88942
Reuss shear modulus, GR:       141.79533
Hill shear modulus, G=(GV+GR)/2:       147.34237 [GPa]

Pughs modulus ratio, k=G/B:       1.0107349
-------------------------------------------------------------

Reference (https://www.osti.gov/servlets/purl/2007348)
-------------------------------------------------------------
NbZr, B2 = CsCl-type
C11 149.70 [GPa]
C12  99.38 [GPa]
C44  34.86 [GPa]
-------------------------------------------------------------



Results [TaTi, B2 = CsCl-type]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 2;
The lattice constant, x (Angstoms) = 3.46802409426734;
The lattice constant, y (Angstoms) = 3.46802409426734;
The lattice constant, z (Angstoms) = 3.46802409426734;
The volume (Angstoms^3) = 41.7105885850345;
The total energy (eV) = -12.8066762199232;
The cohesive energy (eV/atom) = 6.4033381099616;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       164.24553         132.82139         132.82139    -4.6203603e-10     2.6863663e-09    -2.1744135e-09
2       132.82139         164.24553         132.82139    -1.0122919e-09     2.9035651e-09    -1.5435997e-09
3       132.82139         132.82139         164.24553     2.0763585e-10     3.8920935e-09    -1.9311193e-09
4  -4.6203603e-10    -1.0122919e-09     2.0763585e-10         57.663241     5.7440173e-10     3.6254833e-10
5   2.6863663e-09     2.9035651e-09     3.8920935e-09     5.7440173e-10         57.663241     6.2173419e-10
6  -2.1744135e-09    -1.5435997e-09    -1.9311193e-09     3.6254833e-10     6.2173419e-10         57.663241
-------------------------------------------------------------
Voigt bulk modulus, BV:        143.2961
Reuss bulk modulus, BR:        143.2961
Hill bulk modulus, B=(BV+BR)/2:        143.2961 [GPa]

Voigt shear modulus, GV:       75.480716
Reuss shear modulus, GR:       35.638619
Hill shear modulus, G=(GV+GR)/2:       55.559668 [GPa]

Pughs modulus ratio, k=G/B:       0.3877263
-------------------------------------------------------------

Reference (https://www.osti.gov/servlets/purl/2007348)
-------------------------------------------------------------
TaTi, B2 = CsCl-type
C11 159.24 [GPa]
C12 128.34 [GPa]
C44  53.38 [GPa]
-------------------------------------------------------------



Results [TaZr, B2 = CsCl-type]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 2;
The lattice constant, x (Angstoms) = 3.6555116253216;
The lattice constant, y (Angstoms) = 3.6555116253216;
The lattice constant, z (Angstoms) = 3.6555116253216;
The volume (Angstoms^3) = 48.8477436917233;
The total energy (eV) = -12.3715232550166;
The cohesive energy (eV/atom) = 6.1857616275083;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1        150.5282         107.97805         107.97805    -6.9073704e-10    -1.3142876e-09     -4.547705e-11
2       107.97805          150.5282         107.97805     1.4957372e-11    -1.7281282e-09    -1.9270927e-10
3       107.97805         107.97805          150.5282     8.6307821e-10    -1.6894735e-09     1.0419929e-09
4  -6.9073704e-10     1.4957372e-11     8.6307821e-10         59.903246    -7.4818659e-10    -4.8640922e-10
5  -1.3142876e-09    -1.7281282e-09    -1.6894735e-09    -7.4818659e-10         59.903246    -5.1161701e-12
6   -4.547705e-11    -1.9270927e-10     1.0419929e-09    -4.8640922e-10    -5.1161701e-12         59.903246
-------------------------------------------------------------
Voigt bulk modulus, BV:       122.16143
Reuss bulk modulus, BR:       122.16143
Hill bulk modulus, B=(BV+BR)/2:       122.16143 [GPa]

Voigt shear modulus, GV:       80.393925
Reuss shear modulus, GR:       46.936493
Hill shear modulus, G=(GV+GR)/2:       63.665209 [GPa]

Pughs modulus ratio, k=G/B:      0.52115638
-------------------------------------------------------------

Reference (https://www.osti.gov/servlets/purl/2007348)
-------------------------------------------------------------
TaZr, B2 = CsCl-type
C11 149.30 [GPa]
C12 111.22 [GPa]
C44  53.85 [GPa]
-------------------------------------------------------------



Results [TiZr, B2 = CsCl-type]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 2;
The lattice constant, x (Angstoms) = 3.6309779889813;
The lattice constant, y (Angstoms) = 3.6309779889813;
The lattice constant, z (Angstoms) = 3.6309779889813;
The volume (Angstoms^3) = 47.8708180058345;
The total energy (eV) = -10.8110655365165;
The cohesive energy (eV/atom) = 5.40553276825823;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       116.84328          85.41553          85.41553     4.9188988e-10     3.3028961e-10    -1.7270612e-09
2        85.41553         116.84328          85.41553     8.4225807e-10     4.8930461e-10    -1.6596972e-09
3        85.41553          85.41553         116.84328    -2.0765782e-10     7.8633197e-10    -1.1395511e-09
4   4.9188988e-10     8.4225807e-10    -2.0765782e-10         59.481564    -1.1434023e-10    -4.9138572e-11
5   3.3028961e-10     4.8930461e-10     7.8633197e-10    -1.1434023e-10         59.481564    -2.6501833e-10
6  -1.7270612e-09    -1.6596972e-09    -1.1395511e-09    -4.9138572e-11    -2.6501833e-10         59.481564
-------------------------------------------------------------
Voigt bulk modulus, BV:       95.891445
Reuss bulk modulus, BR:       95.891445
Hill bulk modulus, B=(BV+BR)/2:       95.891445 [GPa]

Voigt shear modulus, GV:       77.663426
Reuss shear modulus, GR:       35.743641
Hill shear modulus, G=(GV+GR)/2:       56.703534 [GPa]

Pughs modulus ratio, k=G/B:      0.59133047
-------------------------------------------------------------

Reference (https://www.osti.gov/servlets/purl/2007348)
-------------------------------------------------------------
TiZr, B2 = CsCl-type
C11 115.64 [GPa]
C12  85.53[GPa]
C44  59.74 [GPa]
-------------------------------------------------------------



Results [VTiZr, Fmm2]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 12;
The lattice constant, x (Angstoms) = 3.55439438093788;
The lattice constant, y (Angstoms) = 4.82847117211316;
The lattice constant, z (Angstoms) = 14.9113128048775;
The volume (Angstoms^3) = 255.912286607028;
The total energy (eV) = -64.7641679271938;
The cohesive energy (eV/atom) = 5.39701399393281;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       234.71747         56.990956         51.536045     2.2733281e-08     2.5428387e-08     5.5054398e-10
2       56.990956         134.71475         49.653598    -3.8351147e-08    -4.4404399e-09    -1.4593308e-08
3       51.536045         49.653598         214.87331     3.2593308e-07     -9.660488e-08    -6.4372529e-08
4   2.2733281e-08    -3.8351147e-08     3.2593308e-07         21.791678    -1.0843022e-08    -5.6549909e-09
5   2.5428387e-08    -4.4404399e-09     -9.660488e-08    -1.0843022e-08         47.000424     7.6709369e-10
6   5.5054398e-10    -1.4593308e-08    -6.4372529e-08    -5.6549909e-09     7.6709369e-10         248.93356
-------------------------------------------------------------
Voigt bulk modulus, BV:       100.07408
Reuss bulk modulus, BR:       94.649739
Hill bulk modulus, B=(BV+BR)/2:       97.361909 [GPa]

Voigt shear modulus, GV:       155.49859
Reuss shear modulus, GR:       103.29647
Hill shear modulus, G=(GV+GR)/2:       129.39753 [GPa]

Pughs modulus ratio, k=G/B:       1.3290365
-------------------------------------------------------------

Reference (https://www.osti.gov/servlets/purl/2007348)
-------------------------------------------------------------
NbTiZr, mp-1215185, Fmm2
C11 181.39 [GPa]
C12  61.36 [GPa]
C13  95.11 [GPa]
C22 181.38 [GPa]
C23  95.10 [GPa]
C33 134.75 [GPa]
C44  63.44 [GPa]
C55  63.45 [GPa]
-------------------------------------------------------------



Results [NbTiZr, mp-1215185, Fmm2]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 12;
The lattice constant, x (Angstoms) = 3.66125286097431;
The lattice constant, y (Angstoms) = 4.97363319834154;
The lattice constant, z (Angstoms) = 15.3596030200046;
The volume (Angstoms^3) = 279.694205114598;
The total energy (eV) = -69.2815844532434;
The cohesive energy (eV/atom) = 5.77346537110361;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       218.33015         84.251284         29.999799     1.6986354e-07    -1.9292478e-07     1.4984598e-07
2       84.251284         174.13838         47.003201     7.7706496e-09    -1.7056879e-08     1.3018029e-08
3       29.999799         47.003201           228.091    -1.5745145e-07      1.726014e-07    -1.3007086e-07
4   1.6986354e-07     7.7706496e-09    -1.5745145e-07          9.146951     5.6467158e-09     4.1346871e-10
5  -1.9292478e-07    -1.7056879e-08      1.726014e-07     5.6467158e-09         48.881535     1.1996917e-10
6   1.4984598e-07     1.3018029e-08    -1.3007086e-07     4.1346871e-10     1.1996917e-10         50.492581
-------------------------------------------------------------
Voigt bulk modulus, BV:       104.78534
Reuss bulk modulus, BR:       104.38595
Hill bulk modulus, B=(BV+BR)/2:       104.58565 [GPa]

Voigt shear modulus, GV:       74.028777
Reuss shear modulus, GR:        75.42559
Hill shear modulus, G=(GV+GR)/2:       74.727183 [GPa]

Pughs modulus ratio, k=G/B:      0.71450707
Pughs modulus ratio, k=G/B:      0.71450707
-------------------------------------------------------------

Reference (https://www.osti.gov/servlets/purl/2007348)
-------------------------------------------------------------
NbTiZr, mp-1215185, Fmm2
C11 155.20 [GPa]
C12  94.73 [GPa]
C13  85.62 [GPa]
C22 182.18 [GPa]
C23  58.87 [GPa]
C33 166.17 [GPa]
C44  13.20 [GPa]
C55  53.46 [GPa]
-------------------------------------------------------------


check screening atom
--------------------------------------------------------------------------------------------------------------
check screening j atom version is bad results
VNbTaTiZr_screening_B_atom.meam

Usage in lammps input
#-------------------------------------------------------------
pair_style meam
pair_coeff * * ./../../library.meam V Nb Ta Ti Zr ./../../VNbTaTiZr_screening_B_atom.meam V Ti Zr
#-------------------------------------------------------------

Results [VTiZr, Fmm2]
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       296.97701         100.94912        -46.401455    -3.6590802e-08    -1.9510823e-08     1.4065881e-08
2       100.94912         225.64382         49.209062     1.1327084e-09     -5.772704e-10     4.1561683e-10
3      -46.401455         49.209062         396.06649     6.4634966e-09     2.7825535e-09    -1.1659795e-08
4  -3.6590802e-08     1.1327084e-09     6.4634966e-09         28.139746     -7.701568e-09    -1.0321846e-09
5  -1.9510823e-08     -5.772704e-10     2.7825535e-09     -7.701568e-09         80.589456    -9.1712795e-11
6   1.4065881e-08     4.1561683e-10    -1.1659795e-08    -1.0321846e-09    -9.1712795e-11         84.982885
-------------------------------------------------------------
From these results, it is assumed that the screening atom is probably C.
Therefore, C(A-B-C) = C(i,j,k) = C(i-k-j), and it is highly likely that the k atom is the one being screened.
--------------------------------------------------------------------------------------------------------------
