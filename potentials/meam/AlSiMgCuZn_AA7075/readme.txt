#------------------------------------------------------------------------
# J.-W. Hong, CE-Theses_Ph.D. (2021).: https://koasas.kaist.ac.kr/handle/10203/307792
Al(AA7075)(Al,Si,Mg,Cu,Zn): https://koasas.kaist.ac.kr/handle/10203/307792
#------------------------------------------------------------------------
units metal
dimension 3
boundary p p p 
atom_style atomic

# 2NN-MEAM case
pair_style meam
pair_coeff * * library.meam Al Si Mg Cu Zn AlSiMgCuZn.meam Al Si Mg Cu Zn
#------------------------------------------------------------------------
making lammps input file (test: Ubuntu 22.04 LTS or WSL2)
python3 make_input.py

Al-Si-Mg-Cu-Zn: 7075-zn file
Al-Si-Mg-Cu-Fe: 7075 file
#------------------------------------------------------------------------
For windows
1. python3 make_input.py (on WLS2 (ubuntu))
2. goto file
3. copy&paste "run_msmpi.bat"
4. click "run_msmpi.bat"
5. open cfg on Ovito
#------------------------------------------------------------------------
Note
  It will also work if the second potential file you specify is NULL. However, 
if you want to improve accuracy, please remember that it is important to 
use a parameter file that is fitted (optimized) to the system, rather than NULL.
  If you really want to try out the second potential file you specify when 
there are no parameters, it is a good idea to use NULL. It may not be so bad for transition metals.
#------------------------------------------------------------------------
