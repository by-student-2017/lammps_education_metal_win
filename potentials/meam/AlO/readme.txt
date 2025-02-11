# W. Sekkal et al., Phys. B: Condens. Matter. 404 (2009) 335-339.: https://doi.org/10.1016/j.physb.2008.11.089
# The MEAM potentials used in this work for aluminum and oxygen, originally developed by Baskes et al. [44]/
# [44] M.I. Baskes, SAND, 96, 1996, p. 8484.: https://www.osti.gov/biblio/224267 , https://www.osti.gov/servlets/purl/224267

Usage in lammps input
#-------------------------------------------------------------
# 1NN-MEAM
pair_style meam
pair_coeff * * ./../../library.meam Al O ./../../AlO.meam Al O
#-------------------------------------------------------------
