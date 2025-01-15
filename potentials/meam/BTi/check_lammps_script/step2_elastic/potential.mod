# NOTE: This script can be modified for different pair styles 
# See in.elastic for more info.

# Choose potential
#-----------------------
#pair_style	sw
#pair_coeff * * Si.sw Si
#-----------------------
#pair_style morse	2.83994742	# D0[eV] a[1/A] r0[A] rc[A], 1NN for BCC
#pair_coeff 1 1	2.1173	1.0202	2.4595	2.6497	#	Fe-Fe
#-----------------------
#pair_style smatb # R0(A)   p       q     A(eV)   xi(eV)  Rcs(A)   Rc(A), 4NN: Rcs=4NN, Rc=(4NN+5NN)/2
#pair_coeff 1 1	2.4802	7.0149	2.3779	0.3144	3.0551	4.033	4.176	#	Co	Co
#-----------------------
#pair_style eam/alloy
#pair_coeff * * AlCrFeCoNi_Zhou04.eam.alloy Fe
#-----------------------
pair_style meam
pair_coeff * * ./../../library.meam B Ti ./../../BTi.meam B Ti
#-----------------------

# Setup neighbor style
neighbor 1.0 nsq
neigh_modify once no every 1 delay 0 check yes

# Setup minimization style
min_style	     cg
min_modify	     dmax ${dmax} line quadratic

# Setup output
thermo		1
thermo_style custom step temp pe press pxx pyy pzz pxy pxz pyz lx ly lz vol
thermo_modify norm no
