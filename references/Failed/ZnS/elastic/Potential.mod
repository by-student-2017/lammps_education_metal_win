# NOTE: This script can be modified for different pair styles 
# See in.elastic for more info.

#include init.mod

# Choose potential
# 
pair_style buck/coul/long/cs 12

# Zn-Zn 
pair_coeff * * 0.0 1.0 0.0 0.0

# Zn_shell - S_shell 
pair_coeff 1 2 580.84615 0.400505 0.0

# S_shell - S_shell 
pair_coeff 2 2 1199.78975 0.148604 0.0

pair_modify shift yes

# atomic mass of Zn
mass 1 65.38 

# atomic mass of O
mass 2 32.059

# charges of Zn
set type 1 charge 2.0

# charges of O
set type 2 charge -2.0

dielectric 1.0

pair_modify shift yes
kspace_style ewald/disp 1.0E-06
neighbor 3.0 bin

# Setup neighbor style
neighbor 1.0 nsq
neigh_modify once no every 1 delay 0 check yes

# Setup minimization style
min_style cg 
min_modify dmax ${dmax} line quadratic

dump 1 all xyz 10 ZnS.xyz 
dump 2 all custom 10 ZnS_Custom.xyz type id x y z
dump_modify 2 sort 1

# Setup output
thermo 1

# pxx,pyy,pzz,pxy,pxz,pyz = 6 components of pressure tensor
thermo_style custom step temp pe press pxx pyy pzz pxy pxz pyz lx ly lz vol
thermo_modify norm no

