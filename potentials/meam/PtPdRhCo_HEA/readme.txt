#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
pair_style meam
pair_coeff * * library.meam Pt Pd Rh Co PtPdRhCo.meam Pt Pd Rh Co 
#-------------------------------------------------------------

#-------------------------------------------------------------
# S.-P. Ju et al., Phys. Status Solidi B 260 (2023) 2200366.: https://doi.org/10.1002/pssb.202200366
# The Cmax and Cmin are arranged in the LAMMPS format, and the first and second elements of each binary system are designated as A and B for presenting Cmax and Cmin parameters.
# The Cmax and Cmin parameters for all ternary element types are set to 2.8 to 2.0, respectively.
#-------------------------------------------------------------
# References (Unfortunately, the jushinpon github was missing information on Cmin and Cmax.)
jushinpon file
Github: https://github.com/jushinpon
PtPdRhCo_HEA: https://github.com/jushinpon/PtPdRhCo_HEA
#-------------------------------------------------------------
