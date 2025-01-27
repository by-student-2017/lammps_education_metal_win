#-------------------------------------------------------------
Common settings found in detailed 2NN-MEAM files

library.meam
ibar 3            # The most common value is "3", followed by "0" (seen for elements set to 'dim'). "-5" has also become more common since 2018 (seen for Fe-Si).

# rc is often written as a cut-off in papers. When calculating dimer, it is necessary to check for rc less than 4.0. 
# In a densely packed structure, the potential is close to 0 near 4.0, so the default value of 4.0 is not so bad. If the cut-off value is not written in the paper, it is not a bad idea to start from 4.0 (Empirically, if rc=4.0 does not work, setting it to rc=4.8 or higher will often improve the elastic constant. A specific example I often try is 4.0 -> 4.8 -> 5.5 -> 6.0.). This is because if the correct potential is created, the value will be close to 0 at about 4.0 A. (recall that the potential asymptotically approaches zero at large distances).
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
- ibar: In the initial MEAM formalism "ibar = 0" was used and it is not suitable when any of the t(h) values are less than zero because it produces imaginary electron densities when Gamma < -1. So "ibar = 1" and "ibar = 3" were used and it was "ibar = 3" that  turned out to be the most versatile and able to reproduce the most of the experimental data. (Note: Another way to get around this problem is to set ibar to 0 to -5.)
- Cmin and Cmax: Generally used values for Cmin and Cmax are 2.0 or 0.8 and 2.8, respectively. 
  For the bcc structure, in the case of Cmin < 0.47, even the third nearest-neighbor interactions are not completely screened for the reference structure. In case of element Fe (Cmin = 0.16) the contribution to the potential energy from them is very small, as well as the error in the potential energy calculations if they are ignored. So, in order to avoid that error all together, Cmin should remain larger than 0.47 and then third nearest-neighbor interactions are completely screened [3].
- 1NN-MEAM vs. 2NN-MEAM: The basic formalism of the MEAM and 2nnMEAM is the same, except for the pair potential and the screening function parameters. The original MEAM [3] had a nearest neighbor screening function in order to limit interactions to the rst neighbors and the limiting values of the C parameter were chosen as Cmin = 2.0 and Cmax = 2.8. Now, those limiting values have to be changed to allow for second nearest-neighbor  interactions to be included in the energy calculations. For fcc and bcc Cmin has to be lower than 1.0 and 2.0, respectively [2].
- BCC case
|              | A  | b0 | t1 | t2 | t3 | Cmin |
| ------------ | -- | -- | -- | -- | -- | ---- |
| C11 and C12  | +  | +  |    | -  |    |  +   |
| C44          | +  | +  |    | -  |    |  +   |
| Esurf        | +  | -  | +  | -  | -  |  -   |
| dE(bcc->fcc) | +  | +  |    |    | +  |  +   |
| dE(fcc->hcp) | +  | +  |    |    | +  |  +   |
- One of the approaches for the tting procedure is to rst determine values of A, b0, Cmin,and t3 by tting to elastic constants (C11, C44) and structural energy di erences ( E(bcc->fcc), E(fcc->hcp)). But, it is not always possible to t all of those properties with four parameters. Elastic constants are tted exactly and structural energies as close as possible. After that, t1 and t2 are determined from surface energies and heat of vacancy formation. As a test, the order of the low index surface energies can be checked, and one can also confirm what is the most stable phase of the element in question [2].
- parameters: A total of 13 parameters need to be determined, 4 of which are from the equation of state (Ecoh, re, B and d), 8 are Cmin and Cmax and the nal one is the 0. As seen in Table 4.1, each pure element has its own Cmin and Cmax, because all interaction are between atoms of the same type (A-A-A or B-B-B). On the other hand, in alloys there are 4 di erent cases for screening (A-B-A, B-A-B, A-A-B, and A-B-B) that need to be taken into consideration. In this notation (A-B-C) means the screening ffect of a B atom on a bond between A and C atoms.
- Parameters with (i,j) mean all combinations of (i,j), for example lattce(i,j) which describes the crystal lattice of the pure elements 1 and 2, lattce(1,1) and lattce(2,2), and that of their alloy lattce(1,2). Cmin(i jk) means a minimum value of the screen ing factor where the interaction between atoms i and j starts to be fully screened by the atom k. On the other hand, Cmax(i jk), means the value where atom k does not interfere in the interaction between atoms i and j. Then those two atoms are unscreened by the atom k.
- fitting: (The reference number may be incorrect.->) [7] B.-J. Lee and J.-W. Jang, A modified embedded-atom method interatomic potential for the FeH system, Acta Materialia, vol. 55, pp. 67796788, Dec. 2007.: https://doi.org/10.1016/j.actamat.2007.08.041
| Parameter     | Selected value                       | Fitting procedure |
| Ecoh          | 0.5*Ecoh(Fe) + 0.5*Ecoh(H) + 0.164   | Fitting dilute heat of solution of H in bcc and fcc Fe. 0.5*Ecoh(Fe) + 0.5*Ecoh(H) - (-0.164), delta=-0.164 |
| re            | 1.835                                | Fitting lattice parameter of NaCl-type FeH and for better overall agreement |
| B             | 2.95                                 | Fitting rst-principles bulk modulus of NaCl-type FeH MEAM |
| d             | 0.5*d(Fe) + 0.5*d(H)                 | Assumption, in many cases, attrac=repuls=d=a3=0.5*d(Fe) + 0.5*d(H) |
| Cmin(Fe-H-Fe) | 0.36 = Cmin(Fe)                      | Assumption, Cmin(Fe-H-Fe) = Cmin(1,1,3) = Cmin(Fe,Fe,H) |
| Cmin(H-Fe-H)  | 2.0 = Cmin(H)                        | Assumption, Cmin(H-Fe-H) = Cmin(3,3,1) = Cmin(H,H,Fe) |
| Cmin(Fe-Fe-H) | 2.15                                 | Relative size of heat of solution in bcc and fcc Fe, Cmin(Fe-Fe-H) = Cmin(1,3,1) = Cmin(Fe,H,Fe) |
| Cmin(Fe-H-H)  | [0.5*Cmin(Fe)^0.5+0.5*Cmin(H)^0.5]^2 | Assumption, Cmin(Fe-H-H) = Cmin(1,3,3) = Cmin(Fe,H,H) |
| rho0          | rho0(H)/rho0(Fe) = 18                | For better overall agreement, rho0(1) = 1, rho0(3) = 18 |
Note: see https://arxiv.org/pdf/2109.01712 (Note that the descriptions of Cmin and Cmax in papers can be confusing.)
Note: Cmin(i-k-j) = Cmin(i,j,k) and Cmin(i,j,k) = Cmin(j,i,k): see 2007--Lee-B-J-Jang-J-W--Fe-H on NIST (Interatomic Potentials Repository). (Empirically, this form is often the case when the paper includes a description of C(i-k-j) or does not mention Lammps.)
- Conclusion: Prior to them the MEAM potential was successfully used to calculate the basic properties of the variety of zirconium hydrides. But, MEAM failed in all stacking fault tests. On the other hand, 2nnMEAM was successful in all three tests and once again proved the advantages of the 2nnMEAM formalism. The main challenge was nding the right tting parameters for the new 2nn MEAM. Although, separate 2nnMEAM potentials might have been created for each of the three tests, our focus was more on the transferability of the new 2nnMEAM. DFT results were used for ne-tuning. 2nnMEAM is capable of simulating a realistic response of the solution during shearing. 2nnMEAM results were qualitatively very similar to DFT results, although energy levels were noticeably higher than in DFT tests. At the same time, the ratios of the unstable stacking faults of the pure hcp zirconium to = 0.125, and the pure hcp zirconium to = 0.5 were similar. In order to improve the results of this thesis, better optimization has to be im plemented and new calculations of the reference structure need to be done with rst principles. Furthermore, more DFT results for stacking fault tests of zirconium hy drides would give a better insight of the zirconium hydrogen interaction and help create a better 2nnMEAM
Note: Looking at the publicly available files, H and N that are dimers in library.meam often have nn2=0 (note: for alloys, nn2=1).
#-------------------------------------------------------------
# https://docs.lammps.org/pair_meam.html
Cmax(I,J,K) = Cmax screening parameter when I-J pair is screened by K (I<=J); default = 2.8
Cmin(I,J,K) = Cmin screening parameter when I-J pair is screened by K (I<=J); default = 2.0
Cmin and Cmax are necessary up to (I<=J), but listing C(j,i,k) in addition to C(i,j,k) is often done because it is convenient for finding errors and using the mixing rule.
Note: In some papers, it is not specified whether j or k is used for screening. In such cases, it is a good idea to check by setting C(i,j,k) = C(j,i,k). If a different value of C(j,i,k) exists, it may be possible that the atoms you are currently considering for screening are incorrect.
see "Lammps format"(https://www.ctcms.nist.gov/potentials/Download/2009--Kim-H-K-Jung-W-S-Lee-B-J--Fe-Ti-C/1/FeTiC_Implementation.pdf)
see https://matsci.org/t/meam-screening-parameters/22778/4
#-------------------------------------------------------------
r1 = 1st neighbour, r2 = 2nd neighbour
BCC: r1 < rc < r2, r2 = sqrt(4/3)*r1 = 1.1547*r1
FCC: r1 < rc < r2, r2 = sqrt(2)*r1 = 1.4142*r1
Diamond: r1 < rc < r2, r2 = sqrt(8/3)*r1 = 1.633*r1
#-------------------------------------------------------------
see https://matsci.org/t/lammps-users-meam-is-ialloy-implemented-in-lammps/7889
If you want to match the DYNAMO code
ialloy = 0 or 1 # https://matsci.org/t/ialloy-parameter-in-meam/32853
emb_lin_neg = 1
bkgd_dyn = 1
#-------------------------------------------------------------
https://matsci.org/t/lammps-users-meam-potentials/5982
Note: In 1NN-MEAM, d is not introduced (attract = repuls = a3 = 0), so erose_form = 0, 1, 2 are the same. Therefore, erose_form = 0 or the default is often used.
Note: In 2NN-MEAM, d is introduced, and the formula for erose_form = 2 is often specified in papers. Therefore, erose_form = 2 is often used.
#-------------------------------------------------------------
- Bulk case
Note: As shown in the example of BTi, when Cmin and Cmax published by NIST are added, or when ibar is changed from 3 to 0 or -5, the difference in lattice constant, cohesive energy, and elastic constant is not clear, so it is difficult to clarify which setting is best.
Note: There are also papers in which only the ibar has been changed using files and parameters from published previous papers.
#-------------------------------------------------------------
Conclusion
1. Publishers, referees, and editors should require that input files used in supplementary materials be made public as a condition of publication. It would be ideal if all conditions could be described in the paper, but this is not currently the case.
2. Other than NIST, public institutions should be involved in international efforts to verify and develop the potential, and appropriate institutions should be created.
3. Papers that cannot be reproduced should be downgraded so that they can be used as research results for the next generation. Predecessors should not be obstacles to those who follow. 
4. If there is a correlation between the credibility of potential and the impact factor, it should be shown. If there is no positive correlation, the impact factor is meaningless for the topic under discussion here.
#-------------------------------------------------------------
5. If possible, we should consider using donations to improve the facility. We would like to ask philanthropists who are unsure of how to spend their money to do so.
#-------------------------------------------------------------

#-------------------------------------------------------------
# Assumption in ternary systems
C(A-C-B) = C(A,B,C), when A-B atom pair is screened by C atom.
#----------(see VPdY.meam or TiVN.meam) (This is easy to understand as it is a simple mixture of each.)
Cmin(i-k-j) = [0.5*Cmin(i-k-i)^0.5 + 0.5*Cmin(j-k-j)^0.5]^2
Cmax(i-k-j) = [0.5*Cmax(i-k-i)^0.5 + 0.5*Cmax(j-k-j)^0.5]^2
For Lammps (MEAM potential file)
Cmin(i,j,k) = [0.5*Cmin(i,i,k)^0.5 + 0.5*Cmin(j,j,k)^0.5]^2
Cmax(i,j,k) = [0.5*Cmax(i,i,k)^0.5 + 0.5*Cmax(j,j,k)^0.5]^2
#----------
#----------(see NiAlCo.meam) (This is difficult to understand because something that is not the atom to be screened is used as the atom to be screened. Since Cmin(i-k-j) = Cmin(j-i-k), the expressiveness is lower than the method shown above. It is necessary to consider the physical reason why this method is adopted.)
Cmin(i-j-k) = [0.5*Cmin(i-j-i)^0.5 + 0.5*Cmin(k-j-k)^0.5]^2
Cmax(i-j-k) = [0.5*Cmax(i-j-i)^0.5 + 0.5*Cmax(k-j-k)^0.5]^2
Cmin(i-k-j) = [0.5*Cmin(i-i-j)^0.5 + 0.5*Cmin(k-k-j)^0.5]^2 = Cmin(j-i-k)
Cmax(i-k-j) = [0.5*Cmax(i-i-j)^0.5 + 0.5*Cmax(k-k-j)^0.5]^2 = Cmin(j-i-k)
For Lammps (MEAM potential file)
Cmin(i,k,j) = [0.5*Cmin(i,i,j)^0.5 + 0.5*Cmin(k,k,j)^0.5]^2
Cmax(i,k,j) = [0.5*Cmax(i,i,j)^0.5 + 0.5*Cmax(k,k,j)^0.5]^2
Cmin(i,j,k) = [0.5*Cmin(i,j,i)^0.5 + 0.5*Cmin(k,j,k)^0.5]^2 = Cmin(j,k,i)
Cmax(i,j,k) = [0.5*Cmax(i,j,i)^0.5 + 0.5*Cmax(k,j,k)^0.5]^2 = Cmin(j,k,i)
#----------
#-------------------------------------------------------------

#-------------------------------------------------------------
# Relationship between EAM and MEAM when "b1=b2=b3=t1=t2=t3=O" (e.g., He of FeHe, or Zn of CuZn and AA7075)
- If all the b parameters (b1, b2, b3) other than b0 and all the t parameters (t1, t2, t3) other than t0 are 0, then the MEAM is equivalent to the EAM. This is because the MEAM is an extension of the EAM, with the additional parameters b and t being used to introduce angular dependence.
- Specifically, b0 represents the fundamental term of the angular dependence, and t0 is the parameter for scaling it. If all other parameters are 0, then the angular dependence disappears, resulting in the same form as the EAM.
- This can be confirmed in the following literature: https://doi.org/10.1016/j.commatsci.2018.11.050 and https://doi.org/10.3390/ma13092062
- Note: This is also important when creating potentials with rare gases, since studying different gas atmospheres and their pressures is important for the development of practical materials. 
- Note: The Lammps code has a function ("momb") to calculate Grimme's dispersion force (-D2). It may be worth considering using this function. However, the easiest way to interact with noble gases is to use the Lennerd-Jones potential (see https://doi.org/10.1140/epjd/e2019-100387-9). 
- Note: If you want to take into account the second moment approximation, which has an important effect when changing the coordination number, you need to add it to the MEAM file. In that sense, it is worth taking the trouble to add new elements to the MEAM file.
#-------------------------------------------------------------

#-------------------------------------------------------------
# For 1NN-MEAM (2025/1/25)
- Ask Copilot: The 2022 paper "High strain-rate effect on microstructure evolution and plasticity of aluminum 5052 alloy nano-multilayer: A molecular dynamics study" uses 1NN-MEAM. This is probably because it is a closed pack, and although it deals with grain boundaries, it does not deal with the surface, and discusses tensile strength and dislocation density. What are your thoughts on this? Incidentally, 2NN-MEAM was published by Lee in 2001. I think the authors and referees decided that 2NN-MEAM was not necessary. In addition, as Baskes​ studied with MEAM​ in 1992, it has shown good results in dilute systems. Perhaps it was judged that the additives in Al​ could be approximated as dilute because it is AA5052 ?
- Answer from Copilot: Your analysis is quite insightful. Here are some points to consider regarding the use of 1NN-MEAM in the 2022 paper titled "High strain-rate effect on microstructure evolution and plasticity of aluminum 5052 alloy nano-multilayer: A molecular dynamics study":
1. Closed-packed structure: 1NN-MEAM is well-suited for FCC (face-centered cubic) structures. Since AA5052 has an FCC structure, 1NN-MEAM is a suitable choice.
2. Grain boundary treatment: 1NN-MEAM can accurately simulate grain boundary behavior. Even without considering surface effects, it can effectively capture the influence of grain boundaries.
3. Tensile strength and dislocation density: 1NN-MEAM is effective in evaluating tensile strength and dislocation density, which are directly related to the plastic deformation and strength of the material.
4. Dilute alloying elements: AA5052 is an aluminum alloy with low concentrations of alloying elements. As Baskes demonstrated in 1992, MEAM performs well in dilute systems. Therefore, it is likely that the authors and reviewers deemed 1NN-MEAM sufficient for this study.
- 2NN-MEAM, developed by Lee in 2001, considers more complex interactions but is not always necessary for all simulations. When 1NN-MEAM provides adequate accuracy, it is often chosen for its lower computational cost and simpler model.
- In summary, the choice of 1NN-MEAM in this study appears to be a well-considered decision based on the material properties and the objectives of the simulation. Your analysis aligns well with these considerations.
5. Application to Other Bases
- This research methodology can be applied not only to Al-based materials but also to Fe-based and Ni-based materials. For example, it is effective for analyzing the microstructure of Fe-based nanocrystalline materials and Ni-based superalloys.
#-------------------------------------------------------------

#-------------------------------------------------------------
# Inferred phylogenetic tree
- CFeMnSi (Aslam 2019) -> FeCoCrMnSi (Salloom 2022)
- Fe-X(X=Al,Cu,Nb,W)_CoNb (Muralles 2023) -> CoFe-X(X=V,Nb,Mo,W) (Muralles 2024)
- SiAu -> SiAuO
- TM-N(TM=Ti,V,Cr,Fe) (Ding 2019) -> TiNV (Ding 2020) -> TiCrV (Ding 2021)
- NiTi (Ko 2015) -> NbNiTi (Lee 2022)
- CaMg (Kim 2015) -> CaMgTi (Nersisyan 2024)
- AgTiO3 (Gao 2013) -> CuTiO (CuTaO3 or CuTa2O6) (Gao 2015)
- HfNbTaTiZr_HEA -> AlHfNbTaTiZr_HEIC
  (Note: "VNbTaTiZr_HEA" is probably a different system because the NbTaTiZr parameters do not match those of HfNbTaTiZr_HEA.)
- RhPt (Luyten 2007) -> PtPdRh (Luyten 2009)
- Li (Cui 2012) -> LiMo (Vella 2017)
- Li (Cui 2012) -> LiSi (Godet 2020)
- Al-X(X=Zr,Cu,Cr,Ti)_AlZrTi (J.-R. Castillo-Sanchez 2022)-> Al-X(X=Li,Zr,Zn) (Rincent 2023)
#-------------------------------------------------------------

#-------------------------------------------------------------
# H-X (X=Zr, V, Fe, Ni, Cu, Al, C)
ZrH, VH, VNiH, AlVH, FeH, FeCH, NiH, NiVH, ZrCuH, AlH, CH
#-------------------------------------------------------------
# B-X (X=Mg, Ti, Al)
(MgAlB), BTi
Note: (MgAlB): I'm not sure if I can reproduce the paper.
#-------------------------------------------------------------
# C-X (X=H, Ti, Nb, (W), Mn, Fe, Ni, Pd, Pt, Cu, Al, Si)
CCu, CH, TiC, CNb, (WC), CFeMnSi, FeCH, FeTiC, NbFeC, NiTiC, CNi, PdC, PtC, CCu, SiC, TiAlC
Note: (WC): I'm not sure if I can reproduce the paper.
#-------------------------------------------------------------
# N-X (X=Ti, Zr, V, Cr, Nb, Fe, (Ni), Cu, Al, In, Ga)
TiN, TiVN, (Ti2X(X=N,C)), ZrN, (TM-N(TM=Ti,V,Cr,Fe)), CrTiN, (TiCrN), FeNbN, FeN, FeTiN, (FeCrNiN), CuNTi, TiAlN, GaInN
Note: (TM-N(TM=Ti,V,Cr,Fe)), (Ti2X(X=N,C)), (TiCrN), (FeCrNiN): I'm not sure if I can reproduce the paper.
#-------------------------------------------------------------
# Si-X (X=Li, Mg, Mo, Cr, Mn, Fe, Co, Ni, Cu, Zn, Al, C, Ge, O, He)
LiSi, AlSiMgCuFe_AA6061, AlSiMgCuZn_AA7075, MoSi, FeCrSi, CFeMnSi, FeCoCrMnSi_HEA, FeCrNiN_AISI_316, SiAl, SiC, SiGe, SiO, SiHe, X-Y(FeMnSiCAlZnO)
Note: AlSiMgCuZn_AA7075, MoSi, FeCrNiN_AISI_316, X-Y(FeMnSiCAlZnO), SiGe, SiHe: I'm not sure if I can reproduce the paper.
#-------------------------------------------------------------

#-------------------------------------------------------------
# How to create potentials for High Entropy Alloys (HEA), Fe-based, Ni-based, and Al-based, etc
1. The unit system uses Pure_Elements.
2. The Materials Project provides Ec, re, and B for the alloy, so alpha can be calculated. The elastic constants are also given, so Cmin and Cmax can be optimized. ("meam_converter.xlsx" allows you to calculate alpha.)
3. The Cmin and Cmax of X-Y-Z can be estimated using a binary system.
4. If you want to treat the surface more accurately than the bulk, such as surface energy, you can fit more detailed parameters (e.g. Cmin and Cmax).
Note: Due to a reason known as the Hume-Rothery law, multidimensional systems other than the HEA are quite difficult to exist in, except at dilute states, so much insight would be gained from preparing binary systems that fit the Materials Project data, and even ternary systems that can be inferred from the binary systems.
#-------------------------------------------------------------
# MPC (https://matsci.org/t/fitting-tool-for-meam-parameters/26254)
Intended as a teaching tool, MPC is designed to run on personal computers (Windows 7 64-bit, MacOS X Yosemite) without "MATLAB".
#-------------------------------------------------------------
see "KISSMD_LAMMPS_converter.xlsx" (https://cmse.postech.ac.kr/lammps/3707)
#-------------------------------------------------------------


The MEAM file is described in detail in the literature.
#-------------------------------------------------------------
NbTiZrMoV_HEA
Fe-X(X=Al,Cu,Nb,W)_CoNb
CoFe-X(X=V,Nb,Mo,W)
FeCrSi
FeCH
CrTiN
NiTiCu
TiNAg
LiMo (LiMo.meam only. "library.meam" does not exist. The publisher may have listed it incorrectly. Here, we have constructed library.meam from previously published data.)
LiSi
WP
#-------------------------------------------------------------


#-------------------------------------------------------------
BTi: Results obtained with TiB2 were close to those in the literature. Awesome !
#-------------------------------------------------------------
NiSn: Results similar to those in the literature were obtained with Ni3Sn. Awesome !
#-------------------------------------------------------------
ZrN: The values ​​obtained for NaCl-type ZrN are close to those in the literature. Awesome !
#-------------------------------------------------------------
MgAg: The values ​​obtained for CsCl-type B2-MgAg are close to those in the literature. Awesome !
#-------------------------------------------------------------
TiAlC: Results similar to those in the literature were obtained with Ti2AlC.
Mao's group at Henan University has achieved reproducibility. Amazing !
#-------------------------------------------------------------
FeCrNiN_AISI_316: Results similar to those in the literature were obtained with NiN and Ni3Fe.
Since the elastic constants of CrN did not match, Cmax(i-j-i) was changed from 2.80 to 1.44, the same as Fe-N.
Due to the change in Cmax(2,4,2), the Cmax value for the ternary system was also changed.
I haven't checked the ternary system yet.
#-------------------------------------------------------------
MoSi: The convergence conditions were tightened to calculate the elastic modulus of Mo3Si and Mo5Si3.
init.mod
variable ftol equal 1.0e-8 -> 1.0e-10
variable maxiter equal 100 -> 10000
variable maxeval equal 1000 -> 1000000
Note: Perhaps there is a setting that is closer to the literature value.
Note: Looking at these results, one can see that there may be hope for calculating thermal conductivity in the Mn-Si system, which has a chimney-ladder structure, an important thermoelectric material.
#-------------------------------------------------------------
TM-N(TM=Ti,V,Cr,Fe): he convergence conditions were tightened to calculate the elastic modulus of FeN and TiV..
TiVN
TiCrN
Note: Perhaps there is a setting that is closer to the literature value. It doesn't go well with Cr.
#-------------------------------------------------------------

#-------------------------------------------------------------
VNbTaTiZr_HEA: For binary systems, the values ​​were almost the same except for NbZr. For ternary systems, the values ​​did not match.
#-------------------------------------------------------------
NiRe: It mostly fits. Refitting Cmin and Cmax may bring it closer to the DFT results.
#-------------------------------------------------------------
RePt: It mostly fits. Refitting Cmin and Cmax may bring it closer to the DFT results.
#-------------------------------------------------------------
WC: I'm not sure if I can reproduce the paper.
#-------------------------------------------------------------

I was unable to obtain values ​​close to those found in the literature.
I apologize for this being due to my lack of ability.

#-------------------------------------------------------------
NiTiC: For NiTi, values ​​close to those in the literature were obtained. B2 NiHf and L12 Ti3Hf do not match the literature.
Note: Perhaps there is a setting that is closer to the literature value.
#-------------------------------------------------------------
TiCrN: It could not be considered as literature.
#-------------------------------------------------------------

#-------------------------------------------------------------
SiAuO: I tried it with mp-6930 but it doesn't match the literature.
SiAu: Si and Au are generally good, but I haven't tried Si-Au.
#-------------------------------------------------------------

#-------------------------------------------------------------
FeXO(X=Ni,Cr): Although we tried various things, we were unable to obtain values ​​close to the results in Table 3 using only the data in the paper.
#-------------------------------------------------------------
