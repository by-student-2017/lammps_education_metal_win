variable t equal 500
variable p equal 0
velocity all create $t 4928459
#fix 1 all npt temp $t $t 1 iso $p $p 100

fix 1 all npt temp $t 1.0 10 iso 0.0 0.0 100
fix 2 all temp/rescale 1 $t 1.0 0.01 1.0 

run 100000
unfix 1
unfix 2
