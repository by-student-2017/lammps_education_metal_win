#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Fe Co Cr Mn Si FeCoCrMnSi.meam Fe Co Cr Mn Si
#------------------------------------------------------------------------
# R. Salloom et al., 2022 Modelling Simul. Mater. Sci. Eng. 30 075002.: DOI 10.1088/1361-651X/ac860d
# Note: The value of erose_form is unknown. There is no formula given in the literature.
# Probably related: C-Fe-Mn-Si: 2019--Aslam-I-Baskes-M-I-Dickel-D-E-et-al--Fe-Mn-Si-C in (NIST, Interatomic Potentials Repository): https://www.ctcms.nist.gov/potentials/
#------------------------------------------------------------------------
