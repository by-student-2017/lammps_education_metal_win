import os
from ase.io import read, write
import subprocess
import gc
import json
import re
import numpy as np

#-----
element = 'Xelement'
ncpu = Xncpu   # the number of cpus
dE = XdE       # -esub(library.meam) - reference_DFT("Final Energy/Atom" of Materials Project)
Brate = XBrate # ratio for Bulk modulus (Bexp/Bdft)

wspe = Xwspe   # weight for stress vs. energy

weight_flag = Xwflag # use weight flag
Ec = XEc       # cohesive energy (2NN-MEAM) or sublimation energy (1NN-MEAM)

T = XT         # Temperature [K]
kb = 8.617333262e-5 # [eV/K]
kbT = kb*T     # [eV]
#-----

file_path = 'in.lmp'

# Directory containing CIF files
cif_directory = 'cif_data'

with open('data.json', 'r') as f:
    fit_data = json.load(f)

#-----
log_file_path = 'log.lammps'
# Function to extract cohesive energy from log.lammps file
def extract_cohesive_energy(log_file_path):
    with open(log_file_path, 'r') as log_file:
        for line in log_file:
            if 'print "' not in line and 'The cohesive energy (eV/atom) =' in line:
                cohesive_energy = line.split('=')[-1].strip()
                return cohesive_energy
    return None
# Function to extract the number of atoms from log.lammps file
def extract_natoms(log_file_path):
    with open(log_file_path, 'r') as log_file:
        for line in log_file:
            if 'print "' not in line and 'The number of atoms =' in line:
                cohesive_energy = line.split('=')[-1].strip()
                return cohesive_energy
    return None
# Function to extract the area from log.lammps file
def extract_area(log_file_path):
    with open(log_file_path, 'r') as log_file:
        for line in log_file:
            if 'print "' not in line and 'The area (Angstoms^2) =' in line:
                cohesive_energy = line.split('=')[-1].strip()
                return cohesive_energy
    return None
#-----


#-----
log_file_path = 'log.lammps'
# Function to extract elastic constants from log.lammps file
def extract_elastic_constants(log_file_path):
    elastic_constants = {}
    try:
        with open(log_file_path, 'r') as log_file:
            for line in log_file:
                if 'print "' not in line: # Exclude lines containing 'print "'
                    match = re.search(r'Elastic Constant (C\d+all) = ([\d.eE+-]+) GPa', line)
                    if match:
                        constant_name = match.group(1)
                        constant_value = float(match.group(2))
                        elastic_constants[constant_name] = constant_value
    except FileNotFoundError:
        print(f'Log file {log_file_path} not found.')
    return elastic_constants
#-----

os.system(f'export OMP_NUM_THREADS=1')
# Loop through each CIF file in the directory
nparameters = 0
evalulate_value = 0.0
for cif_file in os.listdir(cif_directory):
    if cif_file.endswith('.cif'):
        print(f'----------{cif_file}----------')
        # Read the CIF file using ASE
        structure = read(os.path.join(cif_directory, cif_file))
        
        # Write the structure to a LAMMPS data file
        lammps_data_file = os.path.join(cif_directory, cif_file.replace('.cif', '.data'))
        write(lammps_data_file, structure, format='lammps-data')
        
        #Also write the structure to a file named 'data.in'
        data_in_file = os.path.join(cif_directory, 'data.in')
        write(data_in_file, structure, format='lammps-data')
        
        with open(file_path, 'r') as file:
            code = file.read()
        modified_code = code.replace('XXXXXXXXXX', lammps_data_file)
        temp_file_path = 'in_tmp.lmp'
        with open(temp_file_path, 'w') as temp_file:
            temp_file.write(modified_code)
        
        # Print the path of the generated LAMMPS data and input files for confirmation
        #print(f'LAMMPS data file generated: {lammps_data_file}')
        #print(f'LAMMPS input file generated: {temp_file_path}')
        
        energy_data = fit_data[cif_file]['Final Energy/Atom'] + dE # dE = -Ec -Edft -> -Ec = Edft + dE
        if weight_flag == 1:
            weight = np.exp(-(energy_data+Ec)/kbT)
        else:
            weight = 1.0
        print(f'weight: {weight}')
        
        # Run LAMMPS calculation
        #os.system(f'mpirun -np {ncpu} lmp -in in.lmp')
        subprocess.run(['mpirun', '-np', str(ncpu), 'lmp', '-in', temp_file_path], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        
        # Run LAMMPS calculation
        if 'C11' in fit_data[cif_file]:
            print('Elastic Constants Calculation')
            os.chdir('./elastic_calculation')
            #os.system(f'mpirun -np {ncpu} lmp -in in.elastic')
            subprocess.run(['mpirun', '-np', str(ncpu), 'lmp', '-in', 'in.elastic'], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            
            # Extract elastic constants and print them
            elastic_constants = extract_elastic_constants(log_file_path)
            difference_elastic_value = 0.0
            #bulk_modulus = 0.0
            for constant, value in elastic_constants.items():
                #print(f'{constant} = {value} GPa')
                key = constant[:3]
                symmetric_key = key[0] + key[2] + key[1]
                reference_elastic_value = 0.0
                dummy_value = 0.0
                if key in fit_data[cif_file]: # e.g., C12, C13, or C23
                    reference_elastic_value = fit_data[cif_file][key]*Brate
                elif symmetric_key in fit_data[cif_file]: # e.g., C21, C31, or C32
                    reference_elastic_value = fit_data[cif_file][symmetric_key]*Brate
                elif key in ['C22', 'C33'] and 'C11' in fit_data[cif_file]:
                    reference_elastic_value = fit_data[cif_file]['C11']*Brate
                elif key in ['C13'] and 'C12' in fit_data[cif_file]:
                    reference_elastic_value = fit_data[cif_file]['C13']*Brate
                elif key in ['C23'] and 'C13' in fit_data[cif_file]:
                    reference_elastic_value = fit_data[cif_file]['C23']*Brate
                elif key in ['C55', 'C66'] and 'C11' in fit_data[cif_file]:
                    reference_elastic_value = fit_data[cif_file]['C44']*Brate
                else:
                    dummy_value = 5.0
                if key in fit_data[cif_file] and fit_data[cif_file][key] == 0.0:
                    dummy_value = 5.0
                print(f'{key}: {value}(this meam), {reference_elastic_value}(data.json) ([GPa] unit)')
                difference_elastic_value += ((float(value) - reference_elastic_value)/(reference_elastic_value+dummy_value))**2
                #bulk_modulus += reference_elastic_value/9
                nparameters += 1
            #difference_elastic_value / (bulk_modulus**2)
            print(f'elastic diff. value: {difference_elastic_value}')
            evalulate_value += difference_elastic_value * weight * wspe
            os.chdir('./../')
        
        #energy_data = fit_data[cif_file]['Final Energy/Atom'] + dE # dE = -Ec -Edft -> -Ec = Edft + dE
        # 1 J/m^2 = 0.06242 eV/A^2
        if 'Surface Energy' in fit_data[cif_file]:
            print('Surface Energy Calculation')
            surface_energy = fit_data[cif_file]['Surface Energy']*0.06242
            natoms = int(extract_natoms(log_file_path))
            Aslab = float(extract_area(log_file_path))
            energy_data += 2*Aslab*surface_energy/natoms
            print(f'Ref: natoms:{natoms}, Aslab [A^2]:{Aslab}, surf. energy [eV/A^2]: {surface_energy}')
            print(f'Ref: The energy (eV/atom) is {energy_data}')
        elif 'Grain Boundaries Energy' in fit_data[cif_file]:
            print('Grain Boundaries Energy Calculation')
            grain_boundary_energy = fit_data[cif_file]['Grain Boundaries Energy']*0.06242
            natoms = int(extract_natoms(log_file_path))
            Agrain = float(extract_area(log_file_path))
            energy_data += Agrain*grain_boundary_energy/natoms
            print(f'Ref: natoms:{natoms}, Aslab [A^2]:{Agrain}, grain. energy [eV/A^2]: {grain_boundary_energy}')
            print(f'Ref: The energy (eV/atom) is {energy_data}')
        
        # Extract and print the cohesive energy
        cohesive_energy = float(extract_cohesive_energy(log_file_path))
        difference_energy = cohesive_energy - (-energy_data)
        evalulate_value += ((cohesive_energy - (-energy_data))/energy_data)**2 * weight
        print(f'The cohesive energy (eV/atom) is {cohesive_energy}')
        print(f'The difference energy (eV/atom) is {difference_energy}')
        nparameters += 1
        
        os.remove(log_file_path)
        os.remove(temp_file_path)
        gc.collect()
        
print(f'------------------------------')
evalulate_value = (evalulate_value/nparameters) * 100
print(f'The evalulate_vale (%) is {evalulate_value}')
with open('evalulate_value.txt', 'w') as file:
    file.write(str(evalulate_value))
#-----
