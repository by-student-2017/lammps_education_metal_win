This file README.txt was updated on 2022-12-12 by Moon-ki Choi


Suggested Citation for dataset: Choi, Moon-ki; Pasetto, Marco; Shen, Zhaoxiang; Tadmor, Ellad; Kamensky, David. (2022). Supporting data for Atomistically-informed continuum modeling and isogeometric analysis of 2D materials over holey substrates. Retrieved from the Data Repository for the University of Minnesota, https://doi.org/10.13020/gfms-wy93.


-------------------
GENERAL INFORMATION
-------------------
Title of Dataset
	Supporting data for "Atomistically-informed continuum modeling and isogeometric analysis of 2D materials over holey substrates." Journal of the Mechanics and Physics of Solids 170 (2023): 105100.

Author Information:
	Name: Moon-ki Choi
	Institution: University of Minnesota 
	Address: Department of Aerospace Engineering and Mechanics, University of Minnesota, Minneapolis, MN 55455
	Email: choi0652@umn.edu
	ORCID: 0000-0003-2887-5880

	Name: Marco Pasetto
	Institution: University of California San Diego 
	Address: Department of Mechanical and Aerospace Engineering, University of California San Diego, La Jolla, CA 92093
	Email: pasetto.marc@gmail.com
	ORCID:

	Name: Zhaoxiang Shen
	Institution: University of Luxembourg
	Address: Department of Engineering, Faculty of Science, Technology and Medicine, University of Luxembourg, Esch-sur-Alzette 4365, Luxembourg
	Email: zhaoxiang.shen@uni.lu
	ORCID: 0000-0002-5184-812X

	Name: Ellad B. Tadmor
	Institution: University of Minnesota
	Address: Department of Aerospace Engineering and Mechanics, University of Minnesota, Minneapolis, MN 55455
	Email: tadmor@umn.edu
	ORCID: 0000-0003-3311-6299
	
	Name: David Kamensky
	Institution: University of California San Diego
	Address: Department of Mechanical and Aerospace Engineering, University of California San Diego, La Jolla, CA 92093
	Email: david.kamensky@gmail.com
	ORCID: 

Date of data collection:
	20200421-20220714

Geographic location of data collection:
	University of Minnesota,
	University of California San Diego,
	University of Luxembourg.

Information about funding sources that supported the collection of the data:
	Start-up funding from the University of California San Diego,
	The University of Minnesota MRSEC under Award Number DMR-2011401.

-------------------
SHARING/ACCESS INFORMATION
-------------------
1. Licenses/restrictions placed on the data: Attribution-NonCommercial-NoDerivs 3.0 United States
2. Links to publications that cite or use the data:
	https://doi.org/10.1016/j.jmps.2022.105100
3. Links to other publicly accessible locations of the data: 
4. Links/relationships to ancillary data sets:
5. Was data derived from another source?
	No.
6. Recommended citation for the data: 
	https://doi.org/10.1016/j.jmps.2022.105100
---------------------
DATA & FILE OVERVIEW
---------------------
1. FILE (or DIRECTORY) list
	A. [DIRECTORY] Uniaxial_strain_test: LAMMPS input script and atomistic structure file of MoS2 layer for tensile test are included. LAMMPS will generate strain-force data.
	B. [DIRECTORY] Bending_test: LAMMPS input script and atomistic structure file of MoS2 layer for bending test are included. LAMMPS will generate a bent MoS2 layer with incremental deformation. Energy minimization is performed for each step. 
	C. [DIRECTORY] Trench_substrate_new_fix: c++ files for new fix command for LAMMPS are included. The new fix command will add force and energy for MoS2 layer from an interaction with a Si3N4 substrate with a trench. The directory includes README_IMPLEMENTATION file for implementation instruction.
	D. [DIRECTORY] Circular_substrate_new_fix: c++ files for new fix command for LAMMPS are included. The new fix command will add force and energy for MoS2 layer from an interaction with a Si3N4 substrate with a circular hole. The directory includes README_IMPLEMENTATION file for implementation instruction.
	E. [DIRECTROY] Figure2: Data and MATLAB file for creating figure 2 in the paper.
	F. [DIRECTROY] Figure7: Data and MATLAB file for creating figure 7 in the paper.
	G. [DIRECTROY] Figure9: Data and MATLAB file for creating figure 9 in the paper.
	H. [DIRECTROY] Figure11: Data and MATLAB file for creating figure 11 in the paper.
	I. [DIRECTROY] Figure14: Data and MATLAB file for creating figure 14 in the paper.
	J. [DIRECTROY] Figure15: Data and MATLAB file for creating figure 15 in the paper.
	K. [DIRECTROY] Figure17: Data and MATLAB file for creating figure 17 in the paper.
	L. [DIRECTROY] Figure18a: Data and MATLAB file for creating figure 18a in the paper.
	M. [DIRECTROY] Figure18b: Data and MATLAB file for creating figure 18b in the paper.
	N. [DIRECTROY] Figure19,21: Data and MATLAB file for creating figure 19 and 21 in the paper. Input variable 'L' can change to generate a figure.
	O. [DIRECTROY] Figure20: Data and MATLAB file for creating figure 20 in the paper. Input variable 'L' can change to generate a figure.
	P. [DIRECTROY] Figure22: Data and MATLAB file for creating figure 22 in the paper. 
2. Relationship between files: Not applicable.
3. Additional related data collected that was not included in the current data package: No.
4. Are there multiple versions of the dataset? No.
-------------------------- 
METHODOLOGICAL INFORMATION
--------------------------	
1. Description of methods used for collection/generation of data: Entire contents of the paper (https://doi.org/10.1016/j.jmps.2022.105100) cover the computational method to generate data. 
2. Methods for processing the data: Data was processed with MATLAB 9.12.0.1956245 (R2022a) Update 2 for visualization and properties computation.
3. Instrument- or software-specific information needed to interpret the data: MATLAB
4. Standards and calibration information, if appropriate: No.
5. Environmental/experimental conditions: 
	Continuum model simulations were performed in serial on a laptop with a 2.6 GHz Intel Core i9-11950H processor and 32 GB of RAM. Molecular static simulations were performed using a computing cluster with 24 2.6 GHz AMD Opteron 6344 processor cores on each node.
6. Describe any quality-assurance procedures performed on the data:
7. People involved with sample collection, processing, analysis and/or submission: List people and their role.
	Moon-ki Choi: Methodology, Software, Validation, Formal analysis, Investigation, Writing – original draft, Writing – review &
editing, Visualization. Marco Pasetto: Methodology, Software, Validation, Formal analysis, Investigation, Writing – original draft,
Writing – review & editing, Visualization. Zhaoxiang Shen: Methodology, Software, Validation, Formal analysis, Investigation, Data
curation, Writing – original draft, Writing – review & editing, Visualization. Ellad B. Tadmor: Conceptualization, Writing – original
draft, Writing – review & editing, Supervision, Project administration, Funding acquisition. David Kamensky: Conceptualization,
Software, Writing – original draft, Writing – review & editing, Supervision, Project administration.
-------------------
Directory Structure
-------------------
[ 640]  ./
├── [ 160]  Bending_test/
│   ├── [1.6K]  MoS.REBO.set5b
│   ├── [2.9K]  bending.in
│   └── [ 30K]  relaxed.data
├── [ 224]  Circular_substrate_new_fix/
│   ├── [ 163]  README_IMPLEMENTATION.txt
│   ├── [ 16K]  fix_addforcefieldMo.cpp
│   ├── [ 21M]  fix_addforcefieldMo.h
│   ├── [ 16K]  fix_addforcefieldS.cpp
│   └── [ 21M]  fix_addforcefieldS.h
├── [ 288]  Figure11/
│   ├── [ 24K]  CM_trench_REBO.csv*
│   ├── [ 24K]  CM_trench_SW.csv*
│   ├── [2.1K]  MS_trench_REBO.mat*
│   ├── [2.1K]  MS_trench_SW.mat*
│   ├── [4.6K]  compare_MDtrench_new.asv*
│   ├── [2.4K]  monolayer_trench.m*
│   └── [ 12K]  substrate.csv*
├── [ 160]  Figure14/
│   ├── [310K]  AFM_data_Si3N4_substrate.mat*
│   ├── [1.9M]  CM_sub.csv*
│   └── [4.1K]  comparison_AFM_CM_Si3N4_substrate.m*
├── [ 256]  Figure15/
│   ├── [ 24K]  CM_REBO.csv*
│   ├── [ 24K]  CM_SW.csv*
│   ├── [2.1K]  MS_REBO.mat*
│   ├── [2.1K]  MS_SW.mat*
│   ├── [2.5K]  monolayer_circular_substrate.m*
│   └── [ 12K]  substrate.csv*
├── [ 224]  Figure17/
│   ├── [347K]  CM_REBO.csv*
│   ├── [335K]  CM_SW.csv*
│   ├── [216K]  MS_REBO.mat*
│   ├── [210K]  MS_SW.mat*
│   └── [1.3K]  main.m*
├── [ 256]  Figure18a/
│   ├── [ 24K]  Nel100_A-16_R16_a2_I_D17.46a_na2.csv
│   ├── [ 10K]  cos_L40_REBO_max_abseig_cross.csv
│   ├── [ 10K]  cos_L40_SW_max_abseig_cross.csv
│   ├── [450K]  data_REBO_Mo_K_tensor.mat
│   ├── [445K]  data_SW_Mo_K_tensor.mat
│   └── [1.8K]  figure18a.m
├── [ 160]  Figure18b/
│   ├── [7.2K]  REBO_strain.mat*
│   ├── [7.2K]  SW_strain.mat*
│   └── [1.1K]  figure18b.m
├── [ 544]  Figure19,21/
│   ├── [ 669]  E_plot_array.m
│   ├── [1.9M]  e_Mo_L340_C0.048_p2_REBO_2D.csv
│   ├── [2.3M]  e_Mo_L360_C0.047_p2_REBO_2D.csv
│   ├── [2.3M]  e_Mo_L360_C0.048_p2_REBO_2D.csv
│   ├── [1.2M]  e_Mo_L370_C0.048_p2_REBO_2D.csv
│   ├── [2.4M]  e_Mo_L380_C0.048_p2_REBO_2D.csv
│   ├── [1.2M]  e_Mo_L390_C0.048_p2_REBO_2D.csv
│   ├── [2.8M]  e_Mo_L400_C0.047_p2_REBO_2D.csv
│   ├── [2.8M]  e_Mo_L400_C0.048_p2_REBO_2D.csv
│   ├── [2.8M]  e_Mo_L440_C0.047_p2_REBO_2D.csv
│   ├── [2.8M]  e_Mo_L440_C0.048_p2_REBO_2D.csv
│   ├── [2.8M]  e_Mo_L480_C0.047_p2_REBO_2D.csv
│   ├── [2.8M]  e_Mo_L480_C0.048_p2_REBO_2D.csv
│   ├── [2.8M]  e_Mo_L520_C0.047_p2_REBO_2D.csv
│   └── [2.8M]  e_Mo_L520_C0.048_p2_REBO_2D.csv
├── [ 128]  Figure2/
│   ├── [164K]  AFM_data_Si3N4substrate.mat*
│   └── [ 488]  AFM_data_Si3N4substrate_fig.m*
├── [ 384]  Figure20/
│   ├── [ 729]  K_plot_array.m
│   ├── [2.0M]  cos_L340_REBO_max_abseig.csv
│   ├── [2.3M]  cos_L360_REBO_max_abseig.csv
│   ├── [ 18M]  cos_L370_REBO_max_abseig.csv
│   ├── [2.5M]  cos_L380_REBO_max_abseig.csv
│   ├── [ 18M]  cos_L390_REBO_max_abseig.csv
│   ├── [2.8M]  cos_L400_REBO_max_abseig.csv
│   ├── [2.8M]  cos_L440_REBO_max_abseig.csv