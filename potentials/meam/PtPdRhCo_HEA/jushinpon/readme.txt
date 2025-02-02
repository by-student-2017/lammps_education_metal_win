Usage in lammps input
#-------------------------------------------------------------
pair_style meam
pair_coeff * * library.meam Pt Pd Rh Co PtPdRhCo.meam Pt Pd Rh Co 
#-------------------------------------------------------------

#-------------------------------------------------------------
# References (Unfortunately, the jushinpon github was missing information on Cmin and Cmax.)
jushinpon file
Github: https://github.com/jushinpon
PtPdRhCo_HEA: https://github.com/jushinpon/PtPdRhCo_HEA
#-------------------------------------------------------------