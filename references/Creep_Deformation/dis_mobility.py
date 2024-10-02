# Ubuntu 22.04 LTS or WSL2
# 
# Installation Ovito
#   pip install -U ovito
#   or
#   conda install --strict-channel-priority -c https://conda.ovito.org -c conda-forge ovito=3.10.6
# 
# Help
# ovitos dis_mobility.py -h
#
# Usage
# ovito dis_mobility.py FILENAME

from ovito import *
import numpy as np
import os

assert(version[0] >= 2 and version[1] >= 7)

def get_dislocation_position(frame, input, output):
  x_extent = output.cell.matrix[0,0]
  positions = output.particle_properties.position.marray #.copy()
  
  # Eliminate all periodic images
  positions[(positions[:,0] > x_extent),0] = positions[(positions[:,0] > x_extent),0] - x_extent
  # Edit positions to put dislocation all on same side 
  if frame == 0:
    global core_spread
    core_spread = np.max(positions[:,0]) - np.min(positions[:,0])
    if core_spread > 0.5*x_extent:
      core_spread = None 
  elif core_spread:
    ref = positions[0,0]
    for i,p in enumerate(positions):
      if i == 0:
        continue 
      if (p[0] - ref) > core_spread*1.3:
        p[0] -= x_extent
    ref = np.mean(positions[0:(i+1),0])
  dislocation = np.mean(positions,0)[0]
  timestep = output.attributes['Timestep']
  
  while (pos[frame - 1] - dislocation) > 0.25*x_extent:
    dislocation += x_extent
  with open('posVStime.txt','a+') as f:
    f.write('{}\t{}\n'.format(timestep, dislocation))
  
  time[frame] = timestep
  pos[frame] = dislocation 

def initialize_data(num):
  global time, pos, core_spread
  time = np.zeros(num)
  pos = np.zeros(num)
  core_spread = None
  
  if os.path.exists('posVStime.txt'):
    data = np.loadtxt('posVStime.txt')
    time.put(range(len(data[:,0])),data[:,0])
    pos.put(range(len(data[:,1])),data[:,1])
  
# If run from the command line setup required modifiers
if __name__ == "__main__":
  from sys import argv
  
  if len(argv) < 2:
    raise Exception("Filename required as an argument.")
  
  filename = argv[-1]
  
  # Parse input arguments
  # Default values
  if len(argv) > 2:
    keyargs = argv[1:-1]
    i = 0
    while (i < len(keyargs)):
      key = keyargs[i].split('-')[1]
      i += 1
      if (key is "h") or (key is "help"):
        print("Usage: ovito dis_mobility.py [OPTIONS] [FILENAME]\n\t-h,help\tThis help message\n")
      else:
        raise Exception("Unknown option: " + key)
  
  # ### Setup ovitos ###
  # Import file
  if len([s for s in filename if s == '*']) > 0:
    node = io.import_file(filename) 
  else:
    node = io.import_file(filename, multiple_frames=True)
  
  # Create CNA or PTM modifier
  # if version[1] = 7:
    #structure = modifiers.CommonNeighborAnalysisModifier()
    #elif version[1] > 7:
  structure = modifiers.PolyhedralTemplateMatchingModifier()
  node.modifiers.append(structure)
  node.compute()
  
  # Estimate bulk structure
  nfcc = node.output.attributes['PolyhedralTemplateMatching.counts.FCC']
  nbcc = node.output.attributes['PolyhedralTemplateMatching.counts.BCC']
  nhcp = node.output.attributes['PolyhedralTemplateMatching.counts.HCP']
  struct_ID = np.argmax([nfcc,nhcp,nbcc]) + 1
  
  # Add expression select
  y_extent = node.output.cell.matrix[1,1]
  bulk = modifiers.SelectExpressionModifier(
    expression = 'StructureType == {} || Position.Y < {} || Position.Y > {}'.format(
      struct_ID,
      y_extent/2.0 - 30.0,
      y_extent/2.0 + 30.0))
  node.modifiers.append(bulk)
  
  # Add delete selected
  delete = modifiers.DeleteSelectedParticlesModifier()
  node.modifiers.append(delete)
  
  numframes = node.source.num_frames
  frames = range(numframes)
  
  initialize_data(numframes)
  
  for frame in frames:
    if frame < numframes:
      dataset.anim.current_frame = frame # Advance frame. 
    else:
      continue
  
  node.compute()
  
  get_dislocation_position(frame, node.output, node.output)
  