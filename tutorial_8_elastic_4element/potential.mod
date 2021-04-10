# NOTE: This script can be modified for different pair styles 
# See in.elastic for more info.

# Choose potential
# ----- Potential settings (MEAM)-----
# -----HEA (Co-Ni-Cr-Fe-Mn)
pair_style      meam/c
pair_coeff      * * ../potentials/meam/CoNiCrFeMn.HEA.library.meam Co Ni Cr Fe Mn ../potentials/meam/CoNiCrFeMn.HEA.meam Co Ni Cr Fe
# -----(Al-Si-Mg-Cu-Fe)
#pair_style      meam/c
#pair_coeff      * * ../potentials/meam/Jelinek_2012_meamf AlS SiS MgS CuS FeS ../potentials/meam/Jelinek_2012_meam.alsimgcufe AlS SiS MgS CuS
# -----(Fe-Mn-Si-C)
#pair_style      meam/c
#pair_coeff      * * ../potentials/meam/CFeMnSi.library.meam Fe Mn Si C ../potentials/meam/CFeMnSi.meam Fe Mn Si C

# ----- Potential settings (EAM)-----
#pair_style      eam/alloy
#pair_coeff      * * ../potentials/eam/FeNiCrCoCu-heafixed.setfl Co Ni Cr Fe
# -----(Ag-Au-Cu-Ni-Pd-Pt)
#pair_style      eam
#pair_coeff      1 * ../potentials/eam/DYNAMO/cuu6.txt
#pair_coeff      2 * ../potentials/eam/DYNAMO/agu6.txt
#pair_coeff      3 * ../potentials/eam/DYNAMO/auu6.txt
#pair_coeff      4 * ../potentials/eam/DYNAMO/niu6.txt

# ----- Potential settings (EIM)-----
#pair_style      eim
#pair_coeff      * * Li Na K Rb Cs F Cl Br Id ../potentials/eim/BrClCsFIKLiNaRb.ffield.eim F K Li Na

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
