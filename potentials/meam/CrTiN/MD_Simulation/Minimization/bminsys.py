#!/usr/bin/python
global pxx,pyy,pzz
import math
from subprocess import call

nstep = 40 
xmax =   0.1    # 0.1% max
xstart = 0.00001 # 0.001% start

### READOUTPUT #######################
def readoutput():

    global pxx,pyy,pzz
    ifind = 0
    pxx = 0.0
    pyy = 0.0
    pzz = 0.0
    
    filein = open("output",'r')

    for line in filein:
        inputs = line.split()

        if (ifind==0) and (inputs[0]=="Step"):
            ifind = 1

        elif (ifind==1) and (inputs[0]=="Loop"):
            break

        elif (ifind==1):
            pxx = float(inputs[6])
            pyy = float(inputs[7])
            pzz = float(inputs[8])


    if (pxx==0.0) and (pyy==0.0) and (pzz==0.0):
        print "screwup getting pxx, pyy, and pzz"
        exit(1)
    filein.close()
    
###################################

### STARTS REGULAR CODE
dvalx = 1.0
dvaly = 1.0
dvalz = 1.0
pxx0 = 0.0
pyy0 = 0.0
pzz0 = 0.0

xdold = xmax
ydold = xmax
zdold = xmax

rcdir = "runlammps"
for nnn in range(nstep):
    adir = "in0"
    fileo = open(adir,'w')

    print >> fileo,"variable x_scale equal ",dvalx
    print >> fileo,"variable y_scale equal ",dvaly
    print >> fileo,"variable z_scale equal ",dvalz
    fileo.close()
    
    bdir = "in.meam.0"
    cdir = "in.meam"
    ccdir = ["cat ",adir," ",bdir," > ",cdir]
    cvar = ''.join(ccdir)
    call(cvar,shell=True)
    
    call(rcdir,shell=True)
    
    readoutput()
    
    ccvar = ["output",""]
    ccvar[1] = str(nnn)
    cdir = ''.join(ccvar)
    call(["cp","output",cdir])

    if (nnn==0):  # first step
        xdisp = xstart
        ydisp = xstart
        zdisp = xstart
    else:
        xdisp = xdisp * abs(pxx/(pxx - pxx0))
        ydisp = ydisp * abs(pyy/(pyy - pyy0))
        zdisp = zdisp * abs(pzz/(pzz - pzz0))
        
        if (xdisp > xmax):
            xdisp = xmax
        if (ydisp > xmax):
            ydisp = xmax
        if (zdisp > xmax):
            zdisp = xmax

    if (xdisp > xdold*2):
	xdisp = xdold*2
    if (ydisp > ydold*2):
        ydisp = ydold*2
    if (zdisp > zdold*2):
        zdisp = zdold*2

    xdold = xdisp
    ydold = ydisp
    zdold = zdisp

    dvalx = 1.0 + xdisp * pxx / abs(pxx)
    dvaly = 1.0 + ydisp * pyy / abs(pyy)
    dvalz = 1.0 + zdisp * pzz / abs(pzz)

    

    print "xdisp",nnn,dvalx,xdisp,pxx,pxx0
    print "ydisp",nnn,dvaly,ydisp,pyy,pyy0
    print "zdisp",nnn,dvalz,zdisp,pzz,pzz0
    
    pxx0 = pxx
    pyy0 = pyy
    pzz0 = pzz

    call(["cp","result.data","data.meam"])
    
