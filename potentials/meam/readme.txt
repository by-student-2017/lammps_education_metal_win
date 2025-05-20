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
- One of the approaches for the fitting procedure is to rst determine values of A, b0, Cmin,and t3 by fitting to elastic constants (C11, C44) and structural energy di erences ( E(bcc->fcc), E(fcc->hcp)). But, it is not always possible to fit all of those properties with four parameters. Elastic constants are tted exactly and structural energies as close as possible. After that, t1 and t2 are determined from surface energies and heat of vacancy formation. As a test, the order of the low index surface energies can be checked, and one can also confirm what is the most stable phase of the element in question [2].
- parameters: A total of 13 parameters need to be determined, 4 of which are from the equation of state (Ecoh, re, B and d), 8 are Cmin and Cmax and the final one is the rho0. As seen in Table 4.1, each pure element has its own Cmin and Cmax, because all interaction are between atoms of the same type (A-A-A or B-B-B). On the other hand, in alloys there are 4 different cases for screening (A-B-A, B-A-B, A-A-B, and A-B-B) that need to be taken into consideration. In this notation (A-B-C) means the screening effect of a B atom on a bond between A and C atoms.
- Parameters with (i,j) mean all combinations of (i,j), for example lattce(i,j) which describes the crystal lattice of the pure elements 1 and 2, lattce(1,1) and lattce(2,2), and that of their alloy lattce(1,2). Cmin(i,j,k) means a minimum value of the screen ing factor where the interaction between atoms i and j starts to be fully screened by the atom k. On the other hand, Cmax(i,j,k), means the value where atom k does not interfere in the interaction between atoms i and j. Then those two atoms are unscreened by the atom k.
- fitting: (The reference number may be incorrect.->) [7] B.-J. Lee and J.-W. Jang, A modified embedded-atom method interatomic potential for the FeH system, Acta Materialia, vol. 55, pp. 67796788, Dec. 2007.: https://doi.org/10.1016/j.actamat.2007.08.041
| Parameter     | Selected value                       | Fitting procedure |
| Ecoh          | 0.5*Ecoh(Fe) + 0.5*Ecoh(H) - 0.164   | Fitting dilute heat of solution of H in bcc and fcc Fe. 0.5*Ecoh(Fe) + 0.5*Ecoh(H) - (0.164), delta=0.164 |
| re            | 1.835                                | Fitting lattice parameter of NaCl-type FeH and for better overall agreement |
| B             | 2.95                                 | Fitting rst-principles bulk modulus of NaCl-type FeH MEAM |
| d             | 0.5*d(Fe) + 0.5*d(H)                 | Assumption, in many cases, attrac=repuls=d=a3=0.5*d(Fe) + 0.5*d(H) |
| Cmin(Fe-H-Fe) | 0.36 = Cmin(Fe)                      | Assumption, Cmin(Fe-H-Fe) = Cmin(1,1,3) = Cmin(Fe,Fe,H) |
| Cmin(H-Fe-H)  | 2.0 = Cmin(H)                        | Assumption, Cmin(H-Fe-H) = Cmin(3,3,1) = Cmin(H,H,Fe) |
| Cmin(Fe-Fe-H) | 2.15                                 | Relative size of heat of solution in bcc and fcc Fe, Cmin(Fe-Fe-H) = Cmin(1,3,1) = Cmin(Fe,H,Fe) |
| Cmin(Fe-H-H)  | [0.5*Cmin(Fe)^0.5+0.5*Cmin(H)^0.5]^2 | Assumption, Cmin(Fe-H-H) = Cmin(1,3,3) = Cmin(Fe,H,H) |
| rho0          | rho0(H)/rho0(Fe) = 18                | For better overall agreement, rho0(1) = 1, rho0(3) = 18 |
Note: Ec (or Ecoh) is the cohesive energy. The larger the positive value, the more stable the material is. There are many papers that incorrectly describe the formula for Ec in alloys. Ec = -(E(re) - E(r=inf))/N [eV/atom]
Note: When "delta(I,J) = heat of formation" is positive, it means that the alloy is energetically unstable. When the heat of formation has a positive value, it means that the compound absorbs energy during its formation. Also recall that "Ec_IJ = (Ec_II + Ec_JJ)/2 - delta_IJ".
Note: see https://arxiv.org/pdf/2109.01712 (Note that the descriptions of Cmin and Cmax in papers can be confusing.)
Note: Cmin(i-k-j) = Cmin(i,j,k) and Cmin(i,j,k) = Cmin(j,i,k): see 2007--Lee-B-J-Jang-J-W--Fe-H on NIST (Interatomic Potentials Repository). (Empirically, this form is often the case when the paper includes a description of C(i-k-j) or does not mention Lammps.)
- Conclusion: Prior to them the MEAM potential was successfully used to calculate the basic properties of the variety of zirconium hydrides. But, MEAM failed in all stacking fault tests. On the other hand, 2nnMEAM was successful in all three tests and once again proved the advantages of the 2nnMEAM formalism. The main challenge was nding the right fitting parameters for the new 2nn MEAM. Although, separate 2nnMEAM potentials might have been created for each of the three tests, our focus was more on the transferability of the new 2nnMEAM. DFT results were used for ne-tuning. 2nnMEAM is capable of simulating a realistic response of the solution during shearing. 2nnMEAM results were qualitatively very similar to DFT results, although energy levels were noticeably higher than in DFT tests. At the same time, the ratios of the unstable stacking faults of the pure hcp zirconium to = 0.125, and the pure hcp zirconium to = 0.5 were similar. In order to improve the results of this thesis, better optimization has to be im plemented and new calculations of the reference structure need to be done with rst principles. Furthermore, more DFT results for stacking fault tests of zirconium hy drides would give a better insight of the zirconium hydrogen interaction and help create a better 2nnMEAM
Note: When looking at publicly available 2NN-MEAM files, elements that are dimers in library.meam (e.g., H and N) often have nn2=0 (note: in alloys, nn2=1).
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
Note: in 1NN-MEAM, d is rarely introduced (Because of this, in many cases "attract = repulsion = a3 = 0"), so erose_form = 0, 1, 2 are the same. Therefore, erose_form = 0 or the default is often used.
Note: In 2NN-MEAM, d is introduced, and the formula for erose_form = 2 is often specified in papers. Therefore, erose_form = 2 is often used.
#-------------------------------------------------------------
## Bulk case
Note: As shown in the example of BTi, when Cmin and Cmax published by NIST are added, or when ibar is changed from 3 to 0 or -5, the difference in lattice constant, cohesive energy, and elastic constant is not clear, so it is difficult to clarify which setting is best.
Note: There are also papers in which only the ibar has been changed using files and parameters from published previous papers.
#-------------------------------------------------------------
## Selecting a reference structure
- Note: We constructed the zirconium potential using fcc as the reference structure. The use of an hcp reference structure is possible [16] but much more cumbersome. The properties predicted by the MEAM potential are the same whether we start with the hcp or fcc structures. (F. J. Cherne et al., LA-UR-03-0368.: https://www.osti.gov/servlets/purl/976517)
- Note: The above is written in the literature, and I agree with the idea if Rose's universal curve is considered to be valid without any problems. However, since the data applied to Rose's universal curve has different errors depending on the reference structure, I think that papers that change the reference structure and examine it can be fully supported.
- FCC base (e.g., Al-base or Ni-base): FCC_B1 (NaCl-type), L12 or Diamond_B3 (interlaced fcc for alloy, e.g., GaAs) reference structure for Alloys (A reference structure close to the symmetric composition ratio to be calculated is often selected.)
- BCC base (e.g., Fe-base): BCC_B2 (CsCl-type) reference structure for Alloys
#-------------------------------------------------------------
## For a3 = d (attrac and repuls)
- Typically a value between 0 and 0.05.
- From the viewpoint of TB-SMA (tight binding second moment approximation), the Rose universal function is fitted such that the smaller the value of d, the more likely the molecule is, and the larger the value, the more densely packed the structure is. It is also useful to remember that the condition close to the Morse potential form (p/q = 2) from the viewpoint of TB-SMA is d = 0.02. 
- Therefore, the condition of d > 0.05 should be carefully checked for any misfit.
- In TB-SMA, it may be possible for p/q = 8 in Li, that is, d = 0.20, but in the case of d > 0.20, which exceeds 0.20, physical reasons must be thoroughly considered.
- If the value of d is not appropriate (for example, if it is not in the range of 0 to 0.05, as is the case normally), you may be fitting with a large change in other parameters such as rho0, which may reduce the possibility of transfer.
- From a TB-SMA perspective, the value of p/q tends to decrease as the number of turns in the periodic table increases (i.e., d approaches 0).
- In the Rose universal curve ("erose = -Ec*(1 +astar + a3*(astar**3))*exp(-astar)"), when d becomes a negative value, a repulsive force occurs on the long-distance side (energy unstable). (Specifically, if we explain that negative energy is stable, when the interatomic distance is moved away from the most stable equilibrium state interatomic distance, it should gradually converge from negative values ​​to 0, but instead it converges to 0 after passing through positive values.) Introducing a cutoff can avoid the problem (where such energy becomes positive), but please understand that making d negative creates such a potential shape.
- There is a method to calculate d in the Rose universal curve, but in many cases the value of d cannot be calculated due to lack of data. It would be reasonable to calculate the energy when the lattice constant is changed using DFT and then find the value of d that matches it. However, this also requires a lot of effort. When DFT-D2 is entered, the value can sometimes be 0.13, making it difficult to determine the value of a3 = d.
#-------------------------------------------------------------
## Note to the author and referees
- When we create a MEAM using the Rose universal function, the energy, lattice constant, and bulk modulus show fairly good values. However, it is necessary to set Cmin and Cmax appropriately for the elastic constants. Therefore, at the very least, you should compare the elastic constants of the reference structure with DFT or experimental values. 
- To check parameters such as Ec for alloys, you should also list the bulk modulus and alpha (aster = a*) values.
- It should be specified whether i, j, or k is used for screening in C(i-k-j). Even though the paper mentions the Lammps format, the Lammps manual on the web does not show any notation for C(i-k-j) (it lists Cmin(I,J,K) and Cmax(I,J,K)).
- The cutoff rc and other setting conditions should also be clearly stated.
- So far, even if you enter the values ​​in the paper into Lammps, the results for the MEAM for Cr often do not match those in the paper. We need to continue to investigate why this is the case.
- "Assumption" is useful, but it is not omnipotent. The fact that a search for parameters was conducted should be clearly stated in the paper, for example by stating that a fit was found and changes were necessary.
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
# For new Materials Project data
- The Equation of states (EOS) is in Mechanical.
- I can not find atomic charge, force, or defect formation energy.
- This should be considered when building a new database.
#-------------------------------------------------------------

#-------------------------------------------------------------
# The electron density function (with orientation dependence) rho(h) is related with b(h). h=0,1,2,3. i.e., b(0) = b0, etc.
#   rho(h) is related with "Direction vector using rij" * exp{-b(h)*(r/re-1)}
#   The number of direction vectors to be multiplied increases as h increases. (Spherical symmetry at h=0.)
#-------------------------------
# The gamma is related with t(h) and rho(h). h=0,1,2,3. i.e., "t(0) = t0 and rho(0)", "t(1) = t0 and rho(1)", etc.
#   Total background electron density rho = rho(0) * "The formula specified in ibar (using gamma)".
#-------------------------------
# Embedded Function, F(rho) = A*Ec*(rho/rho(0)_ref)*ln(rho/rho(0)_ref)
#   "rho(0)_ref" is the background electron density at the reference structure.
#   I haven't looked at the Lammps code yet, but it probably goes something like this:
#     F(rho) = A*Esub*(rho/rozero)*ln(rho/rozero)
#-------------------------------
# Pair potential, phi_ij(r) = (2/Z1)*[Erose_ij(r) - F_i(rho(r)) - F_j(rho(r))] for 1NN-MEAM
#   Z1 is the number of first neighboring atoms.
#   Erose_ij(r) = (1/2)*{F_i(rho(r)) + F_j(rho(r)) + Z1*phi_ij(r)}
#
# In the case of 2NN-MEAM, the pair potential is calculated taking into account the second nearest neighbor configuration.
# Pair potential, phi_ij(r) = (1/Z1)*[2*Erose_ij(r) - F_i(rho(r)) - F_j(rho(r))] - (Z2/2)*[S_A*phi_i(a*r)+S_B*phi_j(a*r)] for 2NN-MEAM
#   Z2 is the number of second neighboring atoms. a is the ratio between the second and first nearest neighbor distances in the reference structure.
#   Erose_ij(r) = (1/2)*[ F_i(rho(r)) + F_j(rho(r)) + Z1*phi_ij(r) + (Z2/2)*{S_i*phi_i(a*r)+S_j*phi_j(a*r)} ]
#   S = fc( (C-Cmin)/(Cmax-Cmin) ): In reality, S is the multiplication of S_ijk (i,j,k are atoms)
#   The fc is smooth cutoff function.
#   For C = Cmin case, fc = 0 -> S = 0 -> 1NN-MEAM (The formula for phi(r) takes into account the first nearest neighbors)
#   For C > Cmax case, fc = 1 -> S = 1. In other words, phi_ij(r) is created by removing overlaps between phi_i(r) and phi_j(r), including the second nearest neighbors, so that Erose holds.
#   For C > Cmin and C < Cmax, As C increase, fc and S increase. In other words, phi_ij(r) is created by gradually removing the overlap between phi_i(r) and phi_j(r), including the second nearest neighbors, so that Erose holds.
#   C is related with (r_ik/r_ij) and (r_jk/r_ij).
#   This screening S_ijk results in the inclusion of three-body terms in the pair potential.
#-------------------------------
# C = [2*(Xik+Xkj)-(Xik-Xkj)^2-1]/[1-(Xik-Xkj)^2]
# Xik = (r_ik/r_ij)^2, Xkj = (r_kj/r_ij)^2
# If r_ij is the second nearest neighbor distance and r_ik = r_kj is the first nearest neighbor distance, then we get:
# FCC: Xik = Xkj = (sqrt(2)/2)^2 -> C = 2*(2/4+2/4)-1 = 1.0
# BCC: Xik = Xkj = (sqrt(3)/2)^2 -> C = 2*(3/4+3/4)-1 = 2.0
# The second nearest-neighbor interactions can be taken into consideration by giving a lower value than 2.0 and 1.0 to Cmin in the case of bcc and fcc metals, respectively. [B.-J. Lee et al., Phys. Rev. B. 62, 8564 (2000).]
# In the original MEAM (1NN-MEAM) Cmax=2.8  and Cmin=2.0 were chosen. These values ensure that for the fcc structure first nearest neighbors are completely unscreened for reasonably large thermal vibration, and the interactions are still first neighbor only even in the bcc structure. [M. I.Baskes, Phys. Rev. B 46, 2727 (1992).]
#-------------------------------
# Therefore, for structures with only first nearest neighbors such as dimer(dim) and ch4, the formula is the same for 2NN as for 1NN. This is the justification for using MEAM92 parameters with dim set to 1NN in 2NN as well. Even for elements with dim set in library.meam, if an alloy with a second nearest neighbor structure is specified as the reference structure, naturally 2NN-MEAM will also set to 2NN.
# It is believed that the dimers in 1NN-MEAM can be used as is in 2NN-MEAM. In papers where parameters have been changed, one possibility is to change the ibar.
# Regarding the dimer(dim) of the MEAM92 series, H, N, and O, papers on 2NN-MEAM have also been reported, so there is little need to reuse the parameters of 1NN-MEAM.
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
# Note: The above mixtures have not been compared with FeTiC or FeTiN. It is important to note that only the mixture below (which is described as the best in the paper) and binary have been examined.
#----------(see NiAlCo.meam, FeTiC.meam, or FeTiN.meam)
Cmin(i-j-k) = [0.5*Cmin(i-j-i)^0.5 + 0.5*Cmin(k-j-k)^0.5]^2 --(j-k -> k-j)--> Cmin(i-k-j) = [0.5*Cmin(i-i-j)^0.5 + 0.5*Cmin(k-k-j)^0.5]^2 --(i-k -> k-i)--> Cmin(k-i-j) = Cmin(j-i-k) = [0.5*Cmin(i-i-j)^0.5 + 0.5*Cmin(k-k-j)^0.5]^2
Cmax(i-j-k) = [0.5*Cmax(i-j-i)^0.5 + 0.5*Cmax(k-j-k)^0.5]^2 --(j-k -> k-j)--> Cmax(i-k-j) = [0.5*Cmax(i-i-j)^0.5 + 0.5*Cmax(k-k-j)^0.5]^2 --(i-k -> k-i)--> Cmax(k-i-j) = Cmax(j-i-k) = [0.5*Cmax(i-i-j)^0.5 + 0.5*Cmax(k-k-j)^0.5]^2
As shown above, first create the equation for C(i-k-j), and then use this equation as a basis to create the others.
For Lammps (MEAM potential file)
Cmin(i,k,j) = [0.5*Cmin(i,i,j)^0.5 + 0.5*Cmin(k,k,j)^0.5]^2
Cmax(i,k,j) = [0.5*Cmax(i,i,j)^0.5 + 0.5*Cmax(k,k,j)^0.5]^2
Cmin(i,j,k) = [0.5*Cmin(i,j,i)^0.5 + 0.5*Cmin(k,j,k)^0.5]^2 = Cmin(j,k,i)
Cmax(i,j,k) = [0.5*Cmax(i,j,i)^0.5 + 0.5*Cmax(k,j,k)^0.5]^2 = Cmin(j,k,i)
#----------
#-------------------------------------------------------------
see https://github.com/by-student-2017/lammps_education_metal_win/blob/master/potentials/meam/Mn-X(X%3DAl%2CCu%2CTi)/ternary_Cmin_Cmax_data.txt
#-------------------------------------------------------------

#-------------------------------------------------------------
If the reference structure is bulk, set rho0=1. If the reference structure is not bulk, adjust rho0. For example, change the value of rho0 to a positive value using dim.

#-------------------------------------------------------------
# M I Baskes and R A Johnson 1994 Modelling Simul. Mater. Sci. Eng. 2 147.: 10.1088/0965-0393/2/1/011
E(r) = -Ec*[1+alpha(r/re-1)]*exp[-alpha(r/re-1)]
alpha^2 = 9*Omega*B/Ec
Here, Ec is cohesive energy, Omega is atomic volume, and B is bulk modulus. HCP and FCC: re^3 = sqrt(2)*Omega.
#-----At r = re
E = -Ec
dE/dr = 0
d(dE/dr)/dr = 9*Omega*B/re^2
#-----EAM form
t1 = t2 = t3 = 0 -> Only b0 is a variable (note that b0 is related to spherical symmetry)
#-----1NN-MEAM (HCP)
Parameter | Experimental input | Eauation
Ec        | sublimation energy | direct
re        | atomic volume      | re^3 = sqrt(2)*Omega
alpha     | bulk modulus       | sqrt(9*Omega*B/Ec)
A         | BCC-HCP energy difference | numerical
b0        | shear elastic constant, Ca | numerical
b1        | internal relaxation for Ca | fixed (Note: b0 = 0)
b2        | shear elastic constants (Cb, Cc) | Equ.24
b3        | shear elastic constant, Ca | numerical
t1        | vacancy fromation energy | Equ.28 and 21
t2        | shear elastic constants (Cb, Cc) | Equ.27
t3        | c/a | numerical
#-------------------------------------------------------------

#-------------------------------------------------------------
#  Here, the plus sign means the effect is significant, the minus sign means the effect is minor, and no sign means no effect.
- BCC case [B.-J. Lee et al., Phys. Rev. B 64, 184102 (2001).]
|                 | A  | b0 | t1 | t2 | t3 | Cmin |
| --------------- | -- | -- | -- | -- | -- | ---- |
| C11 and C12     | +  | +  |    | -  |    |  +   |
| C44             | +  | +  |    | -  |    |  +   |
| Esurf           | +  | -  | +  | -  | -  |  -   |
| EfV             | +  | -  | +  | +  | +  |  +   |
| dE(bcc->fcc)    | +  | +  |    |    | +  |  +   |
| dE(fcc->hcp)    | +  | +  |    |    | +  |  +   |
(EfV is the relaxed vacancy-formation energy)
Step 1. Assume Cmin
Step 2. fit A and b0 for C11 and C44
Step 3. fit Cmin for dE(bcc->fcc) and elastic constants
Step 4. fit t1 and t2 for Esurf and EfV -> Since the elastic constants change with t2, proceed to step 2.
Note: For b1, b2 and b3, it was also intended to keep the same values (all 1.0) as in the 1NN-MEAM.
Note: However, some different values had to be given to b2 for some elements [Nb and V].
Note: By fixing the values of b1, b2, and b3, the adjustable parameters whose values should be actually determined by fitting to physical properties becomes only seven, A, b0, t1, t2, t3, Cmin, and d. 
- FCC case [B.-J. Lee et al., Phys. Rev. B 68, 144112 (2003).]
|                 | A  | b0 | t1 | t2 | t3 | Cmin |
| --------------- | -- | -- | -- | -- | -- | ---- |
| C11 and C12     |    | +  |    |    |    |      |
| C44             |    |    |    | +  |    |      |
| Esurf, EfV, Q   |    |    | +  |    |    |      |
| Esf             |    |    |    |    | +  |      |
| dE(bcc->fcc)    | +  |    |    |    |    |      |
| dE(fcc->hcp)    | +  |    |    |    | +  |      |
| epsilon         |    |    |    |    |    |  +   |
| surf. reconst.  | +  |    |    |    |    |  +   |
(epsilon is the thermal expansion coefficient. "surf. reconst." means "surface reconstruction")
Step 1. Assume Cmin (set about -2.0% of 1NN-MEAM value)
Step 2. fit A for surface reconstruction
Step 3. fit b0 for C11 and C44
Step 4. fit t2 for C44
Step 5. fit t3 for (111) stacking fault energy (Esf)
Step 4. fit t1 for Esurf, EfV and vacancy diffusion (Q) -> proceed to step 1 for epsilon
Note: For b1, b2, and b3, it was also intended to keep the same values (2.2, 6.0, and 2.2, respectively) as in the 1NN MEAM because the effect of those parameters on the physical properties considered here was meager. 
Note: In some cases, different values were given to b1 and b3 in order to better fit surface relaxation, as will be mentioned later again.
Note: By fixing the values of Cmax, b1, b2, and b3, the adjustable parameters whose values should be actually determined by fitting to physical properties become only seven, A, b0, t1, t2, t3, Cmin, and d.
Note:  The plus sign does not mean that the individual properties are affected only by the linked parameter values. For example, the A parameter has an effect on almost all properties. 
- HCP case (Ti and Zr) [Y.-M. Kim et al., Phys. Rev. B 74, 014101 (2006).]
|                 | A  | b0 | b1 | b2 | b3 | t1 | t2 | t3 |
| --------------- | -- | -- | -- | -- | -- | -- | -- | -- |
| C11             | +  | +  | +  |    |    |    |    | +  |
| C12,C66,C44,C33 | +  | +  | +  | +  | +  |    |    | +  |
| C13,Eb,Ep       | +  | +  | +  |    |    | +  | +  | +  |
| EfV             | +  |    | +  |    |    | +  | +  | +  |
| EfI             | +  | +  |    | +  | +  | +  | +  | +  |
| dE(hcp->bcc)    | +  | +  |    |    |    |    |    | +  |
| dE(hcp->fcc)    | +  | +  |    |    |    |    |    | +  |
Note: For the determination of the adjustable parameter values, a similar procedure to the previous ones for bcc and fcc elements was used.
#-------------------------------------------------------------
Fe-H: [7] B.-J. Lee and J.-W. Jang, A modified embedded-atom method interatomic potential for the FeH system, Acta Materialia, vol. 55, pp. 67796788, Dec. 2007.
The NaCl-type FeH, for which first-principles calculation of lattice parameter and bulk modulus is available, was selected as the reference structure.
#-------------------------------------------------------------

#-------------------------------------------------------------
# 1NN-MEAM
## FCC, BCC, Diamond, Dimer
- beta0: gamma'=(C11-C12)/2
- beta1, beta2, beta3
- t1: vacancy energy
- t2: gamma = C44 or gamma' = (C11-C12)/2
- t3: FCC-HCP different energy (or stacking fault energy)
## HCP
- beta0: Ca = gamma = (C11-C12)/2
- beta1: 0.0
- beta2: B, Cb, Cc
- beta3: 
- t1: vacancy energy
- t2: Cb, Cc
- t3 HCP-FCC different energy (or stacking fault energy)
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
Note: For Ec, re and B
The first derivative of energy with respect to volume represents pressure, and the second derivative represents bulk modulus.
P = -dE/dV   (1st derivative)
B = V*-dP/dV = V*d(dE/dV)/dV   (2nd derivative)
As reported in many papers, re and B from DFT (VASP, QE, etc.) are used. This is because they are not bad compared to the experimental values. On the other hand, Ec is quite different from the experimental value even in DFT. 
Considering that B is close to the experimental value, it is thought that the second and first derivatives of the energy are predicted quite accurately.

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
  ("VNbTaTiZr_HEA_Nitol2024" is published by NIST [1].)
- RhPt (Luyten 2007) -> PtPdRh (Luyten 2009)
- Li (Cui 2012) -> LiMo (Vella 2017)
- Li (Cui 2012) -> LiSi (Godet 2020)
- Al-X(X=Zr,Cu,Cr,Ti)_AlZrTi (J.-R. Castillo-Sanchez 2022)-> Al-X(X=Li,Zr,Zn) (Rincent 2023)
- Ni-Zr (Cherne 2003) -> Ni-Zr (Cherne LA-UR-03-0368)
#-------------------------------------------------------------
NbMoTaWV_HEA (Ju 2022)
AlMoNbTaTiZr_HEA (Ju 2022)
PtPdRhCo_HEA (Ju 2023)
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
# Si-X (X=Li, Mg, Mo, Cr, Mn, Fe, Co, Cu, Zn, Al, C, Ge, O, He)
LiSi, AlSiMgCuFe_AA6061, AlSiMgCuZn_AA7075, MoSi, FeCrSi, CFeMnSi, FeCoCrMnSi_HEA, SiAl, SiC, SiGe, SiO, SiHe, X-Y(FeMnSiCAlZnO)
Note: AlSiMgCuZn_AA7075, MoSi, X-Y(FeMnSiCAlZnO), SiGe, SiHe: I'm not sure if I can reproduce the paper.
#-------------------------------------------------------------

#-------------------------------------------------------------
# How to create potentials for High Entropy Alloys (HEA), Fe-based, Ni-based, and Al-based, etc
1. The unit system uses Pure_Elements.
2. The Materials Project provides Ec, re, and B for the alloy, so alpha can be calculated. The elastic constants are also given, so Cmin and Cmax can be optimized. ("meam_converter.xlsx" allows you to calculate alpha.)
3. The Cmin and Cmax of X-Y-Z can be estimated using a binary system.
4. If you want to treat the surface more accurately than the bulk, such as surface energy, you can fit more detailed parameters (e.g. Cmin and Cmax).
Note: Due to a reason known as the Hume-Rothery law, multidimensional systems other than the HEA are quite difficult to exist in, except at dilute states, so much insight would be gained from preparing binary systems that fit the Materials Project data, and even ternary systems that can be inferred from the binary systems.
#-------------------------------------------------------------
# parameter fitting
- MPC (https://matsci.org/t/fitting-tool-for-meam-parameters/26254)
Intended as a teaching tool, MPC is designed to run on personal computers (Windows 7 64-bit, MacOS X Yosemite) without "MATLAB".
- Atomistic Simulations: https://materialsdata.nist.gov/handle/11256/9
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
Mn-X(X=Al,Cu,Ti)
Zr-X(X=Co,Fe,Ni)
#-------------------------------------------------------------


#-------------------------------------------------------------
BTi: Results obtained with TiB2 were close to those in the literature. Awesome !
#-------------------------------------------------------------
TiV: Results obtained with TiV were close to those in the literature. Awesome !
#-------------------------------------------------------------
NiSn: Results similar to those in the literature were obtained with Ni3Sn. Awesome !
#-------------------------------------------------------------
NiZr: The results are in reasonable agreement with the values ​​in the paper, so there is still some room for further refinement.
#-------------------------------------------------------------
CNi: The results obtained for NiC with the NaCl structure were close to those in the literature.
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
TM-N(TM=Ti,V,Cr,Fe): The convergence conditions were tightened to calculate the elastic modulus of FeN and TiV.
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
NiSi: It could not be considered as literature.
#-------------------------------------------------------------


#-------------------------------------------------------------
# References
[1] NIST, Interatomic Potentials Repository: https://www.ctcms.nist.gov/potentials/
[2] Home of 2NN MEAM Interatomic Potential: https://cmse.postech.ac.kr/home_2nnmeam
[3] lammps/potentials: https://github.com/lammps/lammps/tree/develop/potentials
[4] https://github.com/jushinpon
  https://github.com/jushinpon/PtPdRhCo_HEA
  https://github.com/jushinpon/CoCrFeMnNi-HfNbTaTiZr-DP-HEA
#-------------------------------------------------------------


#-------------------------------------------------------------
Elements desired for MEAM
#-------------------------------------------------------------
Mg: Al, Zn, Zr, Y, Gd
Mg: (impurity) Fe, Ni, Cu
#-------------------------------------------------------------
Al: Cu, Mg, Si, Zn, Mn, Ti, Cr, Sr
Al: (impurity) Fe, Cu, Si
---
Al: B, Zr
#-------------------------------------------------------------
Ti: Al, V, Mo, Zr, Sn
Ti: (impurity) O, N, H
#-------------------------------------------------------------
V: Ti, Al, Cr, Ni, Mo
V: (impurity) O, N, C
#-------------------------------------------------------------
Fe: Cr, Ni, Mo, Mn, V, Ti, Nb, W, Co
Fe: (impurity) S, O, P
---
Fe: B, Be, Si
#-------------------------------------------------------------
Ni: Cr, Mo, Al, Ti, W, Co, Ru
Ni: (impurity) S, O, C
---
Ni: Fe, V, Zr
Ni: Be, Si
#-------------------------------------------------------------
Cu: Zn, Sn, Ni, Al, P
Cu: (impurity) Pb, Fe, Bi
---
Cu: As, Sb, Bi, Pb, Ni
Cu: O, Fe, Sn
#-------------------------------------------------------------
