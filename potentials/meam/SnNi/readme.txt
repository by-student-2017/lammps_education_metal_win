Usage in lammps input
#-------------------------------------------------------------
pair_style meam
pair_coeff * * library.meam Ni Sn NiSn.meam Ni Sn
#-------------------------------------------------------------

Results [cP4-Ni3Sn (L12-Cu3Au type)]
#-------------------------------------------------------------
#Show results of 1st step (Running Minimization)
#The number of atoms = 4;
#The lattice constant, x (Angstoms) = 3.97282550877557;
#The lattice constant, y (Angstoms) = 3.97282550877557;
#The lattice constant, z (Angstoms) = 3.97282550877557;
#The volume (Angstoms^3) = 62.7044657898233;
#The total energy (eV) = -15.7673472142757;
#The cohesive energy (eV/atom) = -3.94183680356894;
#-------------------------------------------------------------
#C tensor [GPa] (elastic stiffness constants)
#          1                 2                 3                 4                 5                 6
#1       240.59339         123.19221         123.19221     2.0168613e-09     2.2970716e-09    -1.3887524e-09
#2       123.19221         240.59339         123.19221     1.0941024e-09     1.5188195e-09     1.4170906e-10
#3       123.19221         123.19221         240.59339    -1.4637481e-09     7.1994215e-10     1.5304603e-09
#4   2.0168613e-09     1.0941024e-09    -1.4637481e-09         103.95481    -2.1298811e-09     2.3415493e-10
#5   2.2970716e-09     1.5188195e-09     7.1994215e-10    -2.1298811e-09         103.95481    -2.0584037e-09
#6  -1.3887524e-09     1.4170906e-10     1.5304603e-09     2.3415493e-10    -2.0584037e-09         103.95481
#-------------------------------------------------------------
# Voigt bulk modulus, BV:       162.32594 
# Reuss bulk modulus, BR:       162.32594 
# Hill bulk modulus, B=(BV+BR)/2:       162.32594 [GPa]
#-------------------------------------------------------------

Reference (L. H. Li et al., Comput. Mater. Sci. 99 (2015) 274-284.: https://doi.org/10.1016/j.commatsci.2014.11.031)
#-------------------------------------------------------------
# Lattice constant, a = 3.7399 [A]
# Cohesive energy, Ec = -4.321 [eV/atom]
# Bulk modulus, B0 = 162.6 [GPa]
# Elastic constants, C11 = 227.0 [GPa], C44 = 95.6 [GPa], C12 = 125.3 [GPa]
#-------------------------------------------------------------

#-------------------------------------------------------------
Materials with Ni (nickel) added to Sn (tin) are mainly used and researched for the following purposes:
- Lead-free solder: Adding Ni to Sn-Ag-Cu (tin-silver-copper) lead-free solder improves mechanical properties. The addition of Ni stabilizes the precipitates and improves the tensile strength and breaking elongation of the solder.
- Anti-oxidation: Adding Ni has the effect of preventing the oxidation of Sn and improving the wettability of the solder.
- High-purity ferritic stainless steel: Research is also being conducted on the addition of trace amounts of Sn to reduce the amount of rare metals (e.g. Cr) used, thereby reducing costs and reducing the environmental impact.
- Due to these applications, materials with Ni added to Sn are widely studied in the fields of electronics and metal processing. 
#-------------------------------------------------------------
