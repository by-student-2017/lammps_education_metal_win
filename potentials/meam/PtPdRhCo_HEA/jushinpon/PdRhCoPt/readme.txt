Usage in lammps input
#-------------------------------------------------------------
pair_style meam
pair_coeff * * library.meam Pd Rh Co Pt PdRhCoPt.meam Pd Rh Co Pt
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