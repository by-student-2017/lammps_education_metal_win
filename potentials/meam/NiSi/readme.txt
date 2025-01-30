Usage in lammps input
#-------------------------------------------------------------
# 1NN-MEAM
pair_style meam
pair_coeff * * ./../../library.meam Ni Si ./../../NiSi.meam Ni Si
#-------------------------------------------------------------

Results [NiSi2, mp-2291]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 12;
The lattice constant, x (Angstoms) = 5.83988689369825;
The lattice constant, y (Angstoms) = 5.83988689369825;
The lattice constant, z (Angstoms) = 5.83988689369825;
The volume (Angstoms^3) = 199.165131549278;
The total energy (eV) = -43.5824649489771;
The cohesive energy (eV/atom) = -3.63187207908143;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1        479.5893         66.742719         74.782847         1.0440738         1.3965296         32.906999
2       66.742719         425.71858         132.73075        -36.040331         10.048133          13.34629
3       74.782847         132.73075         420.42662        -37.789675        -29.198195        -43.867623
4       1.0440738        -36.040331        -37.789675         712.46578         46.049668         14.887992
5       1.3965296         10.048133        -29.198195         46.049668         513.70051         33.938643
6       32.906999          13.34629        -43.867623         14.887992         33.938643         619.56813
-------------------------------------------------------------
Voigt bulk modulus, BV:       208.24968
Reuss bulk modulus, BR:       207.38103
Hill bulk modulus, B=(BV+BR)/2:       207.81536 [GPa]

Voigt shear modulus, GV:       808.39232
Reuss shear modulus, GR:       379.73304
Hill shear modulus, G=(GV+GR)/2:       594.06268 [GPa]

Pughs modulus ratio, k=G/B:       2.8586082
-------------------------------------------------------------

Reference (# M. I. Baskes et al 1994 Modelling Simul. Mater. Sci. Eng. 2 505.: DOI 10.1088/0965-0393/2/3A/006)
-------------------------------------------------------------
NiSi2
a   5.404 [A]
                MP: Bv = 150
C11 251   [GPa] MP: 160
C12 209   [GPa] MP: 145
C44  18.3 [GPa] MP:  75
-------------------------------------------------------------



Results [Ni3Si, mp-828: SiNi3 (cubic, Pm-3m, 221)]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 4;
The lattice constant, x (Angstoms) = 3.61771223622934;
The lattice constant, y (Angstoms) = 3.61771223622934;
The lattice constant, z (Angstoms) = 3.61771223622934;
The volume (Angstoms^3) = 47.3480455131102;
The total energy (eV) = -16.9960219357406;
The cohesive energy (eV/atom) = -4.24900548393516;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       334.22974         270.54662         270.54662     6.7459929e-09    -4.9392481e-09    -1.0415695e-08
2       270.54662         334.22974         270.54662     1.2193541e-08    -3.1501703e-09    -1.9534099e-08
3       270.54662         270.54662         334.22974     6.2037742e-09    -5.1836105e-09    -2.3707424e-08
4   6.7459929e-09     1.2193541e-08     6.2037742e-09         534.46789     2.9357896e-09     8.9033297e-09
5  -4.9392481e-09    -3.1501703e-09    -5.1836105e-09     2.9357896e-09         534.46789    -1.1548377e-08
6  -1.0415695e-08    -1.9534099e-08    -2.3707424e-08     8.9033297e-09    -1.1548377e-08         534.46789
-------------------------------------------------------------
Voigt bulk modulus, BV:       291.77433
Reuss bulk modulus, BR:       291.77433
Hill bulk modulus, B=(BV+BR)/2:       291.77433 [GPa]

Voigt shear modulus, GV:       654.09809
Reuss shear modulus, GR:       77.864319
Hill shear modulus, G=(GV+GR)/2:        365.9812 [GPa]

Pughs modulus ratio, k=G/B:       1.2543297
-------------------------------------------------------------

Reference (# M. I. Baskes et al 1994 Modelling Simul. Mater. Sci. Eng. 2 505.: DOI 10.1088/0965-0393/2/3A/006)
-------------------------------------------------------------
Ni3Si
a   3.504 [A] 
               MP: Bv = 215
C11  389 [GPa] MP: 310
C12  237 [GPa] MP: 168
C44  202 [GPa] MP: 132
-------------------------------------------------------------
