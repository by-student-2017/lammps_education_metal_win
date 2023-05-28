# lammps_education_metal_win

* HEA = High Entropy Alloy

------------------------------------------------------------------------------
## lammps (windows 10 (64 bit))


## Installation
1. LAMMPS Windows Installer Repository (http://packages.lammps.org/windows.html) > their own download area > 64bit
  (https://rpm.lammps.org/windows/admin/64bit/index.html)
2. LAMMPS-64bit-18Jun2019.exe (https://rpm.lammps.org/windows/admin/64bit/LAMMPS-64bit-18Jun2019.exe)


## Gnuplot, Ovito and Python3
* Gnuplot (http://www.gnuplot.info/)
  http://www.yamamo10.jp/yamamoto/comp/gnuplot/inst_win/index.php
* Ovito (https://www.ovito.org/windows-downloads/)
* Python3 (Python 3.9, Python 3.8 or Python 3.7) from Microsoft Store


## Usage
1. click run.bat
2. cfg folder > click *.cfg


## How to change to another potential
1. notepad in.lmp

#----------(before)----------

#-----(Fe-Ni-Cr) (FCC)

#pair_style      eam/fs

#pair_coeff      * * ../potentials/eam/Fe-Ni-Cr_fcc.eam.fs Fe Ni Cr

#-----(Fe-Cr-W)


pair_style      hybrid/overlay eam/alloy eam/fs


pair_coeff      * * eam/alloy ../potentials/eam/FeCrW_d.eam.alloy Fe Cr W


pair_coeff      * * eam/fs    ../potentials/eam/FeCrW_s.eam.fs Fe Cr W


#---------------------------

#----------(after)----------

#-----(Fe-Ni-Cr) (FCC)


pair_style      eam/fs


pair_coeff      * * ../potentials/eam/Fe-Ni-Cr_fcc.eam.fs Fe Ni Cr

#-----(Fe-Cr-W)

#pair_style      hybrid/overlay eam/alloy eam/fs

#pair_coeff      * * eam/alloy ../potentials/eam/FeCrW_d.eam.alloy Fe Cr W

#pair_coeff      * * eam/fs    ../potentials/eam/FeCrW_s.eam.fs Fe Cr W

#---------------------------

## Reference_eam_database (Generalized EAM = GEAM)
* official version: Cu, Ag, Au, Ni, Pd, Pt, Al, Pb, Fe, Mo, Ta, W, Mg, Co, Ti, Zr
* test version: V, Ca, Na, Cr, Mn, Nb, Ir, Sr, Rh, Ru, Os, Hf, Re, Zn
* Any combination of these is possible. Don't expect too much about the "test version".

## tutorial_8_elastic
1. notepad potential.mod
2. run.bat
* notepad potential.mod (set potential)
* notepad init.mod (set masses for sw, tersoff or bop potential)

## tutorial_9_elastic_Temp
1. notepad potential.mod
2. notepad init.mod
3. run.bat
* notepad potential.mod (set potential)
* notepad init.mod (set temperature and masses)

## tutorial_10_phonon-primitive-cell
- "Alamode+Lammps" (https://github.com/by-student-2017/alamode-example.git) may be better for phonon calculation.
- "Alamode" is designed to be able to calculate finite temperatures efficiently, so it is a code worthy of careful consideration. The interface is more suitable for intermediate and advanced users than Phonopy, but I also like the fact that it officially supports Lammps.

## tutorial_11_hybrid
- The Example of EAM + MEAM + ADP hybrid potential
- If you are lucky enough to have all the potentials you want to calculate, even if they are separate, you can calculate them by hybridizing them like this.

## tutorial_12_interface
- It is an example of an interface. In addition, I recommend watching “Tutorials_by_NextZenStudent” and Youtube videos.


## tutorial_13_Machine_Learning_potential_MSMPI
- Calculation using potential by neural network. OpenKIM is available in the Linux version, so if you want to use more potential, please try the Linux version.

------------------------------------------------------------------------------
## lammps (windows 11 (64 bit))

## Installation (Lammps)
1. LAMMPS Windows Installer Repository (http://packages.lammps.org/windows.html) > Latest stable versions >admin > 64bit
  (https://rpm.lammps.org/windows/admin/64bit/index.html)
2. LAMMPS-64bit-18Jun2019.exe (LAMMPS-64bit-22Dec2022-MSMPI-admin.exe)


## Microsoft MPI
1. Microsoft MPI v10.1.2 (https://www.microsoft.com/en-us/download/details.aspx?id=100593)

## Gnuplot, Ovito and Python3
* Gnuplot (http://www.gnuplot.info/)
  http://www.yamamo10.jp/yamamoto/comp/gnuplot/inst_win/index.php
* Ovito (https://www.ovito.org/windows-downloads/)

## Python3 (installation) on PowerShell
1. python3
2. python3 -m pip install numpy

## Usage (MS-MPI version)
1. click run_msmpi.bat
2. cfg folder > click *.cfg

------------------------------------------------------------------------------
# units and potential

## units metal

・Stillinger-Weber (SW)

・Tersoff

・EAM, FS

・MEAM

・ADP

・REBO, AIREBO

・COMB

・EIM

・BOP

・adiabatic core/shell model

・Streitz-Mintmire

・vashishta

------------------------------------------------------------------------------
# potential files

## potentials


[1] NIST Interatomic Potential
  https://www.ctcms.nist.gov/potentials/
  https://www.ctcms.nist.gov/potentials/resources.html


[2] Database of Published Interatomic Potential Parameters
  https://www.ucl.ac.uk/klmc/Potentials/


[3] EAM potentials
  https://sites.google.com/site/eampotentials/Home


[4] JARVIS for Force-fields
  https://www.ctcms.nist.gov/~knc6/periodic.html


[5] Embedded Atom Method (EAM) Tabulation
  https://atsimpotentials.readthedocs.io/en/latest/potentials/eam_tabulation.html


[6] Carbon Potentials
  http://www.carbonpotentials.org/potentials


[7] XMD - Molecular Dynamics for Metals and Ceramics 
  http://xmd.sourceforge.net/eam.html


[8] Potentials generated with potfit
  https://www.potfit.net/wiki/doku.php?id=potentials:main


[9] Interatomic Potential Generation
  https://icme.hpc.msstate.edu/mediawiki/index.php/Interatomic_Potential_Generation


[10] Potentials
  https://norman.jiht.ru/wiki/index.php/Potentials


[11] Dr. Adri van Duin 
  https://www.engr.psu.edu/adri/


[12] Welcome to the Knowledgebase of Interatomic Models! (OpenKIM)
  https://openkim.org/


[13] potential_LAMMPS Reference Records
  https://github.com/usnistgov/iprPy/tree/master/library/potential_LAMMPS


[14] KIST Integrated Force Field Platform
  http://kiff.vfab.org/


------------------------------------------------------------------------------
# References

[MC1] Monte Carlo simulations with LAMMPS
  https://lammps.sandia.gov/workshops/Aug15/PDF/talk_Thompson1.pdf


[MC2] fix tfmc command (amorphous -> crystal)
  https://lammps.sandia.gov/doc/fix_tfmc.html
  https://lammps.sandia.gov/threads/msg69314.html
  https://lammps.sandia.gov/threads/msg69318.html
  https://lammps.sandia.gov/threads/msg69323.html
  https://lammps.sandia.gov/threads/msg69348.html
  https://lammps.sandia.gov/threads/msg69352.html


[SGC1] vcsgc-lammps (semi-grandcanonical) (pair_style eam/cd, eam/alloy or  eam/fs)
  https://vcsgc-lammps.materialsmodeling.org/


[GCMC1] fix gcmc command
  https://lammps.sandia.gov/doc/fix_gcmc.html


[GCMC2] Grand canonical Monte Carlo simulations of gas uptake in microporous materials using LAMMPS
  https://www.osti.gov/servlets/purl/1120653


[GCMC3] pysimm
  https://www.sciencedirect.com/science/article/pii/S2352711018300141 (paper)
  https://pysimm.org/ (code)


[R1] Nanofluidics An Introduction
  https://books.google.co.jp/books?id=VwqWDwAAQBAJ


------------------------------------------------------------------------------ 