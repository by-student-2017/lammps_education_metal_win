Each of the folders here correspond to a temperature.

Within Each temperature folder is a folder which contains the compositions tested.
U100 = UO2
U75 = U75Zr25O2 and so on...

Within each composition folder is a supercell size folder:

5x5x20
5x5x40
5x5x60

and, in the case of U0 (ZrO2) there is two folders, one for the x and one for the z direction (X and Z)


Within each folder are the infiles and outfiles from LAMMPS simulations
The main infiles required to replicate these results are:

*.lmpstruct
kappa.lmpin

The main outfiles used to calculate thermal conductivity are:
tmp_profile.out
flux_log.out
lattice.out

Each folder contains all of the above files as well as:
TC.lmpout

which contains the run data from LAMMPS