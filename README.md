# lammps_education_metal_win

------------------------------------------------------------------------------
## lammps (windows 10 (64 bit))


## Installation
1. LAMMPS Windows Installer Repository (http://packages.lammps.org/windows.html) > "their own download area" > ”64bit"
  (https://rpm.lammps.org/windows/admin/64bit/index.html)
2. LAMMPS-64bit-18Jun2019.exe (https://rpm.lammps.org/windows/admin/64bit/LAMMPS-64bit-18Jun2019.exe)


## gnuplot and Ovito
* gnuplot（http://www.gnuplot.info/）
  http://www.yamamo10.jp/yamamoto/comp/gnuplot/inst_win/index.php
* Ovito（https://www.ovito.org/windows-downloads/）


## Usage
1. click run.bat
2. cfg folder > click *.cfg


## How to change to another potential

#----------(before)----------

#-----(Fe-Ni-Cr) (FCC)

#pair_style      eam/fs

#pair_coeff      * * ./eam/Fe-Ni-Cr_fcc.eam.fs Fe Ni Cr

#-----(Fe-Cr-W)


pair_style      hybrid/overlay eam/alloy eam/fs


pair_coeff      * * eam/alloy ./eam/FeCrW_d.eam.alloy Fe Cr W


pair_coeff      * * eam/fs    ./eam/FeCrW_s.eam.fs Fe Cr W


#---------------------------

#----------(after)----------

#-----(Fe-Ni-Cr) (FCC)


pair_style      eam/fs


pair_coeff      * * ./eam/Fe-Ni-Cr_fcc.eam.fs Fe Ni Cr

#-----(Fe-Cr-W)

#pair_style      hybrid/overlay eam/alloy eam/fs

#pair_coeff      * * eam/alloy ./eam/FeCrW_d.eam.alloy Fe Cr W

#pair_coeff      * * eam/fs    ./eam/FeCrW_s.eam.fs Fe Cr W

#---------------------------


## Reference_eam_database (Generalized EAM = GEAM)
* official version: Cu, Ag, Au, Ni, Pd, Pt, Al, Pb, Fe, Mo, Ta, W, Mg, Co, Ti, Zr
* test version: V, Ca, Na, Cr, Mn, Nb, Ir, Sr, Rh, Ru, Os, Hf, Re, Zn
* Any combination of these is possible. Don't expect too much about the "test version".

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