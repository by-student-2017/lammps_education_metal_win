# A python script is present to post-process the previous data and fit them with
# a Gaussian function. Considering my data, the Gaussian profile is a reasonable
# approximation. Nevertheless, these functions must be appropriate for the results.

import matplotlib.pyplot as plt
import numpy as np
# import math
from scipy.optimize import curve_fit

filename = "CuZr.hist.xrd"
data = np.loadtxt(filename, skiprows=4)
#Read data angles or 2Theta vs Intensity
angles = data[:, 1]
I = data[:, 2]

#Define a Gaussian fitting function
def gauss(x, C, x0, sigma, A):
  return C*np.exp(-(x-x0)**2/(2*sigma**2)) + A
mini = I.min()
maxi =I.max()
amp = maxi-mini
ttheta = angles[I.argmax()]

popt, pcov = curve_fit(gauss, angles, I, p0=[amp,ttheta,1, mini])
#Plot the results
plt.plot(angles, I, label='data')
angles_fin = [i/1000 for i in range(int(angles.min())*1000,int(angles.max())*1000)]

plt.plot(angles_fin, gauss(angles_fin, *popt), label='fit')
