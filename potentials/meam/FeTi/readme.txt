#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam Fe Ti FeTi.meam Fe Ti
#------------------------------------------------------------------------
# I. Sa et al., Scripta Materialia, 59(6), 595-598.: https://doi.org/10.1016/j.scriptamat.2008.05.007
# 2008--Sa-I-Lee-B--Fe-Ti (NIST, Interatomic Potentials Repository)
#------------------------------------------------------------------------

#------------------------------------------------------------------------
FeTi B2 (MEAM = the above paper.)
Lattice constant, a  2.98 [Angstrom]
Elastic constants [GPa]
B    189 (Exp.)  189 (MEAM)
C11  325 (Exp.)  274 (MEAM)
C12  121 (Exp.)  147 (MEAM)
C44  069 (Exp.)  169 (MEAM)
#------------------------------------------------------------------------
