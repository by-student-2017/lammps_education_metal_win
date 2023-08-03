#Python version: 2.7.13; Numpy version: 1.11.3
# Dump the structures of coordF with only GB
# Run “cid.py”, “voronoi_functions.py”, “voronoi_centers_data_file”, and 
“coordF*.dump.gz” files under the same folder
import numpy as np
import voronoi_functions
from scipy.spatial import Voronoi
import time
import gzip
import os.path
float_formatter = lambda x: "%5.2f" % x
np.set_printoptions(threshold=np.nan,precision=3,formatter={'float_kind':float_formatter})

def main():
 # Half of GB wall thickness
 gb_thickness = 4.72
 # Half of simulation box size
 simu_box = 240
 ### CID list create and dump
 coordxyz_001 = np.loadtxt('coordF001.dump.gz', skiprows=9)
 tf_list_c_id = voronoi_functions.get_tf_list("coordF001.dump.gz",coordxyz_001,gb_thickness,simu_box)
 np.savetxt('cid.gz', tf_list_c_id)
 
 ### GB dump
 total_atom, x_size, y_size, z_size, pb_box = voronoi_functions.read_file_header('coordF001.dump.gz')
 coordxyz_reduced = np.delete(coordxyz_001, np.where(tf_list_c_id >= 0), axis=0)
 total_c_atom = np.shape(coordxyz_reduced)[0]
 voronoi_functions.file_dumping(total_c_atom, 'coordF_001_gb.dump.gz', coordxyz_reduced,pb_box)
 del coordxyz_001
 del coordxyz_reduced
 
if __name__ == "__main__":
 main()
 
 # References
 # Python Software Foundation. Python Language Reference, version 2.7. Available at http://www.python.org
 # Jones E, Oliphant E, Peterson P, et al. SciPy: Open Source Scientific Tools for Python, 2001-, http://www.scipy.org/ [Online; accessed 2018-11-24].
 # Travis E, Oliphant. A guide to NumPy, USA: Trelgol Publishing, (2006).
