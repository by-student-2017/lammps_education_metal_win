#-----------------------------------------------------------
1NN MEAM
In the paper by Vella et al. (2015), ibar = 0 is used in the Baskes formula. Since the cooperation of Baskes et al. is clearly stated in the acknowledgements, the parameters here are set to ibar = 0. The other unknown parameters (rc and dr) are also set to rc = 4.0 and dr = 0.1, following the same rule.
#-----------------------------------------------------------
# Single crystal (Application: the elastic behavior, simple defect properties, and the surface properties, except bcc metals in open structure.)
pair_style meam
pair_coeff * * library.meam Fe Fe.meam Fe
#-----------------------------------------------------------
# When there is no combination that can be found. (Application: dilute heats of solution) 
# If you can find a match even qualitatively or semi-quantitatively, you're lucky.
# To improve accuracy, it is necessary to optimize lattice, Ec, re, alpha, Cmin, and Cmax using DFT or other methods.
# Mixture rules may be used for Cmin and Cmax.
pair_style meam
pair_coeff * * library.meam Ni H NULL Ni H
#-----------------------------------------------------------
# M. I. Baskes, Phys. Rev. B 46 (1992) 2727.: https://iopscience.iop.org/article/10.1088/0965-0393/2/1/011
Cu,Ag,Au,Ni,Pd,Pt,Al,Pb,Rh,Ir,Li,Na,K,V,Nb,Ta,Cr,Mo,W,Fe,C,Si,Ge,H,N,O
- This simple model was found to explain the elastic behavior and simple defect properties of these diverse materials. 
- The surface properties are in fair agreement with experiments, but the energies of bcc metals in open structure do not match the LDA calculations.
- In contrast to previous methods, it was found to be sufficient to consider only first neighbors, even for hcp or bcc structures. Energy differences such as fcc (not diamond cubic) stacking defects naturally arise from angular dependence rather than long-range interactions. 
- These calculations make many severe approximations, and their use is not recommended until the alloy potential has been fully optimized.
#-----------------------------------------------------------
# M. I. Baskes et al., Modelling Simul. Mater. Sci. Eng. 2 (1994) 147-163.: https://iopscience.iop.org/article/10.1088/0965-0393/2/1/011
Be,Co,Dy,Er,Gd,Hf,Ho,Mg,Nd,Pr,Re,Ru,Sc,Tb,Tl,Ti,Y,Zr
- For 18 HCP metals, we found that MEAM is able to reproduce the database very well.
- For all metals except Be, the double vacancies are found to be unbound.
- The calculated stacking fault energies and surface energies are found to be in good agreement with experiment.
- The value of t(3) is chosen contingent on the equilibrium c/a agreeing with experiment. A numerical procedure is used to vary both c and a to achieve a global minimum.
- It should be noted that for all HCP metals considered here, c/a (relative lo ideal) < 1. Zn and Cd, for which c/a (relative lo ideal) > 1, are not considered. This is because the combination of equilibrium with experimental c/a (relative lo ideal), agreement with experimental elastic constants, and correct HCP/FCC lattice stability was found not to be obtained with this model. To achieve c/a (relative lo ideal) < 1, t(3) must be less than zero, and vice versa.
- If internal relaxation data become available in the future from first-principles calculations or experiments, we encourage the determination of beta(1) from these data.
#-----------------------------------------------------------
# R. Ravelo et al., Phys. Rev. Lett. 79 (1997) 2482-2485.: https://doi.org/10.1103/PhysRevLett.79.2482
Sn
#-----------------------------------------------------------
# M. I. Baskes, Phys. Rev. B 62 (2000) 15532.: https://doi.org/10.1103/PhysRevB.62.15532
Pu
#-----------------------------------------------------------
# M. I. Baskes et al., Phys. Rev. B 66 (2002) 104107.: https://doi.org/10.1103/PhysRevB.66.104107
Ga
#-----------------------------------------------------------
# D.-D. Wang et al., Surf. Sci. 600 (2006) 2990-2996.: https://doi.org/10.1016/j.susc.2006.05.012
- hcp (c/a < 1.633) metals: Be, Hf, Ru, Ti, Y
#-----------------------------------------------------------
# V. V. Dremov et al., AIP Conf. Proc. 955, 305-308 (2007).: https://doi.org/10.1063/1.2833037
Be, Mg (Modified)
#-----------------------------------------------------------
# A. P. Thompson et al.,  AIP Conf. Proc. 1195, 833-836 (2009).:  https://doi.org/10.1063/1.3295271
Be (Modified)
#-----------------------------------------------------------
