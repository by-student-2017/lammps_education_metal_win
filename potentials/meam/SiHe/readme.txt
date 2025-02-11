#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Si He SiHe.meam Si He
#------------------------------------------------------------------------
# L. Pizzagalli et al., 2013 Modelling Simul. Mater. Sci. Eng. 21 065002.: DOI 10.1088/0965-0393/21/6/065002
# L. Ji et al., Nanotechnol. Precis. Eng. 3, 81–87 (2020).: https://doi.org/10.1016/j.npe.2020.03.003
# Note: Not all parameters are listed in the paper. (e.g., augt1, delr, and ialloy, etc)
#------------------------------------------------------------------------
