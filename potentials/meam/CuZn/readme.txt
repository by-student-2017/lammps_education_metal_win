Usage in lammps input
#-------------------------------------------------------------
# 1NN-MEAM
# Note: Zn (b1=b2=b3=t1=t2=t3=0) from EAM
pair_style meam
pair_coeff * * library.meam Cu Zn NULL Cu Zn
#-------------------------------------------------------------
