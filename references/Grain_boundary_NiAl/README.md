# Morrison-Scripta

# Scripta Materialia [1] Repository
 
## Title: Exploration of the Sliding Behavior of a Sigma-11 Grain Boundary with Precipitates in Ni-Al system Using Molecular Dynamic
 
## Authors: Rachel L. Morrison[2], Saryu J. Fensin [3], Jennifer L.W. Carter [2]

[Case Western Reserve University, Mesolab] [2] 
[MST 8, Los Alamos National Laboratory] [3]

Funding Agency: This work made use of the High Performance Computing Resource in the Core Facility for Advanced Research Computing at Case Western Reserve University. 
Thank to you Dr. Eric Hahn for his assistance with MD. 
This work was supported by the Case Western Reserve University Startup Funds and the C2 Marie Program at Los Alamos National Laboratory.
 


This repository contains the following files:

in.nickelPrecipShear - the input files to deform the nickel grain boundary systems 
data.0D - relaxed initial 0D system (compressed)
data.1D - relaxed initial 1D system (compressed)
data.2D - relaxed initial 2D system (compressed)

The data files was created by modifying code developed by [Mark Tschopp][4].

The potential for the Ni-Al system is located at the [NIST website][5].

The code used to deform the system was created by modifying code found used in the following publication:

S. J. Fensin, M. Asta and R. G. Hoagland. (2012) Structure and shear response of a ∑11 asymmetric tilt grain boundary in copper from Molecular-Dynamics. Philosophical Magazine. V92, I34, pp4320-4333.
https://doi.org/10.1080/14786435.2012.705911

In order to generate the data discussed in this paper, the following procedure can be followed. 

1) Aquire a LAMMPS executable from the [LAMMPS website][6]. 

2) Aquire the Ni-Al Mishin Potential (2004)from the [NIST website][5].

3) Edit the input file (in.nickelPrecipShear) to include the data file for the desired simulation. 

4) Run the code.

5) Visualize the results using [Ovito][7].


[1]: https://www.journals.elsevier.com/scripta-materialia
[2]: http://engineering.case.edu/groups/msl/home
[3]: https://www.lanl.gov/org/padste/adeps/materials-science-technology/index.php
[4]: https://icme.hpc.msstate.edu/mediawiki/index.php/LAMMPS_Help3
[5]: https://www.ctcms.nist.gov/potentials/system/Ni/#Al-Ni
[6]: https://lammps.sandia.gov/download.html
[7]: https://ovito.org/