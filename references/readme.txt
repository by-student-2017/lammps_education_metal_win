-------------------------------------------------------------------
input file (metal unit, lammps)
  
- C.N. Andoh et al., J. Appl. Sci. Tech. 22 (2017) 1-13.
  https://www.researchgate.net/profile/Collins-Nana-Andoh/publication/327390429_MOLECULAR_DYNAMICS_SIMULATION_OF_MECHANICAL_DEFORMATION_OF_AUSTENITIC_STAINLESS_STEELS_Fe-Ni-Cr_ALLOYS_AT_SUPERCRITICAL_WATER_CONDITIONS/links/62ae336c938bee3e3f3f2253/MOLECULAR-DYNAMICS-SIMULATION-OF-MECHANICAL-DEFORMATION-OF-AUSTENITIC-STAINLESS-STEELS-Fe-Ni-Cr-ALLOYS-AT-SUPERCRITICAL-WATER-CONDITIONS.pdf
  Fe-Ni-Cr_alloys

- A. C. C. Dutra et al., Energy Adv., 2 (2023) 653-666.
  https://doi.org/10.1039/D3YA00075C
  Li4OCl2

- J. A. Dawson et al., J. Phys. Chem. C 122 (2018) 23978–23984.
  https://doi.org/10.1021/acs.jpcc.8b08208
  Li3OCl

- Y. A. Zulueta et a., J. Phys. Chem. C 124 (2020) 4982-4988.
  https://doi.org/10.1021/acs.jpcc.9b10003
  Li2SiO3

- Y. A. Zulueta et al., Inorg. Chem. 59 (2020) 11841-11846.
  https://doi.org/10.1021/acs.inorgchem.0c01923 (Transition-Metal-Doped Li2SnO3)
  ---------- ---------- ---------- ---------- ---------- ----------
- Y. Zulueta et al., Chem. Rxiv. (2020).
  https://chemrxiv.org/engage/chemrxiv/article-details/60c74cb5bb8c1a8cce3db48a
  10.26434/chemrxiv.12523640.v1
  ---------- ---------- ---------- ---------- ---------- ----------
  Metal-Doped_Li2SnO3
  
- Z. Wang, J. Phys. Chem. C 124 (2020) 3851–3856.
  https://doi.org/10.1021/acs.jpcc.9b10706
  CNT
  ------------------------------------------------
  http://idr.mnit.ac.in/bitstream/123456789/776/1/2015PDE5197-Komal%20Rathi.pdf
  
- M. Li et al., Nanomaterials 9 (2019) 347.
  https://doi.org/10.3390/nano9030347 (Graphene, The temperature of each atom)
  Graphene
  
- Y. Gao et al., Membranes12 (2022) 886.
  https://doi.org/10.3390/membranes12090886
  membranes

- Y.- P. Zhou et al., Sci. Rep. 7 (2017) 45516.
  https://www.nature.com/articles/srep45516
  Borophene
  
- M. Vaezi et al., J. Chem. Phys. 153 (2020) 234702.
  https://doi.org/10.1063/5.0029490
  05_C60_on_BN
  
- ERIK FRANSSON, JOHANNES LAURELL H˚AKANSSON, Master’s Thesis in Applied Physics (2014).
  BaZrO3
  
- G. V. Huerta et al., Doctoral Thesis (2019).
  https://www.repo.uni-hannover.de/bitstream/handle/123456789/4482/GesamtRevisedFinal.pdf?sequence=1&isAllowed=y
  YSZ
  
- J. A. Greathouse et al., J. Phys.: Condens. Matter 32 (2020) 085401.
  https://iopscience.iop.org/article/10.1088/1361-648X/ab5377
  10.1088/1361-648X/ab5377
  ZrW2O8 (Core-shell model + Buckingham potential + harmonic)
  
- P. Malakar et al., ACS Appl. Nano Mater. 5 (2022) 16489-16499.
  https://doi.org/10.1021/acsanm.2c03564 (lammps input file)
  Crack (It cannot be calculated unless it is a Lammps that supports the SW potential file of "MoS2".)
  
- R. G. Patel et al., J. Comput. Phys. 449 (2022) 110754.
  https://doi.org/10.1016/j.jcp.2021.110754
  Cu_shock
  
- G. W. J. Mclntosh et al., (2016)
  https://cradpdf.drdc-rddc.gc.ca/PDFS/unc244/p804516_A1b.pdf
  Al and Explosive
  
- J. M. O.-Roldan et al., Proc. Math. Phys. Eng. Sci. 478 (2022).
  https://doi.org/10.1098/rspa.2022.0201
  Ordered_Nanoporous_Metals
  (ERROR: Molecule auto special bond generation overflow)
  
- A. Fredriksson, Master Thesis (2022).
  https://lup.lub.lu.se/luur/download?func=downloadFile&recordOId=9079628&fileOId=9079859
  tungsten
  
- K.-J. Carter, Bachelor Thesis (2017).
  https://dspace.mit.edu/bitstream/handle/1721.1/112482/1011413174-MIT.pdf?sequence=1&isAllowed=y
  Irradiation
  
- D. Chen et al., Master thesis (2011).
  https://oaktrust.library.tamu.edu/bitstream/handle/1969.1/ETD-TAMU-2011-08-10112/CHEN-THESIS.pdf?sequence=2&isAllowed=y
  polyfe (need polyfe.lammps)
  
- D. Chen et al., Doctor Thesis (2014).
  https://oaktrust.library.tamu.edu/handle/1969.1/154160
  radiation (need datafile.lammps) (Structure of (013)[100]Σ = 5 symmetric-tilt grain boundary)
  -----------------------------------------------------------------------------------------------
  The cell has a dimension of 14nm×14nm×14nm, which contains about 250000 atoms.
  The damage cascade is created by bombardment with one 3 keV Fe atom, which is incident at 
    9 degrees away from the cell normal direction. This avoids ion channeling and helps to 
    confine the damage cascade within the cell. The cell further contains a grain boundary, 
    which is created by putting two bcc-Fe domains together. Prior to the ion bombardment, 
    the bcc alpha-Fe is structurally relaxed to achieve energy minimization. Simulation is 
    performed with the cell temperature at 450K. 
  -----------------------------------------------------------------------------------------------

- S. Shivpuje et al., 
  https://scholar.archive.org/work/ad7atvw33feslkudnhe2piyyhm/access/wayback/https://s3-eu-west-1.amazonaws.com/pstorage-tf-iopjsd8797887/17412845/gmos_a_1619929_sm5753.pdf

- A. Rohskopf et al., Comput. Mater. Sci. 184 (2020) 109884.
  https://doi.org/10.1016/j.commatsci.2020.109884
  IAPs (GaN)

- Z. Liu et al., ACS Appl. Mater. Interfaces 13 (2021) 53409-53415.
  https://doi.org/10.1021/acsami.1c11595
  mlip (failed)
  
- S. K. Achar et al., J. Chem. Theory Comput. 18 (2022) 3593-3606.
  https://doi.org/10.1021/acs.jctc.2c00010
  UiO-66 (It can not be calculated unless it is a Lammps that supports deepmd.)
  
- M. Valavi et al., Cem. Concr. Res. 154 (2022) 106712.
  https://doi.org/10.1016/j.cemconres.2022.106712
  ERICA (need Structure.data)
  
- M. Qamar et al., J. Chem. Theory, Comput. XXX (2023) XXX-XXXX.
  https://doi.org/10.1021/acs.jctc.2c01149
  anc
  
- C. Wilkinson et al., SoftwareX 14 (2021) 100683.
  https://doi.org/10.1016/j.softx.2021.100683
  see https://github.com/ElsevierSoftwareX/SOFTX_2020_31 (github)
  
- M. P. Hazarika, Master Thesis (2019).
  http://dspace.cus.ac.in/jspui/bitstream/1/6333/1/Manash%20Protim%20Hazarika-Chemistry-MPhil.pdf
  
- Introduction to atomman: Running LAMMPS and the Log class
  https://www.ctcms.nist.gov/potentials/testing/atomman/tutorial/2.2._Running_LAMMPS_and_the_Log_class.html

- C. K. Mallick, Thesis (2014).
  http://ethesis.nitrkl.ac.in/6566/
  3d-crystal (need structure files and modifying input files)
  
- Divya and Kamal, Zeba (2013)
  http://ethesis.nitrkl.ac.in/5337/
  
- Venumbaka , Sarat Chandra (2015) 
  http://ethesis.nitrkl.ac.in/7043/
  
- Dora, Jay Krishan (2014)
  http://ethesis.nitrkl.ac.in/6375/
-------------------------------------------------------------------
plot the temperature of each atom

1. *.cfg -> Ovito -> (upper right) Add modification...
2. Color coding -> Input property: f_ave_tempatom
3. (click) Adjust range
-------------------------------------------------------------------