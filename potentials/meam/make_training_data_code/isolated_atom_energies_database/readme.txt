#---------------------------------------------------------------------
Standard solid-state pseudopotentials (SSSP): DOI 10.24435/materialscloud:f3-ym
Efficiency (version 1.3.0): https://www.materialscloud.org/discover/sssp/table/efficiency
Precision (version 1.3.0): https://www.materialscloud.org/discover/sssp/table/precision

WFC: suggested wave function cutoff in Ry for SSSP efficiency *
(RHO): suggested charge density cutoff in Ry for SSSP efficiency (this is equal to the dual times the wave function cutoff)
*the background color corresponds to the pseudopotential library chosen for SSSP efficiency
#---------------------------------------------------------------------
&CONTROL 
  calculation  = 'scf',
  prefix  = 'Cf',
  outdir  = './work/Cf/',
  pseudo_dir = './efficiency' , 
  etot_conv_thr = 1.0e-4,
  disk_io = 'low',
/
&SYSTEM 
  ibrav=1,
  celldm(1)=12.0,
  nat=1,
  ntyp=1,
  nosym=.true.,
  ecutwfc=60,
  ecutrho=480,
  occupations = 'smearing' , 
  degauss  = 0.02 , 
  smearing = 'gauss', 
  nspin = 2,
  starting_magnetization(1) = 0 ,
/
&ELECTRONS 
  mixing_beta=0.7,
  conv_thr=1.0E-6,
  electron_maxstep = 1000,
  diagonalization = 'rmm-davidson',
/
ATOMIC_SPECIES 
Cf 251.00000 Cf.paw.z_20.ld1.uni-marburg.v0.upf
ATOMIC_POSITIONS alat
Cf 0.0 0.0 0.0
K_POINTS automatic
1 1 1  0 0 0
#---------------------------------------------------------------------
# occupations = 'tetrahedra_opt'
# In tetrahedra_opt, 6x6x6 or more is recommended for calculation of isolated atoms.
In spin, tetrahedra_opt runs, but there seems to be a problem with total magnetization. 
This is probably because the k-point is set to gamma points only. In non-spin, 
the k-point must be set to 6x6x6 for stable convergence.
#---------------------------------------------------------------------
# diagonalization = 'rmm-davidson'
With the above settings, the difference in total energy between 'david' and 'rmm-davidson' is about 1e-5 Ry (13.6058e-4 eV). 
This is about an order of magnitude lower than 1 meV/atom, so it is not considered a problem.
#---------------------------------------------------------------------
