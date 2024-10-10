# A python script to plot the pressure pressure evolution in a sample at specific times.

import numpy as np
from matplotlib import pyplot as plt
import matplotlib.pyplot as plt
from mpl_toolkits.axes_grid1 import make_axes_locatable
from scipy.interpolate import make_interp_spline

# loading data

blockIdx = 0
timeSteps={};
Fname="pressure.out"
data = np.loadtxt(Fname, skiprows=3, max_rows=1)
timeIdx = int(data[0])
nRows = int(data[1])
while True:
  try:
    data=np.loadtxt(Fname, skiprows=3+(nRows+1)*blockIdx, max_rows=1)
    timeIdx = int(data[0])
    data=np.loadtxt(Fname,skiprows=4(nRows+1)*blockIdx,max_rows=nRows)
    timeSteps[timeIdx] = data.copy();
    blockIdx += 1;
  except:
    print("Finished loading data")
    break;
fig = plt.figure(figsize=(11,11))
ax = fig.gca()

#Plot the blocks we want
times = [10000, 20000, 40000, 60000, 80000, 100000, 120000, 150000]

for timestep in times:
  print("plotting step", timestep)
  data = timeSteps[timestep];
  X = data[:,1]*0.1 #convert to nm
  X = X-201.03
  P = data[:,3]/data[:,4] # Compute the pressure
  X = np.array(X)
  P = np.array(P)
  Xmin = -100
  Xmax = 200 #Define the saturation values
  Pmin = -5
  Pmax = 25
  plt.xlim(Xmin, Xmax)
  plt.ylim(Pmin,Pmax)
  plt.xlabel('X ($nm$)', fontsize=24)
  plt.ylabel('P (GPa)', fontsize=24)
  plt.xticks(fontsize = 24)
  plt.yticks(fontsize = 24)
  plt.plot(X, P, label = str(timestep/1000) + 'ps', linewidth=3)
  plt.legend(loc=(0.75, 0.4), fontsize=24)
  plt.grid()
  plt.show()
fig.savefig("P_plot.png") #produce the final plot in png format

