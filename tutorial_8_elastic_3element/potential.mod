# NOTE: This script can be modified for different pair styles 
# See in.elastic for more info.

# Choose potential
# ----- Potential settings (MEAM)-----
# -----HEA (Co-Ni-Cr-Fe-Mn)
pair_style      meam/c
pair_coeff      * * ./meam/CoNiCrFeMn.HEA.library.meam Co Ni Cr Fe Mn ./meam/CoNiCrFeMn.HEA.meam Co Ni Cr
# -----(Al-Si-Mg-Cu-Fe)
#pair_style      meam/c
#pair_coeff      * * ./meam/Jelinek_2012_meamf AlS SiS MgS CuS FeS ./meam/Jelinek_2012_meam.alsimgcufe AlS SiS MgS CuS
# -----(Fe-Mn-Si-C)
#pair_style      meam/c
#pair_coeff      * * ./meam/CFeMnSi.library.meam Fe Mn Si C ./meam/CFeMnSi.meam Fe Mn Si C
# -----(Mg-Al-Zn)
#pair_style      meam/c
#pair_coeff      * * ./meam/MgAlZn.library.meam Mg Al Zn ./meam/MgAlZn.parameter.meam Mg Al Zn
# -----(Fe-Ti-C)
#pair_style      meam/c
#pair_coeff      * * ./meam/FeTiC.library.meam Fe Ti C ./meam/FeTiC.meam Fe Ti C
# -----(V-Ni-Ti)
#pair_style      meam/c
#pair_coeff      * * ./meam/VNiTi.library.meam V Ni Ti ./meam/VNiTi.meam V Ni Ti
# -----(AgTaO3)
#pair_style      meam/c
#pair_coeff      * * ./meam/AgTaO3.library.meam Ag Ta O ./meam/AgTaO3.meam Ag Ta O

# ----- Potential settings (EAM)-----
#pair_style      eam/alloy
#pair_coeff      * * ./eam/FeNiCrCoCu-heafixed.setfl Co Ni Cr Fe
# -----(Cu-Ag-Au)
#pair_style      eam/alloy
#pair_coeff      * * ./eam/CuAgAu_Zhou04.eam.alloy Cu Ag Au
# -----(Fe-Cu-Ni)
#pair_style      eam/alloy
#pair_coeff      * * ./eam/FeCuNi.eam.alloy Fe Cu Ni
# -----(Al-Mn-Pd)
#pair_style      eam/alloy
#pair_coeff      * * ./eam/AlMnPd_Schopf_2012.lammps.EAM_CORRECT Al Mn Pd
# -----(Ni-Al-Co)
#pair_style      eam/alloy
#pair_coeff      * * ./eam/Mishin_updated-Ni-Al-Co-2013.eam.alloy Ni Al Co
# -----(Nb-Ti-Al)
#pair_style      eam/alloy
#pair_coeff      * * ./eam/Farkas_Nb-Ti-Al_1996.eam.alloy Nb Ti Al
# -----(Ni-Al-H)
#pair_style      eam/alloy
#pair_coeff      * * ./eam/NiAlH_jea.eam.alloy Ni Al H
# -----(Pd-Ag-H)
#pair_style      eam/alloy
#pair_coeff      * * ./eam/PdAgH_HybridPd3Ag.eam.alloy Pd Ag H
# -----(W-H-He)
#pair_style      eam/alloy
#pair_coeff      * * ./eam/potential-WHHe-EAM1.eam.alloy W H He
# -----(Fe-Ni-Cr) (FCC)
#pair_style      eam/fs
#pair_coeff      * * ./eam/Fe-Ni-Cr_fcc.eam.fs Fe Ni Cr
# -----(Fe-Cr-W)
#pair_style      hybrid/overlay eam/alloy eam/fs
#pair_coeff      * * eam/alloy ./eam/FeCrW_d.eam.alloy Fe Cr W
#pair_coeff      * * eam/fs    ./eam/FeCrW_s.eam.fs Fe Cr W

# ----- Potential settings (ADP)-----
#pair_style      adp
#pair_coeff      * * ./adp/Si_Au_Al.adp.txt Si Au Al

# ----- Potential settings (COMB)-----
#pair_style      comb3 polar_off
#pair_coeff      * * ./comb3/ffield.comb3.NiAlO Ni Al O
#fix             q2 all qeq/comb 10 1.0e-3 # file fq.out
# -----(OCuNCHTiZnZr)
#pair_style      comb3 polar_off
#pair_coeff      * * ./comb3/ffield.comb3.OCuNCHTiZnZr Cu Zn O
#fix             q2 all qeq/comb 10 1.0e-3 # file fq.out

# ----- Potential settings (BOP)-----
#pair_style      bop
#pair_coeff      * * ./bop/CdZnTe_v2.bop.table Cd Zn Te
#comm_modify cutoff 14.70

# ----- Potential settings (SW)-----
#pair_style      sw
#pair_coeff      * * ./sw/InGaN.psw In Ga N
# -----(Cd-Te-Zn-Se-Hg-S)
#pair_style      sw
#pair_coeff      * * ./sw/CdTeZnSeHgS0.sw Cd Te Zn

# ----- Potential settings (tersoff)-----
#pair_style      tersoff
#pair_coeff      * * ./tersoff/BNC.tersoff B N C

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
