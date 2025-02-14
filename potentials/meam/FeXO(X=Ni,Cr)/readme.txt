#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Fe Cr Ni O FeCrNiO.meam Fe Ni O
#------------------------------------------------------------------------


#------------------------------------------------------------------------
Test
#------------------------------------------------------------------------
Usage in lammps input
#-------------------------------------------------------------
# 1NN-MEAM
pair_style meam
pair_coeff * * ./../../library.meam Fe Cr Ni O ./../../FeCrNiO.meam Fe O
#-------------------------------------------------------------

Fe3O4 (using mp-19306: Fe3O4 (cubic, Fd-3m, 227))
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 56;
The lattice constant, x (Angstoms) = 9.12198119023532;
The lattice constant, y (Angstoms) = 9.12198119023532;
The lattice constant, z (Angstoms) = 9.12198119023532;
The volume (Angstoms^3) = 759.044988326242;
The total energy (eV) = -410.631252304872;
The cohesive energy (eV/atom) = 7.33270093401557;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       246.26685         29.416794         29.416794     3.6963643e-10     2.0313161e-10     3.1138935e-10
2       29.416794         246.26685         29.416794     9.8276797e-10     -6.081338e-10    -1.5663428e-09
3       29.416794         29.416794         246.26685    -6.0203909e-09    -2.1917385e-09     2.1703919e-09
4   3.6963643e-10     9.8276797e-10    -6.0203909e-09         74.783007     1.1083189e-09      1.289478e-09
5   2.0313161e-10     -6.081338e-10    -2.1917385e-09     1.1083189e-09         74.783007    -3.1004834e-09
6   3.1138935e-10    -1.5663428e-09     2.1703919e-09      1.289478e-09    -3.1004834e-09         74.783007
-------------------------------------------------------------
Voigt bulk modulus, BV:       101.70015
Reuss bulk modulus, BR:       101.70015
Hill bulk modulus, B=(BV+BR)/2:       101.70015 [GPa]

Voigt shear modulus, GV:       133.10962
Reuss shear modulus, GR:       175.59298
Hill shear modulus, G=(GV+GR)/2:        154.3513 [GPa]

Pughs modulus ratio, k=G/B:       1.5177097
-------------------------------------------------------------

Reference: Fe3O4, mp-19306
-------------------------------------------------------------
C11 244 [GPa]
C12 142 [GPa]
C13 142 [GPa]
C33 244 [GPa]
C44  75 [GPa]
C66  75 [GPa]
BV  176 [GPa]
-------------------------------------------------------------



Fe2NiO4 (mp-22684: Fe2NiO4 (cubic, Fd-3m, 227))
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 56;
The lattice constant, x (Angstoms) = 9.04268819393585;
The lattice constant, y (Angstoms) = 9.04268819393585;
The lattice constant, z (Angstoms) = 9.04268819393585;
The volume (Angstoms^3) = 739.422510527675;
The total energy (eV) = -380.992536968296;
The cohesive energy (eV/atom) = 6.80343816014815;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       254.64144           85.0372           85.0372     2.9817145e-09     1.8241723e-08    -1.1512533e-08
2         85.0372         254.64144         85.037201     5.6549744e-09    -5.4976973e-09     8.8566689e-09
3         85.0372         85.037201         254.64144    -1.1422721e-08     -1.426219e-08     1.3012226e-08
4   2.9817145e-09     5.6549744e-09    -1.1422721e-08         83.265241     -1.173763e-09     3.2796674e-09
5   1.8241723e-08    -5.4976973e-09     -1.426219e-08     -1.173763e-09         83.265241     8.0545081e-11
6  -1.1512533e-08     8.8566689e-09     1.3012226e-08     3.2796674e-09     8.0545081e-11         83.265241
-------------------------------------------------------------
Voigt bulk modulus, BV:       141.57195
Reuss bulk modulus, BR:       141.57195
Hill bulk modulus, B=(BV+BR)/2:       141.57195 [GPa]

Voigt shear modulus, GV:       133.83914
Reuss shear modulus, GR:        153.4134
Hill shear modulus, G=(GV+GR)/2:       143.62627 [GPa]

Pughs modulus ratio, k=G/B:       1.0145108
-------------------------------------------------------------


Cr2O3 (mp-19399)
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 30;
The lattice constant, x (Angstoms) = 5.4174760203634;
The lattice constant, y (Angstoms) = 4.69167185798984;
The lattice constant, z (Angstoms) = 14.8228845475455;
The volume (Angstoms^3) = 376.753549831652;
The total energy (eV) = -180.365674487007;
The cohesive energy (eV/atom) = 6.01218914956688;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       490.85364         106.37648         100.40607         12.181451          0.011846      -0.026814545
2       106.37648          490.8392         100.35027        -12.156705      0.0025929159       0.031007807
3       100.40607         100.35027         332.87907        0.03236881       0.018500409       0.016070096
4       12.181451        -12.156705        0.03236881         10.484266     -0.0074064368      0.0067158469
5        0.011846      0.0025929159       0.018500409     -0.0074064368          10.45865         12.188151
6    -0.026814545       0.031007807       0.016070096      0.0067158469         12.188151         192.17011
-------------------------------------------------------------
Voigt bulk modulus, BV:       214.31528
Reuss bulk modulus, BR:        207.3801
Hill bulk modulus, B=(BV+BR)/2:       210.84769 [GPa]

Voigt shear modulus, GV:       152.40781
Reuss shear modulus, GR:       76.028567
Hill shear modulus, G=(GV+GR)/2:       114.21819 [GPa]

Pughs modulus ratio, k=G/B:      0.54170947
-------------------------------------------------------------

Reference, Cr2O3, mp-19399
-------------------------------------------------------------
C11 348 [GPa]
C12 142 [GPa]
C13 137 [GPa]
C33 308 [GPa]
C44 136 [GPa]
C66 103 [GPa]
BV  204 [GPa]
-------------------------------------------------------------


FeCr2O4 (mp-1192780)
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 28;
The lattice constant, x (Angstoms) = 3.20602878000389;
The lattice constant, y (Angstoms) = 9.79158933520057;
The lattice constant, z (Angstoms) = 11.4228380595496;
The volume (Angstoms^3) = 358.587071243451;
The total energy (eV) = -174.028437696269;
The cohesive energy (eV/atom) = 6.21530134629533;
-------------------------------------------------------------
# Murnaghan equation of state
f(x) = (a*x/(b*(b-1)))*(b*(1-c/x)+(c/x)**b-1)+d

Final set of parameters            Asymptotic Standard Error
=======================            ==========================
a               = 1.22521          +/- 0.0006684    (0.05455%)
b               = 3.79908          +/- 0.01735      (0.4567%)
c               = 299.111          +/- 0.01892      (0.006325%)
d               = -179.474         +/- 0.001495     (0.0008327%)

B = 1.22521*160.2 = 196.2 [GPa] (Exp. 140-170 [GPa])
The "Murnaghan equation of state" is an overestimate, but it's not too bad.
-------------------------------------------------------------
The ELASTIC in Lammps does not work well as shown below. 
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       206322.69        -9003.1361         56515.341        -34851.731         5735.6899         40965.405
2      -9003.1361        -43218.287        -54731.347         29927.078          59359.71         70614.595
3       56515.341        -54731.347        -274.58398        -132056.06         96587.243         90830.966
4      -34851.731         29927.078        -132056.06         295505.19         137904.85         3275.9228
5       5735.6899          59359.71         96587.243         137904.85        -23765.839        -52734.927
6       40965.405         70614.595         90830.966         3275.9228        -52734.927        -18583.917
-------------------------------------------------------------
Voigt bulk modulus, BV:       16487.948
Reuss bulk modulus, BR:       1022169.8
Hill bulk modulus, B=(BV+BR)/2:       519328.85 [GPa]

Voigt shear modulus, GV:       112598.77
Reuss shear modulus, GR:       329191.57
Hill shear modulus, G=(GV+GR)/2:       220895.17 [GPa]

Pughs modulus ratio, k=G/B:      0.42534739
-------------------------------------------------------------

#-------------------------------------------------------------
# Reference: T. Ohira et al., Mat. Res. Soc. Symp. Proc. 492 (1997) 401-406.: https://link.springer.com/journal/43582/aims-and-scope
# Calculation (Expt.)
# Property  Fe3O4  NiFe2O4  Cr2O3  FeCr2O4
# Cohesive energy (eV/atom)  4.91(4.95)  4.38  5.52(5.52)  5.15
# Lattice constant, a0 (A)  8.399(8.396)  8.342(8.340)  4.964(4.961)  8.381(8.377)
# Lattice constant, c0 (A)  --  --  13.606(13.599)
# Bulk modulus (GPa)  156(161)  120(146)  267(234)  40(140-170)
# Elastic shear constants C44 (GPa)  133(97)  82(81)  --  190(80-110)
# Elastic shear constants (C11-C12)/2  --  --  110(113)  --
# (001) Fracture energy (J/m^2)  3.5(about 3.9)  3.3(about 4.1)  5.1(about 5.0)  7.0(about 6.2)  
#-------------------------------------------------------------
