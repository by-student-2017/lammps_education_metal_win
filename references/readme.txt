-------------------------------------------------------------------
### Be careful !
### It is often the case that the github and appendices mentioned in a paper disappear after a few years. If you are not careful, they may disappear. 
-------------------------------------------------------------------
# Custom Lammps Script: https://www.ericnhahn.com/tutorials/lammps-tutorials/creating-polycrystalline-structure-via-sintering
# LAMMPS Tube: https://lammpstube.com/category/lammps-tutorials/
# Cold_Rolling: https://github.com/khaledb9/Cold_Rolling/tree/main
# HandsOn_MD1: https://github.com/Gracen6/HandsOn_MD1
# HandsOn_MD2: https://github.com/Gracen6/HandsOn_MD2
# HandsOn_MD3: https://github.com/Gracen6/HandsOn_MD3
# thermal_expansion: https://github.com/yanxon/thermal_expansion/tree/master
# diffusion: https://github.com/yanxon/diffusion
# catch bond mechanism: https://github.com/keten-group/2tethermodel
# CeO2: https://github.com/sebasatc-115/CeO2/tree/main
# Tensile-Test-of-Functionally-Graded-Ni-Al-FGM-NW: https://github.com/msehabibur/Tensile-Test-of-Functionally-Graded-Ni-Al-FGM-NW
# Grand-canonical MD simulation with H4D method: https://github.com/Jeongmin0658/h4d_lammps
# capture electron-ion interaction and electronic stopping: https://github.com/LLNL/USER-EPH
# Interatomic potentials: https://libatoms.github.io/matscipy/cli/calculators.html
# APSOgenEAM: https://github.com/berkonat/APSOgenEAM
# automated-twin-tracking: https://github.com/hehrich/automated-twin-tracking
# EnCodeVentor: https://www.youtube.com/user/Jere5120/feed
# LaBr3: https://www.osti.gov/servlets/purl/1241668 (slide)
# SPIN: https://www.osti.gov/servlets/purl/1884091 (slide)
# CO2’s Chemisorption and Diffusion in Mg-MOF-74 (DeepMD): https://doi.org/10.1021/acsnano.2c11102 (see "Supporting Information", nn2c11102_si_004.zip)
# DLP_graphene: https://doi.org/10.1021/acs.jpcc.1c01411 (see Supporting Information)
# NEP-data: https://gitlab.com/brucefan1983/nep-data
# supporting-info: https://github.com/hityingph/supporting-info
# DLP graphene: https://doi.org/10.1021/acs.jpcc.1c01411 (see Supporting Information)
# crystal sturcutre data (cif): https://github.com/cryos/avogadro/blob/master/crystals/oxides/SiO2-Quartz-alpha.cif
# Pops: https://github.com/rohskopf/pops (related paper: https://doi.org/10.1016/j.commatsci.2020.109884)
# NC_BN: https://github.com/mehranvaezi/NC_BN
# Carbon Potentials: http://www.carbonpotentials.org/
-------------------------------------------------------------------
input file (metal unit, lammps)

- M. Shabani, Doctor thesis (2020).
  https://tigerprints.clemson.edu/cgi/viewcontent.cgi?article=3761&context=all_dissertations
  High_Entropy_Alloys (Fe-Ni-Cr-Co-Mn) (need structure file: hea1.data)

- C.N. Andoh et al., J. Appl. Sci. Tech. 22 (2017) 1-13.
  https://www.researchgate.net/profile/Collins-Nana-Andoh/publication/327390429_MOLECULAR_DYNAMICS_SIMULATION_OF_MECHANICAL_DEFORMATION_OF_AUSTENITIC_STAINLESS_STEELS_Fe-Ni-Cr_ALLOYS_AT_SUPERCRITICAL_WATER_CONDITIONS/links/62ae336c938bee3e3f3f2253/MOLECULAR-DYNAMICS-SIMULATION-OF-MECHANICAL-DEFORMATION-OF-AUSTENITIC-STAINLESS-STEELS-Fe-Ni-Cr-ALLOYS-AT-SUPERCRITICAL-WATER-CONDITIONS.pdf
  https://www.academia.edu/download/57943795/1._Andoh_Pap_2.pdf
  Fe-Ni-Cr
  
- https://www.researchgate.net/profile/Collins-Nana-Andoh/publication/325126856_Binary_Collision_and_Molecular_Dynamics_Simulation_of_Fe-Ni-Cr_Alloys_at_Supercritical_Water_Condition/links/5f6d445c458515b7cf4c4d16/Binary-Collision-and-Molecular-Dynamics-Simulation-of-Fe-Ni-Cr-Alloys-at-Supercritical-Water-Condition.pdf
  Mechanical_Damage_Assessment (Fe system) (Fe-Ni-Cr Alloys)
  
- J. A. Greathouse et al., J. Phys.: Condens. Matter 32 (2020) 085401.
  https://iopscience.iop.org/article/10.1088/1361-648X/ab5377
  10.1088/1361-648X/ab5377
  ZrW2O8_core_shell_model (Buckingham potential + Core-shell model (O-O bond: harmonic)

- Y. A. Zulueta et al., Inorg. Chem. 59 (2020) 11841-11846.
  https://doi.org/10.1021/acs.inorgchem.0c01923 (Transition-Metal-Doped Li2SnO3)
  ---------- ---------- ---------- ---------- ---------- ----------
- Y. Zulueta et al., Chem. Rxiv. (2020).
  https://chemrxiv.org/engage/chemrxiv/article-details/60c74cb5bb8c1a8cce3db48a
  10.26434/chemrxiv.12523640.v1
  ---------- ---------- ---------- ---------- ---------- ----------
  Metal-Doped_Li2SnO3
  
- Y. A. Zulueta et a., J. Phys. Chem. C 124 (2020) 4982-4988.
  https://doi.org/10.1021/acs.jpcc.9b10003
  Li2SiO3
  
- J. A. Dawson et al., J. Phys. Chem. C 122 (2018) 23978–23984.
  https://doi.org/10.1021/acs.jpcc.8b08208
  Li3OCl
  
- A. C. C. Dutra et al., Energy Adv., 2 (2023) 653-666.
  https://doi.org/10.1039/D3YA00075C
  Li4OCl2

- S. Ariga et al., Phys. Chem. Chem. Phys., 2022,24, 2567-2581.
  https://pubs.rsc.org/en/content/articlelanding/2022/cp/d1cp05393k
  Li2S-P2S5 (real units type)
  
- Z. Wang, J. Phys. Chem. C 124 (2020) 3851–3856.
  https://doi.org/10.1021/acs.jpcc.9b10706
  Carbon_Nanotubes (CNTs)
  ------------------------------------------------
  http://idr.mnit.ac.in/bitstream/123456789/776/1/2015PDE5197-Komal%20Rathi.pdf

- S. Banerjee, Doctor thesis (2008).
  https://vtechworks.lib.vt.edu/server/api/core/bitstreams/aeeda057-de05-4e7b-ad73-c9a3f7f506de/content
  http://hdl.handle.net/10919/28252
  Carbon_Nanotube_Growth (need complete structure data file)

- A. Maulana et al., AIP Conf. Proc. 2314, 020008 (2020).
  https://doi.org/10.1063/5.0034046
  uniaxial_tensile_test_Fe-Ni

- T. P. Bennett, Docter thesis (2019).
  https://scholars.unh.edu/cgi/viewcontent.cgi?article=3467&context=dissertation
  uniaxial_tensile_test_Ni-Cu

- N. D. M. Arachchige, Doctor thesis (2016).
  https://summit.sfu.ca/item/16590
  uniaxial_tensile_test_Graphene
  
- M. Li et al., Nanomaterials 9 (2019) 347.
  https://doi.org/10.3390/nano9030347 (Graphene, The temperature of each atom)
  uniaxial_tensile_test_Graphene_NEMD

- A. A. Khan, Master thesis (2022).
  http://lib.buet.ac.bd:8080/xmlui/bitstream/handle/123456789/6464/Full%20Thesis.pdf
  crumpled_graphene

- Y. Gao et al., Membranes12 (2022) 886.
  https://doi.org/10.3390/membranes12090886
  membranes

- Y.- P. Zhou et al., Sci. Rep. 7 (2017) 45516.
  https://www.nature.com/articles/srep45516
  Borophene
  
- M. Vaezi et al., J. Chem. Phys. 153 (2020) 234702.
  https://doi.org/10.1063/5.0029490
  C60_on_BN
  
- Benjamin T. Dankesreiter, B.S., Master thesis (2021).
  https://ttu-ir.tdl.org/handle/2346/87494
  Diamond_Like_Carbon (DLC) (python code)
  (B series need DLC_pen.txt)
  
- ERIK FRANSSON, JOHANNES LAURELL H˚AKANSSON, Master’s Thesis in Applied Physics (2014).
  https://core.ac.uk/display/70610056
  BaZrO3
  
- G. V. Huerta et al., Doctoral Thesis (2019).
  https://www.repo.uni-hannover.de/bitstream/handle/123456789/4482/GesamtRevisedFinal.pdf
  YSZ (Yttria stabilized zirconia)

- X. Gaobo, Doctor thesis (2016).
  https://theses.lib.polyu.edu.hk/bitstream/200/8409/1/b28372323.pdf
  Orthogonal_cutting_Si

- B. N. Vadgama, Doctor thesis (2014).
  https://etd.auburn.edu/bitstream/handle/10415/4015/Dissertation%20ETD.pdf
  Friction_Cu

- E. Lofquist, Master thesis (2021).
  https://lup.lub.lu.se/student-papers/search/publication/9060962
  shockwaves_InSb
  
- R. G. Patel et al., J. Comput. Phys. 449 (2022) 110754.
  https://doi.org/10.1016/j.jcp.2021.110754
  shock_Cu
  
- G. W. J. Mclntosh et al., (2016)
  https://cradpdf.drdc-rddc.gc.ca/PDFS/unc244/p804516_A1b.pdf
  shock_Al and Explosive

- E. N. Hahn, Doctor thesis (2016).
  https://escholarship.org/content/qt79j2w03v/qt79j2w03v.pdf
  shock_Ta
  
- J. M. O.-Roldan et al., Proc. Math. Phys. Eng. Sci. 478 (2022).
  https://doi.org/10.1098/rspa.2022.0201
  Ordered_Nanoporous_Metals
  (ERROR: Molecule auto special bond generation overflow)
  
- G. Damien, Master Thesis (2022)
  https://lup.lub.lu.se/student-papers/search/publication/9102580
  Nanocutting
  
- Mehta, Gaurav and Patra, Hrushikesh (2013) 
  http://ethesis.nitrkl.ac.in/4903/
  Nanowire_Ni
  
- A. Vesti, Master Thesis (2019).
  https://lup.lub.lu.se/luur/download?func=downloadFile&recordOId=8977878&fileOId=8977883
  Nanowire_SiC
  
- A. Fredriksson, Master Thesis (2022).
  https://lup.lub.lu.se/luur/download?func=downloadFile&recordOId=9079628&fileOId=9079859
  Nanowire_W
  
- Dora, Jay Krishan (2014)
  http://ethesis.nitrkl.ac.in/6375/
  Nanowire_PdPt

- G. S. Camprubi, Master thesis (2010).
  https://upcommons.upc.edu/handle/2099.1/14585
  Nanowire_Cu

- E. Ercikan, Master thesis (2019).
  https://docs.lib.purdue.edu/dissertations/AAI30503130/
  Bombardment_D

- X. Yang et al., Doctor thesis (2013).
  https://docs.lib.purdue.edu/open_access_dissertations/29
  Bombardment_C_D

- K. Datadien, (2013).
  https://essay.utwente.nl/63570/1/BscReport_KarunDatadien_s0208663_openbaar.pdf
  Bombardment_Li_ion

- D. Chen et al., Doctor Thesis (2014).
  https://oaktrust.library.tamu.edu/handle/1969.1/154160
  Radiation_grain_boundary (Structure of (013)[100]Σ = 5 symmetric-tilt grain boundary)
  -----------------------------------------------------------------------------------------------
  The cell has a dimension of 14nm×14nm×14nm, which contains about 250000 atoms.
  The damage cascade is created by bombardment with one 3 keV Fe atom, which is incident at 
    9 degrees away from the cell normal direction. This avoids ion channeling and helps to 
    confine the damage cascade within the cell. The cell further contains a grain boundary, 
    which is created by putting two bcc-Fe domains together. Prior to the ion bombardment, 
    the bcc alpha-Fe is structurally relaxed to achieve energy minimization. Simulation is 
    performed with the cell temperature at 450K. 
  -----------------------------------------------------------------------------------------------
  Recommend !!!
  Build GB: https://aimsgb.org/
  J. Cheng et al., Comput. Mater. Sci., 155, 92-103, (2018).
  Find GB -> Build GB (e.g., using Fe.cif from Material project)
  -----------------------------------------------------------------------------------------------
  GB_code: https://github.com/oekosheri/GB_code
  -----------------------------------------------------------------------------------------------
  GBstudio: A Builder Software on Periodic Models of CSL Boundaries for Molecular Simulation
  https://www.jstage.jst.go.jp/article/matertrans/47/11/47_11_2706/_pdf/-char/en
  -----------------------------------------------------------------------------------------------

- D. Spiteri, ResearchGate (2016).
  https://www.researchgate.net/publication/301552031
  Grain_Boundary_Formation_diamond

- B. Yang, ResearchGate (2020).
  https://www.researchgate.net/publication/345384762
  Grain_Boundary_CBN

- S. A. Bringuie, Doctor thesis (2015).
  http://hdl.handle.net/10150/560748
  https://repository.arizona.edu/bitstream/handle/10150/560748/azu_etd_13780_sip1_m.pdf?sequence=1
  Grain_Boundary_SiC

- K. C. Alexander, thesis (2011).
  https://dspace.mit.edu/handle/1721.1/108218
  Grain_Boundary_Cu

- X. Ke, Doctor Thesis (2019).
  https://scholarworks.uvm.edu/graddis/995/
  Cu-Ag_MC (python code)

- Q. Fang, Doctor Thesis (2020).
  https://scholarworks.uvm.edu/graddis/1323/
  Cu-Ag_2D (need Data-2DCu-20grs-noKk-TBS92A.in) (python and fortran code)
  (need Data-Cu-411-y123-17pct-1.in)
  
- M. R. Pringle, Master Thesis (2021).
  https://scholarworks.uvm.edu/graddis/1410/
  Ag-Ni (need Data-ntAg-12nm-grs-NoTwin.in)
  
- T. Metspalu, Master Thesis (2015)
  https://core.ac.uk/download/pdf/187147604.pdf
  CLIC_electrical_breakdown (test version)
  
- K.-J. Carter, Bachelor Thesis (2017).
  https://dspace.mit.edu/handle/1721.1/112482
  https://dspace.mit.edu/bitstream/handle/1721.1/112482/1011413174-MIT.pdf
  Irradiation
  
- Z. Huang, Master thesis (2016).
  https://trace.tennessee.edu/utk_gradthes/3776/
  Radiation_defects
  
- S. L. Ball, thesis (2014).
  https://dspace.mit.edu/handle/1721.1/104145
  Migration
  
- B. N. Sorbom, thesis (2010).
  https://dspace.mit.edu/handle/1721.1/120392
  YBCO (Y1Ba2Cu3O7) (need *.dat and table)
  
- S. T. T. Lam, thesis (2013).
  https://dspace.mit.edu/handle/1721.1/129108
  (VASP, Packmol, PANNA, Lammps) (failed)
  
- J. Wang, Master thesis (2013).
  https://oaktrust.library.tamu.edu/handle/1969.1/151391
  SWNT (need structure file: SWNT1515_equ.lammps05, SWNT1010_250A_double_equ300.lammps05)
  see "TubeGen Online": http://turin.nss.udel.edu/research/tubegenonline.html

- M. Dong, Master thesis (2020).
  https://oaktrust.library.tamu.edu/handle/1969.1/191617
  Green-Kubo_bulk_h-BN

- A. Rohskopf et al., Comput. Mater. Sci. 184 (2020) 109884.
  https://doi.org/10.1016/j.commatsci.2020.109884
  IAPs (GaN)
  
- S. K. Achar et al., J. Chem. Theory Comput. 18 (2022) 3593-3606.
  https://doi.org/10.1021/acs.jctc.2c00010
  UiO-66 (It can not be calculated unless it is a Lammps that supports deepmd.)
  
- C. Wilkinson et al., SoftwareX 14 (2021) 100683.
  https://doi.org/10.1016/j.softx.2021.100683
  see https://github.com/ElsevierSoftwareX/SOFTX_2020_31 (github)
  
- M. P. Hazarika, Master Thesis (2019).
  http://dspace.cus.ac.in/jspui/bitstream/1/6333/1/Manash%20Protim%20Hazarika-Chemistry-MPhil.pdf
  
- Introduction to atomman: Running LAMMPS and the Log class
  https://www.ctcms.nist.gov/potentials/testing/atomman/tutorial/2.2._Running_LAMMPS_and_the_Log_class.html
  
- 
  Al_comp_stress-strain
  https://ma.issp.u-tokyo.ac.jp/app-post/2315
  https://github.com/cmsi/malive-tutorial/tree/master/lammps
  
- Divya and Kamal, Zeba (2013)
  http://ethesis.nitrkl.ac.in/5337/
  3d-crystal-2013D
  
- C. K. Mallick, Thesis (2014).
  http://ethesis.nitrkl.ac.in/6566/
  3d-crystal-2014M

- BibhudattaSahu, Thesis (2014).
  http://ethesis.nitrkl.ac.in/6239/1/110MM0378-17.pdf
  3d-crystal-2014B
  
- Sethy, Bipin Kumar and Mishra, Siddharth (2013) 
  http://ethesis.nitrkl.ac.in/5403/
  Cu-Ni_thin_film
  
- Rath, Sibasish and Toppo, Joy Kiran (2015) 
  http://ethesis.nitrkl.ac.in/7560/
  defect_Cu
  
- Das , A and Singh, G (2014)
  http://ethesis.nitrkl.ac.in/6152/
  defect_Cu-Al
  
- Kumar, Navratan (2014) 
  http://ethesis.nitrkl.ac.in/6144/
  Fe-Cr_MSD
  
- Venumbaka , Sarat Chandra (2015) 
  http://ethesis.nitrkl.ac.in/7043/
  Fe3Al_intermetallics
  
- D. Chen et al., Master thesis (2011).
  https://oaktrust.library.tamu.edu/bitstream/handle/1969.1/ETD-TAMU-2011-08-10112/CHEN-THESIS.pdf?sequence=2&isAllowed=y
  Fe_poly (need polyfe.lammps)
  
- Gupta, Pradeep (2019) 
  http://ethesis.nitrkl.ac.in/10087/ (do not download)
  
- A. Albano, Doctor Thesis (2021).
  https://etheses.bham.ac.uk/id/eprint/11999/
  hybrid_meso_atomic
  
- B. de Braaf, Master Thesis (2015).
  https://pure.tue.nl/ws/portalfiles/portal/46924674/841526-1.pdf
  Semi-Flexible Rod-Like Particles
  
- M. Jorum, Master thesis (2015).
  https://ntnuopen.ntnu.no/ntnu-xmlui/handle/11250/2350291
  cantilever

- N. Boumerdassi, Master Thesis (2014).
  https://repositories.lib.utexas.edu/handle/2152/26395
  Ag_nanocluster

- M.-K. Choi (2022)
  https://conservancy.umn.edu/handle/11299/250214 (MoS2, zip file)
  DRUM_DATA

- S. Amit, Thesis or Dissertation (2015)
  https://conservancy.umn.edu/handle/11299/182204
  TPI_v2

- Y. Zhang, Master thesis (2017).
  https://mds.marshall.edu/etd/1090/
  PdH (elastic) (MATLAB)

- R. Fuller, Master thesis (2018).
  https://mds.marshall.edu/etd/1124/
  PdAgH (elastic)
  
- https://doi.org/10.26190/5d1d47a9eb76f
  UZrO

- K. Malone, Master thesis (2019).
  https://repository.mines.edu/handle/11124/173097
  Ni-V-O

- M. Hoerner, Doctor thesis (2014).
  https://repository.mines.edu/handle/11124/172834
  Grain_Boundary_Energy
  
- Joy Acharjee, B.S., thesis (2019).
  https://ttu-ir.tdl.org/handle/2346/85090
  Grain_Boundary (CuH)
  
- Z. Zhang, Master thesis (2017).
  https://ttu-ir.tdl.org/handle/2346/73470
  Nanoprotrusion
  
- S. Soltanibajestani, Master thesis (2017).
  https://scholarcommons.scu.edu/mech_mstr/9/
  screw_dislocation
  
- R. K. Siripurapu, Master thesis (2013).
  https://harvest.usask.ca/handle/10388/ETD-2013-10-1264
  ZrH2

- Dhal, Satyanarayan and Yadlapalli, Raja (2012) 
  http://ethesis.nitrkl.ac.in/3349/
  Cu-Zr_2012S

- Kumar , Ajnish (2013)
  http://ethesis.nitrkl.ac.in/4907/
  Cu-Zr_based_metallic_glasses

- A. Kabi, Master thesis (2015).
  http://ethesis.nitrkl.ac.in/6991/ 
  Cu-Zr_2015K
  (Tensil (A2) or Compressive (A3) defromation of quenched specimen (A1))
  
- P. Alexander, Doctor thesis (2023).
  https://research-information.bris.ac.uk/ws/portalfiles/portal/364060220/Final_Copy_2023_05_09_Petkov_A_PhD.pdf 
  beta-Ga2O3 (MATLAB code)
  
- Lammps Examples
  SiO2_QEq

- Lammps Examples
  Al2O3_streitz
  
- P. Malakar et al., ACS Appl. Nano Mater. 5 (2022) 16489-16499.
  https://doi.org/10.1021/acsanm.2c03564 (lammps input file)
  Crack_MoS2

- T. Siby, Doctor thesis (2017).
  http://210.212.194.26/jspui/handle/123456789/14231 (do not get pdf)
  hBN

- C. Zhang, Master thesis (2020).
  https://mds.marshall.edu/etd/1324/
  Pd1-y-zAgyCuzHx

- D. K. Bommidi, Master thesis (2018).
  https://huskiecommons.lib.niu.edu/allgraduate-thesesdissertations/5121/
  Nickel-coated-CNT

- O. Guerrero, ResearchGate (2013)
  https://www.researchgate.net/publication/259644293
  comp_stress-strain_Cu
  shock_Ni

- H. Karimah et al., AIP Conf. Proc. 2663, 030002 (2022).
  https://doi.org/10.1063/5.0108088
  Liquid_lead_corrosion

- D. Iabbaden, Doctor thesis (2023).
  https://theses.hal.science/tel-04540670v1 , https://theses.hal.science/tel-04540670/file/These-Iabadden-Djafar-2023.pdf
  laser-matter-interactions

- W. T. Yorgason, Master thesis (2018).
  https://digitalcommons.usu.edu/etd/7081 
  Thermal_Conductivity_Mg2Si

- A. M. K. Fujii, Master thesis (2014).
  https://escholarship.org/content/qt3km9505t/qt3km9505t_noSplash_48a5d5cd8b3244d58739b9080df60e16.pdf
  Thermal_Conductivity_amorphous_carbon

- S. Lowder, Bachelor thesis (2017).
  https://dspace.mit.edu/handle/1721.1/112369
  https://dspace.mit.edu/bitstream/handle/1721.1/112369/1011355070-MIT.pdf
  DSC_Simulations_Al

- B. Space, ResearchGate (2008).
  https://www.researchgate.net/publication/228935329
  quasicrystal_d-AlCoNi (Note: I made some changes. If there are any problems, it is my (By STUDENT) responsibility.)

- A. M. K. Fujii, Master thesis (2014).
  https://www.diva-portal.org/smash/get/diva2:1466761/FULLTEXT01.pdf
  AlO_RDF_MSD

- R. A. Fleming, Doctor thesis (2017).
  https://scholarworks.uark.edu/etd/2487/
  https://scholarworks.uark.edu/cgi/viewcontent.cgi?article=4027&context=etd
  Hemispherical_AlaSi

- R U Mardiyah et al 2020 J. Phys.: Conf. Ser. 1491 012020.: 10.1088/1742-6596/1491/1/012020
  https://iopscience.iop.org/article/10.1088/1742-6596/1491/1/012020/meta (Open access)
  cohesive_energy_metal_LJ

- B. N. Katz et al., Phys. Rev. Lett. 129 (2022) 096102.: https://doi.org/10.1103/PhysRevLett.129.096102
  https://doi.org/10.1103/PhysRevLett.129.096102
  Shape_Entropy

- B. Cheng et al., Phys. Rev. Lett. 125 (2020) 130602.: https://doi.org/10.1103/PhysRevLett.125.130602
  https://doi.org/10.1103/PhysRevLett.125.130602
  Heat_Conductivity_Fluids

- M. G. Muraleedharan et al., AIP Advances 7, 125022 (2017).: https://doi.org/10.1063/1.5003158
  https://pubs.aip.org/aip/adv/article/7/12/125022/992205
  Al_Vashishta-56

- O. Takahiro, Chiba Univ.
  https://amorphous.tf.chiba-u.jp/lecture.files/ms-workshop/molten.html
  Lecture

- S. K. Pinky et al., Master thesis (2019) 
  https://www.osti.gov/biblio/1902939
  Creep_Deformation

- Liang Zhang et al., 2015 Chinese Phys. B 24 088106.
  https://iopscience.iop.org/article/10.1088/1674-1056/24/8/088106/meta
  GSF_energy_curve

- Z. Luo et al., Carbon 183 (2021) 438-448.
  https://www.sciencedirect.com/science/article/pii/S0008622321006837
  Low-density_microporous_carbon

- F. Faruq, Master thesis (2010).
  https://digital.library.ncat.edu/theses/26/
  Nano-Diamond

- B. Crutchfield, Master thesis (2024).
  https://www.proquest.com/openview/95d9950a23ab02ced3bfd2b782403241
  NixCr_Ti3SiC2

- R. L. Morrison et al., Materialia 7 (2019) 100383.
  https://doi.org/10.1016/j.mtla.2019.100383
  https://data.mendeley.com/datasets/pgzgghnw89/1
  Grain_boundary_NiAl

- P. Y. Simanjuntak, Master thesis (2024).
  https://bearworks.missouristate.edu/theses/3159/
  Ti-Al-N

- https://dr.ntu.edu.sg/handle/10356/175396
  Fe-Co
-------------------------------------------------------------------
- CDC-nanoporous-carbon-ABOP(data file): https://zenodo.org/records/11396617
- HCNT (xyz data): https://doi.org/10.1021/ja404330q
-------------------------------------------------------------------
- J. William, Thesis (2021).
  https://openscience.ub.uni-mainz.de/handle/20.500.12030/6656 
  C60 (girifalco.table) (failed)

- A. P. Thompson (2016).
  https://www.osti.gov/servlets/purl/1733244
  DPD_RDX (need potential files and structure files)
   
- S. Islam, Master Thesis (2017).
  https://bearworks.missouristate.edu/theses/3217/
  Li_Mobility
  (QE and VASP) (no Lammps files)
  
- S. K. Pinky, Master thesis (2019).
  https://bearworks.missouristate.edu/theses/3461/
  Ni-Al (need structure file: poly4_5, etc)

- R. Khadka, Master thesis (2019).
  https://bearworks.missouristate.edu/theses/3455/
  a-BC (need structure file. SW or ReaxFF)

- M. Rabbani, Master thesis (2019).
  https://bearworks.missouristate.edu/theses/3460/
  Al-Ni (need data.AlNi) (lammps and VASP)

- P. Y. Simanjuntak, Master thesis (2017).
  https://bearworks.missouristate.edu/theses/3159/
  Ti-N-Al (need potential and structure files)

- M. J. Buehler et al., Graduate Theses (2017)
  https://dspace.mit.edu/handle/1721.1/109645
  substrate-supported-graphene (need structure file)

- B. Timalsina, Master thesis (2021).
  https://bearworks.missouristate.edu/theses/3670/
  (Rf-MEAM)
  
- Z. Liu et al., ACS Appl. Mater. Interfaces 13 (2021) 53409-53415.
  https://doi.org/10.1021/acsami.1c11595
  mlip
  
- A. S. Butterfield, Bachelor Thesis (2013).
  https://www.byui.edu/documents/physics/Theses/2010-2015/Aaron-ButterfieldS13.pdf
  Cu
  
- https://webthesis.biblio.polito.it/secure/15380/1/tesi.pdf
  Au
  
- https://open.library.ubc.ca/media/download/pdf/24/1.0220767/4
  Fe
  
- https://scholarcommons.scu.edu/mech_mstr/24/
  Al
  
- https://openscholarship.wustl.edu/art_sci_etds/1722/
  ZrNi
  
- S. E. Ferry, thesis (2011).
  https://dspace.mit.edu/handle/1721.1/119031
  Ni-Al (need NiAl_50.data)
  
- S. Zhizhen, Doctor thesis (2022).
  https://repository.lboro.ac.uk/articles/thesis/Damage_of_nuclear_graphite_and_structural_response_of_carbon_fibre_to_tension/22345081/1/files/39760825.pdf
  tensile_test_carbon (need structure file: carbonfibre)
  9.2.2Python codes for coordination analysis
  9.2.3Python codes for bond and angle distribution analysis
  9.3 MATLAB codes for Raman spectrum data analysis
  
- C. Gibbon et al., Phys. Chem. Chem. Phys., 2023,25, 3190-3198.
  https://doi.org/10.1039/D2CP05550C
  
- L. I. D. Cid, Doctor thesis (2015).
  https://repository.mines.edu/handle/11124/17099
  LIGGGGHTs
  
- https://pure.tue.nl/ws/portalfiles/portal/217974945/Wezel_van_1277928_ABP_Salet.pdf
  LIGGGHTS
  
- https://uir.unisa.ac.za/handle/10500/29236
  LIGGGHTS
  
- https://core.ac.uk/download/pdf/161264638.pdf 
  Docking process

- K. McLaughlin, thesis (2009).
  https://digitalcommons.usf.edu/etd/2098/ (Metal, lj)
  low_surface_friction (need structure file)
  
- H. M. Harper, thesis (2008).
  https://digitalcommons.usf.edu/etd/280/  (Metal, lj)
  d-AlNiCo (do not copy & paste from PDF)
  
- https://www.sciencedirect.com/science/article/pii/S0010465518304107 (MagiC)

- https://theses.cz/id/fl7387/2022_DP_Cavojec_Martin_192047.pdf (python)

- G. S. Jung, thesis (2019).
  https://dspace.mit.edu/handle/1721.1/123228 
  (REBO) (MoS2-WSe2)
  
- B. A. Demian, thesis (2014).
  https://dspace.mit.edu/handle/1721.1/90011
  (MATLAB)
  
- M. Valavi et al., Cem. Concr. Res. 154 (2022) 106712.
  https://doi.org/10.1016/j.cemconres.2022.106712
  ERICA (need Structure.data)
  
- T. A. Burt, Master thesis (2017).
  https://shareok.org/handle/11244/52763
  Burt_2017 (need structure file: dummy10.lammps) (real unit)
  
- M. Qamar et al., J. Chem. Theory, Comput. XXX (2023) XXX-XXXX.
  https://doi.org/10.1021/acs.jctc.2c01149
  anc
  
- S. Townsend, thesis (2018).
  https://dspace.mit.edu/handle/1721.1/119936
  Biggest_Trudging (failed)
  
- A. Saltos, Doctor Thesis (2020).
  https://mospace.umsystem.edu/xmlui/handle/10355/83797
  Greens_Function_Method (need Ugamma101010.pos) (MCNP and OpenMC code)
  
- R. Xie, Master thesis (2021).
  https://mds.marshall.edu/etd/1411/
  ZnS (need structure files) (core-shell model) (elastic) (MATLAB)

- L. Adil et al., Doctor thesis (2015).
  https://uhra.herts.ac.uk/handle/2299/15336
  CeO2_in_water (need structure file) (failed)

- R. A. Miller, Master thesis (2015).
  https://scholars.unh.edu/thesis/1087/
  TTPO_on_Au (need structure file, The topology file could not be created successfully on VMD (topotools).)

- N. Karlsen, Master thesis (2022).
  https://www.duo.uio.no/bitstream/handle/10852/98349/1/nicholas_karlsen_thesis-9_FINAL.pdf
  SiO2_vashishta (failed: Too many parts to rewrite. Input file is required.)

- B. N. Doblack, Master thesis (2013).
  https://escholarship.org/content/qt4p33q6zt/qt4p33q6zt_noSplash_0ae1f525544855eed91a2969e98ea177.pdf
  melt-quench_SiO2_BKS.potential (need BKS.potential file and GPU environment)

-------------------------------------------------------------------
plot the temperature of each atom

1. *.cfg -> Ovito -> (upper right) Add modification...
2. Color coding -> Input property: f_ave_tempatom
3. (click) Adjust range
-------------------------------------------------------------------


#---------------------------------------------------------------------
# Backup URL (Unsorted)
CeO: https://harvest.usask.ca/server/api/core/bitstreams/819b4739-6156-4ca5-83d8-82f8d26f8b9f/content
NPSD: https://ujcontent.uj.ac.za/view/pdfCoverPage?instCode=27UOJ_INST&filePid=136016360007691&download=true
Vp2B: https://escholarship.org/content/qt7564g5nd/qt7564g5nd_noSplash_44d43515acf08f39337f2cc99e5ec104.pdf
TAPSim-MD: https://etd.ohiolink.edu/acprod/odb_etd/ws/send_file/send?accession=osu1525763934302517&disposition=inline
TC-QCL: https://digitalcommons.usu.edu/etd/3089
TC-RNEMD: https://etd.ohiolink.edu/acprod/odb_etd/ws/send_file/send?accession=case1455101197&disposition=inline
GBC: https://www.researchgate.net/profile/David-Spiteri-2/publication/301552031_Understanding_phonon_scattering_and_predicting_thermal_conductivity_from_molecular_dynamics_simulation/links/5722038d08aef9c00b7c43d2/Understanding-phonon-scattering-and-predicting-thermal-conductivity-from-molecular-dynamics-simulation.pdf
SAC: https://www.duo.uio.no/bitstream/handle/10852/58676/thesis.pdf
SSi:  https://escholarship.org/uc/item/5sg3c7dp
NAM: https://pure.manchester.ac.uk/ws/portalfiles/portal/146395110/FULL_TEXT.PDF
DEM: https://www.osti.gov/servlets/purl/1656962
SCV: https://escholarship.org/content/qt5sg3c7dp/qt5sg3c7dp.pdf
DG:  https://scholarcommons.scu.edu/mech_mstr/24
DMD: https://etd.ohiolink.edu/acprod/odb_etd/ws/send_file/send?accession=osu1321282489&disposition=inline
NPFe: https://www.bing.com/ck/a?!&&p=6c02823dab68865532924157e695dffdb69fa9084f837ee6675341d5a0dacfb8JmltdHM9MTcyOTk4NzIwMA&ptn=3&ver=2&hsh=4&fclid=33a141eb-211f-6041-026b-55fd206561c3&psq=Masters_Thesis__Marit_Olaisen_v2.pdf&u=a1aHR0cHM6Ly9udG51b3Blbi5udG51Lm5vL250bnUteG1sdWkvYml0c3RyZWFtL2hhbmRsZS8xMTI1MC8yMzUwMjk0L01hc3RlcnNfVGhlc2lzX19NYXJpdF9PbGFpc2VuX3YyLnBkZj9zZXF1ZW5jZT05&ntb=1
NPTa: https://trepo.tuni.fi/bitstream/handle/10024/145080/VoimanenEerik.pdf?sequence=2
Ta:  https://escholarship.org/uc/item/79j2w03v
CdTeZnSeHgS (SW): https://scholarworks.utep.edu/open_etd/3381 
HEA: https://scholarworks.utrgv.edu/etd/859
FeCo: https://dr.ntu.edu.sg/bitstream/10356/175396/2/MarioHernandez_Thesis_PhD_Final.pdf
FeCH: https://scholarsjunction.msstate.edu/td/5702 
  MEAM file: https://arxiv.org/pdf/2109.01712
NbC: https://huskiecommons.lib.niu.edu/cgi/viewcontent.cgi?article=8531&context=allgraduate-thesesdissertations
AlN (zbl): https://scholarsmine.mst.edu/masters_theses/8166
Al: https://scholarsjunction.msstate.edu/td/279 
Al: https://publications.polymtl.ca/10794/
Al: https://scholarcommons.scu.edu/cgi/viewcontent.cgi?article=1049&context=mech_mstr
AlNi: https://www.osti.gov/servlets/purl/1902942
AlCr: https://publications.polymtl.ca/10541/
Ag: https://repositories.lib.utexas.edu/server/api/core/bitstreams/aa0530be-4659-4c18-926d-5ffd1d4bed53/content
AgCu: https://scholarworks.uvm.edu/graddis/995 
Cu: https://dspace.mit.edu/bitstream/handle/1721.1/112482/1011413174-MIT.pdf?sequence=1&isAllowed=y
Ni: http://scholarcommons.scu.edu/mech_mstr/9
Ni: https://qmro.qmul.ac.uk/xmlui/bitstream/handle/123456789/427/SONGExperimental2010.pdf?sequence=1
NiCu: https://scholars.unh.edu/dissertation/2468 
NiCr: https://www.researchgate.net/profile/Collins-Nana-Andoh/publication/325126856_Binary_Collision_and_Molecular_Dynamics_Simulation_of_Fe-Ni-Cr_Alloys_at_Supercritical_Water_Condition/links/5f6d445c458515b7cf4c4d16/Binary-Collision-and-Molecular-Dynamics-Simulation-of-Fe-Ni-Cr-Alloys-at-Supercritical-Water-Condition.pdf
PdCu: https://ujcontent.uj.ac.za/view/pdfCoverPage?instCode=27UOJ_INST&filePid=136016360007691&download=true
Ti: https://www.osti.gov/servlets/purl/1872068
Zr: https://qspace.library.queensu.ca/server/api/core/bitstreams/b42b5726-f1a0-47b4-bd83-3b45996aa99c/content
Au: https://webthesis.biblio.polito.it/secure/15380/1/tesi.pdf
TTPO: https://scholars.unh.edu/thesis/1087
BC: https://bearworks.missouristate.edu/cgi/viewcontent.cgi?article=4487&context=theses
Tip: https://media.proquest.com/media/hms/PFT/2/PD63O?_s=aMwtaWMrQNpEUYSDIxx3fAVjqE8%3D
shock_Si:  https://escholarship.org/uc/item/5sg3c7dp
C: https://www.diva-portal.org/smash/get/diva2:1037517/FULLTEXT01.pdf
C: https://oaktrust.library.tamu.edu/server/api/core/bitstreams/e111844d-ba35-4752-83f9-ca8d053d6f9a/content
C: https://summit.sfu.ca/_flysystem/fedora/sfu_migrate/16590/etd9598_NMallikaArachchige.pdf
C (tensile): https://open.library.ubc.ca/media/download/pdf/24/1.0072708/1
C: https://repository.lboro.ac.uk/articles/thesis/Damage_of_nuclear_graphite_and_structural_response_of_carbon_fibre_to_tension/22345081/1/files/39760825.pdf
C (Green-Kubo): https://escholarship.org/content/qt3km9505t/qt3km9505t_noSplash_48a5d5cd8b3244d58739b9080df60e16.pdf
C (tensile): https://iopscience.iop.org/article/10.35848/1347-4065/ad66d7/pdf
CNT: https://repository.rit.edu/cgi/viewcontent.cgi?article=12009&context=theses
CNT: https://etd.ohiolink.edu/acprod/odb_etd/ws/send_file/send?accession=case1455101197&disposition=inline
CNT: https://irbe.library.vanderbilt.edu/server/api/core/bitstreams/17a57a75-5185-402b-8bf5-556f442f8651/content
CNT: https://ir.library.oregonstate.edu/downloads/t722hc79t
metal-CNT: https://huskiecommons.lib.niu.edu/cgi/viewcontent.cgi?article=7975&context=allgraduate-thesesdissertations
epoxy: https://d1wqtxts1xzle7.cloudfront.net/78091875/MSC_20Dissertation_201436870-libre.pdf?1641367980=&response-content-disposition=inline%3B+filename%3DCharacterization_of_graphene_epoxy_nanoc.pdf&Expires=1730023337&Signature=Bn4v75rnkodB68d--GumwCuntIy7IqRTfv1LiIEsisa20at-bE2Jtizegj70yWRkXGUfESJqSPNbOFNA6LAubvkl96OxGPU8TP0duih2apYf5KXyeByVcL6-PIIGoNwCriWP9vM2k9tPqUPWl5cQi7PxtpQPykqIbs98KzqjRTse4PyTtqPcJOmiX0DrCTbKHQ3D1iznyvXeSZNVypIvxhHa2a0Bga4SBXYJ0ptQDy-h1rt4pR39J2luhxHEXt7sz93yn8TWB2QNmEVh~OWc98B-RpUI5CUFfDcYBTjAvREBY1g2QuhNduJR5VRlhWIGT~2d83zBxCQ6KSAtm40YjA__&Key-Pair-Id=APKAJLOHF5GGSLRBV4ZA
h-BN: http://210.212.194.26/jspui/bitstream/123456789/14231/1/112027PH11F09.pdf
atomsk: https://arxiv.org/pdf/2107.09213
Gate: https://doi.org/10.1103/PhysRevE.104.064133
ZnO: https://open.library.ubc.ca/media/download/pdf/24/1.0319080/4
PdH: https://mds.marshall.edu/cgi/viewcontent.cgi?article=2095&context=etd
APM(zip file): https://doi.org/10.1021/acs.jpcb.1c01966
zip: https://doi.org/10.1016/j.cpc.2023.109062
FMT: https://ntnuopen.ntnu.no/ntnu-xmlui/bitstream/handle/11250/2350291/13447_FULLTEXT.pdf?sequence=1
SiC (meam): https://lup.lub.lu.se/luur/download?func=downloadFile&recordOId=8977878&fileOId=8977883
CdTeZnSeHgS: https://scholarworks.utep.edu/cgi/viewcontent.cgi?article=4380&context=open_etd
InSb2: https://lup.lub.lu.se/luur/download?func=downloadFile&recordOId=9060962&fileOId=9062019
gpu: https://escholarship.org/content/qt4p33q6zt/qt4p33q6zt_noSplash_0ae1f525544855eed91a2969e98ea177.pdf
boundary: https://scholarworks.utep.edu/cgi/viewcontent.cgi?article=2965&context=open_etd
MoS(rebo): https://scholarworks.uark.edu/cgi/viewcontent.cgi?article=1481&context=etd
deepmd: https://hammer.purdue.edu/articles/thesis/Machine_Learning_and_Molecular_Dynamics_Simulations_of_Thermal_Transport/15062682/1/files/28980288.pdf
deepmd: https://dl.acm.org/doi/pdf/10.1145/3503221.3508425
PGMC: https://ntrs.nasa.gov/api/citations/20220003134/downloads/NASA-TM-2022003134_coorected.pdf
Si(sw): https://ro.uow.edu.au/cgi/viewcontent.cgi?article=4397&context=theses
MW Heating: https://figshare.mq.edu.au/articles/thesis/Study_of_microwave_heating_in_semiconductors_using_molecular_dynamics_simulation/21540012/1/files/38178909.pdf
#---------------------------------------------------------------------
DeepMD: https://doi.org/10.1016/j.carbon.2024.119498
bitumen (LJ): https://doi.org/10.1016/j.matdes.2024.112831
HMA (LJ): https://doi.org/10.1063/1.5129942
NEMD (LJ): https://pewi.org/cv/files/msc.pdf
DNA (LJ): https://ir.vanderbilt.edu/bitstream/handle/1803/14842/cp_dissertation.pdf?sequence=1&isAllowed=y
NS (LJ): https://www.researchgate.net/profile/Sankhadeep-Bose-2/publication/342515066_Molecular_Dynamics_Modelling_of_Thermostatic_Properties_of_Nanoparticles/links/5ef9785145851550507b07d3/Molecular-Dynamics-Modelling-of-Thermostatic-Properties-of-Nanoparticles.pdf
LJ: https://theses.hal.science/tel-03649130/file/Demydiuk_Fedir_2021_ED182.pdf
LJ: https://www.researchgate.net/figure/Lennard-Jones-potential-parameters_tbl1_354318730
LJ: https://lup.lub.lu.se/luur/download?func=downloadFile&recordOId=9079628&fileOId=9079859
LJ: https://shareok.org/bitstream/handle/11244/332399/2021_Bhattacharya_Soumya_Dissertation.pdf?sequence=1
LJ: https://library.ndsu.edu/ir/bitstream/handle/10365/28721/Guiding%20Self-Assembly%20of%20Functionalized%20Nanoparticles%20by%20Computational%20Modeling%20of%20Effective%20Interactions.pdf?sequence=1
LJ: https://ir.vanderbilt.edu/bitstream/handle/1803/15546/PhD_Dissertation_BaigAlMuhit.pdf?sequence=1
LJ: https://doi.org/10.1016/j.cemconres.2022.106712
LJ: https://ecommons.cornell.edu/bitstreams/4ef01436-2ba5-4a88-a30d-37f8af0032ac/download
LJ: https://oaktrust.library.tamu.edu/server/api/core/bitstreams/e111844d-ba35-4752-83f9-ca8d053d6f9a/content
LJ: https://ntnuopen.ntnu.no/ntnu-xmlui/bitstream/handle/11250/2562297/18861_FULLTEXT.pdf?sequence=1
LJ: https://vtechworks.lib.vt.edu/server/api/core/bitstreams/5bf03ec1-7d1e-4c1e-934a-887f6d12ef41/content
LJ: https://repository.mines.edu/bitstream/handle/11124/76842/Sullivan_mines_0052N_10066.pdf?sequence=1&isAllowed=y
LJ: https://etda.libraries.psu.edu/files/final_submissions/10598
LJ: https://era.ed.ac.uk/bitstream/handle/1842/35877/Carson2019.pdf?sequence=1
LJ: https://shareok.org/bitstream/handle/11244/50751/Tow%20-%20Thesis%20-%202017.pdf?sequence=1
LJ: https://repository.library.carleton.ca/downloads/zg64tn08c
LJ: https://etda.libraries.psu.edu/files/final_submissions/15360
LJ: https://etda.libraries.psu.edu/files/final_submissions/2077
LJ: https://digitalcommons.usu.edu/etd/4632 
LJ: https://ntnuopen.ntnu.no/ntnu-xmlui/bitstream/handle/11250/2787937/no.ntnu:inspera:77798797:18446734.pdf?sequence=1
LJ: https://core.ac.uk/download/pdf/29409791.pdf
LJ: https://d1wqtxts1xzle7.cloudfront.net/78091875/MSC_20Dissertation_201436870-libre.pdf?1641367980=&response-content-disposition=inline%3B+filename%3DCharacterization_of_graphene_epoxy_nanoc.pdf&Expires=1730700873&Signature=CflYZNWf-voW3tRKyv37HdrdAZcZrITn8AVER4fybS5BpHnLzv6XfcPepdY4Sdwzs4KKRTfvzcXCgIvyWHbXpVxcXwm~wHBzqOBh2Py375~ZTz9Nnn8C~NYz2hQ3prIj7b3XFUASK~nVQ~lUC6~K1f2R3dBWI~Q7LDHir0Q6LJdgxNeO4-0QCbvwrGdtoib54WL8q6CsdLwsOCEvdO~UGXcfW5NWN8QZIcRPeXK~Y5uFmr0ZpiILUpGWSfmXQyZ2coRmybe9ESP~dAFi-7DhPrGrOCFiuRSqVv5iXPcgtZ6b0yC5JstM9Nvz-I8IDbIMY398GFY0xgMSr5-L2M3tpA__&Key-Pair-Id=APKAJLOHF5GGSLRBV4ZA
LJ: https://oaktrust.library.tamu.edu/server/api/core/bitstreams/e111844d-ba35-4752-83f9-ca8d053d6f9a/content
LJ: https://kb.osu.edu/bitstreams/b2c3bfbc-7e92-4fa8-b03b-7835e46e4e0b/download
LJ: https://www.osti.gov/servlets/purl/1898282
LJ: https://pure.tue.nl/ws/portalfiles/portal/172431062/MCE_afstudeerverslag_Roos_Beljon_0959426_.pdf
LJ: https://escholarship.org/content/qt2qw846j7/qt2qw846j7.pdf
LJ: https://www.proquest.com/openview/fb2a1d2a7d330ada4fb2a9657b96f8f2/1.pdf?pq-origsite=gscholar&cbl=18750&diss=y
LJ: https://air.unimi.it/bitstream/2434/820780/2/phd_unimi_R11853.pdf
LJ: https://air.unimi.it/bitstream/2434/820780/2/phd_unimi_R11853.pdf
LJ: https://citeseerx.ist.psu.edu/document?repid=rep1&type=pdf&doi=d309054b1aa8adf177f8e2fcc507fa852b68a228
morse: https://dspace.mit.edu/bitstream/handle/1721.1/109645/986790855-MIT.pdf?sequence=1&isAllowed=y
CVFF: https://ecommons.cornell.edu/server/api/core/bitstreams/2c794d17-a73e-482b-9878-f4175e1fb9b2/content
DPD: https://uhra.herts.ac.uk/bitstream/handle/2299/15336/08174625%20Loya,%20Adil%20-%20Final%20PhD%20Submission.pdf?sequence%253D1
DPD: https://www.osti.gov/servlets/purl/1733244
SI: https://qspace.library.queensu.ca/bitstreams/8de5d6c1-4296-41ac-99d7-bb8b99788164/download
CG: https://ninercommons.charlotte.edu/islandora/object/etd:1542/datastream/PDF/download/citation.pdf
CG: https://eprints.soton.ac.uk/486407/1/Final_thesis_submission_Examination_Miss_Catriona_Gibbon.pdf
CGCMM: https://ars.els-cdn.com/content/image/1-s2.0-S037838122100162X-mmc2.pdf
gran: https://nova.newcastle.edu.au/vital/access/services/Download/uon:34391/ATTACHMENT01
gran: https://eprints.nottingham.ac.uk/69201/1/William%20Reynolds%20Thesis%2016.1_corrections.pdf
gran: https://ir.canterbury.ac.nz/server/api/core/bitstreams/2a64fb98-3143-4d02-9fcb-d02227e80ef3/content
gran: https://open.uct.ac.za/server/api/core/bitstreams/7bbd7d9c-6f80-45e9-8d7e-3e319713b314/content
charmm2lammps (LJ): http://ethesis.nitrkl.ac.in/6144/1/212MM2338-5.pdf
CVFF: https://www.researchgate.net/profile/Jurgen-Lange/publication/283943867_Molecular_Dynamic_Simulation_of_Oxaliplatin_Diffusion_in_Polylactic_acid-_co_-glycolic_acid_Part_A_Parameterization_and_Validation_of_the_Force-Field_CVFF/links/5a749f10a6fdcc53fe16c31f/Molecular-Dynamic-Simulation-of-Oxaliplatin-Diffusion-in-Polylactic-acid-co-glycolic-acid-Part-A-Parameterization-and-Validation-of-the-Force-Field-CVFF.pdf
Ca: https://vtechworks.lib.vt.edu/server/api/core/bitstreams/47c372d7-9944-422b-8f7e-73db3c485857/content
QC: https://citeseerx.ist.psu.edu/document?repid=rep1&type=pdf&doi=d309054b1aa8adf177f8e2fcc507fa852b68a228
FeOH (ReaxFF): https://repository.library.northeastern.edu/files/neu:cj82pr03d/fulltext.pdf
HO (ReaxFF): https://repository.library.northeastern.edu/files/neu:cj82pr03d/fulltext.pdf
NiCHO (ReaxFF): https://dc.suffolk.edu/undergrad/13 
NiC (ReaxFF): https://publications.aston.ac.uk/id/eprint/44530/6/Fikri_Ahmad_Atif_2021.pdf
ZnO (ReaxFF): https://open.library.ubc.ca/media/download/pdf/24/1.0319080/4
Ar (ReaxFF): https://bearworks.missouristate.edu/theses/3416
Ar (ReaxFF): https://bearworks.missouristate.edu/theses/3669 
SiO2 (ReaxFF): https://www.duo.uio.no/bitstream/handle/10852/45552/1/master-thesis.pdf
SiO (ReaxFF): https://www.researchgate.net/profile/Rajni-Chahal-2/publication/369245297_MECHANICS_OF_NANOSCALE_FIBER_NETWORKS_AND_THEIR_COMPOSITES_A_THREE-DIMENSIONAL_MULTISCALE_STOCHASTIC_MODELLING_STUDY/links/6411c8e392cfd54f84015903/MECHANICS-OF-NANOSCALE-FIBER-NETWORKS-AND-THEIR-COMPOSITES-A-THREE-DIMENSIONAL-MULTISCALE-STOCHASTIC-MODELLING-STUDY.pdf
SiCH (ReaxFF): https://www.proquest.com/openview/e18b64c082181cb152500117984293f5/1.pdf?pq-origsite=gscholar&cbl=18750&diss=y
H (ReaxFF): https://ntnuopen.ntnu.no/ntnu-xmlui/bitstream/handle/11250/2390753/12537_FULLTEXT.pdf?sequence=1
C (ReaxFF): https://ninercommons.charlotte.edu/islandora/object/etd:1542/datastream/PDF/download/citation.pdf
GLUCOSEPANE (ReaxFF): https://www.politesi.polimi.it/bitstream/10589/88581/1/2013_12_Bernardi_Crippa.pdf
CHON (ReaxFF): https://doi.org/10.1016/j.carbon.2021.07.080
CHNO (ReaxFF): https://etda.libraries.psu.edu/files/final_submissions/16242
CHO (ReaxFF): https://doi.org/10.1016/j.carbon.2022.02.018
CHO (ReaxFF)(tensile): https://scholarsjunction.msstate.edu/td/3189 
CHOS (ReaxFF): https://macau.uni-kiel.de/servlets/MCRFileNodeServlet/dissertation_derivate_00007173/Diss_Mueller.pdf
graphyne (ReaxFF): https://ninercommons.charlotte.edu/islandora/object/etd:1542/datastream/PDF/download/citation.pdf
Xe (ReaxFF): https://doi.org/10.1016/j.carbon.2018.11.063
C (ReaxFF): https://ntnuopen.ntnu.no/ntnu-xmlui/handle/11250/2445481
C (ReaxFF): https://www.researchgate.net/profile/Sorayot-Chinkanjanarot/publication/304091140_DENSITY_OF_AMORPHOUS_CARBON_BY_USING_DENSITY_FUNCTIONAL_THEORY/links/5a144341aca27240e309cd3e/DENSITY-OF-AMORPHOUS-CARBON-BY-USING-DENSITY-FUNCTIONAL-THEORY.pdf
CHONP (ReaxFF): https://udspace.udel.edu/server/api/core/bitstreams/045abab1-bac0-404b-8f85-b5830b7e32af/content
CHONSSi (ReaxFF): https://doi.org/10.1016/j.matdes.2023.112155
BCH (PKA) (ReaxFF): https://bearworks.missouristate.edu/cgi/viewcontent.cgi?article=4709&context=theses
BCH (PKA) (ReaxFF): https://bearworks.missouristate.edu/theses/3416 
CHOMnLiFPNiAl (ReaxFF): https://deepblue.lib.umich.edu/bitstream/handle/2027.42/133380/sahitya_1.pdf
(ReaxFF, tensile): https://digitalcommons.mtu.edu/etdr/
Reactive Molecular dynamics: https://repository.lib.ncsu.edu/server/api/core/bitstreams/03b4c7f0-f5d1-4e95-a579-12ebfb3193f1/content
oxDNA: https://link.springer.com/content/pdf/10.1140/epje/i2018-11669-8.pdf
ASE: https://digitalcommons.latech.edu/cgi/viewcontent.cgi?article=1000&context=theses
ASE: https://www.duo.uio.no/bitstream/handle/10852/70387/master.pdf?sequence=1
GRO2LAM: https://link.springer.com/content/pdf/10.1007/s00894-019-4011-x.pdf
DeepMD: https://bearworks.missouristate.edu/theses/3835
Ovito python script: https://doi.org/10.1063/1.5085750
Ovito python script: https://scholarworks.utep.edu/cgi/viewcontent.cgi?article=2384&context=open_etd
nanocrystal_builder.py: https://www.researchgate.net/profile/Mark-Tschopp/publication/322147436_Voronoi-Based_Nanocrystalline_Generation_Algorithm_for_Atomistic_Simulations/links/5a480832458515f6b0569fc0/Voronoi-Based-Nanocrystalline-Generation-Algorithm-for-Atomistic-Simulations.pdf
CeO2: https://uhra.herts.ac.uk/bitstream/handle/2299/15336/08174625%20Loya,%20Adil%20-%20Final%20PhD%20Submission.pdf?sequence%253D1
dump: https://scholarsarchive.byu.edu/cgi/viewcontent.cgi?article=7423&context=etd
CP2k: https://www.academia.edu/download/106104072/1040028.pdf
CP2k: https://jollywatt.github.io/assets/pdf/2019.Crystal-Band-Structures-CP2K.pdf
CP2k: https://github.com/MarsalekGroup/aml
CP2k: https://www.pure.ed.ac.uk/ws/portalfiles/portal/19653859/wp140.pdf
PdCNT (CP2k): https://doi.org/10.1063/1.5040048
QE: https://doi.org/10.1021/acs.jctc.2c00742
python: https://doi.org/10.1063/1.5109116
python: https://scholarsarchive.byu.edu/cgi/viewcontent.cgi?article=8348&context=etd
python: https://doi.org/10.1016/j.cpc.2023.108961
python(FeNb): https://arxiv.org/pdf/1907.12254
python: https://aaltodoc.aalto.fi/server/api/core/bitstreams/505042a1-a900-4d42-98e1-6dfb6ad22309/content
COF (cif): https://doi.org/10.1016/j.jcis.2024.03.077
tersoff: https://link.springer.com/article/10.1007/s11051-014-2351-0
tersoff: https://ecommons.cornell.edu/bitstream/handle/1813/67407/Herbol_cornellgrad_0058F_11274.pdf?sequence=1
tersoff: https://arxiv.org/pdf/2106.07090
comb (Fe-F): https://pubs.rsc.org/en/content/articlepdf/2019/cp/c9cp01927h
CH (meam): https://doi.org/10.1016/j.polymer.2019.02.060
AuSi (meam): http://laurent.pizzagalli.free.fr/Pub/God16EML.pdf
xyz: https://doi.org/10.1016/j.fuel.2024.132064
poscar: https://www.researchgate.net/profile/Fadi-Aldakheel/publication/356260165_Exploring_the_mechanical_properties_of_two-dimensional_carbon-nitride_polymer_nanocomposites_by_molecular_dynamics_simulations/links/6193b52f3068c54fa5f0e53c/Exploring-the-mechanical-properties-of-two-dimensional-carbon-nitride-polymer-nanocomposites-by-molecular-dynamics-simulations.pdf
matlab: https://doi.org/10.1016/j.jcp.2018.01.015
matlab: https://www.politesi.polimi.it/bitstream/10589/2021/1/2010_07_Nova.pdf
matlab: https://aaltodoc.aalto.fi/server/api/core/bitstreams/505042a1-a900-4d42-98e1-6dfb6ad22309/content
matlab: https://doi.org/10.1016/j.carbon.2013.08.027
morse: https://doi.org/10.1063/5.0087382
morse (Th-O): https://arxiv.org/pdf/2204.13685
morse: https://ir.vanderbilt.edu/bitstream/handle/1803/14842/cp_dissertation.pdf?sequence=1&isAllowed=y
morse: https://link.springer.com/content/pdf/10.1007/s00339-022-06379-y.pdf
USPEX: https://www2.it.uu.se/edu/course/homepage/projektTDB/ht20/report03/Report_03_final.pdf
CG: https://webthesis.biblio.polito.it/secure/13857/1/tesi.pdf
Alpha-Quartz (tersoff): file:///C:/Users/manab/Downloads/Herbol_cornellgrad_0058F_11274.pdf
PdC, NiC (tersoff): https://ddd.uab.cat/pub/tesis/2018/hdl_10803_664041/fjm1de1.pdf
TB: https://journals.aps.org/prb/abstract/10.1103/PhysRevB.48.22
SiC (tersoff): https://www.theseus.fi/bitstream/handle/10024/149985/Carey_Brent.pdf?sequence=1
SiO2 (tersoff): https://academiccommons.columbia.edu/doi/10.7916/5qte-hh77/download
SiFCl (tersoff): https://pubs.aip.org/aip/jcp/article-pdf/120/5/2405/10858635/2405_1_online.pdf
C (tersoff or REBO): http://www.heatenergist.org/upload/publication/20161126191044.pdf
C (tersoff): https://www.mdpi.com/1996-1944/16/20/6714/pdf
CH (MEAM): https://doi.org/10.1016/j.polymer.2019.02.060
SrTiO3: https://purehost.bath.ac.uk/ws/portalfiles/portal/187927626/Thesis.pdf
CFH (AIREBO): https://physik.uni-greifswald.de/storages/uni-greifswald/fakultaet/mnf/physik/ag_schneider/Arbeiten/mortenMSc.pdf
kART: https://uvadoc.uva.es/bitstream/handle/10324/20512/TFM-G554.pdf?sequence=1&isAllowed=y
TiNAl: https://bearworks.missouristate.edu/cgi/viewcontent.cgi?article=4169&context=theses
ZrYO(buck): https://doi.org/10.1016/j.commatsci.2023.112722
NaCl (back): https://essay.utwente.nl/63570/1/BscReport_KarunDatadien_s0208663_openbaar.pdf
ZnS (back): https://mds.marshall.edu/cgi/viewcontent.cgi?article=2417&context=etd
SC17: https://github.com/ZachMarcus/SC17 , https://doi.org/10.1016/j.parco.2018.07.005
promd.mdp: https://doi.org/10.1016/j.ymeth.2021.03.005
hybrid: https://huskiecommons.lib.niu.edu/cgi/viewcontent.cgi?article=7975&context=allgraduate-thesesdissertations
CuH (bop): https://link.springer.com/content/pdf/10.1007/s10853-015-8848-9.pdf
CdTeSe (bop): https://pubs.acs.org/doi/pdf/10.1021/jp505915u
#---------------------------------------------------------------------
https://pubs.acs.org/doi/10.1021/ja404330q
http://ethesis.nitrkl.ac.in/6144/1/212MM2338-5.pdf
http://ethesis.nitrkl.ac.in/5400/1/211MM1199.pdf
https://zenodo.org/records/10251760
https://ttu-ir.tdl.org/server/api/core/bitstreams/7738845f-5518-4b4e-ae6f-b4ed485f6dca/content
https://digital.library.ncat.edu/cgi/viewcontent.cgi?article=1146&context=dissertations
https://dc.suffolk.edu/cgi/viewcontent.cgi?article=1012&context=undergrad
#---------------------------------------------------------------------
