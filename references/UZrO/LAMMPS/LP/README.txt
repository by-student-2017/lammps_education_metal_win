This section relates to the LAMMPS files used to produce the lattice parameter, thermal expansion and heat capacity. 

Two folders are in this repository:

Cubic - This contains the LAMMPS in and outfiles for structures which began as FCC-Cubic
Tetragonal - This contains the LAMMPS in and outfiles for structures which began as Tetragonal.

Within the Cubic folder is a folder for all compositions which were tested 
U0
U25
U50
U75
U100

Tetragonal contains 
U0
U25

Within these folders are the files:
LP.lmpout
UZrO2.lmpin
*.lmpstruct

The files inside each composition can be used in LAMMPS to regenerate the data that is also found here.

The cubic U0 and tetragonal U25 have been kept as they were compared with their tetragonal counterparts to determine which phase was stable or if both were. It was found the U25 was stable as a cubic structure and the U0 as a tetragonal.