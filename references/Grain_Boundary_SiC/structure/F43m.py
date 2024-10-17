# Appendix A
# Code to generate CSL
# Listing A.1. python script to generate Zinc-Blende lattice and rotate to get CSL

# Program Name : F43m.py
# Purpose : Python class used to create ,manipulate, and modify
# spacegroup F-43m of ZincBlende prototype. Ex: Silicon Carbide.
# Author : Stefan Bringuier
# Affiliation : University of Arizona , Department of Materials Science and Engineering .
# Date : 2/05/2013
# Units :
# distance - Angstroms

# library installation
#   python -m pip install numpy
#   python -m pip install scipy
#     (Successfully installed scipy-1.14.1)

# python version
#   python3 -V
#     (Python 3.12.4)

# Usage
#   python3 F43m.py

#Python libraries required
import sys, os
import math as mt
import numpy as np
import scipy as sp
from scipy import spatial
#Python 3D plotting
#from mayavi import mlab

class F43m( ):
  
  #default SiC
  a, b, c = 4.35, 4.35, 4.32
  alpha, beta, gamma = 90.0, 90.0, 90.0
  
  #Convential basis sites. Fractional coordinates
  atcor = np.array([[0.00, 0.00, 0.00], [0.50, 0.00, 0.50], [0.00, 0.50, 0.50],
                    [0.50, 0.50, 0.00], [0.25, 0.25, 0.25], [0.75, 0.75, 0.25],
                    [0.25, 0.75, 0.75], [0.75, 0.25, 0.75]])
  #1-atom1 2-atom2
  at_id = np.array([1, 1, 1, 1, 2, 2, 2, 2])
  
  num_atoms = 8
  
  def container(self, x, y, z):
    """ Form a orthogonal box for lattice.
    Keyword arguments:
    
    x, y, z: lengths of box.
    """
    self.lx = x
    self.ly = y
    self.lz = z
    
  def unit_cell(self):
    abc = np.array( [ [self.a, self.b, self.c ] ] )
    unitcell = self.atcor * abc
    return unitcell
    
  def enlarge(self, e1, e2, e3):
    """ Extend the unit cell by e1*x e2*y e3*z
    variables: nc_array - new atomic cartesian coordinate array
    id_array - cooresponding atomic array
    Input args: e1 - x multiplication factor
                e2 - y " "
                e3 - z " "
    Output args: nc_array, id_array
    To do : optimize for Numpy like operations
    """
    self.lxm = 0.0
    self.lym = 0.0
    self.lzm = 0.0
    
    self.lx = self.a * e1
    self.ly = self.b * e2
    self.lz = self.c * e3
    self.num_atoms = 8
    self.num_atoms *= (e1*e2*e3)
    
    multi = (e1*e2*e3)
    
    nc_array = self.unit_cell( )
    id_array = np.tile(self.at_id, multi)
    
    for i in range(e1):
      for j in range(e2):
        for k in range(e3):
          tmp_array = self.unit_cell( )
          tmp_array[:,0] = tmp_array[:,0] + i * self.a
          tmp_array[:,1] = tmp_array[:,1] + j * self.b
          tmp_array[:,2] = tmp_array[:,2] + k * self.c
          if(i+j+k) !=0 :
            nc_array=np.vstack( (nc_array, tmp_array) )
    
    return nc_array, id_array
    
  def orient(self, rot_ax, rot_ang, verbose=True):
    "Use formulation from Ballufi and Sutton pg."
    angle = rot_ang
    #a = np.array(rot_ax) # old version
    a = np.array(rot_ax, dtype=np.float64)  # Ensure 'a' is float64
    print(a)
    a /= mt.sqrt(np.inner(a, a)) # make unit vector
    #assertabs(sin_angle - sin(acos(cos_angle))) < 1e-6
    if verbose:
      print(" rotation angle: ", mt.degrees(angle), " [degree]")
      print(" rotation axis: ", a)
    omega = np.array( [ [  0.0, -a[2],  a[1] ],
                        [ a[2],   0.0, -a[0] ] ,
                        [-a[1],  a[0],  0.0] ] )
    rm = (np.identity(3) + omega * mt.sin(angle)
       + np.dot(omega, omega) * (1 - mt.cos(angle)) )
    if verbose:
      print(" rotation matrix: ", rm)
    return np.matrix(rm)
  
# defrotate( ):
  def slic(self, lat, ids, plane, up=False):
    x = plane[0] * self.lx
    y = plane[1] * self.ly
    z = plane[2] * self.lz
    
    # take care of 0 , it works but primitive
    a, b, c = 1, 1, 1
    if x == 0 :
      a = 0
      x = 1
    if y == 0 :
      b = 0
      y = 1
    if z == 0 :
      c = 0
      z = 1
    
    index1= []
    
    for i in range(self.num_atoms):
      value = a*lat[i,0]/x + b*lat[i,1]/y + c*lat[i,2]/z
      
      if up == True:
        if value > 1.0:
          index1.append(i)
      else:
        if value < 1.0:
          index1.append(i)
    
    return lat[index1,:], ids[index1]
    
  def combine(self, lat1, lat2, id1, id2):
    lat_t = np.vstack( (latt, latt2) )
    ids_t = np.hstack( (ids, ids2) )
    self.num_atoms = latt.size/3 # 3dim
    
    return lat_t, ids_t
  
# defovrlap( ):
  def viz(self, lat, ids):    mlab.points3d(lat[:,0], lat[:,1], lat[:,2], ids, colormap=" jet ", scale_factor=1.2214)
    mlab.outline(color = (0, 0, 0), extent =[self.lx_m, self.lx, self.ly_m, self.ly, self.lz_m, self.lz] )
    mlab.show( )
  
def dist(lat1, lat2, ids1, ids2, rc=2.1):
  dist_ar = sp.spatial.distance.cdist(lat1, lat2)
  
  index_tmp = np.where(dist_ar < rc)
  index_r = np.where(ids1[ index_tmp[0][:] ] == ids2[ index_tmp[0][:] ] )
  
  return index_r
  
def write_lammps(lat, ids, file ='data.F43m'):
  print('Writing File: %s' %(file))
  out = open(file, 'w')
  out.write('#data file produced by F43m.py \n')
  out.write('\n')
  out.write('%i atoms \n' %(len(lat[:,0])))
  out.write('2 atom types \n')
  out.write('0.0 81.15 xlo xhi \n')
  out.write('0.0 81.15 ylo yhi \n')
  out.write('0.0 81.15 zlo zhi \n')
  out.write('\n')
  out.write('Atoms \n')
  out.write('\n')
  
  for i, j in enumerate(lat):
    out.write('%i %i %f %f %f \n' %(i+1, ids[i], j[0], j[1], j[2]))
  
  out.close()
  
if __name__=="__main__":
  c = F43m()
  latt, ids = c.enlarge(10, 10, 3)
  latt2, ids2 = c.enlarge(10, 10, 3)
  
  ax = [0, 0, 1]
  theta = 36.870 #/2.0 # Sigma 5
  # theta (degree) -> Convert units from degree to radian. on mt.radians.
  #Need CSL matrix for a given Sigma and axis
  # See Baluffi A.P. Sutton, R.W. Balluffi,
  # Interfaces in Crystalline Materials, OUP Oxford, 2006.
  #
  #Sigma 5
  CSL = np.matrix([[ 0, -2, 1],
                   [ 0,  1, 2],
                   [-1,  0, 0]])
  #
  #Sigma 13
  #CSL = np.matrix([[ 0, -3, 2],
  #                 [ 0,  2, 3],
  #                 [-1,  0, 0]])
  #
  #Sigam 25
  #CSL = np.matrix([[ 0, -4, 3],
  #                 [ 0,  3, 4],
  #                 [-1,  0, 0]])
  #
  #Sigma 365
  #CSL = np.matrix([[ 0, -14, 13],
  #                 [ 0,  13, 14],
  #                 [-1,   0,  0]])
  
  #Get rotation CSL rotation matrix
  min_dim = []
  pbc = CSL.transpose().astype(float)
  rotation = np.zeros((3, 3))
  for i in range(3):
    length = np.sqrt(np.inner(pbc[i], pbc[i]))
    rotation[i] = pbc[i]/length
    min_dim.append(length)
  invrot = rotation.transpose()
  
  #Get grain rotation matrix
  theta1 = mt.radians(-1.0*theta)
  om1 = c.orient(ax, theta1)
  theta2 = mt.radians(theta)
  om2= c.orient(ax, theta2)
  rm1 = np.dot(np.linalg.inv(om1), invrot)
  rm2 = invrot
  
  #Rotate atoms
  # for i in xrange(c.num_atoms): # NameError: name 'xrange' is not defined. Did you mean: 'range'?
  for i in range(c.num_atoms):
    latt[i,:] = np.dot(latt[i,:], rm1) #multiply each atom by transform matrix
    latt2[i,:] = np.dot(latt2[i,:], rm2)
  
  # 5/13/2013 - do post-processing with OVITO or VMD, along with LAMMPS
  #Make sure to use box dimensions commensurate with CSL .
  #latt, ids = c.slic(latt, ids, (0 , 1, -1), up=True )
  #latt2, ids2 = c.slic(latt2, ids2, (0, 1, 1) )
  
  #translate ?
  #remove overlapping atoms
  #indexr = dist(latt, latt2, ids, ids2, rc=2.01)
  #latt = np.delete(latt, indexr[0][:], 0)
  #ids = np.delete(ids, indexr[0][:], 0)
  latt_n, idst = c.combine(latt, latt2, ids, ids2)
  
  #Rotate entire lattice so GB is nice
  #theta2= c.orient(ax, mt.radians(45.0) )
  #for i in range(c.num_atoms):
  # latt_n[i,:] = latt_n[i,:]*theta2
  
  #set bounds
  c.lx_m, c.lx = np.min(latt_n[:,0]), np.max(latt_n[:,0])
  c.ly_m, c.ly = np.min(latt_n[:,1]), np.max(latt_n[:,1])
  c.lz_m, c.lz = np.min(latt_n[:,2]), np.max(latt_n[:,2])
  
  #c.viz(latt_n ,idst)
  write_lammps(latt_n, idst )
  #c.viz(latt, ids)
