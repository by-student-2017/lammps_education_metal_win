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
# M. I. Baskes, Phys. Rev. B 46 (1992) 2727.: https://doi.org/10.1103/PhysRevB.46.2727
- This simple model was found to explain the elastic behavior and simple defect properties of these diverse materials. 
- The surface properties are in fair agreement with experiments, but the energies of bcc metals in open structure do not match the LDA calculations.
- In contrast to previous methods, it was found to be sufficient to consider only first neighbors, even for hcp or bcc structures. Energy differences such as fcc (not diamond cubic) stacking defects naturally arise from angular dependence rather than long-range interactions. 
- These calculations make many severe approximations, and their use is not recommended until the alloy potential has been fully optimized.
#-----------------------------------------------------------
# D.-D. Wang et al., Surf. Sci. 600 (2006) 2990-2996.: https://doi.org/10.1016/j.susc.2006.05.012
- hcp (c/a < 1.633) metals: Be, Hf, Ru, Ti, Y
#-----------------------------------------------------------
