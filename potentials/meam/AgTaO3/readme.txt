#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Ag Cu Sn AgCuSn.meam Ag Cu Sn
#------------------------------------------------------------------------
# AgTaO3 MEAM potential from Medell. Simul. Mater. Sci. Eng. 21 055002 (2013)
# Atom number specific for "Ag", "Ta" and "O" are 1, 2 and 3, respectively.
# to be used with "library.meam" file providing single element parameters
# Contact information: amartini@ucmerced.edu (Dr. Ashlie Martini)
#------------------------------------------------------------------------
