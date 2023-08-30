# NOTE: This script can be modified for different atomic structures, 
# units, etc. See in.elastic for more info.
#

# Define the finite deformation size. Try several values of this
# variable to verify that results do not depend on it.
variable up equal 1.0e-6

# Uncomment one of these blocks, depending on what units
# you are using in LAMMPS and for output

# metal units, elastic constants in eV/A^3
#units metal
#variable cfac equal 6.2414e-7
#variable cunits string eV/A^3

# metal units, elastic constants in GPa
units metal
variable cfac equal 1.0e-4
variable cunits string GPa

# real units, elastic constants in GPa
#units real
#variable cfac equal 1.01325e-4
#variable cunits string GPa

# Define minimization parameters
variable etol equal 0.0 
variable ftol equal 1.0e-10
variable maxiter equal 10000
variable maxeval equal 1000000
variable dmax equal 1.0e-6

# generate the box and atom positions using a diamond lattice
boundary p p p
atom_style full
variable N equal 6

# Generate a Wurtzite crystal with 4 basis
variable a equal 3.8227
variable c equal 6.2607
variable u equal 0.3748 

variable c_a equal $c/$a
variable s_2 equal sqrt(3.0)/2.0
variable u_2 equal ${u}+0.5
variable 1_3 equal 1/3
variable 2_3 equal 2/3 

lattice custom $a &
 a1 0.5 -${s_2} 0.0 & 
 a2 0.5 ${s_2} 0.0 &
 a3 0.0 0.0 ${c_a} & 
 basis ${1_3} ${2_3} 0.0 &
 basis ${2_3} ${1_3} 0.5 & 
 basis ${1_3} ${2_3} $u & 
 basis ${2_3} ${1_3} ${u_2}

region sregion prism 0 $N 0 $N 0 $N 0 0 0

create_box 2 sregi

# Basis 1 & 2 is Zn, Basis 3 Basis 4 is S
create_atoms 1 region sregion basis 3 2 basis 4 2