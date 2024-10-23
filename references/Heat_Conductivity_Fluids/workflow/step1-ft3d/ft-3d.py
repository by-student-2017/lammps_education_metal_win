#!/usr/bin/python

from __future__ import print_function 
import numpy as np
import glob,sys
from math import pi
import time

def read_lammpstrj(filedesc):
    # three comment lines
    for i in range(3): comment = filedesc.readline()
    # number of atoms
    natoms = int(filedesc.readline())
    #print(natoms)
    # 1 comment line
    comment = filedesc.readline()
    # assume orthorombic cell
    cell = np.zeros(3,float)
    for i in range(3): 
        [cellmin, cellmax] = filedesc.readline().split()
        #print(cellmin,cellmax)
        cell[i] = float(cellmax) - float(cellmin)
    #print(cell[:])
    # 1 comment line
    comment = filedesc.readline()
    names = np.zeros(natoms,np.dtype('|S6'))
    q = np.zeros((natoms,3),float)
    orderp = np.zeros(natoms,float)
    v = np.zeros((natoms,3),float)

    for i in range(natoms):
        line = filedesc.readline().split();
        names[i] = line[1] # atom type
        q[i] = line[2:5] # wrapped atomic coordinates
        orderp[i] = float(line[5])+float(line[6]) # The 6/7th column is the PE/KE energy of each atom
        v[i] = line[7:10] # atomic velocities
    return [cell, names, q, orderp, v]

def FT_energy(phi, q, kgrid):
    # This is the un-normalized FT for energy fluctations
    ng = len(kgrid)
    ak = np.zeros(ng,dtype=complex)

    for n,k in enumerate(kgrid):
        ak[n] = np.sum(phi[:]*np.exp(-1j*(q[:,0]*k[0]+q[:,1]*k[1]+q[:,2]*k[2])))

    return ak

def FT_density(q, kgrid):
    # This is the un-normalized FT for density fluctuations
    ng = len(kgrid)
    ak = np.zeros(ng,dtype=complex)

    for n,k in enumerate(kgrid):
        ak[n] = np.sum(np.exp(-1j*(q[:,0]*k[0]+q[:,1]*k[1]+q[:,2]*k[2])))

    return ak

def FT_jflux(v, q, kgrid, transgridx,  transgridy):
    # This is the un-normalized FT for translational particle flux
    ng = len(kgrid)
    akx = np.zeros(ng,dtype=complex)
    aky = np.zeros(ng,dtype=complex)

    for n,k in enumerate(kgrid):
        vx = v[:]@transgridx[n]
        vy = v[:]@transgridy[n]
        #print(np.shape(vx))
        akx[n] = np.sum(vx[:]*np.exp(-1j*(q[:,0]*k[0]+q[:,1]*k[1]+q[:,2]*k[2])))
        aky[n] = np.sum(vy[:]*np.exp(-1j*(q[:,0]*k[0]+q[:,1]*k[1]+q[:,2]*k[2])))
    return akx, aky

def main(sprefix="ft3d", straj="df", replica='1', sbins=8):

    # the input file
    print("Reading file:", straj,".lammpstrj")
    traj = open(straj+'.lammpstrj-part-'+str(replica),"r")
    # Outputs
    ofile = open(sprefix+'-energy-real.dat-part-'+str(replica),"ab")
    oifile = open(sprefix+'-energy-imag.dat-part-'+str(replica),"ab")
    odenfile = open(sprefix+'-density-real.dat-part-'+str(replica),"ab")
    oidenfile = open(sprefix+'-density-imag.dat-part-'+str(replica),"ab")
    ojxfile = open(sprefix+'-jx-real.dat-part-'+str(replica),"ab")
    oijxfile = open(sprefix+'-jx-imag.dat-part-'+str(replica),"ab")
    ojyfile = open(sprefix+'-jy-real.dat-part-'+str(replica),"ab")
    oijyfile = open(sprefix+'-jy-imag.dat-part-'+str(replica),"ab")
    # number of k grids
    bins = int(sbins)

    # get total number of bins and initialize the grid
    print("Use number of bins:", bins)

    # the main thing
    nframe = 0
    while True:
        start_time = time.time()
        # read frame
        try:
            [ cell, names, q, phi, v ] = read_lammpstrj(traj)
        except:
            break
        nframe += 1
        print("Frame No:", nframe)

        if (nframe == 1):
            # normalization
            volume = np.prod(cell[:])
            normfactor = 1./volume

            kgrid = np.zeros((bins*bins*bins,3),float)
            transgridx = np.zeros((bins*bins*bins,3),float) # orthogonal to kgrid
            transgridy = np.zeros((bins*bins*bins,3),float) # orthogonal to kgrid
            transgridbase1 = np.array([1, 0, 0]) # the starting vector of making the translational grids
            transgridbase2 = np.array([0, 1, 0])
            # initialize k grid
            [ dkx, dky, dkz ] = [ (2.*pi)/cell[0], (2.*pi)/cell[1], (2.*pi)/cell[2] ]
            n=0
            for i in range(bins):
                for j in range(bins):
                    for k in range(bins):
                        if i+j+k == 0: pass
                        # initialize k grid
                        kgridbase = np.array([i, j, k])
                        kgrid[n,:] = [ dkx*i, dky*j, dkz*k ]
                        # initialize the translational grid that is orthogonal to [i, j, k]
                        if np.linalg.norm(np.cross(transgridbase1[:],kgridbase[:])) > 0.1:
                            transgridx[n,:] = transgridbase1 - kgridbase*np.dot(transgridbase1,kgridbase)
                        else:
                            transgridx[n,:] = transgridbase2 - kgridbase*np.dot(transgridbase2,kgridbase)
                        transgridy[n,:] = np.cross(transgridx[n,:],kgridbase)
                        #print(transgridx[n,:], transgridy[n,:])
                        transgridx[n,:] /= np.linalg.norm(transgridx[n,:])
                        transgridy[n,:] /= np.linalg.norm(transgridy[n,:])
                        n+=1
            np.savetxt('kgrid.dat-part-'+str(replica),kgrid)
            np.savetxt('transkgridx.dat-part-'+str(replica),transgridx)
            np.savetxt('transkgridy.dat-part-'+str(replica),transgridy)
        print("--- %s seconds after read frame ---" % (time.time() - start_time))
        # FT analysis of energy fluctuations
        ak = normfactor*FT_energy(phi, q, kgrid)
        np.savetxt(ofile,ak[None].real, fmt='%4.4e', delimiter=' ',header="Frame No: "+str(nframe))
        np.savetxt(oifile,ak[None].imag, fmt='%4.4e', delimiter=' ',header="Frame No: "+str(nframe))
        print("--- %s seconds after FFT energy ---" % (time.time() - start_time))
        # FT analysis of density fluctuations
        akden = normfactor*FT_density(q, kgrid)
        np.savetxt(odenfile,akden[None].real, fmt='%4.4e', delimiter=' ',header="Frame No: "+str(nframe))
        np.savetxt(oidenfile,akden[None].imag, fmt='%4.4e', delimiter=' ',header="Frame No: "+str(nframe))
        print("--- %s seconds after FFT density ---" % (time.time() - start_time))
        # FT analysis of translational flux fluctuations
        akjx, akjy = FT_jflux(v, q, kgrid, transgridx, transgridy)
        akjx *= normfactor
        akjy *= normfactor
        np.savetxt(ojxfile,akjx[None].real, fmt='%4.4e', delimiter=' ',header="Frame No: "+str(nframe))
        np.savetxt(oijxfile,akjx[None].imag, fmt='%4.4e', delimiter=' ',header="Frame No: "+str(nframe))
        np.savetxt(ojyfile,akjy[None].real, fmt='%4.4e', delimiter=' ',header="Frame No: "+str(nframe))
        np.savetxt(oijyfile,akjy[None].imag, fmt='%4.4e', delimiter=' ',header="Frame No: "+str(nframe))
        print("--- %s seconds after FFT momentum flux ---" % (time.time() - start_time))

    print("A total of data points ", nframe)

    ofile.close()
    odenfile.close()
    sys.exit()


if __name__ == '__main__':
    main(*sys.argv[1:])

# to use: python ./ft-3d.py [inputfile] [nbin]
