#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Ni Al Co Ti NiAlCoTi.meam Ni Al Co Ti
#------------------------------------------------------------------------
# S. Huang et al.,  Journal of Materials Research and Technology, 30 (2024) 9274–9284.: https://doi.org/10.1016/j.jmrt.2024.06.016
# 2024--Huang-S-Xiong-Y-Ma-S-et-al--Ni-Al-Co-Ti (NIST, Interatomic Potentials Repository): https://www.ctcms.nist.gov/potentials/
#------------------------------------------------------------------------
