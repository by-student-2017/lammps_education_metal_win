#----------------------------------------------------------------------
# Installation
# sudo apt install -y python-scipy
#----------------------------------------------------------------------
from scipy import optimize
#-----------------------------------------------
import numpy as np
import subprocess
import sys
import os
#----------------------------------------------------------------------
import json
json_path = 'library.json'
with open("library.json", "r") as file:
    meam_para = json.load(file)
#----------------------------------------------------------------------
# Usage
# python3 Nelder-Mead_fit.py
#----------------------------------------------------------------------
element = 'Xelement'
#-----
# User setting area -1/3-
ncpu = XXncpu # Number of parallel processes (calculated using lammps)
#-----
# User setting area -2/3-
Ec = meam_para[element]['esub'] # esub in library.meam
Edft = meam_para[element]['Edft'] # [eV/atom], Reference DFT data ("Final Energy/Atom" of Materials Project) (Edft = 0 case -> dE = 0)
Bexp = 1.0 # B [GPa] (Bulk modulus of library.meam) (Eexp = 0 case -> use assumption)
Bdft = 1.0 # Bv or Bvrh [GPa], Reference DFT data
#-----
dE = -Ec - Edft # -esub(library.meam) - reference_DFT("Final Energy/Atom" of Materials Project)
if dE == -Ec:
  dE = 0.0
if Bexp == 0.0:
    Bexp = Bdft*(1-np.sign(dE)*(dE/Edft)**2)
Brate = Bexp/Bdft
#-----
wspe = 0.075 # weight for stress vs. energy ("weight stress / weight energy" ratio)
#-----
weight_flag = 1 # 1:On, 0:Off
T = 300.0 # Temperature [K]
#-----
with open('evalulation_template.py', 'r') as file:
    code = file.read()
    modified_code = code.replace('Xelement', element)
    modified_code = modified_code.replace('Xncpu', str(ncpu))
    modified_code = modified_code.replace('XdE', str(dE))
    modified_code = modified_code.replace('XBrate', str(Brate))
    modified_code = modified_code.replace('Xwspe', str(wspe))
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
           # BCC, FCC, Diamond, dimer
x0 =  meam_para[element]['asub'] # Asub
x1 =  meam_para[element]['b0'] # b0 > 0.5
x2 =  meam_para[element]['b1'] # b1
x3 =  meam_para[element]['b2'] # b2: 1(BCC), 2 or 4 (FCC)
x4 =  meam_para[element]['b3'] # b3
x5 =  meam_para[element]['t1'] # t1
x6 =  meam_para[element]['t2'] # t2
x7 =  meam_para[element]['t3'] # t3: < 0 (BCC), > 0 (FCC, Diamond)
x8 =  meam_para[element]['Cmin(1,1,1)'] # 0 < Cmin < Cmax
x9 =  meam_para[element]['Cmax(1,1,1)'] # Cmin < Cmax < 2.8
#-----
x = [x0,x1,x2,x3,x4,x5,x6,x7,x8,x9]
#-----
if not os.path.exists("results.txt"):
    os.system("echo \"#| No.|Asub | b0  | b1  | b2  | b3  | t1  | t2  | t3  |Cmin |Cmax | evalulate_value (min value is recommendation) |\" >  results.txt")
    os.system("echo \"#|iter| x0  | x1  | x2  | x3  | x4  | x5  | x6  | x7  | x8  | x9  | evalulate_value (min value is reccomendation) |\" >> results.txt")
#-----
count = 0
#----------------------------------------------------------------------
def f(x):

    #print("------------------------")
    os.system("echo ------------------------")
    global count
    count += 1
    #print(f'Step: {count}')
    os.system("echo Step:"+str(count))
    #
    x[9] = 2.8 if x[9] < x[8] else x[9]
    x[9] = 2.8 if x[9] > 2.80 else x[9]
    x[8] = 2.0 if x[8] > 2.00 else x[8]
    R2 = 0.005
    sx0  = str("{:.2f}".format(x[0]+R2))
    sx1  = str("{:.2f}".format(x[1]+R2))
    sx2  = str("{:.2f}".format(x[2]+R2))
    sx3  = str("{:.2f}".format(x[3]+R2))
    sx4  = str("{:.2f}".format(x[4]+R2))
    sx5  = str("{:.2f}".format(x[5]+R2))
    sx6  = str("{:.2f}".format(x[6]+R2))
    sx7  = str("{:.2f}".format(x[7]+R2))
    sx8  = str("{:.2f}".format(x[8]+R2))
    sx9  = str("{:.2f}".format(x[9]+R2))
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
    os.system(f"python3 evalulation.py")
    #subprocess.run(['python3', 'evalulation.py'])
    with open('evalulate_value.txt', 'r') as file:
        evalulate_value = float(file.read().strip())
    #
    os.system("echo No."+str(count)
        +": "+sx0 # Asub
        +", "+sx1+", "+sx2+", "+sx3+", "+sx4 # b0, b1, b2, b3
        +", "+sx5+", "+sx6+", "+sx7 # t1, t2, t3
        +", "+sx8+", "+sx9 # Cmin, Cmax
        +", "+str(evalulate_value) # Evaluate values
        +" >> results.txt")
    #
    y = evalulate_value
    return y
#----------------------------------------------------------------------
res = optimize.minimize(f,x,method='Nelder-Mead',options={'adaptive':True})
#res = optimize.minimize(f,x0,method='Nelder-Mead')
#res = optimize.minimize(f,x0,method='TNC')
#res = optimize.minimize(f,x0,method='Powell')
#res = optimize.minimize(f,x0,method='BFGS')
#----------------------------------------------------------------------
os.system("sort -k 12 results.txt > results_sort.txt")
