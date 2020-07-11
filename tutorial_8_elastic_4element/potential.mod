# NOTE: This script can be modified for different pair styles 
# See in.elastic for more info.

# Choose potential
# ----- Potential settings (MEAM)-----
# -----HEA (Co-Ni-Cr-Fe-Mn)
pair_style      meam/c
pair_coeff      * * ./meam/CoNiCrFeMn.HEA.library.meam Co Ni Cr Fe Mn ./meam/CoNiCrFeMn.HEA.meam Co Ni Cr Fe
# -----(Al-Si-Mg-Cu-Fe)
#pair_style      meam/c
#pair_coeff      * * ./meam/Jelinek_2012_meamf AlS SiS MgS CuS FeS ./meam/Jelinek_2012_meam.alsimgcufe AlS SiS MgS CuS
# -----(Fe-Mn-Si-C)
#pair_style      meam/c
#pair_coeff      * * ./meam/CFeMnSi.library.meam Fe Mn Si C ./meam/CFeMnSi.meam Fe Mn Si C

# ----- Potential settings (EAM)-----
#pair_style      eam/alloy
#pair_coeff      * * ./eam/FeNiCrCoCu-heafixed.setfl Co Ni Cr Fe
# -----

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
