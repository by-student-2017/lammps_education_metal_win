#*********************************************************************
# Potential.mod
# NOTE: This script can be modified for different pair styles 
# See in.elastic for more info.
#include init.mod
# Choose potential
pair_style eam/alloy
pair_coeff * * PdH.eam.alloy Pd H
# Setup neighbor style
neighbor 1.0 nsq
neigh_modify once no every 1 delay 0 check yes
# Setup minimization style
min_style cg 
min_modify dmax ${dmax} line quadratic

dump 1 all xyz 10 PdH.xyz 
dump 2 all custom 10 PdH_Custom.xyz type id x y z
dump_modify 2 sort 1

# Setup output
thermo 1

# pxx,pyy,pzz,pxy,pxz,pyz = 6 components of pressure tensor

thermo_style custom step temp pe press pxx pyy pzz pxy pxz pyz lx ly lz vol
thermo_modify norm no
