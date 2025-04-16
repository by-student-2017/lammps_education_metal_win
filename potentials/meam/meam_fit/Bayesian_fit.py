#----------------------------------------------------------------------
from bayes_opt import BayesianOptimization
#from bayes_opt import UtilityFunction # for ucb
#-----------------------------------------------
# Saving progress
from bayes_opt.logger import JSONLogger
from bayes_opt.event import Events
# Loading progress
from bayes_opt.util import load_logs
#-----------------------------------------------
# Sequential Domain Reduction
from bayes_opt import SequentialDomainReductionTransformer
#-----------------------------------------------
import numpy as np
import subprocess
import sys
import os
import datetime # for results folder
#----------------------------------------------------------------------
# pip3 install bayesian-optimization==1.4.3
element = 'XX' # dummy
ncpu = 8
#-----
with open('evalulation_template.py', 'r') as file:
    code = file.read()
    modified_code = code.replace('Xelement', element)
    modified_code = modified_code.replace('Xncpu', str(ncpu))
with open('evalulation.py', 'w') as file:
    file.write(modified_code)
#-----
# Note: It is assumed that Ec, re (or alat), and alpha, t2 for the stable structure are calculated from data from the Materials Project.
# Note: FCC: b1=b3, BCC, Diamond, dimer: b1=b2=b3
#-----
n_gene = 10 # number of parameters
           # BCC, FCC, Diamond, dimer
x0 =  0.40 # Asub
x1 =  4.00 # b0 > 0.5
x2 =  2.20 # b1
x3 =  2.00 # b2: 1(BCC), 2 or 4 (FCC)
x4 =  2.00 # b3
x5 =  1.70 # t1
x6 = -7.70 # t2
x7 =  6.00 # t3: < 0 (BCC), > 0 (FCC, Diamond)
x8 =  2.00 # 0 < Cmin < Cmax
x9 =  2.80 # Cmin < Cmax < 2.8
pbounds = {
   'x0': (0.1, 1.5), # Asub, Gas: (1.0, 2.5)
   'x1': (0.5, 10), # b0 > 0.5
   'x2': (0, 10), # b1 > 0
   'x3': (0, 10), # b2 > 0
   'x4': (0, 10), # b3 > 0
   'x5': (-10,10), # t1
   'x6': (-15,22), # t2
   'x7': (-10,10), # t3: < 0 (BCC), > 0 (FCC, Diamond)
   'x8': (0.1,2.4), # 0 < Cmin < Cmax
   'x9': (1.4,2.8) # Cmin < Cmax < 2.8
}
#-----
#----------------------------------------------------------------------
def descripter(x0,x1,x2,x3,x4,x5,x6,x7,x8,x9):
    #
    '''
    # parameters
    b2 = 1.0   # FCC: 6.0 or 2.0, BCC: 1.0
    Asub = float(x0)
    Ec = 1.700816 # [eV/atom]
    alpha = 6.999678253
    G1 = 0.06242*14        # C44 [eV/A^3] ( 1 [GPa] = 0.006241509 [eV/A^3])
    G2 = 0.06242*(21-15)/2 # (C11-C12)/2 [eV/A^3] ( 1 [GPa] = 0.006241509 [eV/A^3])
    Z =  8 # FCC:12, BCC:8, DIA:4, DIM:1
    Omega = 87.26346552 # [A^3/atom]
    # 1 J/m^2 = 0.06242 eV/A^2
    #
    # b0 > 0, BCC: ( 0.4, 5.5), FCC:  (3.6, 7.5), Diamond: (0.5, 3.5)
    if b2 == 6.0:
       b02 = (alpha**2-2*Z*G2*Omega/Ec)/Asub
       t2 = ((G1-2*G2)*Z**2*Omega)/(2*Asub*Ec*(b2-2)**2)
    elif b2 == 2.0:
       b02 = (alpha**2-2*Z*G1*Omega/Ec)/Asub
       t2 = ((2*G2-G1)*Z**2*Omega)/(Asub*Ec*(b2-6)**2)
    elif b2 == 1.0:
       b02 = (alpha**2-9*Z*G1*Omega/(8*Ec))/Asub
       t2 = (9*G2*Z**2*Omega)/(256*Asub*Ec)
    else:
       b0 = 0.0
       t2 = 0.10
    if b02 < 0.0:
      b02 = 0.0
    b0 = b02**(1/2)
    '''
    #
    sx9 = 2.8 if sx9 < sx8 else sx9
    R2 = 0.005
    sx0  = str("{:.2f}".format(x0+R2))
    sx1  = str("{:.2f}".format(x1+R2))
    sx2  = str("{:.2f}".format(x2+R2))
    sx3  = str("{:.2f}".format(x3+R2))
    sx4  = str("{:.2f}".format(x4+R2))
    sx5  = str("{:.2f}".format(x5+R2))
    sx6  = str("{:.2f}".format(x6+R2))
    sx7  = str("{:.2f}".format(x7+R2))
    sx8  = str("{:.2f}".format(x8+R2))
    sx9  = str("{:.2f}".format(x9+R2))
    #
    '''
    sb0  = str("{:.2f}".format(b0+R2))
    st2  = str("{:.2f}".format(t2+R2))
    '''
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
    y = 1.0/evalulate_value
    return y
#----------------------------------------------------------------------
# fitting parameters
#-------------------
# Note
#gamma_osc: 0.5-0.7: shrinkage parameter for oscillation. Typically [0.5-0.7]. Default = 0.7
#gamma_pan: panning parameter. Typically 1.0. Default = 1.0
#eta: zoom parameter. Default = 0.9
#minimum_window: Default = 0.0
bounds_transformer = SequentialDomainReductionTransformer(gamma_osc=0.7, gamma_pan=1.0, eta=0.9, minimum_window=0.0)
#-------------------
if os.path.exists("./logs.json"):
  print("# New optimizer is loaded with previously seen points")
  print("If you want to search without using past data, please delete logs.json.")
  new_optimizer = BayesianOptimization(f=descripter, pbounds=pbounds, verbose=2, random_state=7, bounds_transformer=bounds_transformer, allow_duplicate_points=True)
  load_logs(new_optimizer, logs=["./logs.json"]);
  logger = JSONLogger(path="./logs", reset=False) # Results will be saved in ./logs.json
  new_optimizer.subscribe(Events.OPTIMIZATION_STEP, logger)
  new_optimizer.maximize(init_points=5, n_iter=(300*4)) # 300 cycle / 6 h
  new_optimizer.set_gp_params(alpha=1e-3) # The greater the whitenoise, the greater alpha value.
else:
  optimizer = BayesianOptimization(f=descripter, pbounds=pbounds, verbose=2, random_state=1, bounds_transformer=bounds_transformer, allow_duplicate_points=True)
  logger = JSONLogger(path="./logs") # Results will be saved in ./logs.json
  optimizer.subscribe(Events.OPTIMIZATION_STEP, logger)
  optimizer.maximize(init_points=(n_gene*5), n_iter=(400*4)) # 600 cycles / 12 h (Note: It depends on the number of parameters and search range, but usually around 150 times is a good value (in n_gene*5 case). I set it to 600 just in case (from after I got home until the next morning).)
  optimizer.set_gp_params(alpha=1e-3) # The greater the whitenoise, the greater alpha value.
  # Note: Since "bounds_transformer" is used to narrow the search area, 
  #  in order to initially search as wide a range as possible, 
  #  the initial random number search (init_points) is set to the number of parameters * 5 (= n_gene * 5). 
  #  It will take more time, but if you want to be more elaborate, increase the value from 5 to a higher value such as 7 or 9.
  #  Of course, it is also a good idea to expand the initial search range.
#--------------------------------------------------------