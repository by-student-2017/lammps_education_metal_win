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
pair_style smatb # R0(A)   p       q     A(eV)   xi(eV)  Rcs(A)   Rc(A), 5NN: Rcs=5NN, Rc=(5NN+6NN)/2										
pair_coeff 1 1	2.4621	5.2071	1.2252	0.2859	2.7711	4.9	5.3	#	Fe	Fe
#-----------------------
#pair_style eam/alloy
#pair_coeff * * AlCrFeCoNi_Zhou04.eam.alloy Fe
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
