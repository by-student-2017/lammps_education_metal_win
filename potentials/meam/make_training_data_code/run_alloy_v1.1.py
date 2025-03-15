import json
import csv
from itertools import combinations
from ase import Atoms
from ase.calculators.espresso import Espresso
from ase.optimize import BFGS
from ase.eos import EquationOfState
from ase.units import Bohr, Rydberg, kJ, kB, fs, Hartree, mol, kcal
from ase.dft.kpoints import monkhorst_pack
import numpy as np
import os

# For Rose universal function
from scipy.optimize import curve_fit
from scipy.optimize import fsolve
import matplotlib.pyplot as plt

# For bader analysis (charge)
import xml.etree.ElementTree as ET

# For error
from datetime import datetime
with open("error_log.txt","a") as file:
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    file.write(f"#------------------------------------------------------------------\n")
    file.write(f"[{timestamp}]\n")

# For clear memory (use gc.collect())
import gc

#from mpi4py import MPI
#comm = MPI.COMM_WORLD
#rank = comm.Get_rank()
#size = comm.Get_size()

#----------------------------------------------------------------------------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------------------------------------------------------------------------
# User input section
#------------------------------------------------------------------
# b1: FCC_B1 (NaCl-type), b2:BCC_B2 (CsCl-type), dia:Diamond_B3 (Zinc Blende), l12: L12 (Cu3Au-type)
lattce = 'b1'
#lattce = 'XXXXXXXXXX' # for run_seq.py
#------------------------------------------------------------------
# lattice structure of reference configuration [Angstrom] (https://en.wikipedia.org/wiki/Lattice_constant)
lat = ''     # In the case of '', the sum of covalent_radii (sum of concentration ratio in L12)
#lat = 4.046 # Al FCC (e.g., for L12 calculation of Al-base)
#lat = 3.502 # Fe BCC (e.g., for BCC_B2 calculation of Fe-base)
#lat = 5.431 # Si Diamond (e.g., for dia calculation)
#lat = 5.640 # NaCl (e.g., FCC_B1 calculation)
#----------------------------
# making number of data (If the bulk modulus is approximately +/- 0.5 GPa or less, 11 points will suffice. However, for a3, 25 points or more is recommended to keep the accuracy at around +/- 0.005 or less.)
npoints = 7 # >= 7 e.g., 7, 11, 17, 21, or 25, etc (Recommend >= 25), (default = 25) (SSSP: 7 points) (7 points:0.02 step, other:0.01 step)
#------------------------------------------------------------------
fixed_element = 'Cu'
elements = [fixed_element,
             'H', 'He',
            'Li', 'Be',  'B',  'C',  'N',  'O',  'F', 'Ne', 
            'Na', 'Mg', 'Al', 'Si',  'P',  'S', 'Cl', 'Ar',
             'K', 'Ca', 'Sc', 'Ti',  'V', 'Cr', 'Mn', 'Fe', 'Co', 'Ni', 'Cu', 'Zn', 'Ga', 'Ge', 'As', 'Se', 'Br', 'Kr',
            'Rb', 'Sr',  'Y', 'Zr', 'Nb', 'Mo', 'Tc', 'Ru', 'Rh', 'Pd', 'Ag', 'Cd', 'In', 'Sn', 'Sb', 'Te',  'I', 'Xe',
            'Cs', 'Ba', 'La', 'Ce', 'Pr', 'Nd', 'Pm', 'Sm', 'Eu', 'Gd', 'Tb', 'Dy', 'Ho', 'Er', 'Tm', 'Yb', 'Lu', 
            'Hf', 'Ta',  'W', 'Re', 'Os', 'Ir', 'Pt', 'Au', 'Hg', 'Tl', 'Pb', 'Bi', 'Po', 'At', 'Ra',
            'Rn', 'Fr', 'Ac', 'Th', 'Pa',  'U', 'Np', 'Pu'] # <- Enter the element you want to calculate (Note: Time Consumption: Approx. 4 elements/hour)
#elements = [fixed_element, 'Ce', 'Pr', 'Nd', 'Pm', 'Sm', 'Eu', 'Gd', 'Tb', 'Dy', 'Ho', 'Er', 'Tm', 'Yb', 'Lu'] # Pairs with noble gases require careful calculations and must be calculated separately.
#elements = [fixed_element, 'Po', 'At', 'Ra', 'Rn', 'Fr', 'Ac', 'Th', 'Pa',  'U', 'Np', 'Pu'] # Pairs with noble gases require careful calculations and must be calculated separately.
#elements = [fixed_element, 'He', 'Ne', 'Ar', 'Kr', 'Xe', 'Ra'] # Pairs with noble gases require careful calculations and must be calculated separately.
'''
elements = [fixed_element,
             'H', 'He',
            'Li', 'Be',  'B',  'C',  'N',  'O',  'F', 'Ne', 
            'Na', 'Mg', 'Al', 'Si',  'P',  'S', 'Cl', 'Ar',
             'K', 'Ca', 'Sc', 'Ti',  'V', 'Cr', 'Mn', 'Fe', 'Co', 'Ni', 'Cu', 'Zn', 'Ga', 'Ge', 'As', 'Se', 'Br', 'Kr',
            'Rb', 'Sr',  'Y', 'Zr', 'Nb', 'Mo', 'Tc', 'Ru', 'Rh', 'Pd', 'Ag', 'Cd', 'In', 'Sn', 'Sb', 'Te',  'I', 'Xe',
            'Cs', 'Ba', 'La', 'Ce', 'Pr', 'Nd', 'Pm', 'Sm', 'Eu', 'Gd', 'Tb', 'Dy', 'Ho', 'Er', 'Tm', 'Yb', 'Lu', 
            'Hf', 'Ta',  'W', 'Re', 'Os', 'Ir', 'Pt', 'Au', 'Hg', 'Tl', 'Pb', 'Bi', 'Po', 'At', 'Ra',
            'Rn', 'Fr', 'Ac', 'Th', 'Pa',  'U', 'Np', 'Pu'] # <- Enter the element you want to calculate (Note: Time Consumption: Approx. 4 elements/hour)
'''
element_combinations = [(fixed_element, element) for element in elements if element != fixed_element]
#----------------------------
# Get all combinations of elements
#elements = list(pseudopotentials.keys())
#elements = ['Fe', 'Cr']
#element_combinations = list(combinations(elements, 2))
#------------------------------------------------------------------
cutoff = 0 # [eV], 0:read PP file, (520 eV is the main in the Materials Project, except Boron (700 eV)), negative value (< 0): 520 eV
#------------------------------------------------------------------
# Note: In the field of phonons, the accuracy of lattice constant prediction is important, so PBEsol is generally used. 
# However, since there are elements for which calculations do not go well, we recommend using PBE, which has been extensively verified as a database.
PBEsol_flag = 0 # 0:PBE, 1:PBEsol, (default = 0)
# Load the pseudopotential data from the JSON file
if PBEsol_flag == 0:
    #with open('PBE/PSlibrary_PBE.json', 'r') as f:
    with open('PBE/PSlibrary_ONCV_GBRV_mix_PBE.json', 'r') as f:
    #with open('PBE/SSSP-1.3.0_PBE_efficiency.json', 'r') as f:
    #with open('PBE/SSSP-1.3.0_PBE_precision.json', 'r') as f:
        pseudopotentials = json.load(f)
else:
    #with open('PBEsol/PSlibrary_PBEsol.json', 'r') as f:
    with open('PBEsol/PSlibrary_ONCV_GBRV_mix_PBEsol.json', 'r') as f:
    #with open('PBEsol/SSSP-1.3.0_PBEsol_efficiency.json', 'r') as f:
    #with open('PBEsol/SSSP-1.3.0_PBEsol_precision.json', 'r') as f:
        pseudopotentials = json.load(f)
#------------------------------------------------------------------
D_flag = 0 # 0:non-dispersion (non-vdW), 1:DFT-D2, 2: DFT-D3 (no three-body), 3: DFT-D3, (default: 1) (Fr-Pu: 0, 2, or 3)
#------------------------------------------------------------------
spin_flag = 1 # 0:non-spin, 1:spin, (default = 1)
#------------------------------------------------------------------
# Set the number of OpenMP/MPI settings (This is not working.)
mpi_num_procs = 8 # Test CPU: 12th Gen Intel(R) Core(TM) i7-12700
omp_num_threads = 1
os.environ['OMP_NUM_THREADS'] = f'{omp_num_threads}'
#------------------------------------------------------------------
primitive_flag = 1 # 0:conventional cell, 1:primitive cell, (default = 1)
#------------------------------------------------------------------
# max number of cycles for search optimized structure
max_retries = 100 # default = 100
#------------------------------------------------------------------
#Acceptable_values = 0.05 # calculate r at -Ec*Acceptable_values
#------------------------------------------------------------------
# User input section: END
#----------------------------------------------------------------------------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------------------------------------------------------------------------

# Define covalent radii for elements (in angstroms)
covalent_radii = {
     "H": 0.31, "He": 0.28, "Li": 1.28, "Be": 0.96,  "B": 0.84,  "C": 0.76,  "N": 0.71,  "O": 0.66,  "F": 0.57, "Ne": 0.58,
    "Na": 1.66, "Mg": 1.41, "Al": 1.21, "Si": 1.11,  "P": 1.07,  "S": 1.05, "Cl": 1.02, "Ar": 1.06,  "K": 2.03, "Ca": 1.76,
    "Sc": 1.70, "Ti": 1.60,  "V": 1.53, "Cr": 1.39, "Mn": 1.39, "Fe": 1.32, "Co": 1.26, "Ni": 1.24, "Cu": 1.32, "Zn": 1.22,
    "Ga": 1.22, "Ge": 1.20, "As": 1.19, "Se": 1.20, "Br": 1.20, "Kr": 1.16, "Rb": 2.20, "Sr": 1.95,  "Y": 1.90, "Zr": 1.75,
    "Nb": 1.64, "Mo": 1.54, "Tc": 1.47, "Ru": 1.46, "Rh": 1.42, "Pd": 1.39, "Ag": 1.45, "Cd": 1.44, "In": 1.42, "Sn": 1.39,
    "Sb": 1.39, "Te": 1.38,  "I": 1.39, "Xe": 1.40, "Cs": 2.44, "Ba": 2.15, "La": 2.07, "Ce": 2.04, "Pr": 2.03, "Nd": 2.01,
    "Pm": 1.99, "Sm": 1.98, "Eu": 1.98, "Gd": 1.96, "Tb": 1.94, "Dy": 1.92, "Ho": 1.92, "Er": 1.89, "Tm": 1.90, "Yb": 1.87,
    "Lu": 1.87, "Hf": 1.75, "Ta": 1.70,  "W": 1.62, "Re": 1.51, "Os": 1.44, "Ir": 1.41, "Pt": 1.36, "Au": 1.36, "Hg": 1.32,
    "Tl": 1.45, "Pb": 1.46, "Bi": 1.48, "Po": 1.40, "At": 1.50, "Rn": 1.50, "Fr": 2.60, "Ra": 2.21, "Ac": 2.15, "Th": 2.06,
    "Pa": 2.00,  "U": 1.96, "Np": 1.90, "Pu": 1.87
}

# Define atomic radii for elements (in angstroms)
atomic_radii = {
     "H": 0.53, "He": 0.31, "Li": 1.67, "Be": 1.12,  "B": 0.87,  "C": 0.67,  "N": 0.56,  "O": 0.48,  "F": 0.42, "Ne": 0.38,
    "Na": 1.90, "Mg": 1.45, "Al": 1.18, "Si": 1.11,  "P": 0.98,  "S": 0.88, "Cl": 0.79, "Ar": 0.71,  "K": 2.43, "Ca": 1.94,
    "Sc": 1.84, "Ti": 1.76,  "V": 1.71, "Cr": 1.66, "Mn": 1.61, "Fe": 1.56, "Co": 1.52, "Ni": 1.49, "Cu": 1.45, "Zn": 1.42,
    "Ga": 1.36, "Ge": 1.25, "As": 1.14, "Se": 1.03, "Br": 0.94, "Kr": 0.88, "Rb": 2.65, "Sr": 2.19,  "Y": 2.12, "Zr": 2.06,
    "Nb": 1.98, "Mo": 1.90, "Tc": 1.83, "Ru": 1.78, "Rh": 1.73, "Pd": 1.69, "Ag": 1.65, "Cd": 1.61, "In": 1.56, "Sn": 1.45,
    "Sb": 1.33, "Te": 1.23,  "I": 1.15, "Xe": 1.08, "Cs": 2.98, "Ba": 2.53, "La": 2.15, "Ce": 2.04, "Pr": 2.03, "Nd": 2.01,
    "Pm": 2.00, "Sm": 1.98, "Eu": 1.98, "Gd": 1.96, "Tb": 1.94, "Dy": 1.92, "Ho": 1.92, "Er": 1.89, "Tm": 1.90, "Yb": 1.87,
    "Lu": 1.87, "Hf": 1.75, "Ta": 1.70,  "W": 1.62, "Re": 1.51, "Os": 1.44, "Ir": 1.41, "Pt": 1.36, "Au": 1.36, "Hg": 1.32,
    "Tl": 1.70, "Pb": 2.02, "Bi": 2.07, "Po": 1.40, "At": 1.50, "Rn": 1.50, "Fr": 2.60, "Ra": 2.21, "Ac": 2.15, "Th": 2.06,
    "Pa": 2.00,  "U": 1.96, "Np": 1.90, "Pu": 1.87, "XX": 2.00
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


def binary_search(original_cell, atoms, calc, scaling_factor, dsfactor, best_energy):
    scaling_factor += dsfactor/2.0
    scaled_cell = original_cell * scaling_factor
    atoms.set_cell(scaled_cell, scale_atoms=True)
    atoms.set_calculator(calc)
    energy = atoms.get_total_energy()
    if best_energy < energy:
        scaling_factor -= dsfactor
        scaled_cell = original_cell * scaling_factor
        atoms.set_cell(scaled_cell, scale_atoms=True)
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



# Function to extract valence electron count from pseudopotential file
def get_valence_electrons(pseudo_file):
    tree = ET.parse(pseudo_file)
    root = tree.getroot()
    pp_header = root.find('.//PP_HEADER')
    if pp_header is not None:
        z_valence = pp_header.get('z_valence')
        if z_valence is not None:
            try:
                return float(z_valence)
            except ValueError:
                pass
    return None



def update_prefix_in_file(filename, new_prefix):
    with open(filename, 'r') as file:
        lines = file.readlines()
    
    with open(filename, 'w') as file:
        for line in lines:
            if line.strip().startswith('prefix'):
                file.write(f"    prefix  = 'out/{new_prefix}'\n")
            else:
                file.write(line)



def read_bader_charges(filename='ACF.dat'):
    charges = []
    with open(filename, 'r') as f:
        lines = f.readlines()[2:-4]
        for line in lines:
            charges.append(float(line.split()[4]))
    return charges



def fit_rose_curve_erose_form_0(volumes_per_atom, cohesive_energies_per_atom, alpha, V0, Ec, nearest_neighbor_distance):
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
        return -Ec * (1 + astar + a3 * (astar**3)/(V/V0)**(1/3)) * np.exp(-astar)
    
    # Fitting the parameters repuls and attrac
    try:
        popt, _ = curve_fit(lambda V, repuls, attrac: rose_curve(V, alpha, V0, Ec, repuls, attrac), 
                            volumes_per_atom, E_data, p0=[0.0, 0.0])  # Initial guesses for repuls and attrac
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
        with open("error_log.txt", "a") as file:
                file.write(f"An unexpected error occurred: {e} at fit_rose_curve_erose_form_0 \n")
        repuls_fit = attrac_fit = None
        return repuls_fit, attrac_fit
    
    # Fitted parameters
    repuls_fit, attrac_fit = popt
    
    # Calculating rc from EOS
    Acceptable_values = 0.05 # -Ec*{Acceptable_values}
    def equation(astar, d):
        return (1 + astar + d * (astar**3)/((astar+1.0)/alpha)) * np.exp(-astar) - Acceptable_values
    astar = alpha*(4.0/nearest_neighbor_distance - 1.0)
    initial_guess = astar
    solution = fsolve(equation, initial_guess, args=(attrac_fit))
    astar = solution[0]
    rc = (astar+1.0)*nearest_neighbor_distance/alpha
    print(f"[erose_form = 0]: rc = {rc} at -Ec*{Acceptable_values}")
    
    # Plotting the fit
    plt.figure()
    plt.scatter(volumes_per_atom, E_data, label='DFT Data (QE)')
    plt.plot(volumes_per_atom, rose_curve(volumes_per_atom, alpha, V0, Ec, repuls_fit, attrac_fit), 
             label=f'Fit (repuls={repuls_fit:.4f}, attrac={attrac_fit:.4f}), r={rc:.2f}@Ec{Acceptable_values*100.0:.1f}%', color='red')
    #----------
    solution = fsolve(equation, initial_guess, args=(0.00))
    astar = solution[0]
    rc = (astar+1.0)*nearest_neighbor_distance/alpha
    if repuls_fit < 0.0:
        plt.plot(volumes_per_atom, rose_curve(volumes_per_atom, alpha, V0, Ec, 0, 0), 
             label=f'Fit (repuls=0, attrac=0), r={rc:.2f}@Ec{Acceptable_values*100.0:.1f}%', color='blue')
    else:
        plt.plot(volumes_per_atom, rose_curve(volumes_per_atom, alpha, V0, Ec, repuls_fit, 0), 
             label=f'Fit (repuls={repuls_fit:.4f}, attrac=0), r={rc:.2f}@Ec{Acceptable_values*100.0:.1f}%', color='blue')
    #----------
    solution = fsolve(equation, initial_guess, args=(0.05))
    astar = solution[0]
    rc = (astar+1.0)*nearest_neighbor_distance/alpha
    plt.plot(volumes_per_atom, rose_curve(volumes_per_atom, alpha, V0, Ec, 0.05, 0.05), 
             label=f'Fit (repuls=0.05, attrac=0.05), r={rc:.2f}@Ec{Acceptable_values*100.0:.1f}%', color='green')
    plt.xlabel('Volume, V (A^3/atom)')
    plt.ylabel('Cohesive Energy, -Ec (eV/atom)')
    plt.legend()
    plt.title('Modified Rose energy function (erose_form = 0) Fit to DFT Data')
    
    # Save the plot as PNG
    #plt.savefig('rose_curve_fit.png')
    
    return repuls_fit, attrac_fit



def fit_rose_curve_erose_form_1(volumes_per_atom, cohesive_energies_per_atom, alpha, V0, Ec, nearest_neighbor_distance):
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
    def rose_curve(V, alpha, V0, Ec, repuls, attrac, nearest_neighbor_distance):
        astar = alpha * ((V/V0)**(1/3) - 1.0)
        r = nearest_neighbor_distance * (V/V0)**(1/3)
        return -Ec * (1 + astar + (-attrac+repuls/r)*(astar**3)) * np.exp(-astar)
    
    # Fitting the parameters repuls and attrac
    try:
        popt, _ = curve_fit(lambda V, repuls, attrac: rose_curve(V, alpha, V0, Ec, repuls, attrac, nearest_neighbor_distance), 
                            volumes_per_atom, E_data, p0=[0.0, 0.0])  # Initial guesses for repuls and attrac
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
        with open("error_log.txt", "a") as file:
            file.write(f"An unexpected error occurred: {e} at fit_rose_curve_erose_form_1 \n")
        repuls_fit = attrac_fit = None
        return repuls_fit, attrac_fit
    
    # Fitted parameters
    repuls_fit, attrac_fit = popt
    
    # Plotting the fit
    plt.figure()
    plt.scatter(volumes_per_atom, E_data, label='DFT Data (QE)')
    plt.plot(volumes_per_atom, rose_curve(volumes_per_atom, alpha, V0, Ec, repuls_fit, attrac_fit, nearest_neighbor_distance), 
             label=f'Fit (repuls={repuls_fit:.4f}, attrac={attrac_fit:.4f}), r={repuls_fit/attrac_fit:.2f})', color='red')
    plt.plot(volumes_per_atom, rose_curve(volumes_per_atom, alpha, V0, Ec, 0, 0, nearest_neighbor_distance),  
             label=f'Fit (repuls=0, attrac=0)', color='blue')
    plt.plot(volumes_per_atom, rose_curve(volumes_per_atom, alpha, V0, Ec, 0.20, 0.05, nearest_neighbor_distance),  
             label=f'Fit (repuls=0.20, attrac=0.05), r=4.0', color='green')
    plt.xlabel('Volume, V (A^3/atom)')
    plt.ylabel('Cohesive Energy, -Ec (eV/atom)')
    plt.legend()
    plt.title('Modified Rose energy function (erose_form = 1) Fit to DFT Data')
    
    # Save the plot as PNG
    #plt.savefig('rose_curve_fit.png')
    
    return repuls_fit, attrac_fit



def fit_rose_curve_erose_form_2(volumes_per_atom, cohesive_energies_per_atom, alpha, V0, Ec, nearest_neighbor_distance):
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
    try:
        popt, _ = curve_fit(lambda V, repuls, attrac: rose_curve(V, alpha, V0, Ec, repuls, attrac), 
                            volumes_per_atom, E_data, p0=[0.0, 0.0])  # Initial guesses for repuls and attrac
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
        with open("error_log.txt", "a") as file:
            file.write(f"An unexpected error occurred: {e} at fit_rose_curve_erose_form_2 \n")
        repuls_fit = attrac_fit = None
        return repuls_fit, attrac_fit
    
    # Fitted parameters
    repuls_fit, attrac_fit = popt
    
    # Calculating rc from EOS
    Acceptable_values = 0.05 # -Ec*{Acceptable_values}
    def equation(astar, d):
        return (1 + astar + d * (astar**3)) * np.exp(-astar) - Acceptable_values
    astar = alpha*(4.0/nearest_neighbor_distance - 1.0)
    initial_guess = astar
    solution = fsolve(equation, initial_guess, args=(attrac_fit))
    astar = solution[0]
    rc = (astar+1.0)*nearest_neighbor_distance/alpha
    print(f"[erose_form = 2]: rc = {rc} at -Ec*{Acceptable_values}")
    
    # Plotting the fit
    plt.figure()
    plt.scatter(volumes_per_atom, E_data, label='DFT Data (QE)')
    plt.plot(volumes_per_atom, rose_curve(volumes_per_atom, alpha, V0, Ec, repuls_fit, attrac_fit), 
             label=f'Fit (repuls={repuls_fit:.4f}, attrac={attrac_fit:.4f}), r={rc:.2f}@Ec{Acceptable_values*100.0:.1f}%', color='red')
    #----------
    solution = fsolve(equation, initial_guess, args=(0.00))
    astar = solution[0]
    rc = (astar+1.0)*nearest_neighbor_distance/alpha
    if repuls_fit < 0.0:
        plt.plot(volumes_per_atom, rose_curve(volumes_per_atom, alpha, V0, Ec, 0, 0), 
             label=f'Fit (repuls=0, attrac=0), r={rc:.2f}', color='blue')
    else:
        plt.plot(volumes_per_atom, rose_curve(volumes_per_atom, alpha, V0, Ec, repuls_fit, 0), 
             label=f'Fit (repuls={repuls_fit:.4f}, attrac=0), r={rc:.2f}@Ec{Acceptable_values*100.0:.1f}%', color='blue')
    #----------
    solution = fsolve(equation, initial_guess, args=(0.05))
    astar = solution[0]
    rc = (astar+1.0)*nearest_neighbor_distance/alpha
    plt.plot(volumes_per_atom, rose_curve(volumes_per_atom, alpha, V0, Ec, 0.05, 0.05), 
             label=f'Fit (repuls=0.05, attrac=0.05), r={rc:.2f}@Ec{Acceptable_values*100.0:.1f}%', color='green')
    plt.xlabel('Volume, V (A^3/atom)')
    plt.ylabel('Cohesive Energy, -Ec (eV/atom)')
    plt.legend()
    plt.title('Modified Rose energy function (erose_form = 2) Fit to DFT Data')
    
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



def calculate_properties(elements_combination, omp_num_threads, mpi_num_procs, max_retries=100, lattce='', lat='', npoints=25, primitive_flag=1, PBEsol_flag=0, spin_flag=1, D_flag=1, cutoff=520):
    element1, element2 = elements_combination
    
    print(f"{element1}-{element2} pair, lattce = {lattce}")
    
    #radius1 = atomic_radii[element1]
    #radius2 = atomic_radii[element2]
    #
    #radius1 = vdw_radii[element1]
    #radius2 = vdw_radii[element2]
    #
    radius1 = covalent_radii[element1]
    radius2 = covalent_radii[element2]
    
    if lat == '':
        if lattce == 'l12':
            re = (radius1*3/2 + radius2/2) # The reason for this is based on Vegard's law.
            print(f'Start Nearest Neighbor Distance, re = (radius1*3/2 + radius2/2) = {re} [A]')
        else:
            re = (radius1 + radius2)
            print(f'Start Nearest Neighbor Distance, re = (radius1 + radius2) = {re} [A]')
    
    #primitive_flag == 1 # 0:conventional cell, 1:primitive cell
    if lattce == 'b1':
        print("Create the FCC B1 (NaCl-type) structure")
        lattice_type = 'FCC_B1 (NaCl-type)'
        re2a = 2.0
        if not lat == '':
            re = lat / re2a
        a = re * re2a
        if primitive_flag == 0:
              print("# conventional cell")
              atoms = Atoms(f'{element1}4{element2}4', 
                    positions=[(0, 0, 0), (0.5*a, 0.5*a, 0), (0.5*a, 0, 0.5*a), (0, 0.5*a, 0.5*a), 
                               (0.5*a, 0.5*a, 0.5*a), (0, 0.5*a, 0), (0.5*a, 0, 0), (0, 0, 0.5*a)], 
                    cell=[a, a, a], 
                    pbc=True)
              #kpt = 3
              kpt = 4
              Nelem1 = 4
              Nelem2 = 4
        else:
              print("# primitive cell")
              atoms = Atoms(f'{element1}{element2}',
                    positions=[(0, 0, 0), 
                               (0.5*a, 0.5*a, 0.5*a)],
                    cell=[[0, 0.5*a, 0.5*a], [0.5*a, 0, 0.5*a], [0.5*a, 0.5*a, 0]],
                    pbc=True)
              kpt = 6 # 4 or 6
              Nelem1 = 1
              Nelem2 = 1
    elif lattce == 'b2':
        print("Create the BCC B2 (CsCl-type) structure")
        lattice_type = 'BCC_B2 (CsCl-type)'
        re2a = 2.0/3.0**0.5
        if not lat == '':
            re = lat / re2a
        a = re * re2a
        atoms = Atoms(f'{element1}{element2}', 
                  positions=[(0, 0, 0), 
                             (0.5*a, 0.5*a, 0.5*a)], 
                  cell=[a, a, a], 
                  pbc=True)
        kpt = 8 # 6 or 8
        Nelem1 = 1
        Nelem2 = 1
    elif lattce == 'dia':
        print("Create the Diamond B3 (Zinc Blende) structure")
        lattice_type = 'DIA_B3 (Zinc Blende)'
        re2a = 4.0/2.0**0.5
        if not lat == '':
            re = lat / re2a
        a = re * re2a
        if primitive_flag == 0:
              print("# conventional cell")
              atoms = Atoms(f'{element1}4{element2}4', 
                    positions=[(0, 0, 0), (0.5*a, 0.5*a, 0), (0.5*a, 0, 0.5*a), (0, 0.5*a, 0.5*a), 
                               (0.25*a, 0.75*a, 0.75*a), (0.25*a, 0.25*a, 0.25*a), (0.75*a, 0.75*a, 0.25*a), 
                               (0.75*a, 0.25*a, 0.75*a)], 
                    cell=[a, a, a], 
                    pbc=True)
              #kpt = 3
              kpt = 4
              Nelem1 = 4
              Nelem2 = 4
        else:
              print("# primitive cell")
              atoms = Atoms(f'{element1}{element2}',
                    positions=[(0, 0, 0), 
                               (0.25*a, 0.25*a, 0.25*a)],
                    cell=[[0, 0.5*a, 0.5*a], [0.5*a, 0, 0.5*a], [0.5*a, 0.5*a, 0]],
                    pbc=True)
              kpt = 6 # 4 or 6
              Nelem1 = 1
              Nelem2 = 1
    elif lattce == 'l12':
        print("Create the L12 (Cu3Au-type) structure")
        lattice_type = 'L12 (Cu3Au-type)'
        re2a = 2.0/2.0**0.5
        if not lat == '':
            re = lat / re2a
        a = re * re2a
        atoms = Atoms(f'{element1}3{element2}', 
              positions=[(0, 0.5*a, 0.5*a), (0.5*a, 0, 0.5*a), (0.5*a, 0.5*a, 0), 
                         (0, 0, 0)], 
              cell=[a, a, a], 
              pbc=True)
        #kpt = 5
        kpt = 6 # 4 or 6
        Nelem1 = 3
        Nelem2 = 1
    else:
        print("This code does not provide other structures. (Possible structures: b1, b2, dia, l12)")
    
    dsfactor = 0.15
    # The minimum setting for a downward convex search is "scaling_factor = 1.0 - dsfactor*1.0".
    scaling_factor = 1.0 - dsfactor*2.0 # Note: stop caluclation at Ga for dsfactor = 0.12 and scaling_factor = 1.0 - dsfactor*3.0.
    
    original_cell = atoms.get_cell()
    scaled_cell = original_cell * scaling_factor
    atoms.set_cell(scaled_cell, scale_atoms=True)
    
    if PBEsol_flag == 0:
        pseudo_dir = './PBE'
    else:
        pseudo_dir = './PBEsol'
        
    if spin_flag == 0:
        nspin = 1
    else:
        nspin = 2

    pseudopotentials_dict = {
        element1: pseudopotentials[element1]['filename'],
        element2: pseudopotentials[element2]['filename']
    }
    input_data = {
        'control': {
            'calculation': 'scf',
            'restart_mode': 'from_scratch',
            'prefix': f'{lattce}_{element1}_{element2}',
            'pseudo_dir': f'{pseudo_dir}',
            'outdir': './out',
            'tprnfor': True, # Forces will be printed
            'tstress': True, # Stress will be printed
            'nstep': 50,   # for MD or structure optimization (default = 50)
            'etot_conv_thr': 1.0e-4*len(atoms), # 1.36 meV/atom <= about 1 meV/atom
            #'forc_conv_thr': 1.0e-3 # dafault value
            'disk_io': 'low', # qe-7.2:'minimal', qe-7.3:'nowf'
        },
        'system': {
            'ecutwfc': max(pseudopotentials[element1]['cutoff_wfc'], pseudopotentials[element2]['cutoff_wfc']),
            'ecutrho': max(pseudopotentials[element1]['cutoff_rho'], pseudopotentials[element2]['cutoff_rho']),
            #'occupations': 'tetrahedra_opt', # L12 A-N is failed
            'occupations': 'smearing',
            #'smearing': 'mp',
            'smearing': 'gauss', # More robust than mp
            #'degauss': 0.01, # 0.01 = about 150 K, 0.01 is better for mp + Equation of states (eos).
            'degauss': 0.02, # 0.02 = about 300 K
            #
            #'vdw_corr': 'dft-d', # DFT-D2 (Semiempirical Grimme's DFT-D2. Optional variables)
            #'vdw_corr': 'dft-d3',
            #'dftd3_version': 3, # 4:Grimme-D3 (BJ damping) or 3:Grimme-D3 (zero damping) (default = 3) (Error: Al-O for 4)
            #'dftd3_threebody': False, # If it is set to True, the calculation will hardly proceed at all.
            #
            ## pseudo-potential: rel-DFT (e.g., rel-pbe or rel-pbesol, etc)
            #'noncolin': True,
            #'lspinorb': True,
        },
        'electrons': {
            'conv_thr': 1.0e-6*len(atoms),
            'electron_maxstep': 100, # default = 100
            'mixing_beta': 0.7,
            'diagonalization': 'rmm-davidson', # 'david' or 'rmm-davidson'
        },
        'ions': {
            'ion_dynamics': 'bfgs',
        },
        'cell': {
            'cell_dynamics': 'bfgs',
        }
    }
    
    if D_flag == 0:
        input_data['system']['vdw_corr'] = 'none'
    elif D_flag == 1:
        input_data['system']['vdw_corr'] = 'dft-d'
    elif D_flag == 2:
        input_data['system']['vdw_corr'] = 'dft-d3'
        input_data['system']['dftd3_threebody'] = False
    elif D_flag == 3:
        input_data['system']['vdw_corr'] = 'dft-d3'
    
    if cutoff == 0:
        pass
    elif cutoff > 0:
        input_data['system']['ecutwfc'] = cutoff/Rydberg
        input_data['system']['ecutrho'] = cutoff*4.0/Rydberg
    else:
        input_data['system']['ecutwfc'] = 520/Rydberg
        input_data['system']['ecutrho'] = 520*4.0/Rydberg
    
    calc = Espresso(pseudopotentials=pseudopotentials_dict, input_data=input_data, kpts=(kpt, kpt, kpt), koffset=True, nspin=nspin, command=f'mpirun -np {mpi_num_procs} pw.x < espresso.pwi > espresso.pwo')
    #calc = Espresso(pseudopotentials=pseudopotentials_dict, input_data=input_data, kpts=(kpt, kpt, kpt), nspin=nspin, command=f'mpirun -np {mpi_num_procs} pw.x < espresso.pwi > espresso.pwo')
    atoms.set_calculator(calc)

    #-----------------------------------------------------------------------------
    # search optimized structure with scf
    input_data['control']['calculation'] = 'scf'
    best_energy = float('inf')
    retries = 0
    flag = 0
    energy = 0.0
    scaling_factor -= dsfactor
    good_flag = 0
    print("search optimized structure with scf")
    while retries < max_retries:
        gc.collect()
        retries += 1
        print("---------------------------------")
        print(f'{retries}/{max_retries}:')
        scaling_factor += dsfactor
        scaled_cell = original_cell * scaling_factor
        atoms.set_cell(scaled_cell, scale_atoms=True)
        try:
            atoms.set_calculator(calc)
            energy = atoms.get_total_energy()
            print(f'    scaling factor = {scaling_factor}')
            print(f'    Total energy = {energy} [eV]')
            print("cell = ", scaled_cell)
            if energy < best_energy:
                best_energy = energy
                flag = 1
            if flag == 1 and energy > best_energy and good_flag == 1:
                #---------------------------------
                print("--------------------------------------------")
                scaling_factor -= dsfactor
                print("# binary search")
                print(f'0/5:')
                print(f'    scaling_factor = {scaling_factor}, dsfactor = {dsfactor}')
                print(f'    Total energy = {best_energy} [eV]')
                print("--------------------------------------------")
                step = 1
                while step <= 5:
                    gc.collect()
                    try:
                        scaling_factor, dsfactor, best_energy = binary_search(original_cell, atoms, calc, scaling_factor, dsfactor, best_energy)
                    except Exception as e:
                        print("It probably has not converged. You should try increasing electron_maxstep or changing occupations or smearing.")
                        return "Error-2"
                    print(f'{step}/5:')
                    print(f'    scaling_factor = {scaling_factor}, dsfactor = {dsfactor}')
                    print(f'    Total energy = {best_energy} [eV]')
                    print("--------------------------------------------")
                    step += 1
                break
                #---------------------------------
            good_flag = 1
        except Exception as e:
            print(f"Optimization failed for {element1}-{element2} with error: {e}")
            if retries >= max_retries:
                print("Max retries reached. Skipping this combination.")
                return "Error-1"
            else:
                good_flag = 0
                continue

    print("---------------------------------------")
    optimized_scaling_factor = scaling_factor
    print("using optimized_scaling_factor = ", optimized_scaling_factor)
    scaled_cell = original_cell * optimized_scaling_factor
    atoms.set_cell(scaled_cell, scale_atoms=True)
    print("cell = ", scaled_cell)
    #-----------------------------------------------------------------------------
    
    '''
    # The following was useless because vc-relax didn't work properly.
    #-----------------------------------------------------------------------------
    # search optimized structure with vc-relax
    input_data['control']['calculation'] = 'vc-relax'
    retries = 0
    energy = 0.0
    scaling_factor -= dsfactor
    print("search optimized structure with vc-relax")
    while retries < max_retries:
        retries += 1
        scaling_factor += dsfactor
        scaled_cell = original_cell * scaling_factor
        atoms.set_cell(scaled_cell, scale_atoms=True)
        print("---------------------------------")
        print("scaling factor = ", scaling_factor, "energy = ", energy)
        print("cell = ", scaled_cell)
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
                continue
    #-----------------------------------------------------------------------------
    '''

    print("----------------------------------------")
    print("making data and equation of states (eos)")
    print("----------------------------------------")
    
    '''
    # old version
    isolated_atom_energy1 = pseudopotentials[element1]['total_psenergy'] * 13.605693
    isolated_atom_energy2 = pseudopotentials[element2]['total_psenergy'] * 13.605693
    '''
    isolated_atom_energy1 = pseudopotentials[element1]['total_psenergy'] * 13.605693
    isolated_atom_energy2 = pseudopotentials[element2]['total_psenergy'] * 13.605693
    
    '''
    # If the json file has data (old version, But this definitely works.)
    valence_electrons1 = pseudopotentials[element1]['z_valence']
    valence_electrons2 = pseudopotentials[element2]['z_valence']
    '''
    '''
    if PBEsol_flag == 0:
        DFT = 'PBE'
    else:
        DFT = 'PBEsol'
    if not element1 == "XX":
        pseudo_file = os.path.join(f'./{DFT}', pseudopotentials[element1]['filename'])
        valence_electrons1 = get_valence_electrons(pseudo_file)
        print(f'valence_electrons of atom 1: {valence_electrons1}')
    pseudo_file = os.path.join(f'./{DFT}', pseudopotentials[element2]['filename'])
    valence_electrons2 = get_valence_electrons(pseudo_file)
    print(f'valence_electrons of atom 2: {valence_electrons2}')
    '''
    valence_electrons1 = pseudopotentials[element1]['valence_electrons']
    valence_electrons2 = pseudopotentials[element2]['valence_electrons']

    volumes = []
    energies = []
    cohesive_energies = []
    elastic_constants = []
    stress_tensor = []
    forces = []
    charges = []
    magnetic_moments = []
    
    volumes_per_atom = []
    energies_per_atom = []
    cohesive_energies_per_atom = []

    skip_indices = []
    tries = 0
    ndata = 0
    if npoints == 7:
        print(f'{npoints} points (same as SSSP)')
        vrange = 0.06
        print(f'Here, setting +/- {vrange*100}% for volume same as delta-value and SSSP)')
    else:
        vrange = 0.01*(npoints-1)/2
    for scale in np.linspace((1.0-vrange)**(1/3), (1.0+vrange)**(1/3), npoints):
        gc.collect()
        tries += 1
        if tries in skip_indices:
            continue
        print(f'{tries}/{npoints}:')
        
        scaled_cell = original_cell * optimized_scaling_factor * scale
        atoms.set_cell(scaled_cell, scale_atoms=True)
        print("input cell = ", scaled_cell)

        atoms.set_calculator(calc)
        print("qe cell = ", atoms.get_cell())
        
        try:
            energy = atoms.get_total_energy()
        except Exception as e:
            print(f"Error-l1: The calculation may have stopped with [Error in routine electrons: charge is wrong].")
            with open("error_log.txt", "a") as file:
                file.write(f"Error-l1: The calculation may have stopped with [Error in routine electrons: charge is wrong].: {lattce}-{element1}-{element2}\n")
            continue
        energies.append(energy)

        cohesive_energy = -(atoms.get_total_energy() - isolated_atom_energy1*Nelem1 - isolated_atom_energy2*Nelem2)
        cohesive_energies.append(cohesive_energy)
        
        volume = atoms.get_volume()
        volumes.append(volume)
        volumes_per_atom.append(volume/len(atoms))
        
        energies_per_atom.append(atoms.get_total_energy()/len(atoms))
        cohesive_energies_per_atom.append(cohesive_energy/len(atoms))

        stress_tensor.append((calc.get_stress() * 160.21766208).tolist())
        
        forces.append(calc.get_forces().tolist())
        
        print(f'    Volume = {volume/len(atoms)} [A^3/atom], Cohesive_energy = {cohesive_energy/len(atoms)} [eV/atom]')
        print(f'    Total energy = {energy} [eV]')
        
        if spin_flag == 1:
            magnetic_moments.append(atoms.get_magnetic_moments().tolist())
            print(f'    Magnetic moment = {magnetic_moments[ndata-1][:]}')
        print("-------------------------------------------------------------------------------------")
        
        new_prefix = f'{lattce}_{element1}_{element2}'
        
        update_prefix_in_file('val.pp.in', new_prefix)
        update_prefix_in_file('all.pp.in', new_prefix)
        
        os.system('pp.x < val.pp.in > val.pp.out')
        os.system('pp.x < all.pp.in > all.pp.out')
        
        os.system('./bader valence_density.cube -ref all_electron_density.cube')
        charge = read_bader_charges()
        if lattce == 'b1' or lattce == 'dia':
            if primitive_flag == 0:
                charges.append([valence_electrons1-charge[0],
                                valence_electrons1-charge[1],
                                valence_electrons1-charge[2],
                                valence_electrons1-charge[3],
                                valence_electrons2-charge[4],
                                valence_electrons2-charge[5],
                                valence_electrons2-charge[6],
                                valence_electrons2-charge[7]])
            else:
                charges.append([valence_electrons1-charge[0],
                                valence_electrons2-charge[1]])
        elif lattce == 'b2':
            charges.append([valence_electrons1-charge[0], 
                            valence_electrons2-charge[1]])
        elif lattce == 'l12':
            charges.append([valence_electrons1-charge[0],
                            valence_electrons1-charge[1],
                            valence_electrons1-charge[2],
                            valence_electrons2-charge[3]])
            mean_elem1_charge = (valence_electrons1-charge[0] + valence_electrons1-charge[1] + valence_electrons1-charge[2])/3
            print(f'Error for element 1 at position No.1: {(valence_electrons1-charge[0])/mean_elem1_charge*100-100} [%]')
            print(f'Error for element 1 at position No.2: {(valence_electrons1-charge[1])/mean_elem1_charge*100-100} [%]')
            print(f'Error for element 1 at position No.3: {(valence_electrons1-charge[2])/mean_elem1_charge*100-100} [%]')
        else:
            charges.append([0.0])
            print(f"This code does not provide other structures. (Possible structures: b1, b2, dia, l12)")
        
        #print(f'Charges [e]: {charge}')
        print(f'Charges [e]: {charges[ndata-1][:]}')
        total_charge = sum(charges[ndata-1][:])
        print(f"Total charge: {total_charge}")
        if abs(total_charge) >= 0.005:
            warning_message = f"Warning: Total charge is {total_charge}, which is 0.5 % or more. {lattce}-{element1}-{element2}-{ndata}"
            print(warning_message)
            with open('error_log.txt', 'a') as file:
                file.write(warning_message + '\n')
        ndata += 1
        print("-------------------------------------------------------------------------------------")

    if D_flag == 0:
        D_char = ''
    elif D_flag == 1:
        D_char = '-D2'
    elif D_flag == 2:
        D_char = '-D3-no3body'
    elif D_flag == 3:
        D_char = '-D3'
    
    if spin_flag == 0:
        spin_char = 'non-spin'
    else:
        spin_char = 'spin'

    if PBEsol_flag == 0:
        DFT = 'PBE'
    else:
        DFT = 'PBEsol'
    
    directory = f'results_{DFT}{D_char}_{spin_char}_{lattce.upper()}'
    if not os.path.exists(directory):
        os.makedirs(directory)

    # eos: sjeos, taylor, murnaghan, birch, birchmurnaghan, pouriertarantola, vinet, antonschmidt, p3
    eos = EquationOfState(volumes_per_atom, [energy * -1.0 for energy in cohesive_energies_per_atom], eos='birchmurnaghan')
    try:
        v0, e0, B = eos.fit()
        print(B / kJ * 1.0e24, 'GPa')
        # Clear the previous plot
        plt.clf()
        eos.plot(f'{directory}/{lattce}-{element1}-{element2}_eos.png')
        print("The notation of the ASE plot has not been changed. Note that the calculations are done with -Ec [eV/atom] and V [A^3/atom] (the volumes of b1 and dia are the volume of the primitive cell = the volume of the conventional cell / 4).")
    except (ValueError, RuntimeError) as e:
        with open("error_log.txt", "a") as file:
            file.write(f"Error fitting EOS: {e}.: in {lattce}-{element1}-{element2}\n")
        return "Error-eos-1"
    
    cohesive_energy_per_atom = e0 * -1.0
    if primitive_flag == 1 and (lattce == 'b1' or lattce == 'dia'):
        optimized_a = (v0 * len(atoms) * 4)**(1/3)
    else:
        optimized_a = (v0 * len(atoms))**(1/3)
    nearest_neighbor_distance = optimized_a / re2a
    
    if e0 < 0.0:
        #alpha = (9.0*B*((nearest_neighbor_distance*re2a)**3/len(atoms))/cohesive_energy_per_atom)**0.5
        alpha = (9.0*B*v0/(e0*-1.0))**0.5
        
        #-----------------------------------------------------------------
        # d = a3 = attrac = repuls
        plt.clf()
        repuls_fit_erose_form_0, attrac_fit_erose_form_0 = fit_rose_curve_erose_form_0(volumes_per_atom, cohesive_energies_per_atom, alpha, v0, (e0*-1.0), nearest_neighbor_distance)
        print(f"Fitted parameter: repuls = {repuls_fit_erose_form_0}, attrac = {attrac_fit_erose_form_0} for erose_form=0")
        # Save the plot as PNG
        plt.savefig(f'{directory}/{lattce}-{element1}-{element2}_rose_curve_fit_erose_form_0.png')
        #-------------------------
        # d = a3 = attrac = repuls
        plt.clf()
        repuls_fit_erose_form_1, attrac_fit_erose_form_1 = fit_rose_curve_erose_form_1(volumes_per_atom, cohesive_energies_per_atom, alpha, v0, (e0*-1.0), nearest_neighbor_distance)
        print(f"Fitted parameter: repuls = {repuls_fit_erose_form_1}, attrac = {attrac_fit_erose_form_1} for erose_form=1")
        # Save the plot as PNG
        plt.savefig(f'{directory}/{lattce}-{element1}-{element2}_rose_curve_fit_erose_form_1.png')
        #-------------------------
        # d = a3 = attrac = repuls
        plt.clf()
        repuls_fit_erose_form_2, attrac_fit_erose_form_2 = fit_rose_curve_erose_form_2(volumes_per_atom, cohesive_energies_per_atom, alpha, v0, (e0*-1.0), nearest_neighbor_distance)
        print(f"Fitted parameter: repuls = {repuls_fit_erose_form_2}, attrac = {attrac_fit_erose_form_2} for erose_form=2")
        # Save the plot as PNG
        plt.savefig(f'{directory}/{lattce}-{element1}-{element2}_rose_curve_fit_erose_form_2.png')
        #-----------------------------------------------------------------
    else:
        with open("error_log.txt", "a") as file:
            file.write(f"Error-e0, unstable phase (Ec <= 0): {element1}-{element2} in {DFT}{D_char}_{spin_char}_{lattce.upper()}\n")
        alpha = None
        repuls_fit_erose_form_0 = attrac_fit_erose_form_0 = None
        repuls_fit_erose_form_1 = attrac_fit_erose_form_1 = None
        repuls_fit_erose_form_2 = attrac_fit_erose_form_2 = None
    
    #print("---------------------------------")
    #print("initial stress tensor calculation")
    #input_data['control']['calculation'] = 'scf'
    #a = optimized_a
    #atoms.set_cell([a, a, a], scale_atoms=True)
    #atoms.set_calculator(calc)
    #input_data['control']['calculation'] = 'relax'
    #elastic_constants_final = calculate_elastic_constants(atoms, calc, [-0.01, 0.01], [-0.01, 0.01])
    ##elastic_constants_final = calculate_elastic_constants(atoms, calc, [-0.005, 0.005], [-0.005, 0.005])
    
    print("Note: [Lattice Constant (A)] is the [lattice constant, a (A)] of a conventional cell.")
    
    return_data = {
        'Element1': element1,
        'Element2': element2,
        #-------------------------
        # XX.meam file
        'Lattice Type': lattice_type,
        'Cohesive Energy (eV/atom)': cohesive_energy_per_atom,
        'Nearest Neighbor Distance (A)': nearest_neighbor_distance,
        'alpha': alpha,
        #-------------------------
        'repuls_erose_form_0': repuls_fit_erose_form_0, # d = a3 = repuls, astar <  0
        'attrac_erose_form_0': attrac_fit_erose_form_0, # d = a3 = attrac, astar >= 0
        #-------------------------
        'repuls_erose_form_1': repuls_fit_erose_form_1, # d = a3 = repuls, astar <  0
        'attrac_erose_form_1': attrac_fit_erose_form_1, # d = a3 = attrac, astar >= 0
        #-------------------------
        'repuls_erose_form_2': repuls_fit_erose_form_2, # d = a3 = repuls, astar <  0
        'attrac_erose_form_2': attrac_fit_erose_form_2, # d = a3 = attrac, astar >= 0
        #-------------------------
        #----------------------------------------------------------
        # lattice information
        'optimized_scaling_factor': optimized_scaling_factor,
        'Atoms': len(atoms),
        'Lattice Constant a (A)': optimized_a, # Values ​​in conventional cells.
        'Lattice Constant b (A)': optimized_a, # Values ​​in conventional cells.
        'Lattice Constant c (A)': optimized_a, # Values ​​in conventional cells.
        #----------------------------------------------------------
        # eos
        'Optimized Energy (eV/atom)': e0,
        'Optimized Volume (A^3/atom)': v0,
        'Bulk Modulus (GPa)': B / kJ * 1.0e24,
        #----------------------------------------------------------
        # fitting data
        'Volumes (A^3)': volumes,
        'Energies (eV)': energies,
        'Cohesive Energies (eV)': cohesive_energies,
        #----------------------------------------------------------
        #'Elastic Constants (GPa)': elastic_constants_final,
        #----------------------------------------------------------
        'Stress Tensor per Volume (GPa)': stress_tensor,
        'Forces (eV/A)': forces
        }
    if spin_flag == 0:
        pass
    else:
        return_data['Magnetic Moments (Bohr)'] = magnetic_moments
    return_data['Charges (e)'] = charges
    return return_data


# Process the combinations sequentially and store results
for i, combination in enumerate(element_combinations):
    gc.collect()

    if D_flag == 0:
        D_char = ''
    elif D_flag == 1:
        D_char = '-D2'
    elif D_flag == 2:
        D_char = '-D3-no3body'
    elif D_flag == 3:
        D_char = '-D3'
    
    if spin_flag == 0:
        spin_char = 'non-spin'
    else:
        spin_char = 'spin'

    if PBEsol_flag == 0:
        DFT = 'PBE'
    else:
        DFT = 'PBEsol'
    
    directory = f'results_{DFT}{D_char}_{spin_char}_{lattce.upper()}'
    if not os.path.exists(directory):
        os.makedirs(directory)

    results = []
    result = calculate_properties(combination, omp_num_threads, mpi_num_procs, max_retries, lattce, lat, npoints, primitive_flag, PBEsol_flag, spin_flag, D_flag, cutoff)
    element1, element2 = combination
    if result == "Error-1":
        with open("error_log.txt", "a") as file:
            file.write(f"Error-1, Max retries reached. Skipping this combination.: {element1}-{element2} in {DFT}{D_char}_{spin_char}_{lattce.upper()}\n")
        continue
    elif result == "Error-2":
        with open("error_log.txt", "a") as file:
            file.write(f"Error-2, It probably has not converged.: {element1}-{element2} in {DFT}{D_char}_{spin_char}_{lattce.upper()}\n")
        continue
    elif result == "Error-eos-1":
        with open("error_log.txt", "a") as file:
            file.write(f"Error-eos-1, RuntimeError: Optimal parameters not found: Number of calls to function has reached maxfev = 1000.: {element1}-{element2} in {DFT}{D_char}_{spin_char}_{lattce.upper()}\n")
        continue
    results.append(result)

    with open(f'{directory}/{lattce}_{element1}-{element2}_{spin_char}.json', 'a') as jsonfile:
        json.dump(result, jsonfile, indent=4)
        jsonfile.write('\n')

    with open(f'{directory}.csv', 'a', newline='') as csvfile:
        fieldnames = ['Element1', 'Element2', 
                      #----------------------------------------------------------
                      # XX.meam file
                      'lattce',
                      'Ec', 
                      're', 
                      'alpha',
                      #-------------------------
                      'repuls (erose_form=0)', 
                      'attrac (erose_form=0)', 
                      #-------------------------
                      'repuls (erose_form=1)', 
                      'attrac (erose_form=1)', 
                      #-------------------------
                      'repuls (erose_form=2)', 
                      'attrac (erose_form=2)', 
                      #-------------------------
                      #----------------------------------------------------------
                      # lattice information
                      're_opt/re_init',
                      'Atoms', 
                      'Lattice Type',
                      'Lattice Constant a (A)', 
                      'Lattice Constant b (A)', 
                      'Lattice Constant c (A)', 
                      #-------------------------
                      # eos
                      'Optimized Energy (eV/atom)',
                      'Optimized Volume (A^3/atom)',
                      'Bulk Modulus (GPa)', 
                      #-------------------------
                      # fitting data
                      'Volumes (A^3)', 
                      'Energies (eV)',
                      'Cohesive Energies (eV)', 
                      #-------------------------
                      'Bulk Modulus (GPa)', 
                      #-------------------------
                      #'C11', 'C12', 'C22', 'C33', 'C23', 'C13', 'C44', 'C55', 'C66', 
                      #-------------------------
                      'Stress Tensor per Volume (GPa)',
                      'Forces (eV/A)'
                      ]
        if spin_flag == 0:
            pass
        else:
            fieldnames.append('Magnetic Moments (Bohr)')
        fieldnames.append('Charges (e)')

        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

        if i == 0:
            writer.writeheader()

        row_data = {
            'Element1': result['Element1'],
            'Element2': result['Element2'],
            #----------------------------------------------------------
            # XX.meam file
            'lattce': result['Lattice Type'],
            'Ec': result['Cohesive Energy (eV/atom)'],
            're': result['Nearest Neighbor Distance (A)'],
            'alpha': result['alpha'],
            #-------------------------
            'repuls (erose_form=0)': result['repuls_erose_form_0'],
            'attrac (erose_form=0)': result['attrac_erose_form_0'],
            #-------------------------
            'repuls (erose_form=1)': result['repuls_erose_form_1'],
            'attrac (erose_form=1)': result['attrac_erose_form_1'],
            #-------------------------
            'repuls (erose_form=2)': result['repuls_erose_form_2'],
            'attrac (erose_form=2)': result['attrac_erose_form_2'],
            #-------------------------
            #----------------------------------------------------------
            # lattice information
            're_opt/re_init': result['optimized_scaling_factor'],
            'Atoms': result['Atoms'],
            'Lattice Type': result['Lattice Type'],
            'Lattice Constant a (A)': result['Lattice Constant a (A)'], # Values ​​in conventional cells.
            'Lattice Constant b (A)': result['Lattice Constant b (A)'], # Values ​​in conventional cells.
            'Lattice Constant c (A)': result['Lattice Constant c (A)'], # Values ​​in conventional cells.
            #-----------------------------------------------
            # eos
            'Optimized Energy (eV/atom)': result['Optimized Energy (eV/atom)'],
            'Optimized Volume (A^3/atom)': result['Optimized Volume (A^3/atom)'],
            'Bulk Modulus (GPa)': result['Bulk Modulus (GPa)'],
            #-----------------------------------------------
            # fitting data for stable structure
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
            # fitting data
            'Volumes (A^3)': result['Volumes (A^3)'],
            'Energies (eV)': result['Energies (eV)'],
            'Cohesive Energies (eV)': result['Cohesive Energies (eV)'],
            'Stress Tensor per Volume (GPa)': result['Stress Tensor per Volume (GPa)'],
            'Forces (eV/A)': result['Forces (eV/A)']
            #-----------------------------------------------
        }
        if spin_flag == 0:
            pass
        else:
            row_data['Magnetic Moments (Bohr)'] = result['Magnetic Moments (Bohr)']
        row_data['Charges (e)'] = result['Charges (e)']
        writer.writerow(row_data)
    
    # Generate the potfit text file output for each volume and cohesive energy
    natoms = result['Atoms']
    for idx, (volume, cohesive_energy, stress, force) in enumerate(zip(result['Volumes (A^3)'], result['Cohesive Energies (eV)'], result['Stress Tensor per Volume (GPa)'], result['Forces (eV/A)'])):
        ap = (volume * 4) ** (1/3) # primitive cell
        ac = (volume) ** (1/3) # conventional cell
        
        with open(f'{directory}/MPCv4_{element1}-{element2}-DFT_{lattce}_{spin_char}', 'a') as mpcfile:
           mpcfile.write(f"{volume}  {cohesive_energy*-1.0}\n")
        
        if lattce == 'b1':
           #print(f"{idx}: Create the FCC B1 (NaCl-type) structure")
           if primitive_flag == 0:
               print("# conventional cell")
               types=[0,0,0,0,1,1,1,1]
               positions=[(0, 0, 0), (0.5*ac, 0.5*ac, 0), (0.5*ac, 0, 0.5*ac), (0, 0.5*ac, 0.5*ac), 
                          (0.5*ac, 0.5*ac, 0.5*ac), (0, 0.5*ac, 0), (0.5*ac, 0, 0), (0, 0, 0.5*ac)]
               X = [ac, 0,  0 ]
               Y = [0,  ac, 0 ]
               Z = [0,  0,  ac]
           else:
               #print("# primitive cell")
               types=[0,1]
               positions=[(0, 0, 0), 
                          (0.5*ap, 0.5*ap, 0.5*ap)]
               X = [0,      0.5*ap, 0.5*ap]
               Y = [0.5*ap, 0,      0.5*ap]
               Z = [0.5*ap, 0.5*ap, 0     ]
        elif lattce == 'b2':
           #print(f"{idx}: Create the BCC B2 (CsCl-type) structure")
           types=[0,1]
           positions=[(0, 0, 0), 
                      (0.5*ac, 0.5*ac, 0.5*ac)]
           X = [ac, 0,  0]
           Y = [0,  ac, 0]
           Z = [0,  0,  ac]
        elif lattce == 'dia':
           #print(f"{idx}: Create the Diamond B3 (Zinc Blende) structure")
           if primitive_flag == 0:
               print("# conventional cell")
               types=[0,0,0,0,1,1,1,1]
               positions=[(0, 0, 0), (0.5*ac, 0.5*ac, 0), (0.5*ac, 0, 0.5*ac), (0, 0.5*ac, 0.5*ac), 
                          (0.25*ac, 0.75*ac, 0.75*ac), (0.25*ac, 0.25*ac, 0.25*ac), (0.75*ac, 0.75*ac, 0.25*ac), 
                          (0.75*ac, 0.25*ac, 0.75*ac)]
               X = [ac, 0,  0]
               Y = [0,  ac, 0]
               Z = [0,  0,  ac]
           else:
               #print("# primitive cell")
               types=[0,1]
               positions=[(0, 0, 0), 
                          (0.25*ap, 0.25*ap, 0.25*ap)]
               X = [0, 0.5*ap, 0.5*ap]
               Y = [0.5*ap, 0, 0.5*ap]
               Z = [0.5*ap, 0.5*ap, 0]
        elif lattce == 'l12':
           #print(f"{idx}: Create the L12 (Cu3Au-type) structure")
           types=[0,0,0,1]
           positions=[(0, 0.5*ac, 0.5*ac), (0.5*ac, 0, 0.5*ac), (0.5*ac, 0.5*ac, 0), 
                      (0, 0, 0)]
           X = [ac, 0,  0 ]
           Y = [0,  ac, 0 ]
           Z = [0,  0,  ac]
        else:
           print(f"{idx}: This code does not provide other structures. (Possible structures: b1, b2, dia, l12)")
        
        # xyz_array = [[pos[0], pos[1], pos[2]] for pos in positions]
        x_coords = [pos[0] for pos in positions]
        y_coords = [pos[1] for pos in positions]
        z_coords = [pos[2] for pos in positions]
        
        #print(f"## check {natoms} vs. {len(types)}")
        
        with open(f'{directory}/potfit_{lattce}_{element1}-{element2}_{spin_char}.config', 'a') as txtfile:
            txtfile.write(f"#N {natoms} 1\n")
            txtfile.write(f"#C {element1} {element2}\n")
            txtfile.write(f"## force file generated from file espresso.pwo\n")
            txtfile.write(f"#X {X[0]}  {X[1]}  {X[2]}\n")
            txtfile.write(f"#Y {Y[0]}  {Y[1]}  {Y[2]}\n")
            txtfile.write(f"#Z {Z[0]}  {Z[1]}  {Z[2]}\n")
            txtfile.write(f"#W 1.000000\n")
            txtfile.write(f"#E {cohesive_energy*-1.0}\n")
            # https://databases.fysik.dtu.dk/ase/_modules/ase/io/espresso.html
            # stress = np.array([sxx, syy, szz, syz, sxz, sxy], dtype=float)
            txtfile.write(f"## stress_xx stress_yy stress_zz stress_xy stress_yz stress_xz\n")
            txtfile.write(f"#S {stress[0]}  {stress[1]}  {stress[2]}  {stress[5]}  {stress[3]}  {stress[4]}\n")
            txtfile.write(f"## type x y z f_x f_y f_z\n")
            txtfile.write(f"#F\n")
            for atom_index in range(natoms):
                #txtfile.write(f"{types[atom_index]}  {xyz_array[atom_index][0]}  {xyz_array[atom_index][1]}  {xyz_array[atom_index][2]}  {force[atom_index][0]}  {force[atom_index][1]}  {force[atom_index][2]}\n")
                txtfile.write(f"{types[atom_index]}  {x_coords[atom_index]}  {y_coords[atom_index]}  {z_coords[atom_index]}  {force[atom_index][0]}  {force[atom_index][1]}  {force[atom_index][2]}\n")

    print(f"----------------------------------------------------------------------")
    print(f"Processed combination {i+1}/{len(element_combinations)}: {combination}")

print(f"Calculations are complete and results are saved to json MPCv4 and csv file.")
