# Appendix E. Python code for modeling the atomistic models
# python3 make_input.py
import os;
import shutil;

for i in range(2):
  if i==0:
    dirname="7075-zn"
    nsi="134"
    nmg="1127"
    ncu="297"
    nfe="84"
    nzn="914"
  else:
    dirname="7075"
    nsi="134"
    nmg="1127"
    ncu="297"
    nfe="84"
    nzn="0"
  if not os.path.isdir("./"+dirname+"/"):
    os.mkdir("./"+dirname+"/")
  for j in range(4):
    if j==0:
      srate="1E8"
      runn="4000000"
    elif j==1:
      srate="5E7"
      runn="8000000"
    elif j==2:
      srate="1E9"
      runn="400000"
    elif j==3:
      srate="5E8"
      runn="800000"
    if not os.path.isdir("./"+dirname+"/"+srate+"/"):
      os.mkdir("./"+dirname+"/"+srate+"/")
    for k in range(5):
      l=k
      if not os.path.isdir("./"+dirname+"/"+srate+"/"+str(l+1)):
        os.mkdir("./"+dirname+"/"+srate+"/"+str(l+1))
      #shutil.copy('library.meam', dirname+"/"+srate+"/"+str(l+1))
      f=open(dirname+"/"+srate+"/"+str(l+1)+"/"+"al_nano.in",'w')
      f.write("# Deforming a Nanowire. \n")
      f.write("# Suman Kandel, Dr. Mark A. Tschopp. 2011. \n")
      f.write("\n")
      f.write("# ---------- INITIALIZATION ---------- \n")
      f.write("units metal \n")
      f.write("boundary p p p \n")
      f.write("\n")
      f.write("atom_style atomic \n")
      f.write("\n")
      f.write("\n")
      f.write("# ---------- ATOM FEFINITION --------- \n")
      f.write("lattice fcc 4.05 \n")
      f.write("region whole block 20 80 20 80 0 20 units lattice \n")
      f.write("create_box 5 whole \n")
      f.write("region LLF block 40 60 40 60 INF INF units lattice \n")
      f.write("lattice fcc 4.05  orient x 1 0 0 orient y 0 1 0 orient z 0 0 1 \n")
      f.write("create_atoms 1 region LLF \n")
      f.write("lattice hcp 5.431 orient x 1 0 0 orient y 0 1 0 orient z 0 0 1 \n")
      f.write("create_atoms 2 random "+nsi+" "+str(l+1)+" LLF \n")
      f.write("lattice fcc 3.194 orient x 1 0 0 orient y 0 1 0 orient z 0 0 1 \n")
      f.write("create_atoms 3 random "+nmg+" "+str(l+2)+" LLF \n")
      f.write("lattice fcc 3.62  orient x 1 0 0 orient y 0 1 0 orient z 0 0 1 \n")
      f.write("create_atoms 4 random "+ncu+" "+str(l+3)+" LLF \n")
      f.write("lattice hcp 2.665 orient x 1 0 0 orient y 0 1 0 orient z 0 0 1 \n")
      f.write("create_atoms 5 random "+nzn+" "+str(l+4)+" LLF \n")
      f.write("group sub region LLF \n")
      f.write("\n")
      f.write("\n")
      f.write("# ---------- FORCE FIELDS --------- \n")
      f.write("pair_style meam \n")
      if i==0:
        shutil.copy('library.meam', dirname+"/"+srate+"/"+str(l+1))
        shutil.copy('AlSiMgCuZn.meam', dirname+"/"+srate+"/"+str(l+1))
        f.write("#pair_coeff * * library.meam Al Si Mg Cu Zn NULL Al Si Mg Cu Zn \n")
        f.write("pair_coeff * * library.meam Al Si Mg Cu Zn AlSiMgCuZn.meam Al Si Mg Cu Zn \n")
      else:
        #shutil.copy('Jelinek_2012_meam', dirname+"/"+srate+"/"+str(l+1))
        #shutil.copy('Jelinek_2012_meam.alsimgcufe', dirname+"/"+srate+"/"+str(l+1))
        f.write("pair_coeff * * Jelinek_2012_meam AlS SiS MgS CuS FeS Jelinek_2012_meam.alsimgcufe Al Si Mg Cu Fe \n")
      f.write("\n")
      f.write("# ---------- SETTINGS --------- \n")
      f.write("\n")
      f.write("delete_atoms overlap 2.5 sub sub \n")
      f.write("#### Computes Required \n")
      f.write("compute csym all centro/atom 12 \n")
      f.write("compute 2 all stress/atom NULL \n")
      f.write("compute mytemp all temp \n")
      f.write("compute 11 all reduce sum c_2[1] \n")
      f.write("compute 12 all reduce sum c_2[2] \n")
      f.write("compute 13 all reduce sum c_2[3] \n")
      f.write("compute 14 all reduce sum c_2[4] \n")
      f.write("compute 15 all reduce sum c_2[5] \n")
      f.write("compute 16 all reduce sum c_2[6] \n")
      f.write("\n")
      f.write("neighbor 0.3 bin \n")
      f.write("neigh_modify delay 10 \n")
      f.write("thermo 300 \n")
      f.write("# velocity all create 300.0 13723 \n")
      f.write("thermo_style custom step temp etotal press pxx pyy pzz lx ly lz \n")
      f.write("shell mkdir dump \n")
      f.write("shell cd dump \n")
      f.write("\n")
      f.write("# ---------- Energy Esuilibriation --------- \n")
      f.write("reset_timestep 0 \n")
      f.write("timestep 0.001 # 1 [fs] \n")
      f.write("fix 1 all nve \n")
      f.write("fix 2 all temp/rescale 10 300.0 300.0 1.0 0.5 \n")
      f.write("dump 1 all custom 10000 dump.equilibrate.*.cfg id type x y z \n")
      f.write("\n")
      f.write("run 10000 \n")
      f.write("unfix 1 \n")
      f.write("unfix 2 \n")
      f.write("\n")
      f.write("# ---------- Pressure Esuilibriation --------- \n")
      f.write("fix 1 all npt temp 300 300 100.0 aniso 0.0 0.0 10 drag 0.3 \n")
      f.write("run 10000 \n")
      f.write("unfix 1 \n")
      f.write("undump 1 \n")
      f.write("shell cd .. \n")
      f.write("\n")
      f.write("# ---------- Quenching --------- \n")
      f.write("shell mkdir quenching \n")
      f.write("shell cd quenching \n")
      f.write("dump 1 all custom 5000 dump.quenching.*.cfg id type x y z \n")
      f.write("fix 1 all npt temp 300 800 100.0 aniso 0.0 0.0 10 drag 0.3 \n")
      f.write("\n")
      f.write("run 1000 \n")
      f.write("unfix 1 \n")
      f.write("fix 1 all npt temp 800 300 100.0 aniso 0.0 0.0 10 drag 0.3 \n")
      f.write("run 10000 \n")
      f.write("unfix 1 \n")
      f.write("undump 1 \n")
      f.write("shell cd .. \n")
      f.write("shell mkdir deform \n")
      f.write("shell cd deform \n")
      f.write("# ---------- Storing Initial length --------- \n")
      f.write("variable tmp equal \"lz\" \n")
      f.write("variable L0 equal ${tmp} \n")
      f.write("print \"Initial Length, L0:${L0}\" \n")
      f.write("variable strain equal \"v_srate/1e12\" \n")
      f.write("\n")
      f.write("# ---------- Deform --------- \n")
      f.write("reset_timestep 0 \n")
      f.write("timestep 0.001 # 1 [fs] \n")
      f.write("variable ssrate equal "+srate+" \n")
      f.write("variable ssrate1 equal \"v_ssrate/1.0e12\" \n")
      f.write("fix 1 all deform 1 z erate ${ssrate1} units box \n")
      f.write("fix 2 all nvt temp 300.0 300.0 10.0 \n")
      f.write("\n")
      f.write("variable strain equal \"(lz-v_L0)/v_L0\" \n")
      f.write("variable p1 equal \"v_strain\" \n")
      f.write("variable p2 equal \"-pxx/10000\" \n")
      f.write("variable p3 equal \"-pyy/10000\" \n")
      f.write("variable p4 equal \"-pzz/10000\" \n")
      f.write("variable p5 equal \"lx\" \n")
      f.write("variable p6 equal \"ly\" \n")
      f.write("variable p7 equal \"lz\" \n")
      f.write("variable p8 equal \"temp\" \n")
      f.write("variable p9 equal \"pe\" \n")
      f.write("variable p10 equal \"ke\" \n")
      f.write("variable p11 equal \"-pxy/10000\" \n")
      f.write("variable p12 equal \"-pyz/10000\" \n")
      f.write("variable p13 equal \"-pxz/10000\" \n")
      f.write("variable fm equal \"(v_p2+v_p3+v_p4)/3\" ##### Hydrostatic stress \n")
      f.write("\n")
      f.write("variable fv equal \"sqrt((v_p2-v_p3)^2+(v_p3-v_p4)^2+(v_p4-v_p2)^2+6*(v_p11^2+v_p12^2+v_p13^2)/2)\" ##### Von Mises Stress \n")
      f.write("\n")
      f.write("variable t equal \"v_fm/v_fv\" \n")
      f.write("variable fd equal ((v_p2-v_fm)*(v_p3-v_fm)*(v_p4-v_fm)-v_p11^2*(v_p4-v_fm)-v_p12^2*(v_p3-v_fm)-v_p13^2*(v_p2-v_fm)+2*v_p11*v_p12*v_p13) #### Deviatoric Von Mises stress \n")
      f.write("\n")
      f.write("dump 2 all custom 80000 dump.defo.*.cfg id type x y z c_csym c_2[1] c_2[2] c_2[3] c_2[4] c_2[5] c_2[6] \n")
      f.write("#dump 1 all custom 100 dump.comp.*.cfg id type xs ys zs c_csym c_peratom fx fy fz \n")
      f.write("\n")
      f.write("fix fef_print all print 50 \"${p1} ${p2} ${p3} ${p4} ${p5} ${p6} ${p7} ${p8} ${p9} ${p10} ${p11} ${p12} ${p13} ${fm} ${fv} ${t} ${fd}\" file mg001.defo.txt screen no \n")
      f.write("run "+runn+" \n")
      f.write("\n")
      