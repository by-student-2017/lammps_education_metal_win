# A python script is used for post-processing the pressure and temperature in
# order to produce the spatio-temporal color maps.

import numpy as np
import matplotlib.pyplot as plt
from numpy import *

#Spatial limits following x
xmin = 0
xmax = 200

#Saturation values of the property
vmin = -5
vmax = 20

# filename input
fname = "pressure.out"

#Frequency incrementation in the file
timeStepIncrement = 10000 ; # equal to Nfreq chosen in LAMMPS script

#Rescale time axis to ps equal to the timestep in the lammps script)
timeFactor = 0.001 ; # factor to convert time in (ps)

timeSteps={} # list of arrays for each timestep

# read data and skip the 3 first lines
data=np.loadtxt(fname,skiprows = 3,max_rows=1)
nrows = int(data[1]) # number of rows per time block
blockId = 0 # time block number

while True :
  try :
    data=np.loadtxt(fname, skiprows =3+ (nrows+1)*blockId, max_rows=1)
    time = timeStepIncrement * timeFactor * (blockId + 1)
    data=np.loadtxt(fname,skiprows=3(nrows+1)*blockId+1,max_rows=nrows)
    timeSteps[time] = data.copy()
    blockId += 1
    print(str(blockId))
  except :
    print("Finished loading data")
    break ;

# create matrices
X = [] # spatial coordinate
T = [] # time coordinates
V = [] # data values
S = [] # VORONOI

# read the property in the 1 corresponds to column which is for instance
#X or coord1, 3 is the property like density, Temp or pressure
for time in timeSteps.keys() :
  X.append(timeSteps[time][:,1])
  T.append([float(time)]*nrows)  V.append(timeSteps[time][:,3])
  S.append(timeSteps[time][:,4])
#Ignore the zero division since the volume in the vacuum is 0
np.seterr(divide='ignore', invalid='ignore')

# convert angstroms to nm
X = np.array(X)
X = X * 0.1
#Shift the surface position to 0
X = X-201.03

V = np.array(V)
S = np.array(S)

#Define the pressure P= constraint/volume
V = V/S

where_are_NaNs = isnan(V)
V[where_are_NaNs] = 0

fig = plt.figure( figsize=(10,10) )
plt.rcParams.update({'font.size': 24})

#User define sturation values
plt.pcolormesh(T, X, V, shading = "gouraud", cmap='RdBu_r', vmax, vmin)

#Plots only the limits we want
plt.ylim(xmin, xmax)
#Invert the y axix
plt.gca().invert_yaxis()
plt.grid()

#Set legends and label
plt.colorbar().set_label('Pressure (GPa)')
plt.xlabel('Time (ns)')
plt.ylabel('Depth (nm)')
#Output the color maps in a png format

plt.savefig("Pressure_map.png")
