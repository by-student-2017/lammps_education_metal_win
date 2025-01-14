Usage in lammps input
#-------------------------------------------------------------
pair_style meam
pair_coeff * * ./../../library.meam Si Al ./../../SiAl.meam Si Al
#-------------------------------------------------------------

The thermal conductivity results in the literature are calculated using the BCC reference interatomic potential for the interface Si-Al alloy.