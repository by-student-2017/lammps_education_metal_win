#!/bin/bash

## Installation
# Ubuntu 22.04 LTS or WSL2
# 1. wget https://atomsk.univ-lille.fr/code/atomsk_b0.13.1_amd64.deb
# 2. sudo dpkg -i atomsk_b0.13.1_amd64.deb
# 3. atomsk

# Usage
# bash run_atomsk.sh

# Error case
# 

echo "atomsk ver. beta 0.13.1"

cat << EOF1 > atomsk_commands
atomsk --create fcc 3.52 Ni Fcc_Ni.cfg -ow
atomsk Fcc_Ni.cfg -duplicate 40 40 80 Ni_Supercell_512000.cfg -ow
atomsk Ni_Supercell_512000.cfg -select random 20% Ni -substitute Ni Cr Ni4Cr_Supercell_512000.cfg -ow
atomsk Ni4Cr_Supercell_512000.cfg -select in sphere 0.5*box 0.5*box 0.5*box 13 -rmatom select Ni4Cr_13Void_Supercell_512000.cfg -ow
atomsk Ti3SiC2_1x2x1.cif -duplicate 46 26 16 Ti3SiC2_Supercell.cfg -ow
atomsk Ti3SiC2_Supercell.cfg -select out sphere 0.5*box 0.5*box 0.5*box 13 -rmatom select 13Ti3SiC2_Sphere.cfg -ow
atomsk --merge 2 Ni4Cr_13Void_Supercell_512000.cfg 13Ti3SiC2_Sphere.cfg Ni4Cr_13Ti3SiC2_Supercell_512000.cfg -ow
atomsk Ni4Cr_13Ti3SiC2_Supercell_512000.cfg -properties NiCrTiSiC_atomtypes.txt lammps -ow
EOF1

cat << EOF2 > NiCrTiSiC_atomtypes.txt
#Atom types for use with LAMMPS or IMD
#Note that any number can be assigned to each species
type
Ni 1
Cr 2
Ti 3
Si 4
C  5
EOF2

while IFS= read -r line
do
  $line
done < atomsk_commands

