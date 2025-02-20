import json
import csv
from itertools import combinations
from ase import Atoms
from ase.calculators.espresso import Espresso
from ase.optimize import BFGS
from ase.eos import EquationOfState
import numpy as np
import os

from ase.units import Bohr, Rydberg, kJ, kB, fs, Hartree, mol, kcal

# Set the number of OpenMP/MPI settings
omp_num_threads = 1
mpi_num_procs = 1

# Explicitly set OMP_NUM_THREADS
os.environ['OMP_NUM_THREADS'] = '8'

# Load the pseudopotential data from the JSON file
with open('PBE/PSlibrary_PBE.json', 'r') as f:
    pseudopotentials = json.load(f)

# Define atomic radii for elements (in angstroms)
atomic_radii = {
     "H": 0.53, "He": 1.40, "Li": 1.67, "Be": 1.12,  "B": 0.87,  "C": 0.67,  "N": 0.56,  "O": 0.48,  "F": 0.42, "Ne": 1.54,
    "Na": 1.90, "Mg": 1.45, "Al": 1.18, "Si": 1.11,  "P": 0.98,  "S": 0.88, "Cl": 0.79, "Ar": 1.88,  "K": 2.43, "Ca": 1.94,
    "Sc": 1.84, "Ti": 1.76,  "V": 1.71, "Cr": 1.66, "Mn": 1.61, "Fe": 1.56, "Co": 1.52, "Ni": 1.49, "Cu": 1.45, "Zn": 1.42,
    "Ga": 1.36, "Ge": 1.25, "As": 1.14, "Se": 1.03, "Br": 0.94, "Kr": 2.02, "Rb": 2.65, "Sr": 2.19,  "Y": 2.12, "Zr": 2.06,
    "Nb": 1.98, "Mo": 1.90, "Tc": 1.83, "Ru": 1.78, "Rh": 1.73, "Pd": 1.69, "Ag": 1.65, "Cd": 1.61, "In": 1.56, "Sn": 1.45,
    "Sb": 1.33, "Te": 1.23,  "I": 1.15, "Xe": 2.16, "Cs": 2.98, "Ba": 2.53, "La": 2.26, "Ce": 2.26, "Pr": 2.26, "Nd": 2.26,
    "Pm": 2.26, "Sm": 2.26, "Eu": 2.26, "Gd": 2.26, "Tb": 2.26, "Dy": 2.26, "Ho": 2.26, "Er": 2.26, "Tm": 2.26, "Yb": 2.26,
    "Lu": 2.26, "Hf": 2.08, "Ta": 2.00,  "W": 1.93, "Re": 1.88, "Os": 1.85, "Ir": 1.80, "Pt": 1.77, "Au": 1.74, "Hg": 1.71,
    "Tl": 1.56, "Pb": 1.54, "Bi": 1.43, "Po": 1.35, "At": 1.27, "Rn": 2.20, "Fr": 2.94, "Ra": 2.62, "Ac": 2.00, "Th": 2.06,
    "Pa": 2.00,  "U": 1.96, "Np": 1.90, "Pu": 1.87
}

# Define van der Waals radii for elements (in angstroms)
vdw_radii = {
     "H": 1.20, "He": 1.40, "Li": 1.82, "Be": 1.53,  "B": 1.92,  "C": 1.70,  "N": 1.55,  "O": 1.52,  "F": 1.47, "Ne": 1.54,
    "Na": 2.27, "Mg": 1.73, "Al": 1.84, "Si": 2.10,  "P": 1.80,  "S": 1.80, "Cl": 1.75, "Ar": 1.88,  "K": 2.75, "Ca": 2.31,
    "Sc": 2.11, "Ti": 2.00,  "V": 2.00, "Cr": 2.00, "Mn": 2.00, "Fe": 2.00, "Co": 2.00, "Ni": 1.63, "Cu": 1.40, "Zn": 1.39,
    "Ga": 1.87, "Ge": 2.11, "As": 1.85, "Se": 1.90, "Br": 1.85, "Kr": 2.02, "Rb": 3.03, "Sr": 2.49,  "Y": 2.00, "Zr": 2.00,
    "Nb": 2.00, "Mo": 2.00, "Tc": 2.00, "Ru": 2.00, "Rh": 2.00, "Pd": 1.63, "Ag": 1.72, "Cd": 1.58, "In": 1.93, "Sn": 2.17,
    "Sb": 2.06, "Te": 2.06,  "I": 1.98, "Xe": 2.16, "Cs": 3.43, "Ba": 2.68, "La": 2.00, "Ce": 2.00, "Pr": 2.00, "Nd": 2.00,
    "Pm": 2.00, "Sm": 2.00, "Eu": 2.00, "Gd": 2.00, "Tb": 2.00, "Dy": 2.00, "Ho": 2.00, "Er": 2.00, "Tm": 2.00, "Yb": 2.00,
    "Lu": 2.00, "Hf": 2.00, "Ta": 2.00,  "W": 2.00, "Re": 2.00, "Os": 2.00, "Ir": 2.00, "Pt": 1.75, "Au": 1.66, "Hg": 1.55,
    "Tl": 1.96, "Pb": 2.02, "Bi": 2.07, "Po": 2.00, "At": 2.00, "Rn": 2.20, "Fr": 2.00, "Ra": 2.00, "Ac": 2.00, "Th": 2.00,
    "Pa": 2.00,  "U": 1.96, "Np": 1.90, "Pu": 1.87
}

# Get all combinations of elements
#elements = list(pseudopotentials.keys())
elements = ['Ti', 'Fe']
element_combinations = list(combinations(elements, 2))

# Define a function to calculate properties for a given combination of elements
def calculate_properties(elements_combination, omp_num_threads, mpi_num_procs, max_retries=200):
    element1, element2 = elements_combination
    
    scaling_factor = 0.94
    
    # Use vdW radii for noble gases
    vdw_elements = ["H", "He", "Li", "B", "N", "P", "S", "Ne", "Ar", "Kr", "Xe", "Rn"]
    if element1 in vdw_elements and element2 in vdw_elements:
        radius1 = vdw_radii[element1]
        radius2 = vdw_radii[element2]
    else:
        radius1 = atomic_radii[element1]
        radius2 = atomic_radii[element2]
    
    # Estimate lattice constant using atomic radii
    a = (radius1 + radius2) * (2/3**0.5) * scaling_factor
    
    # Create the FCC B1 (NaCl-type) structure
    atoms = Atoms(f'{element1}{element2}', 
              positions=[(0, 0, 0), (0.5*a, 0.5*a, 0), (0.5*a, 0, 0.5*a), (0, 0.5*a, 0.5*a), 
                         (0.5*a, 0.5*a, 0.5*a), (0, 0.5*a, 0), (0.5*a, 0, 0), (0, 0, 0.5*a)], 
              cell=[a, a, a], 
              pbc=True)
    
    # Set up Quantum Espresso calculator
    pseudopotentials_dict = {
        element1: pseudopotentials[element1]['filename'],
        element2: pseudopotentials[element2]['filename']
    }
    input_data = {
        'control': {
            'calculation': 'scf',
            'restart_mode': 'from_scratch',
            'prefix': f'b2_{element1}_{element2}',
            'pseudo_dir': './PBE',
            'outdir': './out',
            'tprnfor': True,
            'tstress': True,
            'nstep': 1000
        },
        'system': {
            'ecutwfc': max(pseudopotentials[element1]['cutoff_wfc'], pseudopotentials[element2]['cutoff_wfc']),
            'ecutrho': max(pseudopotentials[element1]['cutoff_rho'], pseudopotentials[element2]['cutoff_rho']),
            'occupations': 'smearing',
            'smearing': 'gaussian',  # or 'fermi-dirac'
            'degauss': 0.01,
            #'smearing': 'mp',  # or 'fermi-dirac'
            #'degauss': 0.02,
            #'vdw_corr': 'DFT-D'  # Add this line to include van der Waals interactions, 'DFT-D' or 'DFT-D3'
        },
        'electrons': {
            'conv_thr': 1.0e-6  # Updated convergence threshold
        },
        'ions': {
            #'ion_dynamics': 'bfgs'
            'ion_dynamics': 'cg'
        },
        'cell': {
            'cell_dynamics': 'bfgs'
        }
    }
    
    calc = Espresso(pseudopotentials=pseudopotentials_dict, input_data=input_data, kpts=(5, 5, 5), omp_num_threads=omp_num_threads, mpi_num_procs=mpi_num_procs)
    atoms.set_calculator(calc)
    
    input_data['control']['calculation'] = 'scf'
    scaling_factor = 0.99
    best_energy = float('inf')
    best_atoms = None
    retries = 0
    flag = 0
    while retries < max_retries:
        scaling_factor += 0.01
        print("a =", a," [A], v =", a**3," [A^3]")
        try:
            opt = BFGS(atoms)
            opt.run(fmax=0.02)
            energy = atoms.get_total_energy()
            print("E =",atoms.get_total_energy()," [eV]")
            if energy < best_energy:
                best_energy = energy
                best_atoms = atoms.copy()
                flag = 1
            if flag == 1 and energy > best_energy:
                break
        except Exception as e:
            print(f"Optimization failed for {element1}-{element2} with error: {e}")
            if retries >= max_retries:
                print("Max retries reached. Skipping this combination.")
            else:
                pass
        print(retries,"/",max_retries,": scaling factor = ", scaling_factor)
        a = (radius1 + radius2) * (2 / 3**0.5) * scaling_factor
        atoms.set_cell([a, a, a], scale_atoms=True)
        retries += 1
    
    scaling_factor -= 0.01
    print(retries,"/",max_retries,": scaling factor = ", scaling_factor)
    a = (radius1 + radius2) * (2 / 3**0.5)  * scaling_factor
    atoms.set_cell([a, a, a], scale_atoms=True)
    input_data['control']['calculation'] = 'vc-relax'
    opt = BFGS(atoms)
    opt.run(fmax=0.02)
    
    # Get optimized lattice constant and total energy
    optimized_a = atoms.get_cell()[0, 0]
    total_energy = atoms.get_total_energy()
    
    # check
    print("Check: vc-relax a=",optimized_a," [A] vs. input a=",a," [A]")
    
    # Calculate volumes, energies, and elastic constants for EOS fitting
    volumes = []
    energies = []
    cohesive_energies = []
    elastic_constants = []
    isolated_atom_energy1 = pseudopotentials[element1]['total_psenergy'] * 13.605693  # Convert to eV
    isolated_atom_energy2 = pseudopotentials[element2]['total_psenergy'] * 13.605693  # Convert to eV
    
    input_data['control']['calculation'] = 'scf'
    for scale in np.linspace((1.0-0.12)**(1/3), (1.0+0.12)**(1/3), 25):
        atoms.set_cell([scale * optimized_a] * 3, scale_atoms=True)
        
        # Perform SCF calculation at each volume step
        input_data['control']['calculation'] = 'scf'
        calc = Espresso(pseudopotentials=pseudopotentials_dict, input_data=input_data, kpts=(5, 5, 5), omp_num_threads=omp_num_threads, mpi_num_procs=mpi_num_procs)
        atoms.set_calculator(calc)
        
        volumes.append(atoms.get_volume()) # Convert each volume to Angstrom^3
        energies.append(atoms.get_total_energy())
        
        # Calculate cohesive energy
        cohesive_energy = -(atoms.get_total_energy() - isolated_atom_energy1 - isolated_atom_energy2) / len(atoms)
        cohesive_energies.append(cohesive_energy)
        
        # Extract stress tensor from the calculator
        stress_tensor = calc.get_stress() # QE([Ry/Bohr^3] -- ASE --> -[eV/A^3]
        
        # Calculate elastic constants (C11, C12, C44) from the stress tensor
        C11 = stress_tensor[0] * 160.21766208 # 1 [eV/A^3] = 160.21766208 [GPa]
        C22 = stress_tensor[1] * 160.21766208 # 1 [eV/A^3] = 160.21766208 [GPa]
        C33 = stress_tensor[2] * 160.21766208 # 1 [eV/A^3] = 160.21766208 [GPa]
        C23 = stress_tensor[3] * 160.21766208 # 1 [eV/A^3] = 160.21766208 [GPa]
        C13 = stress_tensor[4] * 160.21766208 # 1 [eV/A^3] = 160.21766208 [GPa]
        C12 = stress_tensor[5] * 160.21766208 # 1 [eV/A^3] = 160.21766208 [GPa]
        print("C11, C22, C33, C23, C13, C12: ",C11, C22, C33, C23, C13, C12)
        
        # Apply shear strains and calculate C44, C55, C66
        shear_strains = [0.01, 0.02, 0.03]
        shear_stresses = {'C44': [], 'C55': [], 'C66': []}
        
        for strain in shear_strains:
            # Apply shear strain in yz-plane for C44
            shear_atoms = atoms.copy()
            shear_atoms.set_cell(shear_atoms.get_cell() * [[1, 0, 0], [0, 1, strain], [0, 0, 1]], scale_atoms=True)
            shear_atoms.set_calculator(calc)
            opt = BFGS(shear_atoms)
            opt.run(fmax=0.02)
            shear_stress = shear_atoms.get_stress()
            shear_stresses['C44'].append(shear_stress[3] / strain)
            
            # Apply shear strain in xz-plane for C55
            shear_atoms = atoms.copy()
            shear_atoms.set_cell(shear_atoms.get_cell() * [[1, 0, strain], [0, 1, 0], [0, 0, 1]], scale_atoms=True)
            shear_atoms.set_calculator(calc)
            opt = BFGS(shear_atoms)
            opt.run(fmax=0.02)
            shear_stress = shear_atoms.get_stress()
            shear_stresses['C55'].append(shear_stress[4] / strain)
            
            # Apply shear strain in xy-plane for C66
            shear_atoms = atoms.copy()
            shear_atoms.set_cell(shear_atoms.get_cell() * [[1, strain, 0], [0, 1, 0], [0, 0, 1]], scale_atoms=True)
            shear_atoms.set_calculator(calc)
            opt = BFGS(shear_atoms)
            opt.run(fmax=0.02)
            shear_stress = shear_atoms.get_stress()
            shear_stresses['C66'].append(shear_stress[5] / strain)
        
        C44 = np.mean(shear_stresses['C44']) * 160.21766208 # 1 [eV/A^3] = 160.21766208 [GPa]
        C55 = np.mean(shear_stresses['C55']) * 160.21766208 # 1 [eV/A^3] = 160.21766208 [GPa]
        C66 = np.mean(shear_stresses['C66']) * 160.21766208 # 1 [eV/A^3] = 160.21766208 [GPa]
        
        elastic_constants.append({
            'C11': C11,
            'C12': C12,
            'C22': C22,
            'C33': C33,
            'C23': C23,
            'C13': C13,
            'C44': C44,
            'C55': C55,
            'C66': C66
        })
    
    # Calculate bulk modulus using Equation of State (EOS)
    eos = EquationOfState(volumes, energies, eos='murnaghan')  # Try different EOS models (volumes [A^3], energies [eV])
    try:
        v0, e0, B = eos.fit()
        print(B / kJ * 1.0e24, 'GPa') # 1 [eV/A^3] -> 160.21766208 [GPa]
        eos.plot('FCC_B1_'+element1+'-'+element2+'_eos.png')
    except ValueError as e:
        print(f"Error fitting EOS: {e}")
    
    a = v0**(1/3)
    atoms.set_cell([a, a, a], scale_atoms=True)
    input_data['control']['calculation'] = 'scf'
    opt = BFGS(atoms)
    opt.run(fmax=0.02)
    
    # Get optimized lattice constant and total energy
    optimized_a = atoms.get_cell()[0, 0]
    total_energy = atoms.get_total_energy()
    
    # check results
    print("EOS ",e0,"[eV] vs. SCF",total_energy," [eV]")
    
    cohesive_energy = -(atoms.get_total_energy() - isolated_atom_energy1 - isolated_atom_energy2) / len(atoms)
    
    # Calculate nearest neighbor distance
    nearest_neighbor_distance = optimized_a / 3**0.5
    
    # Extract stress tensor from the calculator
    stress_tensor = calc.get_stress() # QE([Ry/Bohr^3] -- ASE --> -[eV/A^3]
    
    # Calculate elastic constants (C11, C12, C44) from the stress tensor
    C11 = stress_tensor[0] * 160.21766208 # 1 [eV/A^3] = 160.21766208 [GPa]
    C22 = stress_tensor[1] * 160.21766208 # 1 [eV/A^3] = 160.21766208 [GPa]
    C33 = stress_tensor[2] * 160.21766208 # 1 [eV/A^3] = 160.21766208 [GPa]
    C23 = stress_tensor[3] * 160.21766208 # 1 [eV/A^3] = 160.21766208 [GPa]
    C13 = stress_tensor[4] * 160.21766208 # 1 [eV/A^3] = 160.21766208 [GPa]
    C12 = stress_tensor[5] * 160.21766208 # 1 [eV/A^3] = 160.21766208 [GPa]
    print("C11, C22, C33, C23, C13, C12: ",C11, C22, C33, C23, C13, C12)
    
    # Apply shear strains and calculate C44, C55, C66
    shear_strains = [0.01, 0.02, 0.03]
    shear_stresses = {'C44': [], 'C55': [], 'C66': []}
    
    input_data['control']['calculation'] = 'scf'
    for strain in shear_strains:
        # Apply shear strain in yz-plane for C44
        shear_atoms = atoms.copy()
        shear_atoms.set_cell(shear_atoms.get_cell() * [[1, 0, 0], [0, 1, strain], [0, 0, 1]], scale_atoms=True)
        shear_atoms.set_calculator(calc)
        opt = BFGS(shear_atoms)
        opt.run(fmax=0.02)
        shear_stress = shear_atoms.get_stress()
        shear_stresses['C44'].append(shear_stress[3] / strain)
        
        # Apply shear strain in xz-plane for C55
        shear_atoms = atoms.copy()
        shear_atoms.set_cell(shear_atoms.get_cell() * [[1, 0, strain], [0, 1, 0], [0, 0, 1]], scale_atoms=True)
        shear_atoms.set_calculator(calc)
        opt = BFGS(shear_atoms)
        opt.run(fmax=0.02)
        shear_stress = shear_atoms.get_stress()
        shear_stresses['C55'].append(shear_stress[4] / strain)
        
        # Apply shear strain in xy-plane for C66
        shear_atoms = atoms.copy()
        shear_atoms.set_cell(shear_atoms.get_cell() * [[1, strain, 0], [0, 1, 0], [0, 0, 1]], scale_atoms=True)
        shear_atoms.set_calculator(calc)
        opt = BFGS(shear_atoms)
        opt.run(fmax=0.02)
        shear_stress = shear_atoms.get_stress()
        shear_stresses['C66'].append(shear_stress[5] / strain)
    
    C44 = np.mean(shear_stresses['C44']) * 160.21766208 # 1 [eV/A^3] = 160.21766208 [GPa]
    C55 = np.mean(shear_stresses['C55']) * 160.21766208 # 1 [eV/A^3] = 160.21766208 [GPa]
    C66 = np.mean(shear_stresses['C66']) * 160.21766208 # 1 [eV/A^3] = 160.21766208 [GPa]
    
    elastic_constants.append({
        'C11': C11,
        'C12': C12,
        'C22': C22,
        'C33': C33,
        'C23': C23,
        'C13': C13,
        'C44': C44,
        'C55': C55,
        'C66': C66
    })
    
    return {
        'Element1': element1,
        'Element2': element2,
        'Cohesive Energy (eV/atom)': cohesive_energy,
        'Nearest Neighbor Distance (A)': nearest_neighbor_distance,
        'Bulk Modulus (GPa)': B / kJ * 1.0e24 , # 1 [eV/A^3] = 1/ ase.units.kJ * 1.0e24 = 160.21766208 = [GPa]
        'Elastic Constants (GPa)': {
            'C11': C11,
            'C12': C12,
            'C22': C22,
            'C33': C33,
            'C23': C23,
            'C13': C13,
            'C44': C44,
            'C55': C55,
            'C66': C66
        },
        'Lattice Constant (A)': optimized_a,
        'Volume (A^3)': optimized_a**3,
        'Total Energy (eV)': total_energy,
        'Volumes (A^3)': volumes,
        'Energies (eV)': energies,
        'Cohesive Energies (eV/atom)': cohesive_energies,
        'Elastic Constants per Volume': elastic_constants
    }

# Process the combinations sequentially and store results
results = []
for i, combination in enumerate(element_combinations):
    result = calculate_properties(combination, omp_num_threads, mpi_num_procs)
    results.append(result)
    element1, element2 = combination
    
    # Create the directory if it doesn't exist
    directory = f'FCC_B1_{element1}-{element2}'
    if not os.path.exists(directory):
        os.makedirs(directory)
    
    # Save intermediate results to a JSON file
    #with open('FCC_B1_'+element1+'-'+element2+'/results_FCC_B1_'+element1+'-'+element2+'.json', 'a') as jsonfile:
    with open(f'{directory}/results_FCC_B1_{element1}-{element2}.json', 'a') as jsonfile:
        json.dump(result, jsonfile, indent=4)
        jsonfile.write('\n')
    
    # Save intermediate results to a CSV file
    #with open('FCC_B1_'+element1+'-'+element2+'/results_FCC_B1_'+element1+'-'+element2+'.csv', 'a', newline='') as csvfile:
    with open(f'{directory}/results_FCC_B1_{element1}-{element2}.csv', 'a', newline='') as csvfile:
        fieldnames = ['Element1', 'Element2', 
                      'Cohesive Energy (eV/atom)', 'Nearest Neighbor Distance (A)', 'Bulk Modulus (GPa)', 
                      'C11', 'C12', 'C22', 'C33', 'C23', 'C13', 'C44', 'C55', 'C66', 
                      'Lattice Constant (A)', 'Volumes (A^3)', 'Energies (eV)', 'Total Energy (eV)', 'Cohesive Energies (eV/atom)', 
                      'Elastic Constants per Volume']
        
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        
        if i == 0:
            writer.writeheader()  # Write header only once
        
        writer.writerow({
            'Element1': result['Element1'],
            'Element2': result['Element2'],
            'Cohesive Energy (eV/atom)': result['Cohesive Energy (eV/atom)'],
            'Nearest Neighbor Distance (A)': result['Nearest Neighbor Distance (A)'],
            'Bulk Modulus (GPa)': result['Bulk Modulus (GPa)'],
            'C11': result['Elastic Constants (GPa)']['C11'],
            'C12': result['Elastic Constants (GPa)']['C12'],
            'C22': result['Elastic Constants (GPa)']['C22'],
            'C33': result['Elastic Constants (GPa)']['C33'],
            'C23': result['Elastic Constants (GPa)']['C23'],
            'C13': result['Elastic Constants (GPa)']['C13'],
            'C44': result['Elastic Constants (GPa)']['C44'],
            'C55': result['Elastic Constants (GPa)']['C55'],
            'C66': result['Elastic Constants (GPa)']['C66'],
            'Lattice Constant (A)': result['Lattice Constant (A)'],
            'Total Energy (eV)': result['Total Energy (eV)'],
            'Volumes (A^3)': result['Volumes (A^3)'],
            'Energies (eV)': result['Energies (eV)'],
            'Cohesive Energies (eV/atom)': result['Cohesive Energies (eV/atom)'],
            'Elastic Constants per Volume': result['Elastic Constants per Volume']
        })
    
    print(f"Processed combination {i+1}/{len(element_combinations)}: {combination}")

print("Calculations are complete and results are saved to results_FCC_B1.json and results_FCC_B1.csv.")
