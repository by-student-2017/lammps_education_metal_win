#---------------------------------------------------------------------
## Installations and Usages

# Installation of qe-7.3
1. sudo apt update
2. sudo apt -y install gfortran gcc build-essential libopenmpi-dev fftw3-dev
3. sudo apt -y install gnuplot 
4. wget https://github.com/QEF/q-e/archive/refs/tags/qe-7.3.tar.gz
5. tar zxvf qe-7.3
6. cd q-e-qe-7.3
7. ./configure LAPACK_LIBS="-L/usr/lib/x86_64-linux-gnu  -lopenblas"
#--------------------------------------------------------
The following libraries have been found:
  BLAS_LIBS= -lopenblas
  LAPACK_LIBS=-L/usr/lib/x86_64-linux-gnu  -lopenblas
  FFT_LIBS= -lfftw3
#--------------------------------------------------------
8. make pwall
9. sudo make install
#Note: sudo apt install quantum-espresso # In my case, the calculation of pw.x failed in ubuntu 22.04 qe. I recommend using qe-7.2 or qe-7.3 (not qe-7.3.1 !!!). 

# Installation dos2unix
1. sudo apt update
2. sudo apt install dos2unix

# Installation of ASE (ASE. ver.3.19.0)
1. sudo apt update
2. sudo apt -y install python3-ase
3. find /usr/lib/python3/dist-packages/ase/io/ -name "espresso.py"
4. sudo vim /usr/lib/python3/dist-packages/ase/io/espresso.py
5. /mag_line.split
6. i
7. Change "mag_line.split()[5]" to "mag_line.split()[-1]".
8. ESC
9. wq

# On the SSSP potential of Dy
I asked the SSSP management, and they told me the following:
「Also, we dediced to take the Wentz. library as a whole for the lanthanides, for consistency.」
Note: "Can't you see the results of Dy on the website ?" he asked. The organizers are funny !  They didn't show the above in the paper. I'm not smart enough to know if it was a simple mistake or another reason.


# Get pseudo-potential
STUDENT, B. (2025). SUGGESTED PSEUDOPOTENTIALS for PBEsol v.1.0.0 [Data set]. Zenodo. https://doi.org/10.5281/zenodo.14912399
STUDENT, B. (2025). SUGGESTED PSEUDOPOTENTIALS for PBE v.1.0.0 [Data set]. Zenodo. https://doi.org/10.5281/zenodo.14912402
1. python3 get_zenodo_data.py

# PSlibrary (recommend)
0.1: F, Si
0.2: I, As(US)
0.2.1: Fe
0.2.3: Sc, V(US), Cr, Cs(US), Rb(US), Sr(US), K(US), Y
0.3.0: Au
0.3.1: Ti, Mn
1.0.0: La(US), Ce(US), Pr(US), Nd(US), Pm(US), Sm(US), Eu(US or PAW), Gd(PAW), Tb(PAW, US), Dy(PAW, US), Ho(US), Er(US), Tm(PAW), Yb(PAW), Lu(US)
               Th(US), Pa(US),  U(US), Np(US), Pu(US)
Ga: dn -> dnl
S: n - > nl

# PSlibrary_ONCV_GBRV_mix
main PSlibrary
Ne, Kr, Xe: ONCV in SSSP efficiency (Not He and Ar)
Ge, Li, Ni: GBRV in SSSP efficiency
La: wentzcovitch in SSSP efficiency (failed Ni-La)
Th, Pa, U, Np: marburg in SSSP efficiency (failed Cu-X, Ni-X, Al-Np))
Note: -> PSlibrary: La(US), Ra, Rn(Us), Th(US), U(US), Np(US), Pu(US)
Note: With Ni-Ar, even if the potential, QE version, and ubuntu are the same, the results can be different depending on whether you are using Linux only or WSL2 on Windows. This may also be the case for systems where Ec <= 0. With WSL2, it is easier to get a clean EOS even if Ec <= 0.
Note: -> marburg: U (Al-U is good)

# Energy of an isolated atom (PBE or PBEsol) (v2)
PSlibrary: total_psenergy
calculate: box (6 A), Gauss 0.02 Ry
Cs: BCC (re = 6 A), Gauss 0.02 Ry
Rn: FCC (re = 6 A), Gauss 0.02 Ry
Note: Ga and Ge calculation stops for unknown reasons.

# Mag
- Ferro: Cr, Fe-Ni, Fe-Co, Ni-Co
- Ferri: Mn
- Fe-Pt, Co-Pt
- Fe-Rh
- Mn-O, Ni-O

# Usage
1. gedit run_alloy_v1.0.py
   (elements = ['Fe', 'Cr', 'Al'] # <- Enter the element you want to calculate)
2. python3 run_alloy_v1.0.py

# Installation of bader (Version 1.05 08/19/23)
1. wget http://theory.cm.utexas.edu/henkelman/code/bader/download/bader_lnx_64.tar.gz
2. tar xzvf bader_lnx_64.tar.gz
3. chmod +x bader

# Usage (with bader analysis (need bader code, val.pp.in and all.pp.in file) 
1. gedit run_alloy_v1.1.py
2. python3 run_alloy_v1.1.py

# Usage (isolated atom energy) (pslibrary)
## bash version
1. chmod +x run_isolated_atom.sh
2. ./run_isolated_atom.sh
## csh version
1. chmod +x run_isolated_atom.csh
2. ./run_isolated_atom.csh
## I also tried "ASE", but the calculation stopped halfway through. I do not recommend to use "run_isolated_atom.py".

# Get pseudo-potential
https://www.materialscloud.org/discover/sssp/table/efficiency

# Usage (isolated atom energy) (SSSP-1.3.0)
1. sudo apt update
2. sudo apt install jq
3. chmod +x run_isolated_atom_SSSP.sh
4. ./run_isolated_atom_SSSP.sh
# Note: Once a calculation is complete, you want to recalculate it under different conditions.
5. gedit run_isolated_atom_SSSP.sh
-----
restart_mode = 'restart',
diagonalization = 'rmm-davidson',
-----
# Note: For example, for a system with poor convergence such as Cu, calculations may be performed with mp 0.02, and then recalculated later with mp 0.01, including for confirmation.

# Test
- Ubuntu 20.04.3 LTS, ase-3.19.0 and qe-7.2
- Ubuntu 22.04.5 LTS on WLS, ase-3.22.1 and qe-7.3
- Ubuntu 24.04 LTS, ase-3.22.1 and qe-7.3
# Note: qe-7.3.1 show ylmr2 error.
# Note: 0.02 [Ry] * 13.6 [eV] / 11605 [K/eV] = ca. 315.8 [K]
#---------------------------------------------------------------------
# For d = a3
Problems will arise if a3 becomes negative.
When erose_form=1, a3 = -attrac + replus/r, so the condition replus/attrac <= r exists.
In the case of erose_form=1, this has been improved in later data to show rc = replus/attrac in the figure.
#---------------------------------------------------------------------
# Failed
# PBE, BCC: P
# PBEsol-D2, B2: Fe-F: F.pbesol-n-kjpaw_psl.1.0.0.UPF -> F.pbesol-n-kjpaw_psl.0.1.UPF
# PBEsol-D2, B2: Fe-Si: Si.pbesol-n-kjpaw_psl.1.0.0.UPF -> Si.pbesol-nl-kjpaw_psl.1.0.0.UPF (Removed the parts that are not compatible with eos.)
# PBEsol-D2, B2: Fe-Ti: Ti.pbesol-spn-kjpaw_psl.1.0.0.UPF -> Ti.pbesol-spn-rrkjus_psl.1.0.0.UPF
# PBEsol-D2, B2: Fe-Cs: Cs.pbesol-spn-kjpaw_psl.1.0.0.UPF -> Cs.pbesol-spn-rrkjus_psl.1.0.0.UPF (All failed)
# PBEsol-D2, L12: Fe-Si: Si.pbesol-n-kjpaw_psl.1.0.0.UPF -> Si.pbesol-nl-kjpaw_psl.1.0.0.UPF
# PBEsol-D2, L12: Fe-F: F.pbesol-n-kjpaw_psl.1.0.0.UPF -> F.pbesol-n-kjpaw_psl.0.1.UPF
# PBEsol-D2, L12: Fe-Ti: Ti.pbesol-spn-kjpaw_psl.1.0.0.UPF -> Ti.pbesol-spn-rrkjus_psl.1.0.0.UPF
# PBEsol-D2, L12: Fe-Cs: Cs.pbesol-spn-kjpaw_psl.1.0.0.UPF -> Cs.pbesol-spn-rrkjus_psl.1.0.0.UPF
# PBE, B2: Al-Sc: Using SSSP-1.3.0 didn't work either. (Removed the parts that are not compatible with eos.)
# PBE, B2: Al-Pt: Using SSSP-1.3.0 didn't work either. (Removed the parts that are not compatible with eos.)
# PBE, B2: Al-Pd: Using SSSP-1.3.0 didn't work either. (All failed)
# PBE, B2: Al-I: I.pbe-n-kjpaw_psl.1.0.0.UPF -> I.pbe-n-kjpaw_psl.0.2.UPF (Removed the parts that are not compatible with eos.)
# PBE, L12: Al-Fe: Fe.pbe-spn-kjpaw_psl.1.0.0.UPF
# PBEsol-D2, L12: Al-Au: Au.pbesol-n-kjpaw_psl.1.0.0.UPF -> Au.pbesol-spfn-kjpaw_psl.1.0.0.UPF
# PBEsol-D2, L12: Al-Mn: Mn.pbesol-spn-kjpaw_psl.0.3.1.UPF (Specify re manually.)
# PBEsol-D3(no3body), L12: Al-Ar: Ar.pbesol-n-kjpaw_psl.1.0.0.UPF
# PBEsol-D3(no3body), L12: Al-Kr: Kr.pbesol-dn-kjpaw_psl.1.0.0.UPF
# PBEsol-D2, L12: Fr, Ac, etc -> PBEsol-D3(non threebody)
     Error in routine  init_london (2):
     atom Fr     not found
# qe-6.7: Ni DIA, In B2, Sb
#---------------------------------------------------------------------
# Cutoff: Materials Project
# 520 eV (= 38.22 Ry): All elements except "Boron"
# 700 eV (= 51.45 Ry): "Boron"
#---------------------------------------------------------------------

#---------------------------------------------------------------------
# Single element data by DFT
STUDENT, B. (2026). EOS Data for Single Element Structures (Spin-Polarized) Using Quantum ESPRESSO [Data set]. Zenodo. https://zenodo.org/records/15743193
#---------------------------------------------------------------------
# binary data by DFT
STUDENT, B. (2026). EOS Data for Binary Element Structures (FM Initialization) Using Quantum ESPRESSO [Data set]. Zenodo. https://zenodo.org/records/15743605
#---------------------------------------------------------------------

#---------------------------------------------------------------------
## pseudopotentials
Enter the pseudopotentials of the "pslibrary" to PBE or PBEsol directory. The list is in PSlibrary_PBE.json or PSlibrary_PBEsol.json .
PBE: https://pseudopotentials.quantum-espresso.org/legacy_tables/ps-library
PBEsol: generate on q-e-qe-6.3 with pslibrary.1.0.0.tar.gz (https://dalcorso.github.io/pslibrary/)
Note: https://dalcorso.github.io/pslibrary/PP_list.html <- The potential version was selected based on the description on this page.

I tried to add pseudopotentials, but github said it was full and wouldn't let me.
So I uploaded it on "Zenodo".
STUDENT, B. (2025). SUGGESTED PSEUDOPOTENTIALS for PBEsol v.1.0.0 [Data set]. Zenodo. https://doi.org/10.5281/zenodo.14912399
STUDENT, B. (2025). SUGGESTED PSEUDOPOTENTIALS for PBE v.1.0.0 [Data set]. Zenodo. https://doi.org/10.5281/zenodo.14912402
#----------------------------------
For database (e.g., 1element_data_PBE.zip)
STUDENT, B. (2026). Pseudopotentials for Quantum ESPRESSO-Based Database Construction (SSSP/Theos-Informed Selection) [Data set]. Zenodo. https://zenodo.org/records/15743264
#---------------------------------------------------------------------

#---------------------------------------------------------------------
## Results
1 element data: https://doi.org/10.5281/zenodo.15171902
#---------------------------------------------------------------------

#---------------------------------------------------------------------
v.1.1 (bader charge) [BC]
1. wget http://theory.cm.utexas.edu/henkelman/code/bader/download/bader_lnx_64.tar.gz
2. tar xzvf bader_lnx_64.tar.gz
3. chmod +x bader
[BC1] https://ma.issp.u-tokyo.ac.jp/app-post/2321
[BC2] https://theory.cm.utexas.edu/henkelman/code/bader/
#---------------------------------------------------------------------

#---------------------------------------------------------------------
sudo apt install dos2unix (WLS2 -> Linux)
dos2unix *.in
dos2unix *.py
#---------------------------------------------------------------------

#---------------------------------------------------------------------
spin polarization calculation for QE ver.6.8 or later.
1. find /usr/lib/python3/dist-packages/ase/io/ -name "espresso.py"
2. sudo vim /usr/lib/python3/dist-packages/ase/io/espresso.py
3. (search) /mag_line.split()[5]
4. (enter) i
5. Change "mag_line.split()[5]" to "mag_line.split()[-1]".
6. ESC -> wq
#---------------------------------------------------------------------

#---------------------------------------------------------------------
# vdW
'vdw_corr': 'dft-d3',
'dftd3_version': 3, # 4:Grimme-D3 (BJ damping) or 3:Grimme-D3 (zero damping) (default = 3) (Error: Al-O for 4) (The energy drops further at a volume close to the most stable level without being on the Marnahan scale.: Al-C for 3)
'dftd3_threebody': False, # If it is set to True, the calculation will hardly proceed at all.
#---------------------------------------------------------------------

#---------------------------------------------------------------------
Potfit: https://www.potfit.net/wiki/doku.php?id=config:main
Note: potfit fits the stress tensor, not the elastic constants. I also have a very hard time calculating the elastic constants correctly, so I've decided to comment out the calculation and output of the elastic constants.
#---------------------------------------------------------------------
potfit format

 #N natoms useforce
 #C type_0 type_1 type_2 ...
 #X boxx.x boxx.y boxx.z
 #Y boxy.x boxy.y boxy.z
 #Z boxz.x boxz.y boxz.z
 #B_S x y z r
 #B_O x y z
 #B_A x y z
 #B_B x y z
 #B_C x y z
 #W weight
 #E coh_eng
 #S stress_xx stress_yy stress_zz stress_xy stress_yz stress_xz
 #F 

The lines starting with #N, #X, #Y, #Z, #E and #F are mandatory, while the lines starting with #C, #W, #B and #S are optional. All other lines are ignored. #N must head the first line specifying the number of atoms in the configuration and an integer flag to control whether to use or to ignore force and stress information in this configuration. #F signifies the last header line. All parameters except the type_i are numbers and have the following meaning:
#---------------------------------------------------------------------
Potfit: https://www.potfit.net/wiki/doku.php?id=examples:configurations

#N 4 1
#C Al
## force file generated from file OUTCAR
#X    4.04836934    0.00000000    0.00000000
#Y    0.00000000    4.04836934    0.00000000
#Z    0.00000000    0.00000000    4.04836934
#W 1.000000
#E -3.6884100000
## type x y z f_x f_y f_z
#F
0           0           0           0           0           0           0
0           0     2.02418     2.02418           0           0           0
0     2.02418           0     2.02418           0           0           0
0     2.02418     2.02418           0           0           0           0
#N 4 1
#C Al
## force file generated from file OUTCAR
#X    4.04836934    0.00000000    0.00000000
#Y    0.00000000    4.04836934    0.00000000
#Z    0.00000000    0.00000000    4.04836934
#W 1.000000
#E -3.0536245000
#S   0.0954432   0.1134831   0.1081461  0.02513733  0.04822722 -0.001235955
## type x y z f_x f_y f_z
#F
0     0.40484     0.60726      0.4858   -3.544691   -5.412783   -4.538642
0           0     2.02418     2.02418   -1.035276    3.504476    3.673407
0     2.02418           0     2.02418    1.799793   -0.736215    1.791375
0     2.02418     2.02418           0    2.780173    2.644523   -0.926139
#---------------------------------------------------------------------


#---------------------------------------------------------------------
MPC v4: https://www.cavs.msstate.edu/icme/code/lammps/tutorials/MEAM/MPC.php
#---------------------------------------------------------------------


#---------------------------------------------------------------------
Zenodo
Figshare
OSF (Open Science Framework)
#---------------------------------------------------------------------

