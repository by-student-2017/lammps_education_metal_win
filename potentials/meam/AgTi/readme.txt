#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Ag Ti AgTi.meam Ag Ti
#------------------------------------------------------------------------
# Y. Zhou et al., Nucl. Instrum. Methods Phys. Res. B 393 (2017) 122-125.: https://doi.org/10.1016/j.nimb.2016.10.030
# Y. Zhou, Doctor thesis (2018).: https://repository.lboro.ac.uk/articles/thesis/Modelling_thin_film_growth_in_the_Ti-Ag_system/9374516?file=16985483

# There is no mention of d in AgTi in the paper.
# "For our AgTi binary system, the ordered bcc AgTi structure is first chose nas a reference."
# From the above, the reference structure of AgTi is estimated to be BCC B2.
# The elastic constants were not verified in the paper.
#------------------------------------------------------------------------
