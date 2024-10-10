import numpy as np
from matplotlib import pyplot as plt
import matplotlib.pyplot as plt
from mpl_toolkits.axes_grid1 import make_axes_locatable
from scipy.interpolate import make_interp_spline
blockIdx = 0
timeSteps={};
Fname="rdf_merge.dat"
data = np.loadtxt(Fname, skiprows=3, max_rows=1)
timeIdx = int(data[0])
nRows = int(data[1])
while True:
  try:
    data=np.loadtxt(Fname,skiprows=3+(nRows+1)*blockIdx, max_rows=1)
    timeIdx = int(data[0])
    data=np.loadtxt(Fname,skiprows=4+(nRows+1)*blockIdx,max_rows=nRows)
    timeSteps[timeIdx] = data.copy();
    blockIdx += 1;
  except:
    print("Finished loading data")
    break;
fig = plt.figure(figsize=(11,11))
ax = fig.gca()
times = [ 0, 5000000, 9000000, 10000000, 12000000, 14000000, 17000000]
for timestep in times:
  print("plotting step", timestep)
  data = timeSteps[timestep];
  r = data[:,1]
  gr = data[:,2]
  r = np.array(r)
  gr = np.array(gr)
  rmin = 1.5
  rmax = 6.4
  grmin = 0.0
  grmax = 5.0
  rnew = np.linspace(r.min(), r.max(), 300)
  gfg = make_interp_spline(r, gr, k=2)
  gr_new = gfg(rnew)
  plt.xlim(rmin, rmax)
  plt.ylim(grmin,grmax)
  plt.xlabel('r ($\AA$)', fontsize=32)
  plt.ylabel('g(r)', fontsize=32)
  plt.xticks(fontsize = 36)
  plt.yticks(fontsize = 36)
  plt.plot(rnew, gr_new ,label = str(timestep/1000000), linewidth=4)
  plt.legend(loc=(0.01, 0.50), fontsize=25)

plt.show()
fig.savefig("final_RDF.png")
