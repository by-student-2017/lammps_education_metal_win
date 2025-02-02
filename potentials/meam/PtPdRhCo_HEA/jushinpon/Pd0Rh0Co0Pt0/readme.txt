Usage in lammps input
#-------------------------------------------------------------
pair_style meam
pair_coeff * * library.meam Pd0 Rh0 Co0 Pt0 Pd0Rh0Co0Pt0.meam Pd0 Rh0 Co0 Pt0
#-------------------------------------------------------------

#-------------------------------------------------------------
# Test
(double click) run_mesmpi.bat
#-------------------------------------------------------------

#-------------------------------------------------------------
# References (Unfortunately, the jushinpon github was missing information on Cmin and Cmax.)
jushinpon file
Github: https://github.com/jushinpon
PtPdRhCo_HEA: https://github.com/jushinpon/PtPdRhCo_HEA
#-------------------------------------------------------------