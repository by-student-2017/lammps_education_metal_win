#!/usr/bin/python
# version1.1.6
# Script to produce Radial-Distribution-Function,
# Bond-Angle-Distribution, and atomic Lagrangian-Green strain
# Author: Stefan Bringuier
# 09/21/2014 University of Arizona

# Appendix D
# Post-Processing Code
# Listing D.1. ’Python script to calculate RDF, BAD, and atomic strain tensor

# Usage
#   python3 analysis.py
# Or
#   python3 analysis.py -r 3.0 -f dump.Sigma5-tilt37_xz.lmp_T300_Vel0.01.gz -fr 800 -sv 800 -sp "Si C" -n 5 -sc False -gz True -bn 20 -t "tersoff"

from math import degrees, acos, floor, copysign, sqrt
import numpy as np
import argparse as ap
import glob
import sys, os
import gzip


def read_dump(FileName, Nfield, SnapShots, SaveSnap, gzipf, scaled):
  """ read lammps dumpfile with header saved for specified file
  number o f atoms can not change
  format: id type x y z ...
  """
  
  if gzipf == True:
    File = gzip.open(FileName, 'r')
  else:
    File = open(FileName, 'r')
  
  #Get number of atoms then rewind
  garb1 = File.readline()
  garb2 = File.readline()
  garb3 = File.readline()
  numatoms= int(File.readline())
  garb4 = File.readline()
    try:
    testxlo, testxhi, testxy = File.readline().strip('\n').split()
    Flag = 0
  except:
    Flag = 1
  
  File.seek(0)
  
  data = np.ndarray((numatoms, Nfield, SnapShots), dtype= float)
  
  t = 0
  while(t < SnapShots):
    #read header
    h1 = File.readline()
    tmptime = File.readline()
    h2 = File.readline()
    tmpatoms = File.readline()
    h3 = File.readline()
    
    if Flag != 1:
      tmpxlo, tmpxhi, tmpxy = File.readline().strip('\n').split()
      tmpylo, tmpyhi, tmpxz = File.readline().strip('\n').split()
      tmpzlo, tmpzhi, tmpyz = File.readline().strip('\n').split()
    else:
      tmpxlo, tmpxhi = File.readline().strip('\n').split()
      tmpylo, tmpyhi = File.readline().strip('\n').split()
      tmpzlo, tmpzhi = File.readline().strip('\n').split()
      tmpxy, tmpxz, tmpyz = 0.00, 0.00, 0.00
    
    h4 = File.readline()
    
    if t == SaveSnap:
      xlo_bound, xhi_bound, xy = tmpxlo, tmpxhi, tmpxy
      ylo_bound, yhi_bound, xz = tmpylo, tmpyhi, tmpxz
      zlo_bound, zhi_bound, yz = tmpzlo, tmpzhi, tmpyz
    
    for a in range(numatoms):
      #Read string -> strip '\n' char -> splitin to new list
      line = File.readline().strip('\n').split()
      data[a,:,t] = line
    
    t += 1  File.close()
  
  #only use data for SaveSnap
  datasave = data[:,:,SaveSnap]
  
  #Convert data types & LAMMPS Dump bounding box
  xlo_bound, xhi_bound = float(xlo_bound), float(xhi_bound)
  ylo_bound, yhi_bound = float(ylo_bound), float(yhi_bound)
  zlo_bound, zhi_bound = float(zlo_bound), float(zhi_bound)
  xy, xz, yz = float(xy), float(xz), float(yz)
  
  xlo = xlo_bound - min(0.0, xy, xz, xy+xz)
  xhi = xhi_bound - max(0.0, xy, xz, xy+xz)
  ylo = ylo_bound - min(0.0, yz)
  yhi = yhi_bound - max(0.0, yz)
  zlo = zlo_bound
  zhi = zhi_bound
  
  # Shift box to origin 0, 0, 0
  if xlo < 0.00:
    datasave[:,2] += abs(xlo)
  if ylo < 0.00:
    datasave[:,3] += abs(ylo)
  if zlo < 0.00:
    datasave[:,4] += abs(zlo)  
  #Define box lengths and tilts
  lx = xhi - xlo
  ly = yhi - ylo
  lz = zhi - zlo
  
  #lbox = [lx, ly, lz]
  #ltilt = [xy, xz, yz]
  boxarry = np.array([[lx, 0.0, 0.0],
                      [xy,  ly, 0.0],
                      [xz,  yz,  lz]])
  #boxarry = boxarry.T
  print("Simulation Box: ")
  print(boxarry)
  
  #I f s c a l e d c o o r d i n a t e s u n s c al e
  if scaled == True:
    datasave[:,2] *= lx
    datasave[:,3] *= ly
    datasave[:,4] *= lz
  
  return numatoms, boxarry, datasave


def neighborlist(data, types, natoms, boxd, rcut):
  """ Build Neighbor list with O(Nˆ2) and Triclinic PBC
  Status: Working
  This version takes advantage of element-array operations """
  
  print("*************************")
  print("Building Neighbor-List")
  
  #Invert box and scale coordinates
  boxdinv = np.linalg.inv(boxd)
  sdata = np.dot(data, boxdinv)
  
  neighlist = [0]*(natoms) #neighborlist, TODO-Numpy Object arry
  try :
    rij_mat = np.zeros((natoms, natoms, 3), dtype=np.float32) #rij, rik vector array
  except MemoryAlloc :
    print("Not enough memory (RAM)")
    mem = natoms*natoms*3*32*1.25e-10
    print("required: %f Gigabytes" %(mem))
  
  #Build Distance array
  for i in range(natoms):
    
    #PBC - Min Image, origin 0, 0, 0
    si = sdata[i,:] #scale coords
    tmpsij  = sdata - si
    tmpsij -= np.rint(tmpsij)
    tmprij  = np.dot(tmpsij, boxd)
    
    #Distance array
    tmpdij = np.sqrt(np.sum(np.power(tmprij, 2), axis=1))
    #store distances/ and find neighbors
    slic = np.where((tmpdij < rcut) &
                    (tmpdij > 0.0e-8))
    
    neighlist[i] = slic[0]
    rijmat[i, slic[0][:], :] = tmprij[slic[0][:], :]
    
  print("Finished building neighbor list")
  print("*************************")
  return neighlist, rijmat


def rdf(natoms, spos, box, cut):
  binsize = cut/nbins
  distance = np.zeros((nbins, 1))
  distribution = np.zeros((nbins, 1))
  rcutsq = cut**2
  vol = np.linalg.det(box)
  for i in range(natoms):
    for j in range(i+1, natoms):
      sij   = spos[j, :] - spos[i, :]
      sij  -= round(sij)
      rij   = np.dot(box, sij)
      dijsq = np.sum(np.square, axis=1)
      if dijsq <= rcutsq:
        ibin = int(np.sqrt(dij)/binsize) + 1 #place in ith bin
        distribution[ibin] = distribution[ibin] + 1
  
  # Normal ize and c r e a t e pr o per d i s t a n c e s
  factor = 2.0*vol/(4.0*pi*natoms**2*binsize)
  for i in range(nbins):    distance[i] = (i + 0.5)*binsize;
    distribution[i] = factor*distribution[i]/(i*binsize)**2
  
  return distance, distribution


def angle(natoms, types, neighlist, rdist):
  """ TODO - Make more general
  still requires edits for a specific system """
  
  print("Starting Angle Calculation")
  anglelist = []
  for i in range(natoms):
    itype = types[i]
    for jj, j in enumerate(neighlist[i][:- 1]):
      jtype = types[j]
      
      if itype != jtype:
        rij = rdist[i, j, :]
      
      for k in neighlist[i][jj+1:]:
        ktype = types[k]
        
        rij = rdist[i, j, :]
        rik = rdist[i, k, :]
        dotprod = np.dot(rij, rik)
        
        # sqrt(vx*vx + vy*vy + vz*vz)
        magv1 = np.sqrt(np.sum(np.power(rij, 2)))
        magv2 = np.sqrt(np.sum(np.power(rik, 2)))
        magnitude = magv1*magv2
        
        costheta = dotprod / magnitude
        anglelist.append([itype, jtype, ktype, costheta])
  
  #Numpy arry of angle list
  anglearry = np.array(anglelist)
  anglearry[:, 3] = np.rad2deg(np.arccos(anglearry[:, 3]))
  print("*************************")
  return anglearry


def strain(natoms, pos0, neighlist0, rijvec0, pos, boxd):
  """ Calculate the lagragian strain tensor with respect to time 0 simulation cell
  using the approach by Shimizu et al.
  NOTE: This requires that LAMMPS output the atom ids are continous and sorted i.e.
  at time 0 and t the atom ids are in sequence 1, 2, 3 ... """
  
  #using the initial neighbor list get the seperation vector
  #rijvec = np.zeros(rijvec.shape, dtype=np.float32)
  
  boxdinv = np.linalg.inv(boxd)
  spos = np.dot(pos, boxdinv)
  
  eta = np.zeros((natoms, 3, 3))
  for i in range(natoms):
    itype = types[i]
    J0 = np.zeros((3, 3))
    J = np.zeros((3, 3))
    for j in neighlist0[i]:
      jtype = types[j]
      rij0 = rijvec0[i, j, :]
      
      #PBC - Min Image,
      tmpsij  = spos[j] - spos[i]
      tmpsij -= np.rint(tmpsij)
      rij = np.dot(tmpsij, boxd)
      
      #Reshape vectors
      rij = rij.reshape((1, 3))
      rij0 = rij0.reshape((1, 3))
      
      J0 += (rij0.T * rij0)
      J += (rij0.T * rij)
    
    Ji = np.linalg.inv(J0) * J
    
    eta[i, :, :] = Ji.T*Ji - np.identity(3)
  
  eta *= 0.5
  diagterm = np.square(eta[:, 1, 1] - eta[:, 2, 2]) + np.square(eta[:, 0, 0] - eta[:, 2, 2]) + np.square(eta[:, 0, 0] - eta[:, 1, 1])
  diagterm *= 1.0/6.0
  nmises = np.sqrt(np.square(eta[:, 1, 2]) + np.square(eta[:, 0, 2]) + np.square(eta
    [:, 0, 1]) + diagterm)
  return nmises


def orderniti(natoms, types, neighlist, rdist):
  print("**** Only For NiTi ****")
  print(" Order Parameter Calculation ")
  orderp = np.zeros(natoms, dtype=np.float32)
  
  #Characteristic distances between NiTi
  d0B19 = 2.460232 #Angstrom
  d1B19 = 2.646524 #d i t t o
  d0B2 = 2.611067
  d1B2 = 2.611067
  
  # Bruteforce Approach to get distance
  # between i-j of different TYPES and
  # exclude nieghbors who are have a distance of
  # 0.0E-8 (i.e. not within cutoff)
  newdist = [0]*natoms
  for i in range(natoms):
    itype = types[i]
    tmpdij = []
    for j in neighlist[i]:
      jtype = types[j]
      if itype == jtype: continue
      rij = rdist[i, j, :]
      dij = np.sqrt(np.sum(np.square(rij)))
      if dij == 0.0e-8: continue
      tmpdij.append(dij)
    newdist[i] = tmpdij
  del tmpdij #delete temporary list
  
  #Calculate Order parameter
  for i in range(natoms):
    sortdist = np.sort(newdist[i])
    #Order Parameter from D. Mutter
    d0 = 0.00
    d1 = 0.00
    
    #Ensure 8 n e i g h b o r s
    if sortdist.size < 8:
      print("Atom $i does not have 8 neighbors ! Increase cutoff ! " %(i))
      print("Chi parameter will be 0 ! ")
      continue
    
    #Only use f i r s t 8 n e i g h b o r s
    for k in range(8):
      if k < 6:
        d0 += sortdist[k]
      else:
        d1 += sortdist[k]
    
    d0/= 6.00
    d1/= 2.00
    chi = (d0*(d1B2+d1B19) - d1*(d0B2+d0B19)) / (d0B2*(d0B19-d1B19))
    orderp[i] = chi
  
  print("*************************")
  return orderp


def writedata(Elem, Pairsijk, AngleList, BinNum):
  """ pass dictionary and anglelist """
  
  for i in Pairsijk:
    #find where ijk are in angle array
    indx = np.int32(AngleList[:,:3])
    
    #Account for cases where j-k are k-j / 1-2 2-1
    if i[1] != i[2]:
      slic1 = np.where((i[0] == indx[:,0]) &
      (i[1] == indx[:,1]) &
      (i[2] == indx[:,2]))
      slic2 = np.where((i[0] == indx[:,0]) &
      (i[2] == indx[:,1]) &
      (i[1] == indx[:,2]))
      slici = np.hstack((slic1, slic2))
    else:
      slici = np.where((i[0] == indx[:,0]) &
      (i[1] == indx[:,1]) &
      (i[2] == indx[:,2]))
    
    e1 = Elem[i[0]]
    e2 = Elem[i[1]]
    e3 = Elem[i[2]]
    
    name = e1+'-'+e2+'-'+e3
    outdata = AngleList[slici[0], -1]
    histo, bins = np.histogram(outdata, bins=BinNum, range=(0,180)) #Save as histogram
    np.savetxt(name+'angle.dat', np.c[bins[1:], histo],
    header='# Angle(degrees) Intensity')


def write_dump(savestp, box, types, pos, orderp, file='dump.NiTi-order'):
  """ box - LAMMPS forma t box
  lx, 0, 0
  xy, ly, 0
  xz, yz, lz
  """
  
  #Always origin 0, 0, 0
  xlo, ylo, zlo = 0.00, 0.00, 0.00
  xhi, yhi, zhi = box[0, 0], box[1, 1], box[2, 2]
  xy, xz, yz = box [1, 0], box[2, 0], box[2, 1]
  xlo_bound = xlo + min(0.0, xy, xz, xy+xz)
  xhi_bound = xhi + max(0.0, xy, xz, xy+xz)
  ylo_bound = ylo + min(0.0, yz)
  yhi_bound = yhi + max(0.0, yz)
  zlo_bound = zlo
  zhi_bound = zhi
  
  print('*** Only For NiTi ***')
  print(' Writing LAMMPS Dump File: %s with order parameter' %(file +'- '+str(savestp)))
  out = open(file+'-'+str(savestp), 'w')
  out.write(' ITEM: TIMESTEP \n')
  out.write(' %i \n' %(savestp))
  out.write(' ITEM: NUMBER OF ATOMS \n')
  out.write(' %i \n' %(len(pos[:,0])))
  out.write(' ITEM: BOX BOUNDS xy xz yz pp pp pp \n')
  out.write(' %f %f %f \n' %(xlo_bound, xhi_bound, xy))
  out.write(' %f %f %f \n' %(ylo_bound, yhi_bound, xz))
  out.write(' %f %f %f \n' %(zlo_bound, zhi_bound, yz))
  out.write(' ITEM: ATOMS id type x y z op \n')
  for i,j in enumerate(pos):
    out.write('%i %i %f %f %f %f \n' %(i+1, types[i], j[0], j[1], j[2], orderp[i])) 
  out.close()


def permus(numspecies):
  if numspecies == 1:
    pairs = [(1, 1, 1)]
  elif numspecies == 2:
    pairs = [(1, 1, 1),
             (1, 1, 2),
             (1, 2, 2),
             (2, 1, 1),
             (2, 1, 2),
             (2, 2, 2)]
  elif numspecies == 3:
    pairs = [(1, 1, 1),
             (1, 1, 2),
             (1, 1, 3),
             (1, 2, 2),
             (1, 2, 3),
             (1, 3, 3),
             (2, 2, 2),
             (2, 1, 1),
             (2, 1, 2),
             (2, 1, 3),
             (2, 2, 3),
             (2, 3, 3),
             (3, 1, 1),
             (3, 1, 2),
             (3, 1, 3),
             (3, 2, 2),
             (3, 2, 3),
             (3, 3, 3)]
  else:
    pairs = ([])
    print(" No Support ")
  
  return pairs


if __name__ == "__main__":
  #NEVER use lammps atom index  parser = ap.ArgumentParser(description='Perform Bond-Angle analysis to get distribution. Inversion 1.1.4, the calculation of order parameter for NiTi is included.')
  parser.add_argument("-r",  type=float, default=3.0,    help='# Cutoff: use largest value but ensure no 2nd nearest neighbors (default: 3.0)')
  parser.add_argument("-f",  type=str,   default='dump.Sigma5-tilt37_xz.lmp_T300_Vel0.01.gz', help='Filename')
  parser.add_argument("-fr", type=int,   default=800,    help='Number of frames / snapshots / trajectories')
  parser.add_argument("-sv", type=int,   default=800,    help='Frame / snapshot / trajectory to process and save')
  parser.add_argument("-sp", type=str,   default='Si C', help='Species symbol list in order (e.g. Si for type1)')
  parser.add_argument("-n",  type=int,   default=5,      help='Number of columns in dump file (default: n=5)')
  parser.add_argument("-sc", type=bool,  default=False,  help='If scaled units (default: False)')
  parser.add_argument("-gz", type=bool,  default=True,   help='If file is gzipped (default: False)')
  parser.add_argument("-bn", type=int,   default=20,     help='Number of bins for histogram (default: 20)')
  parser.add_argument("-t",  type=str,   default='tersoff', help='pair_style in lammps script (default: tersoff)') # add parser
  # Note: python3 analysis.py -r 3.0 -f dump.Sigma5-tilt37_xz.lmp_T300_Vel0.01.gz -fr 800 -sv 800 -sp "Si C" -n 5 -sc False -gz True -bn 20 -t "tersoff"
  
  args = parser.parse_args()
  
  #set currect working dir
  path=os.getcwd()
  os.chdir(path)
  
  #Inputs
  rcut = args.r
  filename = args.f
  snapshots = args.fr
  save = args.sv
  nfields = args.n
  slic = nfields - 3
  pairtyp = args.t
  
  #Screen
  print("*************************")
  print(" Cutoff: %f" %(rcut))
  print("*************************")
  
  species = args.sp.split(' ')
  elements = {}
  for i,sym in enumerate(species):
    elements[i + 1] = sym
  pairtypes = permus(len(species))
  for i in elements:
    print('Type %i - %s' %(i, elements[i]))
  print("*************************")
  
  #read file, boxm - box matrix
  natoms, boxm, data = read_dump(filename, nfields, snapshots, save, args.gz, args.sc)
  print('Number of Atoms: %i' %(natoms))
  
  #TODO-doesn 't work for multicolumn dump
  #pos = data[:,slic:]
  pos = data[:,2:5] #Assumes id type x y z ...
  
  types = np.int32(data[:,1])
  #build neighbor list
  neighlist, rijvec = neighborlist(pos, types, natoms, boxm, rcut)
  #calculate angles
  angleall = angle(natoms, types, neighlist, rijvec)
  #Write angle fils
  write_data(elements, pairtypes, angleall, args.bn)
  
  # if 'Ni' in elements.values() and 'Ti' in elements.values():
  # order = orderniti(natoms, types, neighlist, rijvec)
  # write_dump(save, boxm, types, pos, order)
  
  #Calculate strain tensor
  eps = 'True'
  if eps == 'True':
    natoms0, boxm0, data0 = read_dump(filename, nfields, snapshots, 0, args.gz, args.sc)
    pos0 = data0[:,2:5] #Assumes id type x y z ...
    neighlist0, rijvec0 = neighborlist(pos0, types, natoms0, boxm0, rcut)
    nij = strain(natoms, pos0, neighlist0, rijvec0, pos, boxm)
    write_dump(save, boxm, types, pos, nij)
  
  print("*************************")
