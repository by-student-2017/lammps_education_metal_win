Usage in lammps input
#-------------------------------------------------------------
pair_style meam
pair_coeff * * library.meam Ni Sn NiSn.meam Ni Sn
#-------------------------------------------------------------

Results [cP4-Ni3Sn (L12-Cu3Au type)]
-------------------------------------------------------------
Show results of 1st step (Running Minimization)
The number of atoms = 4;
The lattice constant, x (Angstoms) = 3.97283661106867;
The lattice constant, y (Angstoms) = 3.97283661106867;
The lattice constant, z (Angstoms) = 3.97283661106867;
The volume (Angstoms^3) = 62.7049914851769;
The total energy (eV) = -15.7665357492556;
The cohesive energy (eV/atom) = 3.9416339373139;
-------------------------------------------------------------
C tensor [GPa] (elastic stiffness constants)
          1                 2                 3                 4                 5                 6
1       235.55853         125.69372         125.69372    -3.0674258e-09    -1.5784796e-09    -1.7483246e-09
2       125.69372         235.55853         125.69372    -4.9203052e-09     -1.040756e-09    -2.0264278e-09
3       125.69372         125.69372         235.55853    -5.6337417e-09    -6.9443618e-11      5.367192e-10
4  -3.0674258e-09    -4.9203052e-09    -5.6337417e-09         103.93952    -1.4580025e-10     3.2830906e-10
5  -1.5784796e-09     -1.040756e-09    -6.9443618e-11    -1.4580025e-10         103.93952    -5.5652813e-10
6  -1.7483246e-09    -2.0264278e-09      5.367192e-10     3.2830906e-10    -5.5652813e-10         103.93952
#-------------------------------------------------------------
Voigt bulk modulus, BV:       162.31532
Reuss bulk modulus, BR:       162.31532
Hill bulk modulus, B=(BV+BR)/2:       162.31532 [GPa]

Voigt shear modulus, GV:       146.70039
Reuss shear modulus, GR:        114.6155
Hill shear modulus, G=(GV+GR)/2:       130.65795 [GPa]

Pughs modulus ratio, k=G/B:      0.80496373
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
