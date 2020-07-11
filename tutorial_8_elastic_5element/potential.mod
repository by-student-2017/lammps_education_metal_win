# NOTE: This script can be modified for different pair styles 
# See in.elastic for more info.

# ----- Potential settings (MEAM)-----
# -----HEA (Co-Ni-Cr-Fe-Mn)
pair_style      meam/c
pair_coeff      * * ./meam/CoNiCrFeMn.HEA.library.meam Co Ni Cr Fe Mn ./meam/CoNiCrFeMn.HEA.meam Co Ni Cr Fe Mn
# -----(Al-Si-Mg-Cu-Fe)
#pair_style      meam/c
#pair_coeff      * * ./meam/Jelinek_2012_meamf AlS SiS MgS CuS FeS ./meam/Jelinek_2012_meam.alsimgcufe AlS SiS MgS CuS FeS

# Setup neighbor style
neighbor 1.0 nsq
neigh_modify once no every 1 delay 0 check yes

# Setup minimization style
min_style	     cg
min_modify	     dmax ${dmax} line quadratic

# Setup output
thermo		1
thermo_style custom step temp pe press pxx pyy pzz pxy pxz pyz lx ly lz vol
thermo_modify norm no
