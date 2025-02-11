#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic
#------------------------------------------------------------------------
# 2NN-MEAM
pair_style meam
pair_coeff * * library.meam U Si Xe USiXe.meam U Si Xe
#------------------------------------------------------------------------
The reference structures for Si, U, and Xe are not given in the paper. Since the cited paper is not readily available, the most likely structure for Xe is FCC.

I set the parameters as closely as possible to those in the paper. I haven't tested it yet.
#------------------------------------------------------------------------
