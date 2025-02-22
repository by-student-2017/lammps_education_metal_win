import json
import csv
from itertools import combinations
from ase import Atoms
from ase.calculators.espresso import Espresso
from ase.optimize import BFGS
from ase.eos import EquationOfState
from ase.units import Bohr, Rydberg, kJ, kB, fs, Hartree, mol, kcal
import numpy as np
import os

# For Rose universal function
from scipy.optimize import curve_fit
import matplotlib.pyplot as plt

#------------------------------------------------------------------
# b1: FCC_B1 (NaCl-type), b2:BCC_B2 (CsCl-type), dia:Diamond_B3 (Zinc Blende), l12: L12 (Cu3Au-type)
lattce = 'l12'
#------------------------------------------------------------------
# lattice structure of reference configuration [Angstrom] (https://en.wikipedia.org/wiki/Lattice_constant)
lat = 4.046 # Al FCC (e.g., for L12 calculation of Al-base)
#lat = 3.502 # Fe BCC (e.g., for BCC_B2 calculation of Fe-base)
#lat = 5.431 # Si Diamond (e.g., for dia calculation)
#lat = 5.640 # NaCl (e.g., FCC_B1 calculation)
#----------------------------
# making number of data
npoints = 25 # >= 5, 11, 17, 25, or 31, etc (Recommend >= 11)
#------------------------------------------------------------------
elements = ['Al', 'Fe', 'Cr', 'Ru', 'Rh', 'Re', 'Os', 'Ir', 'Si', 'B', 'Be', 'S', 'O', 'P'] # <- Enter the element you want to calculate
fixed_element = 'Al'
#elements = ['Fe', 'Cr', 'Al', 'Ru', 'Rh', 'Re', 'Os', 'Ir', 'Hf', 'B', 'Be', 'S', 'O', 'P'] # <- Enter the element you want to calculate
#fixed_element = 'Fe'
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
#with open('PBE/PSlibrary_PBE.json', 'r') as f:
#    pseudopotentials = json.load(f)
#
with open('PBEsol/PSlibrary_PBEsol.json', 'r') as f:
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


def binary_search(re, re2a, atoms, calc, scaling_factor, dsfactor, best_energy):
    scaling_factor += dsfactor/2.0
    a = re * re2a * scaling_factor
    atoms.set_cell([a, a, a], scale_atoms=True)
    
    atoms.set_calculator(calc)
    energy = atoms.get_total_energy()
    if best_energy < energy:
        scaling_factor -= dsfactor
        a = re * re2a * scaling_factor
        atoms.set_cell([a, a, a], scale_atoms=True)
        atoms.set_calculator(calc)
        energy = atoms.get_total_energy()
        if best_energy < energy:
            scaling_factor += dsfactor/2.0
            new_best_energy = best_energy
        else:
            new_best_energy = energy
    else:
        new_best_energy = energy
    new_scaling_factor = scaling_factor
    new_dsfactor = dsfactor/2
    return new_scaling_factor, new_dsfactor, new_best_energy



def fit_rose_curve(volumes_per_atom, cohesive_energies_per_atom, alpha, V0, Ec):
    """
    Fit the Rose's universal curve to DFT data to find the parameter a3.

    Parameters:
    volumes_per_atom (array): Array of volumes per atom from DFT calculations.
    cohesive_energies_per_atom (array): Array of cohesive energies per atom from DFT calculations.
    alpha (float): Constant alpha.
    V0 (float): Equilibrium volume per atom.
    Ec (float): Cohesive energy per atom.

    Returns:
    tuple: Fitted parameters repuls and attrac.
    """
    
    # Convert cohesive energies to the form needed for fitting
    E_data = np.array([-energy for energy in cohesive_energies_per_atom])
    
    # Rose's universal curve function
    def rose_curve(V, alpha, V0, Ec, repuls, attrac):
        astar = alpha * ((V/V0)**(1/3) - 1.0)
        a3 = np.where(astar < 0, repuls, attrac)
        return -Ec * (1 + astar + a3 * (astar**3)) * np.exp(-astar)
    
    # Fitting the parameters repuls and attrac
    popt, _ = curve_fit(lambda V, repuls, attrac: rose_curve(V, alpha, V0, Ec, repuls, attrac), 
                        volumes_per_atom, E_data, p0=[0.0, 0.0])  # Initial guesses for repuls and attrac
    
    # Fitted parameters
    repuls_fit, attrac_fit = popt
    
    # Plotting the fit
    plt.figure()
    plt.scatter(volumes_per_atom, E_data, label='DFT Data')
    plt.plot(volumes_per_atom, rose_curve(volumes_per_atom, alpha, V0, Ec, repuls_fit, attrac_fit), 
             label=f'Rose Curve Fit (repuls={repuls_fit:.4f}, attrac={attrac_fit:.4f})', color='red')
    plt.xlabel('Volume, V (A^3/atom)')
    plt.ylabel('Cohesive Energy, -Ec (eV/atom)')
    plt.legend()
    plt.title('Rose Curve Fit to DFT Data')
    
    # Save the plot as PNG
    #plt.savefig('rose_curve_fit.png')
    
    return repuls_fit, attrac_fit



def calculate_elastic_constants(atoms, calc, shear_strains, normal_strains):
    initial_stress_tensor = calc.get_stress()
    
    # Normal strains for C11, C12, etc.
    normal_stresses = {'C11': [], 'C12': [], 'C22': [], 'C33': [], 'C23': [], 'C13': []}
    for strain in normal_strains:
        print("# Apply strain in x direction for C11")
        normal_atoms = atoms.copy()
        normal_atoms.set_cell(normal_atoms.get_cell() * [[1 + strain, 0, 0], [0, 1, 0], [0, 0, 1]], scale_atoms=True)
        normal_atoms.set_calculator(calc)
        opt = BFGS(normal_atoms)
        opt.run(fmax=0.02)
        normal_stress = normal_atoms.get_stress()
        normal_stresses['C11'].append((normal_stress[0] - initial_stress_tensor[0]) / strain)

        print("# Apply strain in y direction for C22")
        normal_atoms = atoms.copy()
        normal_atoms.set_cell(normal_atoms.get_cell() * [[1, 0, 0], [0, 1 + strain, 0], [0, 0, 1]], scale_atoms=True)
        normal_atoms.set_calculator(calc)
        opt = BFGS(normal_atoms)
        opt.run(fmax=0.02)
        normal_stress = normal_atoms.get_stress()
        normal_stresses['C22'].append((normal_stress[1] - initial_stress_tensor[1]) / strain)

        print("# Apply strain in z direction for C33")
        normal_atoms = atoms.copy()
        normal_atoms.set_cell(normal_atoms.get_cell() * [[1, 0, 0], [0, 1, 0], [0, 0, 1 + strain]], scale_atoms=True)
        normal_atoms.set_calculator(calc)
        opt = BFGS(normal_atoms)
        opt.run(fmax=0.02)
        normal_stress = normal_atoms.get_stress()
        normal_stresses['C33'].append((normal_stress[2] - initial_stress_tensor[2]) / strain)

        print("# Apply strain in xy direction for C12")
        normal_atoms = atoms.copy()
        normal_atoms.set_cell(normal_atoms.get_cell() * [[1 + strain, 0, 0], [0, 1 + strain, 0], [0, 0, 1]], scale_atoms=True)
        normal_atoms.set_calculator(calc)
        opt = BFGS(normal_atoms)
        opt.run(fmax=0.02)
        normal_stress = normal_atoms.get_stress()
        normal_stresses['C12'].append((normal_stress[0] - initial_stress_tensor[0]) / strain)

        print("# Apply strain in yz direction for C23")
        normal_atoms = atoms.copy()
        normal_atoms.set_cell(normal_atoms.get_cell() * [[1, 0, 0], [0, 1 + strain, 0], [0, 0, 1 + strain]], scale_atoms=True)
        normal_atoms.set_calculator(calc)
        opt = BFGS(normal_atoms)
        opt.run(fmax=0.02)
        normal_stress = normal_atoms.get_stress()
        normal_stresses['C23'].append((normal_stress[1] - initial_stress_tensor[1]) / strain)

        print("# Apply strain in xz direction for C13")
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
        print("# Apply shear strain in xy direction for C44")
        shear_atoms = atoms.copy()
        shear_atoms.set_cell(shear_atoms.get_cell() * [[1, 0, 0], [0, 1, strain], [0, 0, 1]], scale_atoms=True)
        shear_atoms.set_calculator(calc)
        opt = BFGS(shear_atoms)
        opt.run(fmax=0.02)
        shear_stress = shear_atoms.get_stress()
        shear_stresses['C44'].append((shear_stress[3] - initial_stress_tensor[3]) / strain)

        print("# Apply shear strain in xz direction for C55")
        shear_atoms = atoms.copy()
        shear_atoms.set_cell(shear_atoms.get_cell() * [[1, 0, strain], [0, 1, 0], [0, 0, 1]], scale_atoms=True)
        shear_atoms.set_calculator(calc)
        opt = BFGS(shear_atoms)
        opt.run(fmax=0.02)
        shear_stress = shear_atoms.get_stress()
        shear_stresses['C55'].append((shear_stress[4] - initial_stress_tensor[4]) / strain)

        print("# Apply shear strain in yz direction for C66")
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



def calculate_properties(elements_combination, omp_num_threads, mpi_num_procs, max_retries=200, lattce='', lat='', npoints=11):
    element1, element2 = elements_combination
    
    dsfactor = 0.1
    scaling_factor = 1.0 - dsfactor*5.0
    
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
        Nelem1 = 4
        Nelem2 = 4
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
        Nelem1 = 1
        Nelem2 = 1
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
        Nelem1 = 4
        Nelem2 = 4
        '''
        # primitive cell
        atoms = Atoms(f'{element1}{element2}',
              positions=[(0, 0, 0), (0.25*a, 0.25*a, 0.25*a)],
              cell=[[0.5*a, 0.5*a, 0], [0.5*a, 0, 0.5*a], [0, 0.5*a, 0.5*a]],
              pbc=True)
        kpt = 3
        Nelem1 = 1
        Nelem2 = 1
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
        Nelem1 = 3
        Nelem2 = 1
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
            #'pseudo_dir': './PBE',
            'pseudo_dir': './PBEsol',
            'outdir': './out',
            'tprnfor': True, # Forces will be printed
            'tstress': True, # Stress will be printed
            'nstep': 1000
        },
        'system': {
            'ecutwfc': max(pseudopotentials[element1]['cutoff_wfc'], pseudopotentials[element2]['cutoff_wfc']),
            'ecutrho': max(pseudopotentials[element1]['cutoff_rho'], pseudopotentials[element2]['cutoff_rho']),
            'occupations': 'smearing',
            'smearing': 'gaussian',
            'degauss': 0.01,
            #
            #'vdw_corr': 'dft-d', # DFT-D2 (Semiempirical Grimme's DFT-D2. Optional variables)
            'vdw_corr': 'dft-d3',
            'dftd3_version': 3,
            'dftd3_threebody': False, # If it is set to True, the calculation will hardly proceed at all.
            #
            ## pseudo-potential: rel-DFT (e.g., rel-pbe or rel-pbesol, etc)
            #'noncolin': True,
            #'lspinorb': True,
        },
        'electrons': {
            'conv_thr': 1.0e-6
        },
        'ions': {
            'ion_dynamics': 'bfgs'
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
    retries = 0
    flag = 0
    print("search optimized structure with scf")
    while retries < max_retries:
        print("---------------------------------")
        print(retries+1,"/",max_retries,", a = ", a," [A], v =", a**3," [A^3]")
        try:
            atoms.set_calculator(calc)
            energy = atoms.get_total_energy()
            print("E =",atoms.get_total_energy()," [eV]")
            if energy < best_energy:
                best_energy = energy
                flag = 1
            if flag == 1 and energy > best_energy:
                #---------------------------------
                print("--------------------------------------------")
                scaling_factor -= dsfactor
                print("# binary search")
                print("step, scaling_factor, dsfactor, best_energy")
                print("0/5: ", scaling_factor, dsfactor, best_energy)
                print("--------------------------------------------")
                step = 1
                while step <= 5:
                    scaling_factor, dsfactor, best_energy = binary_search(re, re2a, atoms, calc, scaling_factor, dsfactor, best_energy)
                    print(f"{step}/5: ", scaling_factor, dsfactor, best_energy)
                    print("--------------------------------------------")
                    step += 1
                break
                #---------------------------------
        except Exception as e:
            print(f"Optimization failed for {element1}-{element2} with error: {e}")
            if retries >= max_retries:
                print("Max retries reached. Skipping this combination.")
            else:
                pass
        print("scaling factor = ", scaling_factor, "energy = ",energy)
        retries += 1
        scaling_factor += dsfactor
        a = re * re2a * scaling_factor
        atoms.set_cell([a, a, a], scale_atoms=True)

    print("---------------------------------------")
    print("using scaling factor = ", scaling_factor)
    a = re * re2a * scaling_factor
    optimized_a = a
    #-----------------------------------------------------------------------------
    
    '''
    # The following was useless because vc-relax didn't work properly.
    #-----------------------------------------------------------------------------
    # search optimized structure with vc-relax
    input_data['control']['calculation'] = 'vc-relax'
    retries = 0
    print("search optimized structure with vc-relax")
    while retries < max_retries:
        print("---------------------------------")
        print(retries+1,"/",max_retries,", a = ", a," [A], v =", a**3," [A^3]")
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
        print("scaling factor = ", scaling_factor, "energy = ",energy)
        retries += 1
        scaling_factor += 0.03
        a = re * re2a * scaling_factor
        atoms.set_cell([a, a, a], scale_atoms=True)
    optimized_a = atoms.get_cell()[0, 0]
    #-----------------------------------------------------------------------------
    '''

    print("----------------------------------------")
    print("making data and equation of states (eos)")
    print("----------------------------------------")

    volumes = []
    energies = []
    cohesive_energies = []
    elastic_constants = []
    stress_tensor = []
    forces = []
    isolated_atom_energy1 = pseudopotentials[element1]['total_psenergy'] * 13.605693
    isolated_atom_energy2 = pseudopotentials[element2]['total_psenergy'] * 13.605693
    
    volumes_per_atom = []
    energies_per_atom = []
    cohesive_energies_per_atom = []

    tries = 0
    #npoints = 11 # >= 5, 11, 17, 25, or 31, etc (Recommend >= 11)
    for scale in np.linspace((1.0-0.24)**(1/3), (1.0+0.24)**(1/3), npoints):
    #for scale in np.linspace((1.0-0.24)**(1/3), (1.0+0.24)**(1/3), 25):
    #for scale in np.linspace((1.0-0.30)**(1/3), (1.0+0.42)**(1/3), 37):
    #for scale in np.linspace((1.0-0.40)**(1/3), (1.0+0.56)**(1/3), 45):
    #for scale in np.linspace((1.0-0.40)**(1/3), (1.0+0.56)**(1/3), npoints):
        tries += 1
        atoms.set_cell([scale * optimized_a] * 3, scale_atoms=True)

        input_data['control']['calculation'] = 'scf'
        calc = Espresso(pseudopotentials=pseudopotentials_dict, input_data=input_data, kpts=(kpt, kpt, kpt), omp_num_threads=omp_num_threads, mpi_num_procs=mpi_num_procs)
        atoms.set_calculator(calc)

        volumes.append(atoms.get_volume())
        energies.append(atoms.get_total_energy())

        cohesive_energy = -(atoms.get_total_energy() - isolated_atom_energy1*Nelem1 - isolated_atom_energy2*Nelem2)
        cohesive_energies.append(cohesive_energy)
        
        volume = atoms.get_volume()
        volumes_per_atom.append(volume/len(atoms))
        print(f"       check volume: QE {volume/len(atoms)} vs. input {(scale * optimized_a)**3/len(atoms)}")
        
        energies_per_atom.append(atoms.get_total_energy()/len(atoms))
        cohesive_energies_per_atom.append(cohesive_energy/len(atoms))

        stress_tensor.append((calc.get_stress() * 160.21766208).tolist())
        
        forces.append(calc.get_forces().tolist())
        
        print(f"{tries}/{npoints}, Volume = {volume/len(atoms)} [A^3/atom], Cohesive_energy = {cohesive_energy/len(atoms)} [eV/atom]")
        print("-------------------------------------------------------------------------------------")

    # eos: sjeos, taylor, murnaghan, birch, birchmurnaghan, pouriertarantola, vinet, antonschmidt, p3
    eos = EquationOfState(volumes_per_atom, [energy * -1.0 for energy in cohesive_energies_per_atom], eos='murnaghan')
    try:
        v0, e0, B = eos.fit()
        print(B / kJ * 1.0e24, 'GPa')
        # Clear the previous plot
        plt.clf()
        eos.plot('results_PBEsol/'+lattce+'-'+element1+'-'+element2+'_eos.png')
    except ValueError as e:
        print(f"Error fitting EOS: {e}")
    
    cohesive_energy_per_atom = e0 * -1.0
    optimized_a = (v0 * len(atoms))**(1/3)
    nearest_neighbor_distance = optimized_a / re2a
    
    #alpha = (9.0*B*((nearest_neighbor_distance*re2a)**3/len(atoms))/cohesive_energy_per_atom)**0.5
    alpha = (9.0*B*v0/(e0*-1.0))**0.5
    
    # d = a3 = attrac = repuls
    repuls_fit, attrac_fit = fit_rose_curve(volumes_per_atom, cohesive_energies_per_atom, alpha, v0, (e0*-1.0))
    print(f"Fitted parameter: repuls = {repuls_fit}, attrac = {attrac_fit}")
    # Save the plot as PNG
    plt.savefig('results_PBEsol/'+lattce+'-'+element1+'-'+element2+'_rose_curve_fit.png')
    
    #print("---------------------------------")
    #print("initial stress tensor calculation")
    #input_data['control']['calculation'] = 'scf'
    #a = optimized_a
    #atoms.set_cell([a, a, a], scale_atoms=True)
    #atoms.set_calculator(calc)
    #input_data['control']['calculation'] = 'relax'
    #elastic_constants_final = calculate_elastic_constants(atoms, calc, [-0.01, 0.01], [-0.01, 0.01])
    ##elastic_constants_final = calculate_elastic_constants(atoms, calc, [-0.005, 0.005], [-0.005, 0.005])
    
    return {
        'Element1': element1,
        'Element2': element2,
        'Lattice Type': lattice_type,
        'Cohesive Energy (eV/atom)': cohesive_energy_per_atom,
        'Nearest Neighbor Distance (A)': nearest_neighbor_distance,
        'alpha': alpha,
        'repuls': repuls_fit, # d = a3 = repuls, astar <  0
        'attrac': attrac_fit, # d = a3 = attrac, astar >= 0
        #----------------------------------------------------------
        'Atoms': len(atoms),
        'Lattice Constant (A)': optimized_a,
        'Volumes (A^3)': volumes,
        'Energies (eV)': energies,
        'Cohesive Energies (eV)': cohesive_energies,
        #----------------------------------------------------------
        'Bulk Modulus (GPa)': B / kJ * 1.0e24,
        #'Elastic Constants (GPa)': elastic_constants_final,
        #----------------------------------------------------------
        'Stress Tensor per Volume (GPa)': stress_tensor,
        'Forces (eV/A)': forces
    }



# Process the combinations sequentially and store results
for i, combination in enumerate(element_combinations):

    directory = f'results_PBEsol'
    if not os.path.exists(directory):
        os.makedirs(directory)

    results = []
    result = calculate_properties(combination, omp_num_threads, mpi_num_procs, max_retries, lattce, lat, npoints)
    results.append(result)
    element1, element2 = combination

    with open(f'{directory}/{lattce}_{element1}-{element2}.json', 'a') as jsonfile:
        json.dump(result, jsonfile, indent=4)
        jsonfile.write('\n')

    with open(f'results_{lattce}.csv', 'a', newline='') as csvfile:
        fieldnames = ['Element1', 'Element2', 
                      #----------------------------------------------------------
                      'lattce',
                      'Ec', 
                      're', 
                      'alpha',
                      'repuls', 'attrac', 
                      #----------------------------------------------------------
                      'Atoms', 
                      'Lattice Type',
                      'Lattice Constant (A)', 'Volumes (A^3)', 
                      'Energies (eV)', 'Cohesive Energies (eV)', 
                      'Bulk Modulus (GPa)', 
                      #'C11', 'C12', 'C22', 'C33', 'C23', 'C13', 'C44', 'C55', 'C66', 
                      'Stress Tensor per Volume (GPa)',
                      'Forces (eV/A)']

        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

        if i == 0:
            writer.writeheader()

        writer.writerow({
            'Element1': result['Element1'],
            'Element2': result['Element2'],
            #----------------------------------------------------------
            'lattce': lattce,
            'Ec': result['Cohesive Energy (eV/atom)'],
            're': result['Nearest Neighbor Distance (A)'],
            'alpha': result['alpha'],
            'repuls': result['repuls'],
            'attrac': result['attrac'],
            #----------------------------------------------------------
            'Atoms': result['Atoms'],
            'Lattice Type': result['Lattice Type'],
            'Lattice Constant (A)': result['Lattice Constant (A)'],
            'Volumes (A^3)': result['Volumes (A^3)'],
            'Energies (eV)': result['Energies (eV)'],
            'Cohesive Energies (eV)': result['Cohesive Energies (eV)'],
            #-----------------------------------------------
            'Bulk Modulus (GPa)': result['Bulk Modulus (GPa)'],
            #'C11': result['Elastic Constants (GPa)']['C11'],
            #'C12': result['Elastic Constants (GPa)']['C12'],
            #'C22': result['Elastic Constants (GPa)']['C22'],
            #'C33': result['Elastic Constants (GPa)']['C33'],
            #'C23': result['Elastic Constants (GPa)']['C23'],
            #'C13': result['Elastic Constants (GPa)']['C13'],
            #'C44': result['Elastic Constants (GPa)']['C44'],
            #'C55': result['Elastic Constants (GPa)']['C55'],
            #'C66': result['Elastic Constants (GPa)']['C66'],
            #-----------------------------------------------
            'Stress Tensor per Volume (GPa)': result['Stress Tensor per Volume (GPa)'],
            'Forces (eV/A)': result['Forces (eV/A)']
        })
    
    # Generate the potfit text file output for each volume and cohesive energy
    natoms = result['Atoms']
    for idx, (volume, cohesive_energy, stress, force) in enumerate(zip(result['Volumes (A^3)'], result['Cohesive Energies (eV)'], result['Stress Tensor per Volume (GPa)'], result['Forces (eV/A)'])):
        # Calculate the lattice constant 'a' from the volume for BCC structure
        a = (volume) ** (1/3)
        
        with open(f'{directory}/MPCv4_{element1}-{element2}-DFT_{lattce}', 'a') as mpcfile:
           mpcfile.write(f"{volume}  {cohesive_energy*-1.0}\n")
        
        if lattce == 'b1':
           print(f"{idx}: Create the FCC B1 (NaCl-type) structure")
           positions=[(0, 0, 0), (0.5*a, 0.5*a, 0), (0.5*a, 0, 0.5*a), (0, 0.5*a, 0.5*a), 
                      (0.5*a, 0.5*a, 0.5*a), (0, 0.5*a, 0), (0.5*a, 0, 0), (0, 0, 0.5*a)]
           types=[0,0,0,0,1,1,1,1]
        elif lattce == 'b2':
           print(f"{idx}: Create the BCC B2 (CsCl-type) structure")
           positions=[(0, 0, 0), (0.5*a, 0.5*a, 0.5*a)]
           types=[0,1]
        elif lattce == 'dia':
           print(f"{idx}: Create the Diamond B3 (Zinc Blende) structure")
           '''
           # conventional cell
           positions=[(0, 0, 0), (0.5*a, 0.5*a, 0), (0.5*a, 0, 0.5*a), (0, 0.5*a, 0.5*a), 
                      (0.25*a, 0.75*a, 0.75*a), (0.25*a, 0.25*a, 0.25*a), (0.75*a, 0.75*a, 0.25*a), 
                      (0.75*a, 0.25*a, 0.75*a)]
           types=[0,0,0,0,1,1,1,1]
           '''
           # primitive cell
           positions=[(0, 0, 0), (0.25*a, 0.25*a, 0.25*a)]
           types=[0,1]
        elif lattce == 'l12':
           print(f"{idx}: Create the L12 (Cu3Au-type) structure")
           positions=[(0, 0.5*a, 0.5*a), (0.5*a, 0, 0.5*a), (0.5*a, 0.5*a, 0), 
                      (0, 0, 0)]
           types=[0,0,0,1]
        else:
           print(f"{idx}: This code does not provide other structures. (Possible structures: b1, b2, dia, l12)")
        
        # xyz_array = [[pos[0], pos[1], pos[2]] for pos in positions]
        x_coords = [pos[0] for pos in positions]
        y_coords = [pos[1] for pos in positions]
        z_coords = [pos[2] for pos in positions]
        
        with open(f'{directory}/potfit_{lattce}_{element1}-{element2}.config', 'a') as txtfile:
            txtfile.write(f"#N {natoms} 1\n")
            txtfile.write(f"#C {element1} {element2}\n")
            txtfile.write(f"## force file generated from file espresso.pwo\n")
            txtfile.write(f"#X {a}  0.000000000000000  0.000000000000000\n")
            txtfile.write(f"#Y 0.000000000000000  {a}  0.000000000000000\n")
            txtfile.write(f"#Z 0.000000000000000  0.000000000000000  {a}\n")
            txtfile.write(f"#W 1.000000\n")
            txtfile.write(f"#E {cohesive_energy*-1.0}\n")
            # https://databases.fysik.dtu.dk/ase/_modules/ase/io/espresso.html
            # stress = np.array([sxx, syy, szz, syz, sxz, sxy], dtype=float)
            txtfile.write(f"## stress_xx stress_yy stress_zz stress_xy stress_yz stress_xz\n")
            txtfile.write(f"#S {stress[0]}  {stress[1]}  {stress[2]}  {stress[5]}  {stress[3]}  {stress[4]}\n")
            txtfile.write(f"## type x y z f_x f_y f_z\n")
            txtfile.write(f"#F\n")
            for i in range(natoms):
                #txtfile.write(f"{types[i]}  {xyz_array[i][0]}  {xyz_array[i][1]}  {xyz_array[i][2]}  {force[i][0]}  {force[i][1]}  {force[i][2]}\n")
                txtfile.write(f"{types[i]}  {x_coords[i]}  {y_coords[i]}  {z_coords[i]}  {force[i][0]}  {force[i][1]}  {force[i][2]}\n")

    print(f"----------------------------------------------------------------------")
    print(f"Processed combination {i+1}/{len(element_combinations)}: {combination}")

print(f"Calculations are complete and results are saved to results_{lattce}.json and results_{lattce}.csv.")
