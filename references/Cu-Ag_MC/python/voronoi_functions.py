import numpy as np
from scipy.spatial import Voronoi
import time
import gzip
import os.path
float_formatter = lambda x: "%5.2f" % x
np.set_printoptions(threshold=np.nan,precision=3,formatter={'float_kind':float_formatt
er})
start_time = time.time()
def read_file_header(file_name):
 if os.path.isfile(file_name):
  header_rows = 9
  with gzip.open(file_name) as f:
   for i in range(header_rows):
    exec ('line%d = f.readline()' % i)
  total_atom = int(line3)
  x_min, x_max = float(line5.split()[0]), float(line5.split()[1])
  y_min, y_max = float(line6.split()[0]), float(line6.split()[1])
  z_min, z_max = float(line7.split()[0]), float(line7.split()[1])
  pb_box = np.array([[x_min, x_max], [y_min, y_max], [z_min, z_max]])
  x_size = float(line5.split()[1]) - float(line5.split()[0])
  y_size = float(line6.split()[1]) - float(line6.split()[0])
  z_size = float(line7.split()[1]) - float(line7.split()[0])
  print file_name + ' header read, %d atoms with x = %f A, y = %f A, z = %f A' % (
  total_atom, x_size, y_size, z_size)
 else:
  print file_name + ' not found, skipped header reading.'
 return total_atom, x_size, y_size, z_size, pb_box
 
def voronoi_prep(file_name,x_size,y_size,z_size,simu_box):
 # input file name
 # output rescaled voronoi centers and related coordinates
 vcenters = np.delete(np.loadtxt(file_name),0,axis=1)
 pb_size_0 = simu_box
 vcenters[:,0] = vcenters[:,0]*x_size/(2*pb_size_0)
 vcenters[:,1] = vcenters[:,1]*y_size/(2*pb_size_0)
 vcenters[:,2] = vcenters[:,2]*z_size/(2*pb_size_0)
 vcenters_expand = np.empty((0,3))
 vcenters_expand_mask = np.empty((0,3))
 c_id = np.arange(np.shape(vcenters)[0])
 c_id_expand = np.empty(0)
 for i in range(-1,2):
  for j in range(-1,2):
   for k in range(-1,2):
    temp = vcenters-np.array([[x_size*i,y_size*j,z_size*k]])
    vcenters_expand = np.append(vcenters_expand,temp,axis=0)
    vcenters_expand_mask = np.append(vcenters_expand_mask,vcenters,axis=0)
    c_id_expand = np.append(c_id_expand,c_id)
 return vcenters, vcenters_expand,vcenters_expand_mask,c_id,c_id_expand
 
def voronoi_centers_inbox_index(pb_enlarge_factor,pb_box_in,vor_points):
 # define box for calculating centers
 print 'This simulation use pb-enlarge-factor %f'%pb_enlarge_factor
 pb_box_en = pb_box_in * pb_enlarge_factor
 center_inbox = np.empty(0,dtype=int)
 for ve in range(np.shape(vor_points)[0]):
  if vor_points[ve,0] > pb_box_en[0,0] and vor_points[ve,0] < pb_box_en[0,1] \
  and vor_points[ve,1] > pb_box_en[1,0] and vor_points[ve,1] < pb_box_en[1,1] \
  and vor_points[ve,2] > pb_box_en[2,0] and vor_points[ve,2] < pb_box_en[2,1]:
   center_inbox = np.append(center_inbox, ve)
 return center_inbox
 
def voronoi_nb_index(vor_id,vor_ridge_points):
 # input index of a center
 # output its neighbour list
 nb_index = np.empty(0)
 for rp in vor_ridge_points: 
  if rp[0]==vor_id:
   nb_index = np.append(nb_index, rp[1])
  elif rp[1]==vor_id:
    nb_index = np.append(nb_index, rp[0])
 return nb_index
 
def voronoi_centers_out_box_index(centers_inbox_index,vor_ridge_points):
 # input centers_inbox_index
 # output its surrounding neighbours
 centers_nb_index = np.empty(0)
 for i in centers_inbox_index:
  for j in voronoi_nb_index(i,vor_ridge_points):
   if j in centers_inbox_index:
    pass
   else:
    centers_nb_index = np.append(centers_nb_index,j)
 return np.unique(centers_nb_index)
 
def voronoi_crys_id(index_list,crystallite_id,vcenters_expand_mask,vcenters):
 # input: a list of centers
 # output: its original crystallite number list
 index_list_cid = np.empty(0)
 for i in index_list:
  for j in crystallite_id:
   if np.array_equal(vcenters_expand_mask[i, :], vcenters[j, :]):
    index_list_cid = np.append(index_list_cid, j)
 if np.shape(index_list) != np.shape(index_list_cid):
  print 'ERROR: missing centers in voronoi_crys_id()'
 return index_list_cid
 
def proj_eval(center_id,gb_thickness,total_atom,vor_ridge_points,vor_points,coordxyz):
 # input: a center
 # output: T/F list for the center, T for crystallite atom
 tf_list = np.ones(total_atom)>0
 for i in voronoi_nb_index(center_id,vor_ridge_points):
  vector_proj = vor_points[i,:] - vor_points[center_id,:]
  evaluater = (np.linalg.norm(vector_proj)/2-gb_thickness)*np.linalg.norm(vector_proj)
  tf_list = np.logical_and(tf_list, np.inner(coordxyzvor_points[center_id,:],vector_proj).flatten()<=evaluater)
 return tf_list
 
def crys_regroup(ID,vor_inbox_index,vor_outbox_nb_index,vor_inbox_index_cid,vor_outbox_nb_index_cid):
 # input ID of the crystallite
 # return list of all crystallites
 merged_center_index = np.append(vor_inbox_index, vor_outbox_nb_index)
 merged_center_mask = np.append(vor_inbox_index_cid, vor_outbox_nb_index_cid)
 c_grouped = np.empty(0)
 c_grouped = np.append(c_grouped,merged_center_index[merged_center_mask == ID])
 return c_grouped
 
def get_tf_list(file_name,coordxyz,gb_thickness,simu_box):
 total_atom, x_size, y_size, z_size, pb_box = read_file_header(file_name)
 vcenters, vcenters_expand, vcenters_expand_mask, crystallite_id, crystallite_id_expand = voronoi_prep('voronoi-centers-45grs.txt', x_size, y_size, z_size,simu_box)
 vor = Voronoi(vcenters_expand)
 vor_inbox_index = voronoi_centers_inbox_index(1.5, pb_box, vor.points)
 vor_outbox_nb_index = voronoi_centers_out_box_index(vor_inbox_index, vor.ridge_points) 
 vor_inbox_index_cid = voronoi_crys_id(vor_inbox_index, crystallite_id, vcenters_expand_mask,vcenters)
 vor_outbox_nb_index_cid = voronoi_crys_id(vor_outbox_nb_index, crystallite_id,vcenters_expand_mask, vcenters)
 tf_list_c_id = np.ones(total_atom) * (-1)
 for g_i in range(np.shape(vcenters)[0]):
  tf_list = np.ones(total_atom) < 0
  for g_j in crys_regroup(g_i, vor_inbox_index, vor_outbox_nb_index, vor_inbox_index_cid,vor_outbox_nb_index_cid):
   tf_list = np.logical_or(tf_list,proj_eval(g_j, gb_thickness, total_atom, vor.ridge_points,vor.points, coordxyz))
  tf_list_c_id[np.where(tf_list == True)] = g_i
 return tf_list_c_id
 
def file_dumping(total_c_atom,file_name_in,coordxyz_c,pb_box):
 header = ''
 header_rows = 9
 line0 = 'ITEM: TIMESTEP\n'
 line1 = '0\n'
 line2 = 'ITEM: NUMBER OF ATOMS\n'
 line3 = '%d\n' % total_c_atom
 line4 = 'ITEM: BOX BOUNDS\n'
 line5 = '%6.2f %6.2f\n' % (pb_box[0, 0], pb_box[0, 1])
 line6 = '%6.2f %6.2f\n' % (pb_box[1, 0], pb_box[1, 1])
 line7 = '%6.2f %6.2f\n' % (pb_box[2, 0], pb_box[2, 1])
 line8 = 'ITEM: ATOMS x y z'
 for i in range(header_rows):
  exec ('header += line%d' % i)
 else:
  "Files not found for %s"%file_name_in
 file_name_out = file_name_in[:9] + '_no_gb' + file_name_in[9:]
 np.savetxt(file_name_out, coordxyz_c,header=header.strip(),fmt='%10.2f',comments='')