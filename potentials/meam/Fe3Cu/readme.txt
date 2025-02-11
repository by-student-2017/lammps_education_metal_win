#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
pair_style	meam
pair_coeff	* * library2.meam Fe Cu Fe3Cu_param.meam Fe Cu
#------------------------------------------------------------------------
https://matsci.org/t/questions-about-ni-si-alloy-with-the-meam-potential/21058/3
#------------------------------------------------------------------------
