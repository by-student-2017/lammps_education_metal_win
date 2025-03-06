#!/bin/csh -f

#-----------------------------------------------------------------------
set DFT = PBE
set NCPUs = 8

setenv OMP_NUM_THREADS 1
set nspin = 2
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
set element_list = (H He Li Be B C N O F Ne Na Mg Al Si P S Cl Ar K Ca Sc Ti V Cr Mn Fe Co Ni Cu Zn Ga Ge As Se Br Kr Rb Sr Y Zr Nb Mo Tc Ru Rh Pd Ag Cd In Sn Sb Te I Xe Cs Ba La Ce Pr Nd Pm Sm Eu Gd Tb Dy Ho Er Tm Yb Lu Hf Ta W Re Os Ir Pt Au Hg Tl Pb Bi Po At Rn Fr Ra Ac Th Pa U Np Pu Am Cm Bk Cf Es Fm Md No Lr Rf Db Sg Bh Hs Mt Ds Rg Cn Nh Fl Mc Lv Ts Og)
set mass_list = (1.00794 4.00260 6.941 9.01218 10.81 12.01 14.007 16.00 18.9984 20.180 22.99 24.305 26.98 28.1 30.97 32.1 35.45 39.95 39.10 40.08 44.955912 47.867 50.9415 51.9961 54.938045 55.845 58.933195 58.6934 63.546 65.38 69.723 72.63 74.92160 78.96 79.904 83.798 85.4678 87.62 88.90585 91.224 92.90638 95.96 98 101.07 102.90550 106.42 107.8682 112.411 114.818 118.710 121.760 127.60 126.90447 131.293 132.9054519 137.33 138.90547 140.116 140.90765 144.242 145 150.36 151.964 157.25 158.92535 162.500 164.93032 167.259 168.93421 173.054 174.9668 178.49 180.94788 183.84 186.207 190.23 192.217 195.084 196.966569 200.59 204.3833 207.2 208.98040 209 210 222 223 226 227 232.0381 231.03588 238.02891 237 244 243 247 247 251 252 257 258 259 262 261.11 268 271 270 269 278 281 281 285 286 289 289 293 294 294)
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
set outfile = isolated_atom_energy.csv
echo -n "" > ${outfile}
echo "Element, Total energy [Ry], filename" >> ${outfile}

mkdir work
#-----------------------------------------------------------------------
cd ${DFT}
set upf_list = `ls *.UPF`
cd ..
foreach upf_name (${upf_list})
  set element_name = `echo ${upf_name} | sed 's/\..*//g' | sed 's/\_.*//g' | awk '{print toupper($0)}'`
  set element_name_num = `echo ${#element_name}`
  echo $element_name_num
  if ("$element_name_num" == "1") then
    set element_name_part1 = `echo ${upf_name} | sed 's/\..*//g' | sed 's/\_.*//g' | awk '{print toupper($0)}' | cut -c 1-1`
    set element_name_part2 = `echo ${upf_name} | sed 's/\..*//g' | sed 's/\_.*//g' | cut -c 2-2`
    set element_name = `echo ${element_name_part1}${element_name_part2}`
  endif
  echo $element_name
  #
  set count = 1
  foreach atom ($element_list)
    if ("${atom}" == "${element_name}") then
      set mass = `echo $mass_list[$count] | awk '{printf("%9.5f",$1)}'`
      echo "${atom}:${mass}"
    endif
    @ count += 1
  end
#-----------------------------------------------------------------------
cat << EOF > isolated_atom.in
&CONTROL 
  calculation  = 'scf',
  prefix  = '${element_name}',
  outdir  = './work/${element_name}/',
  pseudo_dir = './${DFT}' , 
  etot_conv_thr = 5.0e-5,
  disk_io = 'none',
/
&SYSTEM 
  ibrav=1,
  celldm(1)=12.0,
  nat=1,
  ntyp=1,
  nosym=.true.,
EOF
if ($1 != "") then
  echo "  ecutwfc=$1," >> isolated_atom.in
endif
cat << EOF >> isolated_atom.in
  occupations = 'smearing' , 
  degauss  = 0.01 , 
  smearing = 'mp', 
  nspin = ${nspin},
  starting_magnetization(1) = 1 ,
  tot_magnetization = -1 ,
/
&ELECTRONS 
  mixing_beta=0.3,
  conv_thr=5.0E-7,
  electron_maxstep = 5000,
  diagonalization = 'rmm-davidson',
/
ATOMIC_SPECIES 
${element_name} ${mass} ${upf_name}
ATOMIC_POSITIONS alat
${element_name} 0.0 0.0 0.0
K_POINTS automatic
1 1 1  0 0 0
EOF
#-----------------------------------------------------------------------
  mpirun -np ${NCPUs} pw.x < isolated_atom.in | tee isolated_atom.out
  #mpirun -np ${NCPUs} --allow-run-as-root $HOME/q-e-qe-*/bin/pw.x < isolated_atom.in | tee isolated_atom.out
  #
  set TOTEN_Ry = `grep "  total energy  " isolated_atom.out | tail -1 | sed 's/.*=//g' | sed 's/Ry//g'`
  #set TOTEN = `echo "${TOTEN_Ry}*13.605693122990" | bc -l | awk '{printf "%15.10f",$0}'`
  set TOTEN = `echo "${TOTEN_Ry}" | bc -l | awk '{printf "%15.10f",$0}'`
  echo "----------eV/atom for isolated atom----------"
  echo "${element_name}:${TOTEN} eV: ${upf_name}"
  echo "${element_name}, ${TOTEN}, ${upf_name}" >> ${outfile}
end
#-----------------------------------------------------------------------