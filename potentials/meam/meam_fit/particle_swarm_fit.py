#----------------------------------------------------------------------
# Installation
# pip3 install pyswarms==1.3.0
#----------------------------------------------------------------------
# Import PySwarms
import pyswarms as ps
#-----------------------------------------------
# Random search case
from pyswarms.utils.search import RandomSearch
#-----------------------------------------------
# Grid search case
#from pyswarms.utils.search import GridSearch
#-----------------------------------------------
import numpy as np
import subprocess
import sys
import os
#----------------------------------------------------------------------
# Usage
# python3 particle swarm_fit.py
#----------------------------------------------------------------------
#-----
# User setting area -1/3-
ncpu = 8 # Number of parallel processes (calculated using lammps)
#-----
# User setting area -2/3-
Ec = 6.740 # esub in library.meam
Edft = -9.2744 # [eV/atom], Reference DFT data ("Final Energy/Atom" of Materials Project) (Edft = 0 case -> dE = 0)
Bexp = 308 # B [GPa] (Bulk modulus of library.meam) (Eexp = 0 case -> use assumption)
Bdft = 308 # Bv or Bvrh [GPa], Reference DFT data
#-----
dE = -Ec - Edft # -esub(library.meam) - reference_DFT("Final Energy/Atom" of Materials Project)
if dE == -Ec:
  dE = 0.0
if Bexp == 0.0:
    Bexp = Bdft*(1-np.sign(dE)*(dE/Edft)**2)
Brate = Bexp/Bdft
#-----
weight_flag = 1 # 1:On, 0:Off
T = 300.0 # Temperature [K]
element = 'XX' # dummy
#-----
with open('evalulation_template.py', 'r') as file:
    code = file.read()
    modified_code = code.replace('Xelement', element)
    modified_code = modified_code.replace('Xncpu', str(ncpu))
    modified_code = modified_code.replace('XdE', str(dE))
    modified_code = modified_code.replace('XBrate', str(Brate))
    modified_code = modified_code.replace('Xwflag', str(weight_flag))
    modified_code = modified_code.replace('XT', str(T))
    modified_code = modified_code.replace('XEc', str(Ec))
with open('evalulation.py', 'w') as file:
    file.write(modified_code)
#-----
# Note: It is assumed that Ec, re (or alat), and alpha, t2 for the stable structure are calculated from data from the Materials Project.
# Note: FCC: b1=b3, BCC, Diamond, dimer: b1=b2=b3
#-----
# User setting area -3/3-
# Note: First step: Bayesian_fit.py, then next step Nelder-Mead_fit.py
n_gene = 10
           # BCC, FCC, Diamond, dimer
x0 =  0.92 # Asub
x1 =  3.34 # b0 > 0.5
x2 =  0.20 # b1
x3 =  3.81 # b2: 1(BCC), 2 or 4 (FCC)
x4 =  3.19 # b3
x5 =  9.92 # t1
x6 =  2.48 # t2
x7 =-10.66 # t3: < 0 (BCC), > 0 (FCC, Diamond)
x8 =  1.06 # 0 < Cmin < Cmax
x9 =  2.80 # Cmin < Cmax < 2.8
pbounds = {
  # min
  ( 0.8, # x0, Asub
    1.0, # x1, b0
    0.0, # x2, b1
    0.0, # x3, b2
    0.0, # x4, b3
    0.0, # x5, t1
    0.0, # x6, t2
  -15.0, # x7, t3
    0.1, # x8, Cmin
    1.0, # x9, Cmax
  ),
  # max
  ( 1.3, # x0, Asub
    8.0, # x1, b0
    8.0, # x2, b1
    8.0, # x3, b2
    8.0, # x4, b3
   10.0, # x5, t1
   20.0, # x6, t2
    0.0, # x7, t3
    2.4, # x8, Cmin
    2.8, # x9, Cmax
  )
  }# boundary
#-----
count = 0
#----------------------------------------------------------------------
def descripter(x0,x1,x2,x3,x4,x5,x6,x7,x8,x9):

    print("------------------------")
    global count
    count += 1
    print(f'Step: {count}')
    #
    nop = len(x0)
    print("n_particles =",nop)
    y = np.zeros(nop)
    #
    for i in range(nop):
        print("------------------------")
        print("now_particles = ",i)
        #
        x9[i] = 2.8 if x9[i] < x8[i]  else x9[i]
        x9[i] = 2.8 if x9[i] > 2.8 else x9[i]
        R2 = 0.005
        sx0  = str("{:.2f}".format(x0[i]+R2))
        sx1  = str("{:.2f}".format(x1[i]+R2))
        sx2  = str("{:.2f}".format(x2[i]+R2))
        sx3  = str("{:.2f}".format(x3[i]+R2))
        sx4  = str("{:.2f}".format(x4[i]+R2))
        sx5  = str("{:.2f}".format(x5[i]+R2))
        sx6  = str("{:.2f}".format(x6[i]+R2))
        sx7  = str("{:.2f}".format(x7[i]+R2))
        sx8  = str("{:.2f}".format(x8[i]+R2))
        sx9  = str("{:.2f}".format(x9[i]+R2))
        #
        # Read the content of library_temp.meam, replace the values, and save it as library.meam
        with open('library_template.meam', 'r') as file:
            content = file.read()
        # Replace the values
        content = content.replace('Xasub', sx0)
        content = content.replace('Xb0', sx1)
        content = content.replace('Xb1', sx2)
        content = content.replace('Xb2', sx3)
        content = content.replace('Xb3', sx4)
        content = content.replace('Xt1', sx5)
        content = content.replace('Xt2', sx6)
        content = content.replace('Xt3', sx7)
        #content = content.replace('Xb0', sb0) # analytical
        #content = content.replace('Xt2', st2) # analytical
        # Write the modified content to library.meam
        with open('library.meam', 'w') as file:
            file.write(content)
        #
        # Read the content of XX_temp.meam, replace the values, and save it as XX.meam
        with open('XX_template.meam', 'r') as file:
            content = file.read()
        # Replace the values
        content = content.replace('XCmin', sx8)
        content = content.replace('XCmax', sx9)
        # Write the modified content to XX.meam
        with open('XX.meam', 'w') as file:
            file.write(content)
        #
        #os.system(f"python3 evalulation.py")
        subprocess.run(['python3', 'evalulation.py'])
        with open('evalulate_value.txt', 'r') as file:
            evalulate_value = float(file.read().strip())
        #
        subprocess.run("echo No."+str(count)+"-"+str(i)
          +": "+sx0+", " # Asub
          +", "+sx1+", "+sx2+", "+sx3+", "+sx4 # b0, b1, b2, b3
          +", "+sx5+", "+sx6+", "+sx7 # t1, t2, t3
          +", "+sx8+", "+sx9 # Cmin, Cmax
          +", "+str(evalulate_value) # Evaluate values
          +" >> results.txt", shell=True)
        #
        y[i] = evalulate_value
    return y
#----------------------------------------------------------------------
# fitting parameters
#-------------------
def descripter_pso(x):
  return descripter(x[:,0], x[:,1], x[:,2], x[:,3], x[:,4], x[:,5], x[:,6], x[:,7], x[:,8], x[:,9])
#-------------------
# Fix random value for test
#np.random.seed(0)
#----------------------------------------------------------------------
random_search="no"
#----------------------------------------------------------------------
Nop=10 # n_particles (= nop)
if random_search=="yes" :
  #-------------------------------
  # Random search case
  print("Random search: ", random_search)
  # Set-up choices for the parameters
  options = { 'c1': (2.5,0.5), 'c2': (0.5,2.5), 'w': (0.4,0.9), 'k': (int(Nop/3-2),int(Nop/3+2)), 'p': 2 }
  # c1=2.5-0.5, c2=0.5-2.5, w=0.4-0.8 # https://doi.org/10.1371/journal.pone.0188746
  #-------------------------------
  # Create a RandomSearch object
  # n_selection_iters is the number of iterations to run the searcher
  # iters is the number of iterations to run the optimizer
  g = RandomSearch(ps.single.LocalBestPSO, n_particles=(Nop),
    dimensions=(n_gene), options=options, objective_func=descripter_pso,bounds=pbounds,
    iters=10, n_selection_iters=100)
  best_score, best_options = g.search()
  #-------------------------------
  # Show optimized values
  print("best score: ", best_score)
  print("c1 = ", best_options['c1'])
  print("c2 = ", best_options['c2'])
  print(" w = ", best_options['w'])
  print(" k = ", best_options['k'])
  print(" p = ", best_options['p'])
  #-------------------------------
else:
  #-------------------------------
  # Initialize swarm
  options = {'c1': 2.0, 'c2': 2.0, 'w':0.8, 'k': int(Nop/3), 'p': 2}
  #--------------------------------------------------------
  # https://pyswarms.readthedocs.io/en/latest/api/pyswarms.discrete.html
  # c1: Cognitive parameter (weight of local)
  # c2: Social parameter (weight of global)
  # w: Inertia parameter (0.0-1.0)
  # k: Number of neighbors to be considered. Must be a positive integer less than n_particles.
  # p: The Minkowski p-norm to use. 1 is the sum-of-absolute values (or L1 distance) while 2 is the Euclidean (or L2) distance.
  #   L1 = LASSO ?, L2 = Ridge (or Gauss)
  #------------------------------------------------------------------
  # c1=2.5-0.5, c2=0.5-2.5, w=0.4-0.8 # https://doi.org/10.1371/journal.pone.0188746
  # c1=0-4,  c2=0-4, w=0-1 # (usually c1=c2=2.0) https://doi.org/10.3390/math10163019
  # c1=2.00, c2=2.0, w=0.8-1.2 # https://doi.org/10.3390/w14132018
  # c1=2.00, c2=2.0, w=1.0 # https://doi.org/10.1016/j.jksuci.2021.12.018
  # c1=2.00, c2=2.0, w=0.9 # https://www.sba.org.br/Proceedings/SBAI/SBAI2017/SBAI17/papers/paper_36.pdf
  # c1=2.00, c2=2.0, w=0.9 # doi:10.4304/jcp.5.8.1160-1168
  # c1=2.00, c2=2.0, w=0.8 # (Np=40,Ndim=10) DOI: 10.2478/cait-2023-0020 , https://intapi.sciendo.com/pdf/10.2478/cait-2023-0020
  # c1=2.00, c2=2.0, w=0.4-0.9 # https://doi.org/10.1063/5.0140105
  # c1=2.00, c2=2.0, w=0.3-0.9 # https://doi.org/10.1155/2017/2090783
  # c1=2.00, c2=2.0, w=0.4-0.6 # https://doi.org/10.1049/cit2.12106
  # c1=2.00, c2=2.0 # https://doi.org/10.1038/s41598-022-09947-7
  # c1=1.85, c2=2.0, w=0.8 # https://arxiv.org/pdf/2011.11944.pdf
  # c1=1.50, c2=2.0, # https://doi.org/10.3390/en13020391
  # c1=c2=1.49618, w=0.7298 # https://doi.org/10.1016/j.scs.2022.103667
  # c1=0.80, c2=0.5, w=0.9=(beta) # https://arxiv.org/pdf/2202.01943.pdf
  # c1=0.50, c2=0.3, w=0.9 # github (pyswarms)
  # c1=0.50, c2=3.0, w=0.2 # https://link.springer.com/chapter/10.1007/978-3-030-78743-1_20
  # c1=0.10= c2=0.1, w=0.8 # https://machinelearningmastery.com/a-gentle-introduction-to-particle-swarm-optimization/
  # c1=c2=0.5+ln(2) w=0.4-0.9 # https://www.sciencedirect.com/science/article/pii/S0925231223005374
  # w=0.4-0.9 # https://doi.org/10.1049/iet-its.2018.5127
  # w=0.3-0.9 # https://doi.org/10.3390/atmos14111696
  #------------------------------------------------------------------
  # The PySwarms hyperparameters is a parameter in the Particle Swarm Optimization (PSO) algorithm that 
  #   is a factor by which the difference between the current velocity and the global best position is multiplied when 
  #   updating the particle velocity1. The larger this value, the more the particle velocity changes and 
  #   the wider the search range. On the other hand, if you set it to a small value,
  #   the search range becomes narrower and you are more likely to fall into a local solution.
  #------------------------------------------------------------------
  
  # Call instance of PSO with bounds argument
  optimizer = ps.single.GlobalBestPSO(n_particles=Nop,
    dimensions=(n_gene),options=options,bounds=pbounds)
  
  # Perform optimization
  cost, pos = optimizer.optimize(objective_func=descripter_pso, iters=600)
  #-------------------------------
  # Obtain the cost history
  optimizer.cost_history
  # Obtain the position history
  optimizer.pos_history
  # Obtain the velocity history
  optimizer.velocity_history
  #-------------------------------
  optimizer.mean_pbest_history
  optimizer.mean_neighbor_history
  #-------------------------------
  # Show optimized values
  print("cost: ", cost)
  # Show optimized coordinaties
  print("position:", pos)
  #-------------------------------
  #----------------------------------------------------------------------
  # Memo: Grid search case
  #options = {"c1": [0.3, 0.5, 0.8], "c2": [0.3, 0.5, 0.8], "w": [0.2, 0.3, 0.5]}
  #g_search = GridSearch(ps.single.GlobalBestPSO, n_particles=30,dimensions=(n_gene),
  #  options=options,objective_func=descripter,iters=200)
  #best_score, best_options = g_search.search()
  #----------------------------------------------------------------------
#----------------------------------------------------------------------
subprocess.run("sort -k 2 results.txt > results_sort.txt", shell=True)