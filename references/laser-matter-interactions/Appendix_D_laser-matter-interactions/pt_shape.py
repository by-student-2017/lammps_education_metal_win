# In the python script below, we provide all the necessary ingredients to post
# process data in order to obtain the pure spatial profile (x-y) of pressure (or any
# other local property) behavior by cutting following the z-direction.
import numpy as np
from matplotlib import pyplot as plt
from mpl_toolkits.axes_grid1 import make_axes_locatable

# loading weird data

blockIdx = 0
timeSteps={};
Fname="local_py.out"
data = np.loadtxt(Fname, skiprows=3, max_rows=1)
timeIdx = int(data[0])
nRows = int(data[1])
while True:
  try:
    data=np.loadtxt(Fname, skiprows=3+(nRows+1)*blockIdx , max_rows=1)
    timeIdx = int(data[0])
    data=np.loadtxt(Fname,skiprows=4(nRows+1)*blockIdx,max_rows=nRows)
    timeSteps[timeIdx] = data.copy();
    #timeIdx += 5000;
    blockIdx += 100;
  except:
    print("Finished loading data")
    break;

#iterate over the entirety of loaded data
for timestep in timeSteps.keys():
  print("plotting step", timestep)
  #load the data of the time step
  data = timeSteps[ timestep ];
  dataX = np.array(data[:, 1]) * 0.1
  dataY = np.array(data[:, 2]) * 0.1
  dataZ = np.array(data[:, 3]) * 0.1
  x_unique = np.unique(dataX)
  y_unique = np.unique(dataY)
  z_unique = np.unique(dataZ)
  
  x_unique = x_unique-205
  
  # Extract pressure
  c = data[:,3] / data[:,4]
  #temp = data[:,2]  
  # Create a grid and reshape the value array
  # into a grid, this is only necessary if one uses pcolormesh as plot
  X , Y = np.meshgrid(x_unique, y_unique)
  values = np.reshape(c, (x_unique.shape[0], y_unique.shape[0],z_unique.shape[0]) );
  # cut the 3D cake for a slice to plot
  # We take 3 cells around the center of the domain in z-direction
  PlotDataSlice = values[:,:, z_unique.shape[0]//2-3:z_unique.shape[0]//2+5 ];
  # average to reduce variability
  PlotDataSliceAvg = np.average(PlotDataSlice, axis=2)
  
  minXval = 35
  maxXval = 65
  
  minIdx = np.where(x_unique < minXval)[0][-1]
  maxIdx = np.where(x_unique > maxXval)[0][0]
  #generate a figure
  fig = plt.figure( figsize=(9,9) )
  ax = fig.gca()
  
  print(X[:,minIdx:maxIdx].shape, Y[:,minIdx:maxIdx].shape)
  im = ax.pcolormesh(X[:,minIdx:maxIdx],Y[:,minIdx:maxIdx],
  PlotDataSliceAvg[minIdx:maxIdx,:].transpose(), vmin = -1, vmax = 1,
  shading = "gouraud")#, aspect='equal')#, norm=norm )
  #ax.set_xlim([minXval,maxXval], size='x-large')
  ax.set_xlabel("X (nm)", fontsize=24)
  ax.set_ylabel("Y (nm)", fontsize=24)
  plt.rcParams.update({'font.size':24})
  plt.xticks(fontsize=24)
  plt.yticks(fontsize=24)
  
  ax.set_title("t = " + str(timestep*0.000001) + " ns")
  
  xtick_loc = [-20, 0, 50]
  ytick_loc = [-15, 0, 50]
  # set the colorbar to the right of the plot, make it as high as
  #the vertical axis by introducing a colorbar axis we call cax
  divider=make_axes_locatable(ax)
  
  colorbarAxis = divider.append_axes("right", size="5%", pad=0.05)
  #fig.colorbar(im, cax=colorbarAxis, orientation='vertical',
  #ticks=[0, 1500, 3000]).set_label("£T£ [K]")
  fig.colorbar(im, cax=colorbarAxis, orientation='vertical').set_label("$P$ (GPa)")
  fig.tight_layout()
  #plt.show()
  fig.savefig("P_Timestep_shape"+ str(timestep*0.000001)+".png",dpi=150)
  plt.close()
  