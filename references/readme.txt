-------------------------------------------------------------------
input file (metal unit, lammps)

- G. W. J. Mclntosh et al., (2016)
  https://cradpdf.drdc-rddc.gc.ca/PDFS/unc244/p804516_A1b.pdf
  Al and Explosive
  
- C.N. Andoh et al., J. Appl. Sci. Tech. 22 (2017) 1-13.
  https://www.researchgate.net/profile/Collins-Nana-Andoh/publication/327390429_MOLECULAR_DYNAMICS_SIMULATION_OF_MECHANICAL_DEFORMATION_OF_AUSTENITIC_STAINLESS_STEELS_Fe-Ni-Cr_ALLOYS_AT_SUPERCRITICAL_WATER_CONDITIONS/links/62ae336c938bee3e3f3f2253/MOLECULAR-DYNAMICS-SIMULATION-OF-MECHANICAL-DEFORMATION-OF-AUSTENITIC-STAINLESS-STEELS-Fe-Ni-Cr-ALLOYS-AT-SUPERCRITICAL-WATER-CONDITIONS.pdf
  Fe-Ni-Cr_alloys

- S. K. Achar et al., J. Chem. Theory Comput. 18 (2022) 3593-3606.
  https://doi.org/10.1021/acs.jctc.2c00010
  UiO-66 (It can not be calculated unless it is a Lammps that supports deepmd.)

- Y. A. Zulueta et al., Inorg. Chem. 59 (2020) 11841-11846.
  https://doi.org/10.1021/acs.inorgchem.0c01923 (Transition-Metal-Doped Li2SnO3)
  TMD_Li2SnO3

- M. Li et al., Nanomaterials 9 (2019) 347.
  https://doi.org/10.3390/nano9030347 (Graphene, The temperature of each atom)
  Graphene

- Y.- P. Zhou et al., Sci. Rep. 7 (2017) 45516.
  https://www.nature.com/articles/srep45516
  Borophene
  
- P. Malakar et al., ACS Appl. Nano Mater. 5 (2022) 16489-16499.
  https://doi.org/10.1021/acsanm.2c03564 (lammps input file)
  Crack (It cannot be calculated unless it is a Lammps that supports the SW potential file of "MoS2".)

- M. Valavi et al., Cem. Concr. Res. 154 (2022) 106712.
  https://doi.org/10.1016/j.cemconres.2022.106712

- C. Wilkinson et al., SoftwareX 14 (2021) 100683.
  https://doi.org/10.1016/j.softx.2021.100683

- M. Qamar et al., J. Chem. Theory, Comput. XXX (2023) XXX-XXXX.
  https://doi.org/10.1021/acs.jctc.2c01149
  
- J. A. Dawson et al., J. Phys. Chem. C 122 (2018) 23978–23984.
  https://doi.org/10.1021/acs.jpcc.8b08208
  
- S. Shivpuje et al., 
  https://scholar.archive.org/work/ad7atvw33feslkudnhe2piyyhm/access/wayback/https://s3-eu-west-1.amazonaws.com/pstorage-tf-iopjsd8797887/17412845/gmos_a_1619929_sm5753.pdf

- Z. Wang, J. Phys. Chem. C 124 (2020) 3851–3856.
  https://doi.org/10.1021/acs.jpcc.9b10706
  CNT

- R. G. Patel et al., J. Comput. Phys. 449 (2022) 110754.
  https://doi.org/10.1016/j.jcp.2021.110754
  Cu_shock
-------------------------------------------------------------------
plot the temperature of each atom

1. *.cfg -> Ovito -> (upper right) Add modification...
2. Color coding -> Input property: f_ave_tempatom
3. (click) Adjust range
-------------------------------------------------------------------