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
- If you really want to calculate the phonons, you should consider the method of calculating 0 K with "Alamode + DFTB+ & xTB potential" (https://github.com/by-student-2017/alamode-example/tree/main/Si_DFTBplus).

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
# plot the temperature of each atom

- MSMPI_heat_map version file
1. *.cfg -> Ovito -> (upper right) Add modification... 
2. Color coding -> Input property: f_ave_tempatom
3. (click) Adjust range

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
# Input file


## Metal

[IFM1] P. Malakar et al., ACS Appl. Nano Mater. 5 (2022) 16489-16499.
  https://doi.org/10.1021/acsanm.2c03564 (lammps input file)


[IFM2] S. K. Achar et al., J. Chem. Theory Comput. 18 (2022) 3593-3606.
  https://doi.org/10.1021/acs.jctc.2c00010


[IFM3] M. Qamar et al., J. Chem. Theory, Comput. XXX (2023) XXX-XXXX.
  https://doi.org/10.1021/acs.jctc.2c01149


[IFM4] Y. A. Zulueta et al., Inorg. Chem. 59 (2020) 11841-11846.
  https://doi.org/10.1021/acs.inorgchem.0c01923 (Transition-Metal-Doped Li2SnO3)


[IFM5] M. Li et al., Nanomaterials 9 (2019) 347.
  https://doi.org/10.3390/nano9030347 (Graphene, The temperature of each atom)


[IFM6] Y.- P. Zhou et al., Sci. Rep. 7 (2017) 45516.
  https://www.nature.com/articles/srep45516


[IFM7] G. W. J. Mclntosh et al., (2016)
  https://cradpdf.drdc-rddc.gc.ca/PDFS/unc244/p804516_A1b.pdf


[IFM8] C. Wilkinson et al., SoftwareX 14 (2021) 100683.
  https://doi.org/10.1016/j.softx.2021.100683


[IFM9] Al-Cu Symmetric/Asymmetric Tilt Grain Boundary Dataset
  https://materialsdata.nist.gov/handle/11256/358


[IFM10] C.N. Andoh et al., Journal of Applied Science and Technology (JAST), Vol. 22, Nos. 1 & 2, 2017/18, pp. 01 - 13 
  https://www.researchgate.net/profile/Collins-Nana-Andoh/publication/327390429_MOLECULAR_DYNAMICS_SIMULATION_OF_MECHANICAL_DEFORMATION_OF_AUSTENITIC_STAINLESS_STEELS_Fe-Ni-Cr_ALLOYS_AT_SUPERCRITICAL_WATER_CONDITIONS/links/62ae336c938bee3e3f3f2253/MOLECULAR-DYNAMICS-SIMULATION-OF-MECHANICAL-DEFORMATION-OF-AUSTENITIC-STAINLESS-STEELS-Fe-Ni-Cr-ALLOYS-AT-SUPERCRITICAL-WATER-CONDITIONS.pdf


## Other

[IFO1] P. G. Boyd et al., J. Phys. Chem. Lett. 8 (2017) 357-363.
  https://doi.org/10.1021/acs.jpclett.6b02532 (MOF)


[IFO2] K. Banlusan et al., J. Phys. Chem. C 119 (2015) 25845-25852.
  https://doi.org/10.1021/acs.jpcc.5b05446 (MOF)


[IFO3] M. Witman et al., J. Phys. Chem. Lett. 10 (2019) 5929-5934.
  https://doi.org/10.1021/acs.jpclett.9b02449 (MOF)


[IFO4] J. P. Ruffley et al., J. Phys. Chem. C 124 (2020) 19873.
  https://doi.org/10.1021/acs.jpcc.0c07650 (MOF)


[IFO5] R. Anderson et al., Chem. Mater, 32 (2020) 8106-8119.
  https://doi.org/10.1021/acs.chemmater.0c00744 (MOF)


[IFO6] A. v. Wedelstedt et al., J. Chem. Inf. Model. 62 (2022) 1154-1159.
  https://doi.org/10.1021/acs.jcim.2c00158 (input file of MOF on Lammps and CP2k code)


[IFO7] J. J. Wardzala et al., J. Phys. Chem. C 124 (2020) 28469-28478.
  https://doi.org/10.1021/acs.jpcc.0c07040 (MOF)


[IFO8] M. C. Oliver et al., J. Phys. Chem. C 127 (2023) 6503-6514.
  https://doi.org/10.1021/acs.jpcc.2c08695 (MOF)


[IFO9] H. Xu et al., J. Chem. Theory Comput. 18 (2022) 2826-2835.
  https://doi.org/10.1021/acs.jctc.2c00094 (MOF)
  https://archive.materialscloud.org/record/2022.37


[IFO10] J. M. Findley et al., J. Phys. Chem. C 125 (2021) 8418-8429.
  https://doi.org/10.1021/acs.jpcc.1c00943 (input file of MOF on Lammps and RASPA code)


[IFO11] A. S. S. Daou et al., J. Phys. Chem. C 125 (2021) 5296-5305.
  https://doi.org/10.1021/acs.jpcc.0c09952 (input file of MOF on Lammps and RASPA code)


[IFO12] Z. Zhu et al., ACS Omega 7 (2022) 37640-37653.
  https://doi.org/10.1021/acsomega.2c04517 (input file of MOF on Lammps and RASPA code)


[IFO13] T. Weng et al., J. Phys. Chem. A 123 (2019) 3000-3012.
  https://doi.org/10.1021/acs.jpca.8b12311 (ZIF-8)


[IFO14] S. Wang et al., J. Chem. Theory Comput. 17 (2021) 5198-5213.
  https://doi.org/10.1021/acs.jctc.0c01132 (Zeolite)


[IFO15] P. Saidi et al., J. Phys. Chem. C 124 (2020) 26864-26873.
  https://doi.org/10.1021/acs.jpcc.0c08817 (GO)


[IFO16] M. L. Urquiza et al., ACS Nano 15 (2021) 12945-12954.
  https://doi.org/10.1021/acsnano.1c01466 (HfO2)


[IFO17] M. Deffner et al., J. Chem. Theory Comput. 19 (2023) 992-1002.
  https://doi.org/10.1021/acs.jctc.2c00648


[IFO18] W. A. Pisani et al., Ind. Eng. Chem. Res. 60 (2021) 13604-13613.
  https://doi.org/10.1021/acs.iecr.1c02440


[IFO19] K. Goloviznina et al., J. Chem. Theory Comput. 17 (2021) 1606-1617.
  https://doi.org/10.1021/acs.jctc.0c01002


[IFO20] C. Han et al., J. Phys. Chem. C 124 (2020) 20203-20212.
  https://doi.org/10.1021/acs.jpcc.0c05942


[IFO21] S. Sharma et al., J. Phys. Chem. A 124 (2020) 7832-7842.
  https://doi.org/10.1021/acs.jpca.0c06721


[IFO22] E. Braun et al., J. Chem. Theory Comput. 14 (2018) 5262-5272.
  https://doi.org/10.1021/acs.jctc.8b00446


[IFO23] Y. Chen et al., J. Phys. Chem. B 125 (2021) 8193-8204.
  https://doi.org/10.1021/acs.jpcb.1c01966


[IFO24] Y. Zhang et al., J. Phys. Chem. B 124 (2020) 5251-5264.
  https://doi.org/10.1021/acs.jpcb.0c04058


[IFO25] C. M. Tenney et al., J. Phys. Chem. C 117 (2013) 24673-24684.
  https://doi.org/10.1021/jp4039122


[IFO26] S. K. Achar et al., J. Phys. Chem. C 125 (2021) 14874-14882.
  https://doi.org/10.1021/acs.jpcc.1c01411
------------------------------------------------------------------------------
# Structure

[S1] N. Sakhavand et al., ACS Appl. Mater. Interfaces 7 (2015) 18312-18319.
  https://doi.org/10.1021/acsami.5b03967


[S2] M. Agrawal et al., J. Phys. Chem. Lett. 10 (2019) 7823-7830.
  https://doi.org/10.1021/acs.jpclett.9b03119


[S3] R. Thyagarajan et al., Chem. Mater. 32 (2020) 8020-8033.
  https://doi.org/10.1021/acs.chemmater.0c03057
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