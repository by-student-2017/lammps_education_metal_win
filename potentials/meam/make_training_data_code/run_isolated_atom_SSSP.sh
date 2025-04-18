#!/bin/bash

#-----------------------------------------------------------------------
# Test: qe-7.2 and qe-7.3 on Ubuntu 22.04 LTS or Ubuntu 24.04 LTS

#-----------------------------------------------------------------------
NCPUs=8

DFT="PBE" # PBE or PBEsol
mode="efficiency" # efficiency or precision
outfile="isolated_atom_energies_SSSP-1.3.0_${DFT}_${mode}.csv"
jsonfile="SSSP-1.3.0_${DFT}_${mode}.json"

export OMP_NUM_THREADS=1
nspin=2 # 1:non-spin, 2:spin

degauss=0.02
smearing=gauss # gauss or mp
mixing_beta=0.7
diagonalization=david # david or rmm-davidson
electron_maxstep=1000

restart_mode=from_scratch # from_scratch or restart
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
element_list=("H" "He" "Li" "Be" "B" "C" "N" "O" "F" "Ne" "Na" "Mg" "Al" "Si" "P" "S" "Cl" "Ar" "K" "Ca" "Sc" "Ti" "V" "Cr" "Mn" "Fe" "Co" "Ni" "Cu" "Zn" "Ga" "Ge" "As" "Se" "Br" "Kr" "Rb" "Sr" "Y" "Zr" "Nb" "Mo" "Tc" "Ru" "Rh" "Pd" "Ag" "Cd" "In" "Sn" "Sb" "Te" "I" "Xe" "Cs" "Ba" "La" "Ce" "Pr" "Nd" "Pm" "Sm" "Eu" "Gd" "Tb" "Dy" "Ho" "Er" "Tm" "Yb" "Lu" "Hf" "Ta" "W" "Re" "Os" "Ir" "Pt" "Au" "Hg" "Tl" "Pb" "Bi" "Po" "At" "Rn" "Fr" "Ra" "Ac" "Th" "Pa" "U" "Np" "Pu" "Am" "Cm" "Bk" "Cf" "Es" "Fm" "Md" "No" "Lr" "Rf" "Db" "Sg" "Bh" "Hs" "Mt" "Ds" "Rg" "Cn" "Nh" "Fl" "Mc" "Lv" "Ts" "Og")
mass_list=(1.00794 4.00260 6.941 9.01218 10.81 12.01 14.007 16.00 18.9984 20.180 22.99 24.305 26.98 28.1 30.97 32.1 35.45 39.95 39.10 40.08 44.955912 47.867 50.9415 51.9961 54.938045 55.845 58.933195 58.6934 63.546 65.38 69.723 72.63 74.92160 78.96 79.904 83.798 85.4678 87.62 88.90585 91.224 92.90638 95.96 98 101.07 102.90550 106.42 107.8682 112.411 114.818 118.710 121.760 127.60 126.90447 131.293 132.9054519 137.33 138.90547 140.116 140.90765 144.242 145 150.36 151.964 157.25 158.92535 162.500 164.93032 167.259 168.93421 173.054 174.9668 178.49 180.94788 183.84 186.207 190.23 192.217 195.084 196.966569 200.59 204.3833 207.2 208.98040 209 210 222 223 226 227 232.0381 231.03588 238.02891 237 244 243 247 247 251 252 257 258 259 262 261.11 268 271 270 269 278 281 281 285 286 289 289 293 294 294)
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
date > log.txt
echo "#-----------------------------------------------------------------" >> log.txt
echo "# DFT:${DFT}, mode:${mode}, spin:${nspin}" >> log.txt
echo "# degauss:${degauss}, smearing:${smearing}, mixing_beta:${mixing_beta}" >> log.txt
echo "# diagonalization:${diagonalization}, electron_maxstep:${electron_maxstep}" >> log.txt
echo "# restart_mode:${restart_mode}" >> log.txt
echo "#-----------------------------------------------------------------" >> log.txt
echo -n "" > ${outfile}
echo "{" > ${jsonfile}
echo "Element, Total energy [Ry], filename, cutoff_wfc [Ry], cutoff_rho [Ry], valence_electrons, Type, tot_mag [Bohr mag/cell], abs_mag [Bohr mag/cell]" >> ${outfile}

mkdir -p work
#-----------------------------------------------------------------------
cd ${mode}
#upf_list=($(ls *.UPF *.upf 2>/dev/null | sort)) # Linux is OK
upf_list=($(ls *.[Uu][Pp][Ff] | sort -f)) # Windows is OK
#for upf_name in "${upf_list[@]}"; do
#  echo ${upf_name}
#done
cd ..
for upf_name in "${upf_list[@]}"; do
  element_name=$(echo ${upf_name} | awk '{print toupper(substr($0, 1, 1)) tolower(substr($0, 2, 1))}' | sed 's/\..*//g' | sed 's/\_.*//g')
  echo $element_name
  #
  count=1
  for atom in "${element_list[@]}"; do
    if [ "${atom}" == "${element_name}" ]; then
      mass=$(echo ${mass_list[$count-1]} | awk '{printf("%9.5f",$1)}')
      echo "${atom}:${mass}"
    fi
    count=$((count + 1))
  done
#-----------------------------------------------------------------------
  # Extract cutoff values from SSSP-1.3.0_PBE_efficiency.json or SSSP-1.3.0_PBE_precision.json
  cutoff_wfc=$(jq -r --arg element "$element_name" '.[$element].cutoff_wfc' ./${mode}/SSSP-1.3.0_${DFT}_${mode}.json)
  cutoff_rho=$(jq -r --arg element "$element_name" '.[$element].cutoff_rho' ./${mode}/SSSP-1.3.0_${DFT}_${mode}.json)
  pstype=$(jq -r --arg element "$element_name" '.[$element].pseudopotential' ./${mode}/SSSP-1.3.0_${DFT}_${mode}.json)

cat << EOF > isolated_atom.in
&CONTROL 
  calculation  = 'scf',
  prefix  = '${element_name}',
  outdir  = './work/${element_name}/',
  pseudo_dir = './${mode}' , 
  etot_conv_thr = 1.0e-4,
  disk_io = 'low',
  restart_mode = '${restart_mode}',
/
&SYSTEM 
  ibrav=1,
  celldm(1)=12.0,
  nat=1,
  ntyp=1,
  nosym=.true.,
  ecutwfc=${cutoff_wfc},
  ecutrho=${cutoff_rho},
EOF
cat << EOF >> isolated_atom.in
  occupations = 'smearing' , 
  degauss  = ${degauss} , 
  smearing = '${smearing}', 
  nspin = ${nspin},
  starting_magnetization(1) = 0 ,
/
&ELECTRONS 
  mixing_beta=${mixing_beta},
  conv_thr=1.0E-6,
  electron_maxstep = ${electron_maxstep},
  diagonalization = '${diagonalization}',
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
  TOTEN_Ry=$(grep "  total energy  " isolated_atom.out | tail -1 | sed 's/.*=//g' | sed 's/Ry//g' | sed 's/ //g')
  valence_electrons=$(grep "  number of electrons  " isolated_atom.out | tail -1 | sed 's/.*=//g' | sed 's/(.*//g' |  sed 's/ //g')
  #TOTEN=$(echo "${TOTEN_Ry}*13.605693122990" | bc -l | awk '{printf "%15.10f",$0}')
  #TOTEN=$(echo "${TOTEN_Ry}*1.0" | bc -l | awk '{printf "%15.10f",$0}')
  md5=$(grep "MD5 check sum" isolated_atom.out | sed 's/.*://g' | sed 's/ //g')
  echo "----------eV/atom for isolated atom----------"
  #
  if [ "${nspin}" == 2 ]; then
    tot_mag=$(grep "  total magnetization  " isolated_atom.out | tail -1 | sed 's/.*=//g' | sed 's/Bohr.*//g' | sed 's/ //g')
    abs_mag=$(grep "  absolute magnetization  " isolated_atom.out | tail -1 | sed 's/.*=//g' | sed 's/Bohr.*//g' | sed 's/ //g')
cat << EOF >> ${jsonfile}
    "${element_name}": {
        "filename": "${upf_name}",
        "total_psenergy": ${TOTEN_Ry},
        "pseudopotential": "${pstype}",
        "relativistic": "scalar",
        "cutoff_wfc": ${cutoff_wfc},
        "cutoff_rho": ${cutoff_rho},
        "valence_electrons": ${valence_electrons},
        "total_magnetization": ${tot_mag},
        "absolute_magnetization": ${abs_mag},
        "md5": "${md5}"
    },
EOF
  else
    tot_mag = 0.0
    abs_mag = 0.0
cat << EOF >> ${jsonfile}
    "${element_name}": {
        "filename": "${upf_name}",
        "total_psenergy": ${TOTEN_Ry},
        "pseudopotential": "${pstype}",
        "relativistic": "scalar",
        "cutoff_wfc": ${cutoff_wfc},
        "cutoff_rho": ${cutoff_rho},
        "valence_electrons": ${valence_electrons},
        "md5": "${md5}"
    },
EOF
  fi
  #
  echo "${element_name}:${TOTEN_Ry} [Ry]: ${upf_name}:${cutoff_wfc} [Ry]:${cutoff_rho} [Ry]:${valence_electrons}:${pstype}:${tot_mag}:${abs_mag}"
  echo "${element_name}, ${TOTEN_Ry}, ${upf_name}, ${cutoff_wfc}, ${cutoff_rho}, ${valence_electrons}, ${pstype}, ${tot_mag}, ${abs_mag}" >> ${outfile}
  #
  Iter=$(grep "iteration #" isolated_atom.out | tail -1 | sed 's/ecut=.*//g')
  accuracy=$(grep "  estimated scf accuracy  " isolated_atom.out | tail -1)
  echo ${element_name}:${Iter}:${accuracy} >> log.txt
done
#-----------------------------------------------------------------------
cat << EOF >> ${jsonfile}
    "XX": {
        "filename": "",
        "total_psenergy": 0.0,
        "pseudopotential": "none",
        "relativistic": "none",
        "cutoff_wfc": 0.0,
        "cutoff_rho": 0.0,
        "valence_electrons": 0.0,
        "md5": ""
    }
}
EOF
#-----------------------------------------------------------------------
