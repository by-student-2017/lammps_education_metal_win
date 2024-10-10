# Here is a python script that we have used for post-processing the sketch
# of the PRDF obtained for the liquid structure of both B2-Cu50Zr50 and C11bCu33.3Zr66.7.
import numpy as np
from matplotlib import pyplot as plt
import matplotlib.pyplot as plt
from mpl_toolkits.axes_grid1 import make_axes_locatable
from scipy.interpolate import make_interp_spline
# loading weird data

for fname in ('Zr-Zr.dat', 'Cu-Zr.dat', 'Cu-Cu.dat'):
  data=np.loadtxt(fname)
  r=data[:,1]
  gr=data[:,2]
  r = np.array(r)
  gr = np.array(gr)
  rmin = 0
  rmax = 8
  rnew = np.linspace(r.min(), r.max(), 300)
  gfg = make_interp_spline(r, gr, k=3)
  gr_new = gfg(rnew)
  plt.xlim(rmin, rmax)
  plt.xlabel('r ($\AA$)', fontsize=32)
  plt.ylabel('g(r)', fontsize=32)
  plt.xticks(fontsize = 36)
  plt.yticks(fontsize = 36)
  legend = fname.split('.')[0]
  legend = legend.split('_')
  legend = '.'.join(legend)
  plt.plot(rnew, gr_new, label = legend , linewidth=5)
  plt.legend(loc=(0.75, 0.75), fontsize=25)
plt.show()