#-------------------------------------------------------------
Common settings found in detailed 2NN-MEAM files

library.meam
ibar 3            # The most common value is "3", followed by "0" (seen for elements set to 'dim'). "-5" has also become more common since 2022.

# rc is often written as a cut-off in papers. When calculating dimer, it is necessary to check for rc less than 4.0.
# In a densely packed structure, the potential is close to 0 near 4.0, so the default value of 4.0 is not so bad. If the cut-off value is not written in the paper, it is not a bad idea to start from 4.0.
delr = 0.1        # default = 0.1
augt1 = 0         # default = 1
erose_form = 2    # The default is 0, but 2 is often used for papers and MEAM files.
ialloy = 2        # default = 0, The default is 0, but 2 is often used for papers and MEAM files.

# The following is often not listed, so the default settings will be used.
mixture_ref_t = 0 # default = 0
emb_lin_neg = 0   # default = 0
bkgd_dyn = 0      # default = 0
#-------------------------------------------------------------
Note: https://repository.library.carleton.ca/concern/etds/05741s48q <- This is also discussed in various papers.
ibar: In the initial MEAM formalism "ibar = 0" was used and it is not suitable when any of the t(h) values are less than zero because it produces imaginary electron densities when < 1. So "ibar = 1" and "ibar = 3" were used and it was "ibar = 3" that  turned out to be the most versatile and able to reproduce the most of the experimental data.
Cmin and Cmax: Generally used values for Cmin and Cmax are 2.0 or 0.8 and 2.8, respectively.
1NN-MEAM vs. 2NN-MEAM: The basic formalism of the MEAM and 2nnMEAM is the same, except for the pair potential and the screening function parameters. The original MEAM [3] had a nearest neighbor screening function in order to limit interactions to the rst neighbors and the limiting values of the C parameter were chosen as Cmin = 2.0 and Cmax = 2.8. Now, those limiting values have to be changed to allow for second nearest-neighbor
#-------------------------------------------------------------
Note: As shown in the example of BTi, when Cmin and Cmax published by NIST are added, or when ibar is changed from 3 to 0 or -5, the difference in lattice constant, cohesive energy, and elastic constant is not clear, so it is difficult to clarify which setting is best.
Note: There are also papers in which only the ibar has been changed using files and parameters from published previous papers.
#-------------------------------------------------------------
Conclusion
1. Publishers, referees, and editors should require that input files used in supplementary materials be made public as a condition of publication. It would be ideal if all conditions could be described in the paper, but this is not currently the case.
2. Other than NIST, public institutions should be involved in international efforts to verify and develop the potential, and appropriate institutions should be created.
3. Papers that cannot be reproduced should be downgraded so that they can be used as research results for the next generation. Predecessors should not be obstacles to those who follow. 
4. If there is a correlation between the credibility of potential and the impact factor, it should be shown. If there is no positive correlation, the impact factor is meaningless for the topic under discussion here.
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
TiAlC: Results similar to those in the literature were obtained with Ti2AlC.
Mao's group at Henan University has achieved reproducibility. Amazing !
#-------------------------------------------------------------
FeCrNiN_AISI_316: Results similar to those in the literature were obtained with NiN and Ni3Fe.
Since the elastic constants of CrN did not match, Cmax(i-j-i) was changed from 2.80 to 1.44, the same as Fe-N.
Due to the change in Cmax(2,4,2), the Cmax value for the ternary system was also changed.
I haven't checked the ternary system yet.
#-------------------------------------------------------------


I was unable to obtain values ​​close to those found in the literature.
I apologize for this being due to my lack of ability.

#-------------------------------------------------------------
MoSi: Similar results were obtained for MoSi2, but the elastic constants for Mo3Si and Mo5Si3 did not match the literature values.
#-------------------------------------------------------------
NiTiC: NiTi is close to the literature, but the elastic constants of TiC and NiC do not match.
#-------------------------------------------------------------

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
