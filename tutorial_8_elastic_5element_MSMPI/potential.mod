# NOTE: This script can be modified for different pair styles 
# See in.elastic for more info.

# ----- Potential settings (MEAM)-----
# -----HEA (Co-Ni-Cr-Fe-Mn)
pair_style      meam/c
pair_coeff      * * ../potentials/meam/CoNiCrFeMn.HEA.library.meam Co Ni Cr Fe Mn ../potentials/meam/CoNiCrFeMn.HEA.meam Co Ni Cr Fe Mn
# -----(Al-Si-Mg-Cu-Fe)
#pair_style      meam/c
#pair_coeff      * * ../potentials/meam/Jelinek_2012_meam AlS SiS MgS CuS FeS ../potentials/meam/Jelinek_2012_meam.alsimgcufe AlS SiS MgS CuS FeS

# ----- Potential settings (EAM)-----
# -----(Fe-Ni-Cr-Co-Al): https://doi.org/10.1557/jmr.2020.294
#pair_style      eam/alloy
#pair_coeff      * * ../potentials/eam/FeNiCrCoAl-heaweight.setfl Fe Ni Cr Co Al
# -----(Fe-Ni-Cr-Co-Cu): https://doi.org/10.1557/jmr.2018.245
#pair_style      eam/alloy
#pair_coeff      * * ../potentials/eam/FeNiCrCoCu-heafixed.setfl Fe Ni Cr Co Cu
# -----(Ag-Au-Cu-Ni-Pd-Pt): https://doi.org/10.1557/jmr.1989.0102
#pair_style      eam
#pair_coeff      1 * ../potentials/eam/DYNAMO/cuu6.txt
#pair_coeff      2 * ../potentials/eam/DYNAMO/agu6.txt
#pair_coeff      3 * ../potentials/eam/DYNAMO/auu6.txt
#pair_coeff      4 * ../potentials/eam/DYNAMO/niu6.txt
#pair_coeff      5 * ../potentials/eam/DYNAMO/ptu6.txt

# https://doi.org/10.1103/physrevb.69.144113
# -----(Cr-Mn-Fe-Co-Ni), Cr and Mn are low accuracy
#pair_style      eam/alloy
#pair_coeff      * * ../potentials/eam/Zhou04/CrMnFeCoNi_Zhou04.eam.alloy Cr Mn Fe Co Ni
# -----(Cr-Fe-Co-Ni-Cu), Cr is low accuracy
#pair_style      eam/alloy
#pair_coeff      * * ../potentials/eam/Zhou04/CrFeCoNiCu_Zhou04.eam.alloy Cr Fe Co Ni Cu
# -----(Al-Cr-Fe-Co-Ni), Cr is low accuracy
#pair_style      eam/alloy
#pair_coeff      * * ../potentials/eam/Zhou04/AlCrFeCoNi_Zhou04.eam.alloy Al Cr Fe Co Ni
# -----(Al-Ti-Fe-Co-Ni)
#pair_style      eam/alloy
#pair_coeff      * * ../potentials/eam/Zhou04/AlTiFeCoNi_Zhou04.eam.alloy Al Ti Fe Co Ni
# -----(Al-Ti-V-Cr-Nb), V and Nb are low accuracy
#pair_style      eam/alloy
#pair_coeff      * * ../potentials/eam/Zhou04/AlTiVCrNb_Zhou04.eam.alloy Al Ti V Cr Nb
# -----(Au-Cu-Pt-Pd-Ni)
#pair_style      eam/alloy
#pair_coeff      * * ../potentials/eam/Zhou04/AuCuPtPdNi_Zhou04.eam.alloy Au Cu Pt Pd Ni
# -----(Ti-Zr-Hf-Nb-Ta), Hf and Nb are low accuracy
#pair_style      eam/alloy
#pair_coeff      * * ../potentials/eam/Zhou04/TiZrHfNbTa_Zhou04.eam.alloy Ti Zr Hf Nb Ta
# -----(V-Nb-Mo-Fe-Ni), V and Nb are low accuracy
#pair_style      eam/alloy
#pair_coeff      * * ../potentials/eam/Zhou04/VNbMoFeNi_Zhou04.eam.alloy V Nb Mo Fe Ni

# ----- Potential settings (EIM)-----
#pair_style      eim
#pair_coeff      * * Li Na K Rb Cs F Cl Br Id ../potentials/eim/BrClCsFIKLiNaRb.ffield.eim F K Li Na Rb

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
