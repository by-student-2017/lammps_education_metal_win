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

#------------------------------------------------------------------
# b1: FCC_B1 (NaCl-type), b2:BCC_B2 (CsCl-type), dia:Diamond_B3 (Zinc Blende), l12: L12 (Cu3Au-type)
lattce = 'b2'
#------------------------------------------------------------------
# lattice structure of reference configuration [Angstrom]
lat = 3.502
#------------------------------------------------------------------
elements = ['Fe', 'Cr', 'Al'] # <- Enter the element you want to calculate
fixed_element = 'Fe'
element_combinations = [(fixed_element, element) for element in elements if element != fixed_element]
#print(element_combinations)
#----------------------------
# Get all combinations of elements
#elements = list(pseudopotentials.keys())
#elements = ['Fe', 'Cr']
#element_combinations = list(combinations(elements, 2))
#------------------------------------------------------------------
# max number of cycles for search optimized structure
max_retries = 200
#------------------------------------------------------------------
# Load the pseudopotential data from the JSON file
with open('PBE/PSlibrary_PBE.json', 'r') as f:
    pseudopotentials = json.load(f)
#------------------------------------------------------------------
# Explicitly set OMP_NUM_THREADS
os.environ['OMP_NUM_THREADS'] = '4'
#------------------------------------------------------------------
# Set the number of OpenMP/MPI settings (This is not working.)
omp_num_threads = 1
mpi_num_procs = 1
#------------------------------------------------------------------

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

def calculate_elastic_constants(atoms, calc, shear_strains, normal_strains):
    initial_stress_tensor = calc.get_stress()
    
    # Normal strains for C11, C12, etc.
    normal_stresses = {'C11': [], 'C12': [], 'C22': [], 'C33': [], 'C23': [], 'C13': []}
    for strain in normal_strains:
        # Apply strain in x direction for C11
        normal_atoms = atoms.copy()
        normal_atoms.set_cell(normal_atoms.get_cell() * [[1 + strain, 0, 0], [0, 1, 0], [0, 0, 1]], scale_atoms=True)
        normal_atoms.set_calculator(calc)
        opt = BFGS(normal_atoms)
        opt.run(fmax=0.02)
        normal_stress = normal_atoms.get_stress()
        normal_stresses['C11'].append((normal_stress[0] - initial_stress_tensor[0]) / strain)

        # Apply strain in y direction for C22
        normal_atoms = atoms.copy()
        normal_atoms.set_cell(normal_atoms.get_cell() * [[1, 0, 0], [0, 1 + strain, 0], [0, 0, 1]], scale_atoms=True)
        normal_atoms.set_calculator(calc)
        opt = BFGS(normal_atoms)
        opt.run(fmax=0.02)
        normal_stress = normal_atoms.get_stress()
        normal_stresses['C22'].append((normal_stress[1] - initial_stress_tensor[1]) / strain)

        # Apply strain in z direction for C33
        normal_atoms = atoms.copy()
        normal_atoms.set_cell(normal_atoms.get_cell() * [[1, 0, 0], [0, 1, 0], [0, 0, 1 + strain]], scale_atoms=True)
        normal_atoms.set_calculator(calc)
        opt = BFGS(normal_atoms)
        opt.run(fmax=0.02)
        normal_stress = normal_atoms.get_stress()
        normal_stresses['C33'].append((normal_stress[2] - initial_stress_tensor[2]) / strain)

        # Apply strain in xy direction for C12
        normal_atoms = atoms.copy()
        normal_atoms.set_cell(normal_atoms.get_cell() * [[1 + strain, 0, 0], [0, 1 + strain, 0], [0, 0, 1]], scale_atoms=True)
        normal_atoms.set_calculator(calc)
        opt = BFGS(normal_atoms)
        opt.run(fmax=0.02)
        normal_stress = normal_atoms.get_stress()
        normal_stresses['C12'].append((normal_stress[0] - initial_stress_tensor[0]) / strain)

        # Apply strain in yz direction for C23
        normal_atoms = atoms.copy()
        normal_atoms.set_cell(normal_atoms.get_cell() * [[1, 0, 0], [0, 1 + strain, 0], [0, 0, 1 + strain]], scale_atoms=True)
        normal_atoms.set_calculator(calc)
        opt = BFGS(normal_atoms)
        opt.run(fmax=0.02)
        normal_stress = normal_atoms.get_stress()
        normal_stresses['C23'].append((normal_stress[1] - initial_stress_tensor[1]) / strain)

        # Apply strain in xz direction for C13
        normal_atoms = atoms.copy()
        normal_atoms.set_cell(normal_atoms.get_cell() * [[1 + strain, 0, 0], [0, 1, 0], [0, 0, 1 + strain]], scale_atoms=True)
        normal_atoms.set_calculator(calc)
        opt = BFGS(normal_atoms)
        opt.run(fmax=0.02)
        normal_stress = normal_atoms.get_stress()
        normal_stresses['C13'].append((normal_stress[0] - initial_stress_tensor[0]) / strain)

    C11 = np.mean(normal_stresses['C11']) * 160.21766208
    C12 = np.mean(normal_stresses['C12']) * 160.21766208
    C22 = np.mean(normal_stresses['C22']) * 160.21766208
    C33 = np.mean(normal_stresses['C33']) * 160.21766208
    C23 = np.mean(normal_stresses['C23']) * 160.21766208
    C13 = np.mean(normal_stresses['C13']) * 160.21766208

    shear_stresses = {'C44': [], 'C55': [], 'C66': []}
    for strain in shear_strains:
        # Apply shear strain in xy direction for C44
        shear_atoms = atoms.copy()
        shear_atoms.set_cell(shear_atoms.get_cell() * [[1, 0, 0], [0, 1, strain], [0, 0, 1]], scale_atoms=True)
        shear_atoms.set_calculator(calc)
        opt = BFGS(shear_atoms)
        opt.run(fmax=0.02)
        shear_stress = shear_atoms.get_stress()
        shear_stresses['C44'].append((shear_stress[3] - initial_stress_tensor[3]) / strain)

        # Apply shear strain in xz direction for C55
        shear_atoms = atoms.copy()
        shear_atoms.set_cell(shear_atoms.get_cell() * [[1, 0, strain], [0, 1, 0], [0, 0, 1]], scale_atoms=True)
        shear_atoms.set_calculator(calc)
        opt = BFGS(shear_atoms)
        opt.run(fmax=0.02)
        shear_stress = shear_atoms.get_stress()
        shear_stresses['C55'].append((shear_stress[4] - initial_stress_tensor[4]) / strain)

        # Apply shear strain in yz direction for C66
        shear_atoms = atoms.copy()
        shear_atoms.set_cell(shear_atoms.get_cell() * [[1, strain, 0], [0, 1, 0], [0, 0, 1]], scale_atoms=True)
        shear_atoms.set_calculator(calc)
        opt = BFGS(shear_atoms)
        opt.run(fmax=0.02)
        shear_stress = shear_atoms.get_stress()
        shear_stresses['C66'].append((shear_stress[5] - initial_stress_tensor[5]) / strain)

    C44 = np.mean(shear_stresses['C44']) * 160.21766208
    C55 = np.mean(shear_stresses['C55']) * 160.21766208
    C66 = np.mean(shear_stresses['C66']) * 160.21766208
    
    #Bv = ((C11 + C22 + C33) + 2 * (C12 + C13 + C23)) / 9

    return {
        'C11': C11,
        'C12': C12,
        'C22': C22,
        'C33': C33,
        'C23': C23,
        'C13': C13,
        'C44': C44,
        'C55': C55,
        'C66': C66,
        #'Bv': Bv
    }

def calculate_properties(elements_combination, omp_num_threads, mpi_num_procs, max_retries=200, lattce='', lat=''):
    element1, element2 = elements_combination
    scaling_factor = 0.88
    
    print(f"{element1}-{element2} pair, lattce = {lattce}")

    vdw_elements = ["H", "He", "Li", "B", "N", "P", "S", "Ne", "Ar", "Kr", "Xe", "Rn"]
    if element1 in vdw_elements and element2 in vdw_elements:
        radius1 = vdw_radii[element1]
        radius2 = vdw_radii[element2]
    else:
        radius1 = atomic_radii[element1]
        radius2 = atomic_radii[element2]
    re = (radius1 + radius2)

    if lattce == 'b1':
        print("Create the FCC B1 (NaCl-type) structure")
        lattice_type = 'FCC_B1 (NaCl-type)'
        re2a = 2.0
        if not lat == '':
            re = lat / re2a
        a = re * re2a * scaling_factor
        atoms = Atoms(f'{element1}4{element2}4', 
              positions=[(0, 0, 0), (0.5*a, 0.5*a, 0), (0.5*a, 0, 0.5*a), (0, 0.5*a, 0.5*a), 
                         (0.5*a, 0.5*a, 0.5*a), (0, 0.5*a, 0), (0.5*a, 0, 0), (0, 0, 0.5*a)], 
              cell=[a, a, a], 
              pbc=True)
        kpt = 4
    elif lattce == 'b2':
        print("Create the BCC B2 (CsCl-type) structure")
        lattice_type = 'BCC_B2 (CsCl-type)'
        re2a = 2.0/3.0**0.5
        if not lat == '':
            re = lat / re2a
        a = re * re2a * scaling_factor
        atoms = Atoms(f'{element1}{element2}', 
                  positions=[(0, 0, 0), (0.5*a, 0.5*a, 0.5*a)], 
                  cell=[a, a, a], 
                  pbc=True)
        kpt = 7
    elif lattce == 'dia':
        print("Create the Diamond B3 (Zinc Blende) structure")
        lattice_type = 'DIA_B3 (Zinc Blende)'
        re2a = 4.0/2.0**0.5
        if not lat == '':
            re = lat / re2a
        a = re * re2a * scaling_factor
        '''
        # conventional cell
        atoms = Atoms(f'{element1}4{element2}4', 
              positions=[(0, 0, 0), (0.5*a, 0.5*a, 0), (0.5*a, 0, 0.5*a), (0, 0.5*a, 0.5*a), 
                         (0.25*a, 0.75*a, 0.75*a), (0.25*a, 0.25*a, 0.25*a), (0.75*a, 0.75*a, 0.25*a), 
                         (0.75*a, 0.25*a, 0.75*a)], 
              cell=[a, a, a], 
              pbc=True)
        '''
        # primitive cell
        atoms = Atoms(f'{element1}{element2}',
              positions=[(0, 0, 0), (0.25*a, 0.25*a, 0.25*a)],
              cell=[[0.5*a, 0.5*a, 0], [0.5*a, 0, 0.5*a], [0, 0.5*a, 0.5*a]],
              pbc=True)
        kpt = 3
    elif lattce == 'l12':
        print("Create the L12 (Cu3Au-type) structure")
        lattice_type = 'L12 (Cu3Au-type)'
        re2a = 2.0/2.0**0.5
        if not lat == '':
            re = lat / re2a
        a = re * re2a * scaling_factor
        atoms = Atoms(f'{element1}3{element2}', 
              positions=[(0, 0.5*a, 0.5*a), (0.5*a, 0, 0.5*a), (0.5*a, 0.5*a, 0), 
                         (0, 0, 0)], 
              cell=[a, a, a], 
              pbc=True)
        kpt = 6
    else:
        print("This code does not provide other structures. (Possible structures: b1, b2, dia, l12)")

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
            'smearing': 'gaussian',
            'degauss': 0.01,
        },
        'electrons': {
            'conv_thr': 1.0e-6
        },
        'ions': {
            'ion_dynamics': 'cg'
        },
        'cell': {
            'cell_dynamics': 'bfgs'
        }
    }

    calc = Espresso(pseudopotentials=pseudopotentials_dict, input_data=input_data, kpts=(kpt, kpt, kpt), omp_num_threads=omp_num_threads, mpi_num_procs=mpi_num_procs)
    atoms.set_calculator(calc)

    #-----------------------------------------------------------------------------
    # search optimized structure with scf
    input_data['control']['calculation'] = 'scf'
    best_energy = float('inf')
    best_atoms = None
    retries = 0
    flag = 0
    print("search optimized structure with scf")
    while retries < max_retries:
        scaling_factor += 0.04
        print("---------------------------------")
        print(retries+1,"/",max_retries,", a = ", a," [A], v =", a**3," [A^3]")
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
        a = re * re2a * scaling_factor
        atoms.set_cell([a, a, a], scale_atoms=True)
        retries += 1

    scaling_factor -= 0.04/2
    print(retries,"/",max_retries,": scaling factor = ", scaling_factor)
    a = re * re2a * scaling_factor
    atoms.set_cell([a, a, a], scale_atoms=True)
    #-----------------------------------------------------------------------------
    
    '''
    #-----------------------------------------------------------------------------
    # search optimized structure with vc-relax
    input_data['control']['calculation'] = 'vc-relax'
    retries = 0
    print("search optimized structure with vc-relax")
    while retries < max_retries:
        scaling_factor += 0.04
        print("a =", a," [A], v =", a**3," [A^3]")
        try:
            opt = BFGS(atoms)
            opt.run(fmax=0.02)
            energy = atoms.get_total_energy()
            print("E =",atoms.get_total_energy()," [eV]")
            break
        except Exception as e:
            print(f"Optimization failed for {element1}-{element2} with error: {e}")
            if retries >= max_retries:
                print("Max retries reached. Skipping this combination.")
            else:
                pass
        print(retries,"/",max_retries,": scaling factor = ", scaling_factor)
        a = re * re2a * scaling_factor
        atoms.set_cell([a, a, a], scale_atoms=True)
        retries += 1
    #-----------------------------------------------------------------------------
    '''

    optimized_a = atoms.get_cell()[0, 0]
    total_energy = atoms.get_total_energy()

    volumes = []
    energies = []
    cohesive_energies = []
    elastic_constants = []
    stress_tensor = []
    isolated_atom_energy1 = pseudopotentials[element1]['total_psenergy'] * 13.605693
    isolated_atom_energy2 = pseudopotentials[element2]['total_psenergy'] * 13.605693
    
    volumes_per_atom = []
    energies_per_atom = []
    cohesive_energies_per_atom = []

    input_data['control']['calculation'] = 'scf'
    tries = 0
    for scale in np.linspace((1.0-0.24)**(1/3), (1.0+0.24)**(1/3), 25):
        tries += 1
        atoms.set_cell([scale * optimized_a] * 3, scale_atoms=True)

        input_data['control']['calculation'] = 'scf'
        calc = Espresso(pseudopotentials=pseudopotentials_dict, input_data=input_data, kpts=(kpt, kpt, kpt), omp_num_threads=omp_num_threads, mpi_num_procs=mpi_num_procs)
        atoms.set_calculator(calc)

        volumes.append(atoms.get_volume())
        energies.append(atoms.get_total_energy())

        cohesive_energy = -(atoms.get_total_energy() - isolated_atom_energy1*4 - isolated_atom_energy2*4)
        cohesive_energies.append(cohesive_energy)
        
        volume = atoms.get_volume()
        volumes_per_atom.append(volume/len(atoms))
        print(f"       check volume: QE {volume/len(atoms)} vs. input {(scale * optimized_a)**3/len(atoms)}")
        
        energies_per_atom.append(atoms.get_total_energy()/len(atoms))
        cohesive_energies_per_atom.append(cohesive_energy/len(atoms))

        input_data['control']['calculation'] = 'scf'
        #elastic_constants.append(calculate_elastic_constants(atoms, calc, [0.01, 0.02, 0.03], [0.01, 0.02, 0.03]))
        stress_tensor.append((calc.get_stress() * 160.21766208).tolist())
        
        print(f"{tries}/25, Volume = {volume/len(atoms)} [A^3/atom], Cohesive_energy = {cohesive_energy/len(atoms)} [eV/atom]")
        print("-------------------------------------------------------------------------------------")

    #eos = EquationOfState(volumes, energies, eos='murnaghan')
    #eos = EquationOfState(volumes_per_atom, energies_per_atom, eos='murnaghan')
    #eos = EquationOfState(volumes, [energy * -1.0 for energy in cohesive_energies], eos='murnaghan')
    eos = EquationOfState(volumes_per_atom, [energy * -1.0 for energy in cohesive_energies_per_atom], eos='murnaghan')
    try:
        v0, e0, B = eos.fit()
        print(B / kJ * 1.0e24, 'GPa')
        eos.plot('FCC_B1_'+element1+'-'+element2+'_eos.png')
    except ValueError as e:
        print(f"Error fitting EOS: {e}")

    a = v0**(1/3)
    atoms.set_cell([a, a, a], scale_atoms=True)
    input_data['control']['calculation'] = 'scf'
    opt = BFGS(atoms)
    opt.run(fmax=0.02)

    optimized_a = atoms.get_cell()[0, 0]
    total_energy = atoms.get_total_energy()

    print("EOS ",e0,"[eV] vs. SCF",total_energy," [eV]")

    cohesive_energy = -(atoms.get_total_energy() - isolated_atom_energy1*4 - isolated_atom_energy2*4)
    cohesive_energy_per_atom = cohesive_energy / len(atoms)
    nearest_neighbor_distance = optimized_a / re2a

    input_data['control']['calculation'] = 'scf'
    elastic_constants_final = calculate_elastic_constants(atoms, calc, [0.01, 0.02, 0.03], [0.01, 0.02, 0.03])
    #elastic_constants_final = calculate_elastic_constants(atoms, calc, [0.001, 0.002, 0.003], [0.001, 0.002, 0.003])

    return {
        'Element1': element1,
        'Element2': element2,
        'Lattice Type': lattice_type,
        'Cohesive Energy (eV/atom)': cohesive_energy_per_atom,
        'Nearest Neighbor Distance (A)': nearest_neighbor_distance,
        'Bulk Modulus (GPa)': B / kJ * 1.0e24,
        'Elastic Constants (GPa)': elastic_constants_final,
        #----------------------------------------------------------
        'Atoms': len(atoms),
        'Lattice Constant (A)': optimized_a,
        'Volume (A^3)': optimized_a**3,
        'Total Energy (eV)': total_energy,
        'Volumes (A^3)': volumes,
        'Energies (eV)': energies,
        'Cohesive Energies (eV)': cohesive_energies,
        'Stress Tensor per Volume (GPa)': stress_tensor
    }

# Process the combinations sequentially and store results
results = []
for i, combination in enumerate(element_combinations):
    result = calculate_properties(combination, omp_num_threads, mpi_num_procs, max_retries, lattce, lat)
    results.append(result)
    element1, element2 = combination

    directory = f'{lattce}_{element1}-{element2}'
    if not os.path.exists(directory):
        os.makedirs(directory)

    with open(f'{directory}/results_{lattce}_{element1}-{element2}.json', 'a') as jsonfile:
        json.dump(result, jsonfile, indent=4)
        jsonfile.write('\n')

    with open(f'{directory}/results_{lattce}_{element1}-{element2}.csv', 'a', newline='') as csvfile:
        fieldnames = ['Element1', 'Element2', 
                      'Lattice Type',
                      'Cohesive Energy (eV/atom)', 'Nearest Neighbor Distance (A)', 'Bulk Modulus (GPa)', 
                      'C11', 'C12', 'C22', 'C33', 'C23', 'C13', 'C44', 'C55', 'C66', 
                      'Atoms', 
                      'Lattice Constant (A)', 'Volumes (A^3)', 'Energies (eV)', 'Total Energy (eV)', 
                      'Cohesive Energies (eV)', 'Stress Tensor per Volume (GPa)']

        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

        if i == 0:
            writer.writeheader()

        writer.writerow({
            'Element1': result['Element1'],
            'Element2': result['Element2'],
            'Lattice Type': result['Lattice Type'],
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
            #-----------------------------------------------
            'Atoms': result['Atoms'],
            'Lattice Constant (A)': result['Lattice Constant (A)'],
            'Total Energy (eV)': result['Total Energy (eV)'],
            'Volumes (A^3)': result['Volumes (A^3)'],
            'Energies (eV)': result['Energies (eV)'],
            'Cohesive Energies (eV)': result['Cohesive Energies (eV)'],
            'Stress Tensor per Volume (GPa)': result['Stress Tensor per Volume (GPa)']
        })

    print(f"Processed combination {i+1}/{len(element_combinations)}: {combination}")

print(f"Calculations are complete and results are saved to results_{lattce}.json and results_{lattce}.csv.")
