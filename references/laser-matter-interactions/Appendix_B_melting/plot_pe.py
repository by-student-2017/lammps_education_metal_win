# Here is a python script to plot the potential energy versus temperature in
# the B2-Cu50Zr50 crystal alloys during the liquefaction (solid-liquid) phase change process.
import numpy as np
from matplotlib import pyplot as plt
from mpl_toolkits.axes_grid1 import make_axes_locatable

Fname="Tm.dat"
data = np.loadtxt(Fname)
x = data[:,1]
y = data[:,3]/54000

fig = plt.figure(figsize=(9,9))
ax = fig.gca()
plt.plot(x, y)
ax.set_xlabel("T (K)", fontsize=20)
ax.set_ylabel("Potential energy per atom (eV)", fontsize=20)
plt.xticks(fontsize = 20)
plt.yticks(fontsize = 20)
plt.autoscale()
fig.savefig("Tm_B2.png")
plt.show()
