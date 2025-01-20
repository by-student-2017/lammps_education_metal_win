#!/usr/bin/python





filein = open('output','r')
fileout = open('stress.dat','w')


stress1 = []
stress2 = []

sfac1 = 6.0/6.0
sfac2 = 6.0/6.0

smax = 0.0

n = 0
for line in filein:
    inputs = line.split()
    if (len(inputs) == 9):
        if (inputs[0]=="!!!!!!"):
            stress1.append(sfac1*float(inputs[1]))
            stress2.append(sfac2*float(inputs[3]))
            n = n + 1

filein.close()


ntot = n
for n in range(ntot):
    print >> fileout,n,stress1[n]*0.1
    if (stress1[n] > smax):
        smax = stress1[n]
#print >> fileout,'\n'
#for n in range(ntot):
#    print >> fileout,n*0.02,stress2[n]*0.1


fileout.close()


print 0.1*smax




        
        
        
        
    
