# NOTE: This script can be modified for different pair styles 
# See in.elastic for more info.

reset_timestep 0

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
# -----(Co-Ni-Cr-Fe-Cu)
#pair_style      eam/alloy
#pair_coeff      * * ../potentials/eam/FeNiCrCoCu-heafixed.setfl Co Ni Cr Fe
# -----(Fe-Ni-Cr-Co-Al)
#pair_style      eam/alloy
#pair_coeff      * * ../potentials/eam/FeNiCrCoAl-heaweight.setfl Fe Ni Cr Co Al
# -----(Ta-Hf-Zr-Ti)
#pair_style      eam/fs
#pair_coeff      * * ../potentials/eam/TaHfZrTi.eam.fs Ta Hf Zr Ti
# -----(Ag-Au-Cu-Ni-Pd-Pt)
#pair_style      eam
#pair_coeff      1 * ../potentials/eam/DYNAMO/cuu6.txt
#pair_coeff      2 * ../potentials/eam/DYNAMO/agu6.txt
#pair_coeff      3 * ../potentials/eam/DYNAMO/auu6.txt
#pair_coeff      4 * ../potentials/eam/DYNAMO/niu6.txt

# https://doi.org/10.1103/physrevb.69.144113
# -----(Cr-Mn-Fe-Co-Ni), Cr and Mn are low accuracy
#pair_style      eam/alloy
#pair_coeff      * * ../potentials/eam/Zhou04/CrMnFeCoNi_Zhou04.eam.alloy Cr Fe Co Ni
# -----(Cr-Fe-Co-Ni-Cu), Cr is low accuracy
#pair_style      eam/alloy
#pair_coeff      * * ../potentials/eam/Zhou04/CrFeCoNiCu_Zhou04.eam.alloy Fe Co Ni Cu
# -----(Al-Cr-Fe-Co-Ni), Cr is low accuracy
#pair_style      eam/alloy
#pair_coeff      * * ../potentials/eam/Zhou04/AlCrFeCoNi_Zhou04.eam.alloy Al Fe Co Ni
# -----(Al-Ti-Fe-Co-Ni)
#pair_style      eam/alloy
#pair_coeff      * * ../potentials/eam/Zhou04/AlTiFeCoNi_Zhou04.eam.alloy Al Ti Fe Co
# -----(Al-Ti-V-Cr-Nb), V and Nb are low accuracy
#pair_style      eam/alloy
#pair_coeff      * * ../potentials/eam/Zhou04/AlTiVCrNb_Zhou04.eam.alloy Al Ti V Nb
# -----(Au-Cu-Pt-Pd-Ni)
#pair_style      eam/alloy
#pair_coeff      * * ../potentials/eam/Zhou04/AuCuPtPdNi_Zhou04.eam.alloy Au Cu Pt Pd
# -----(Ti-Zr-Hf-Nb-Ta), Hf and Nb are low accuracy
#pair_style      eam/alloy
#pair_coeff      * * ../potentials/eam/Zhou04/TiZrHfNbTa_Zhou04.eam.alloy Ti Zr Nb Ta
# -----(V-Nb-Mo-Fe-Ni), V and Nb are low accuracy
#pair_style      eam/alloy
#pair_coeff      * * ../potentials/eam/Zhou04/VNbMoFeNi_Zhou04.eam.alloy V Mo Fe Ni

# ----- Potential settings (EIM)-----
#pair_style      eim
#pair_coeff      * * Li Na K Rb Cs F Cl Br Id ../potentials/eim/BrClCsFIKLiNaRb.ffield.eim F K Li Na

# Setup neighbor style
neighbor 1.0 nsq
neigh_modify once no every 1 delay 0 check yes

# Setup output

fix avp all ave/time  ${nevery} ${nrepeat} ${nfreq} c_thermo_press mode vector
thermo		${nthermo}
thermo_style custom step temp pe press f_avp[1] f_avp[2] f_avp[3] f_avp[4] f_avp[5] f_avp[6]
thermo_modify norm no

# Setup MD

timestep ${timestep}
fix 4 all nve
if "${thermostat} == 1" then &
   "fix 5 all langevin ${temp} ${temp} ${tdamp} ${seed}"


