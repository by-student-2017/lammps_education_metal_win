#-------------------------------------------------------------
Common settings found in detailed 2NN-MEAM files

library.meam
ibar 3            # The most common value is 3, followed by 0 (seen for elements set to 'dim'). -5 is also seen occasionally, but only occasionally.

# rc is often written as a cut-off in papers. When calculating dimer, it is necessary to check for rc less than 4.0.
# In a densely packed structure, the potential is close to 0 near 4.0, so the default value of 4.0 is not so bad. If the cut-off value is not written in the paper, it is not a bad idea to start from 4.0.
delr = 0.1        # default = 0.1
augt1 = 0         # default = 1
erose_form = 2    # The default is 0, but 2 is often used for papers and MEAM files.
ialloy = 2        # default = 0

# The following is often not listed, so the default settings will be used.
mixture_ref_t = 0 # default = 0
emb_lin_neg = 0   # default = 0
bkgd_dyn = 0      # default = 0
#-------------------------------------------------------------


The MEAM file is described in detail in the literature.
#-------------------------------------------------------------
NbTiZrMoV_HEA
Fe-X(X=Al,Cu,Nb,W)_CoNb
CoFe-X(X=V,Nb,Mo,W)
NiTiCu
#-------------------------------------------------------------

#-------------------------------------------------------------
BTi: Results obtained with TiB2 were close to those in the literature.
#-------------------------------------------------------------
NiSn: Results similar to those in the literature were obtained with Ni3Sn.
#-------------------------------------------------------------

I was unable to obtain values ​​close to those found in the literature.
I apologize for this being due to my lack of ability.
#-------------------------------------------------------------
TiVN: The unknown parameters were changed to bring the elastic constants closer to the TiV values. Looking at the results below, this is unlikely to be true.
#-------------------------------------------------------------
TM-N(TM=Ti,V,Cr,Fe): The unknown parameters were changed in the same way as TiVN, but the elastic constants do not match those in the literature.
#-------------------------------------------------------------
TiCrN: The unknown parameters were changed in the same way as TiVN, but the elastic constants do not match those in the literature.
#-------------------------------------------------------------

#-------------------------------------------------------------
FeXO(X=Ni,Cr): Although we tried various things, we were unable to obtain values ​​close to the results in Table 3 using only the data in the paper.
#-------------------------------------------------------------