#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 1NN-MEAM
pair_style meam
pair_coeff * * library.meam Pt Ru PtRu.meam Pt Ru
#------------------------------------------------------------------------
# In the paper, it is stated that Cmin(Pt-Ru-Pt) = 2.8. It is necessary to check whether it is 2.0, 1.8, or 0.8.

# Pt: [18] M. I. Baskes, Phys, Rev. B 46, 2727 (1992).
# Ru: [19] M. I. Baskes et al., Modelling Simul. Mater. Sci. Eng. 2, 147 (1994).
# Pt-Ru: Liu, H. B. et al., J. Comput. Theor. Nanosci. 8 (2011) 201-206.: https://doi.org/10.1166/jctn.2011.1677
#------------------------------------------------------------------------
