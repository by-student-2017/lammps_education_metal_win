#----------------------------------------------------------------------
from scipy import optimize
#-----------------------------------------------
import numpy as np
import subprocess
import sys
import os
#----------------------------------------------------------------------
# sudo apt install -y python-scipy
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
element = 'XX' # dummy
#-----
with open('evalulation_template.py', 'r') as file:
    code = file.read()
    modified_code = code.replace('Xelement', element)
    modified_code = modified_code.replace('Xncpu', str(ncpu))
    modified_code = modified_code.replace('XdE', str(dE))
    modified_code = modified_code.replace('XBrate', str(Brate))
with open('evalulation.py', 'w') as file:
    file.write(modified_code)
#-----
# Note: It is assumed that Ec, re (or alat), and alpha, t2 for the stable structure are calculated from data from the Materials Project.
# Note: FCC: b1=b3, BCC, Diamond, dimer: b1=b2=b3
#-----
# User setting area -3/3-
# Note: First step: Bayesian_fit.py, then next step Nelder-Mead_fit.py
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
#-----
x = [x0,x1,x2,x3,x4,x5,x6,x7,x8,x9]
count = 0
#----------------------------------------------------------------------
def f(x):

    print("------------------------")
    global count
    count += 1
    print(f'Step: {count}')
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
    x[9] = 2.8 if x[9] < x[8] else x[9]
    x[9] = 2.8 if x[9] > 2.80 else x[9]
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
    y = evalulate_value
    return y
#----------------------------------------------------------------------
res = optimize.minimize(f,x,method='Nelder-Mead',options={'adaptive':True})
#res = optimize.minimize(f,x0,method='Nelder-Mead')
#res = optimize.minimize(f,x0,method='TNC')
#res = optimize.minimize(f,x0,method='Powell')
#res = optimize.minimize(f,x0,method='BFGS')