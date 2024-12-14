#-----------------------------------------------------------
# Single crystal
pair_style meam
pair_coeff * * library.meam Fe Fe.meam Fe
#-----------------------------------------------------------
# When there is no combination that can be found. 
# If you can find a match even qualitatively or semi-quantitatively, you're lucky.
# To improve accuracy, it is necessary to optimize lattice, Ec, re, alpha, Cmin, and Cmax using DFT or other methods.
# Mixture rules may be used for Cmin and Cmax.
pair_style meam
pair_coeff * * library.meam Pt H NULL Pt H
#-----------------------------------------------------------
- This simple model was found to explain the elastic behavior and simple defect properties of these diverse materials. 
- In this comprehensive study, bulk structures and surface properties were calculated and compared to experiments and higher-level calculations. The surface properties are in fair agreement with experiments, but the energies of bcc metals in open structure do not match the LDA calculations.
- In contrast to previous methods, it was found to be sufficient to consider only first neighbors, even for hcp or bcc structures. Energy differences such as fcc (not diamond cubic) stacking defects naturally arise from angular dependence rather than long-range interactions.
- A formalism has been developed to apply the MEAM to alloy systems and has been applied to the calculation of dilute heats of solution. These calculations make many severe approximations, and their use is not recommended until the alloy potential has been fully optimized. More work is needed in this area.
#-----------------------------------------------------------
