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

# For error
from datetime import datetime
with open("error_log.txt","a") as file:
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    file.write(f"#------------------------------------------------------------------\n")
    file.write(f"[{timestamp}]\n")

# For clear memory (use gc.collect())
import gc
import signal
import time

#from mpi4py import MPI
#comm = MPI.COMM_WORLD
#rank = comm.Get_rank()
#size = comm.Get_size()

#----------------------------------------------------------------------------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------------------------------------------------------------------------
# User input section
#------------------------------------------------------------------
# b1: FCC_B1 (NaCl-type), b2:BCC_B2 (CsCl-type), dia:Diamond_B3 (Zinc Blende), l12: L12 (Cu3Au-type)
# fcc: FCC (1 element), hcp: HCP (1 element), bcc: BCC (1 element), sc: SC (1 element), dia1: Daiamond
# dim(dimer), ch4(binary system), dim1(1 element)
#lattce = 'dim1'
lattce = 'XXXXXXXXXX' # for run_seq.py
#------------------------------------------------------------------
# lattice structure of reference configuration [Angstrom] (https://en.wikipedia.org/wiki/Lattice_constant)
lat = ''     # In the case of '', the sum of covalent_radii (sum of concentration ratio in L12)
#lat = 4.046 # Al FCC (e.g., for L12 calculation of Al-base)
#lat = 3.502 # Fe BCC (e.g., for BCC_B2 calculation of Fe-base)
#lat = 5.431 # Si Diamond (e.g., for dia calculation)
#lat = 5.640 # NaCl (e.g., FCC_B1 calculation)
#----------------------------
# making number of data (If the bulk modulus is approximately +/- 0.5 GPa or less, 11 points will suffice. However, for a3, 25 points or more is recommended to keep the accuracy at around +/- 0.005 or less.)
npoints = 7 # >= 7 e.g., 7, 11, 17, 21, or 25, etc (Recommend >= 25), (default = 25) (SSSP: 7 points) (7 points:0.02 step, other:0.01 stepm)
#------------------------------------------------------------------
# Note: "fixed_element" becomes a dummy when a lattice of one element is selected (the atom in *.json is temporarily specified).
fixed_element = 'XX'
#fixed_element = 'YYYYYYYYYY'
elements = [fixed_element, 'Co']
'''
             'H',                                                                                                'He',
            'Li', 'Be',                                                              'B',  'C',  'N',  'O', 'F', 'Ne',
            'Na', 'Mg',                                                             'Al', 'Si',  'P',  'S', 'Cl', 'Ar',
             'K', 'Ca', 'Sc', 'Ti',  'V', 'Cr', 'Mn', 'Fe', 'Co', 'Ni', 'Cu', 'Zn', 'Ga', 'Ge', 'As', 'Se', 'Br', 'Kr',
            'Rb', 'Sr',  'Y', 'Zr', 'Nb', 'Mo', 'Tc', 'Ru', 'Rh', 'Pd', 'Ag', 'Cd', 'In', 'Sn', 'Sb', 'Te',  'I', 'Xe',
            'Cs', 'Ba', 'La', 
                        'Ce', 'Pr', 'Nd', 'Pm', 'Sm', 'Eu', 'Gd', 'Tb', 'Dy', 'Ho', 'Er', 'Tm', 'Yb', 'Lu', 
                              'Hf', 'Ta',  'W', 'Re', 'Os', 'Ir', 'Pt', 'Au', 'Hg', 'Tl', 'Pb', 'Bi', 'Po', 'At', 'Ra',
            'Rn', 'Fr', 'Ac', 'Th', 'Pa',  'U', 'Np', 'Pu'] # <- Enter the element you want to calculate (Note: Time Consumption: Approx. 4 elements/hour)
'''
#Note: hcp: He, O, F, Ne, S
#Note: dim: remain U', 'Np', 'Pu'
#elements = [fixed_element, 'Ce', 'Pr', 'Nd', 'Pm', 'Sm', 'Eu', 'Gd', 'Tb', 'Dy', 'Ho', 'Er', 'Tm', 'Yb', 'Lu'] # Pairs with noble gases require careful calculations and must be calculated separately.
#elements = [fixed_element, 'Po', 'At', 'Ra', 'Rn', 'Fr', 'Ac', 'Th', 'Pa',  'U', 'Np', 'Pu'] # Pairs with noble gases require careful calculations and must be calculated separately.
#elements = [fixed_element, 'He', 'Ne', 'Ar', 'Kr', 'Xe', 'Ra'] # Pairs with noble gases require careful calculations and must be calculated separately.
'''
elements = [fixed_element,
             'H',                                                                                                 'He',
            'Li', 'Be',                                                              'B',  'C',  'N',  'O',  'F', 'Ne',
            'Na', 'Mg',                                                             'Al', 'Si',  'P',  'S', 'Cl', 'Ar',
             'K', 'Ca', 'Sc', 'Ti',  'V', 'Cr', 'Mn', 'Fe', 'Co', 'Ni', 'Cu', 'Zn', 'Ga', 'Ge', 'As', 'Se', 'Br', 'Kr',
            'Rb', 'Sr',  'Y', 'Zr', 'Nb', 'Mo', 'Tc', 'Ru', 'Rh', 'Pd', 'Ag', 'Cd', 'In', 'Sn', 'Sb', 'Te',  'I', 'Xe',
            'Cs', 'Ba', 'La', 
                        'Ce', 'Pr', 'Nd', 'Pm', 'Sm', 'Eu', 'Gd', 'Tb', 'Dy', 'Ho', 'Er', 'Tm', 'Yb', 'Lu', 
                              'Hf', 'Ta',  'W', 'Re', 'Os', 'Ir', 'Pt', 'Au', 'Hg', 'Tl', 'Pb', 'Bi', 'Po', 'At', 'Ra',
            'Rn', 'Fr', 'Ac', 'Th', 'Pa',  'U', 'Np', 'Pu'] # <- Enter the element you want to calculate (Note: Time Consumption: Approx. 4 elements/hour)
'''
'''
# ch4: Si-X4
elements = [fixed_element,
             'H',                                                                                                 'He',
            'Li', 'Be',                                                              'B',                         'Ne',
                  'Mg',                                                             'Al',        'P',       'Cl', 'Ar',
                                                                              'Zn', 'Ga', 'Ge', 'As', 'Se',       'Kr',
                                                                        'Ag', 'Cd', 'In', 'Sn',              'I', 'Xe',
                              'Hf',                                     'Au', 'Hg', 'Tl', 'Pb', 'Bi', 'Po', 'At',
            'Rn'] # <- Enter the element you want to calculate (Note: Time Consumption: Approx. 4 elements/hour)
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
    #with open('PBE/PSlibrary_ONCV_GBRV_mix_PBE.json', 'r') as f:
    with open('PBE/PSlibrary_ONCV_GBRV_mix_PBE_v2.json', 'r') as f:
    #with open('PBE/SSSP-1.3.0_PBE_efficiency.json', 'r') as f:
    #with open('PBE/SSSP-1.3.0_PBE_precision.json', 'r') as f:
        pseudopotentials = json.load(f)
else:
    #with open('PBEsol/PSlibrary_PBEsol.json', 'r') as f:
    #with open('PBEsol/PSlibrary_ONCV_GBRV_mix_PBEsol.json', 'r') as f:
    with open('PBEsol/PSlibrary_ONCV_GBRV_mix_PBEsol_v2.json', 'r') as f:
    #with open('PBEsol/SSSP-1.3.0_PBEsol_efficiency.json', 'r') as f:
    #with open('PBEsol/SSSP-1.3.0_PBEsol_precision.json', 'r') as f:
        pseudopotentials = json.load(f)
#------------------------------------------------------------------
D_flag = 0 # 0:non-dispersion (non-vdW), 1:DFT-D2, 2: DFT-D3 (no three-body), 3: DFT-D3, (default: 1) (Fr-Pu: 0, 2, or 3)
#------------------------------------------------------------------
spin_flag = 1 # 0:non-spin, 1:spin, (default = 1)
#magnetic_type_flag = 1 # 1:Ferro magnetic, 0:set starting_magnetization = 0.0, -1: Anti-ferro magnetic, -2: Anti-ferri magnetic, (default = 1) (see "Table start_mag")
magnetic_type_flag = int('ZZZZZZZZZZ')
# Mn (antiferrimagnetic), O and Cr (antiferromagnetic), Fe, Co, and Ni (ferromagnetic).
#------------------------------------------------------------------
# Set the number of OpenMP/MPI settings (This is not working.)
mpi_num_procs = 14 # Test CPU: 12th Gen Intel(R) Core(TM) i7-12700
omp_num_threads = 1
os.environ['OMP_NUM_THREADS'] = f'{omp_num_threads}'
#------------------------------------------------------------------
primitive_flag = 1 # 0:conventional cell, 1:primitive cell, (default = 1)
# Note: hcp, dim, ch4, dim1, sc are forced to primitive_flag = 0.
#------------------------------------------------------------------
# max number of cycles for search optimized structure
max_retries = 20 # default = 100 (Note: set 100 for He and Ne)
#------------------------------------------------------------------
#Acceptable_values = 0.05 # calculate r at -Ec*Acceptable_values
#------------------------------------------------------------------
# User input section: END
#----------------------------------------------------------------------------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------------------------------------------------------------------------

# Dummy: Am = Cr-antiferromagnetic, Bm = O-antiferromagnetic, Cm=Mn-antiferrimagnetic: Am-Cm, Bm-Cm
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
    "Pa": 2.00,  "U": 1.96, "Np": 1.90, "Pu": 1.87, "XX": 2.00, "Am": 1.39, "Cm": 0.66, "Bm": 1.39
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
    "Pa": 2.00,  "U": 1.96, "Np": 1.90, "Pu": 1.87, "XX": 2.00, "Am": 1.66, "Cm": 0.48, "Bm": 1.61
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
    "Pa": 2.00,  "U": 1.96, "Np": 1.90, "Pu": 1.87, "XX": 2.00, "Am": 2.00, "Cm": 1.52, "Bm": 2.00
}

atomic_numbers = {
     "H":  1, "He":  2, "Li":  3, "Be":  4,  "B":  5,  "C": 6,   "N":  7,  "O":  8,  "F":  9, "Ne": 10,
    "Na": 11, "Mg": 12, "Al": 13, "Si": 14,  "P": 15,  "S": 16, "Cl": 17, "Ar": 18,  "K": 19, "Ca": 20,
    "Sc": 21, "Ti": 22,  "V": 23, "Cr": 24, "Mn": 25, "Fe": 26, "Co": 27, "Ni": 28, "Cu": 29, "Zn": 30,
    "Ga": 31, "Ge": 32, "As": 33, "Se": 34, "Br": 35, "Kr": 36, "Rb": 37, "Sr": 38,  "Y": 39, "Zr": 40,
    "Nb": 41, "Mo": 42, "Tc": 43, "Ru": 44, "Rh": 45, "Pd": 46, "Ag": 47, "Cd": 48, "In": 49, "Sn": 50,
    "Sb": 51, "Te": 52,  "I": 53, "Xe": 54, "Cs": 55, "Ba": 56, "La": 57, "Ce": 58, "Pr": 59, "Nd": 60,
    "Pm": 61, "Sm": 62, "Eu": 63, "Gd": 64, "Tb": 65, "Dy": 66, "Ho": 67, "Er": 68, "Tm": 69, "Yb": 70,
    "Lu": 71, "Hf": 72, "Ta": 73,  "W": 74, "Re": 75, "Os": 76, "Ir": 77, "Pt": 78, "Au": 79, "Hg": 80,
    "Tl": 81, "Pb": 82, "Bi": 83, "Po": 84, "At": 85, "Rn": 86, "Fr": 87, "Ra": 88, "Ac": 89, "Th": 90,
    "Pa": 91,  "U": 92, "Np": 93, "Pu": 94, "XX": 95, "Am": 24, "Cm":  8, "Bm": 25
}

atomic_masses = {
     "H":  1.008, "He": 4.0026, "Li": 6.94,   "Be": 9.0122,  "B": 10.81,   "C": 12.011,  "N": 14.007,  "O": 15.999,  "F": 18.998, "Ne": 20.180,
    "Na": 22.990, "Mg": 24.305, "Al": 26.982, "Si": 28.085,  "P": 30.974,  "S": 32.06,  "Cl": 35.45,  "Ar": 39.948,  "K": 39.098, "Ca": 40.078,
    "Sc": 44.956, "Ti": 47.867,  "V": 50.942, "Cr": 51.996, "Mn": 54.938, "Fe": 55.845, "Co": 58.933, "Ni": 58.693, "Cu": 63.546, "Zn": 65.38,
    "Ga": 69.723, "Ge": 72.63,  "As": 74.922, "Se": 78.971, "Br": 79.904, "Kr": 83.798, "Rb": 85.468, "Sr": 87.62,   "Y": 88.906, "Zr": 91.224,
    "Nb": 92.906, "Mo": 95.95,  "Tc": 98,     "Ru": 101.07, "Rh": 102.91, "Pd": 106.42, "Ag": 107.87, "Cd": 112.41, "In": 114.82, "Sn": 118.71,
    "Sb": 121.76, "Te": 127.60,  "I": 126.90, "Xe": 131.29, "Cs": 132.91, "Ba": 137.33, "La": 138.91, "Ce": 140.12, "Pr": 140.91, "Nd": 144.24,
    "Pm": 145,    "Sm": 150.36, "Eu": 151.96, "Gd": 157.25, "Tb": 158.93, "Dy": 162.50, "Ho": 164.93, "Er": 167.26, "Tm": 168.93, "Yb": 173.05,
    "Lu": 174.97, "Hf": 178.49, "Ta": 180.95,  "W": 183.84, "Re": 186.21, "Os": 190.23, "Ir": 192.22, "Pt": 195.08, "Au": 196.97, "Hg": 200.59,
    "Tl": 204.38, "Pb": 207.2,  "Bi": 208.98, "Po": 209,    "At": 210,    "Rn": 222,    "Fr": 223,    "Ra": 226,    "Ac": 227,    "Th": 232.04,
    "Pa": 231.04,  "U": 238.03, "Np": 237,    "Pu": 244,    "XX": 999,    "Am": 51.996, "Cm": 15.999, "Bm": 54.938
}

start_mag = {
     "H": 0.01, "He": 0.01, "Li": 0.04, "Be": 0.02,  "B": 0.05,  "C": 0.01,  "N": 0.01,  "O": 0.01,  "F": 0.01, "Ne": 0.01,
    "Na": 0.03, "Mg": 0.02, "Al": 0.03, "Si": 0.02,  "P": 0.01,  "S": 0.01, "Cl": 0.01, "Ar": 0.01,  "K": 0.03, "Ca": 0.02,
    "Sc": 0.05, "Ti": 0.05,  "V": 0.05, "Cr": 0.05, "Mn": 0.05, "Fe": 0.50, "Co": 0.30, "Ni": 0.20, "Cu": 0.01, "Zn": 0.01,
    "Ga": 0.03, "Ge": 0.02, "As": 0.01, "Se": 0.01, "Br": 0.01, "Kr": 0.01, "Rb": 0.03, "Sr": 0.02,  "Y": 0.05, "Zr": 0.05,
    "Nb": 0.05, "Mo": 0.05, "Tc": 0.05, "Ru": 0.05, "Rh": 0.05, "Pd": 0.01, "Ag": 0.01, "Cd": 0.01, "In": 0.03, "Sn": 0.02,
    "Sb": 0.01, "Te": 0.01,  "I": 0.01, "Xe": 0.01, "Cs": 0.03, "Ba": 0.02, "La": 0.05, "Ce": 0.05, "Pr": 0.05, "Nd": 0.05,
    "Pm": 0.05, "Sm": 0.05, "Eu": 0.05, "Gd": 0.05, "Tb": 0.05, "Dy": 0.05, "Ho": 0.05, "Er": 0.05, "Tm": 0.05, "Yb": 0.05,
    "Lu": 0.05, "Hf": 0.05, "Ta": 0.05,  "W": 0.05, "Re": 0.05, "Os": 0.05, "Ir": 0.05, "Pt": 0.01, "Au": 0.01, "Hg": 0.01,
    "Tl": 0.03, "Pb": 0.02, "Bi": 0.01, "Po": 0.01, "At": 0.01, "Rn": 0.01, "Fr": 0.03, "Ra": 0.02, "Ac": 0.05, "Th": 0.05,
    "Pa": 0.05,  "U": 0.05, "Np": 0.05, "Pu": 0.05, "XX": 0.01, "Am": 0.05, "Cm": 0.01, "Bm": 0.05
}

# CN = coordination number, z = CN
CN = {
      "b1":  6,  "b2": 8, "l12": 12,
     "fcc": 12, "bcc": 8, "hcp": 12, "sc": 6, "dia": 4,
     "dim":  1, "ch4": 4,
     "dim1": 1, "dia1": 4
}


def check_file_update(file_path, timeout):
    last_mod_time = os.path.getmtime(file_path)
    start_time = time.time()
    while time.time() - start_time < timeout:
        time.sleep(10)
        current_mod_time = os.path.getmtime(file_path)
        if current_mod_time != last_mod_time:
            last_mod_time = current_mod_time
            start_time = time.time()
        with open(file_path, 'r') as file:
            content = file.read()
            if "JOB DONE." in content:
                print("Calculation completed successfully.")
                return "Calculation completed"
    print(f"File not updated for more than {timeout/60} minutes, stopping calculation.")
    os.kill(os.getpid(), signal.SIGTERM)


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
    plt.title('Modified Rose energy function (erose_form = 2) Fit to DFT Data')
    
    # Save the plot as PNG
    #plt.savefig('rose_curve_fit.png')
    
    return repuls_fit, attrac_fit


def get_last_cell_and_positions(file_path):
    atomic_elements = []
    cell_parameters = []
    atomic_positions = []
    with open(file_path, 'r') as f:
        lines = f.readlines()
        # Find last CELL_PARAMETERS block
        for i in range(len(lines) - 1, -1, -1):  # Reverse search
            if "CELL_PARAMETERS (angstrom)" in lines[i]:
                cell_parameters = [
                    list(map(float, lines[i+1].strip().split())),
                    list(map(float, lines[i+2].strip().split())),
                    list(map(float, lines[i+3].strip().split()))
                ]
                break
        # Find last ATOMIC_POSITIONS block
        for i in range(len(lines) - 1, -1, -1):  # Reverse search
            if "ATOMIC_POSITIONS (angstrom)" in lines[i]:
                j = i + 1
                while j < len(lines) and lines[j].strip():  # Read until an empty line
                    parts = lines[j].strip().split()
                    # Skip if non-numeric data exists
                    if not all(p.replace('.', '', 1).replace('-', '', 1).isdigit() for p in parts[1:]):
                        j += 1
                        continue
                    atomic_elements.append(parts[0])  # Add atomic element
                    atomic_positions.append(list(map(float, parts[1:])))  # Correctly format positions
                    j += 1
                break
    # Return extracted parameters and positions
    return cell_parameters, atomic_elements, atomic_positions


def calculate_properties(elements_combination, omp_num_threads, mpi_num_procs, max_retries=100, lattce='', lat='', npoints=25, primitive_flag=1, PBEsol_flag=0, spin_flag=1, D_flag=1, cutoff=520, magnetic_type_flag=1):
    element1, element2 = elements_combination
    
    if lattce in ['fcc', 'bcc', 'hcp', 'sc', 'dia1', 'dim1']:
        print(f"{element2}, lattce = {lattce}")
    else:
        print(f"{element1}-{element2} pair, lattce = {lattce}")
    
    if lattce in ['dim', 'ch4', 'dim1']:
        radius1 = covalent_radii[element1]
        radius2 = covalent_radii[element2]
    else:
        radius1 = atomic_radii[element1] # hcp: He,etc *2.0
        radius2 = atomic_radii[element2] # hcp: He,etc *2.0
        #radius1 = vdw_radii[element1]
        #radius2 = vdw_radii[element2]
    
    if lat == '':
        if lattce == 'l12':
            re = (radius1*3/2 + radius2/2) # The reason for this is based on Vegard's law.
            print(f'Start Nearest Neighbor Distance, re = (radius1*3/2 + radius2/2) = {re} [A]')
        elif lattce in ['fcc', 'bcc', 'hcp', 'sc', 'dia1']:
            re = radius2*2 # radius2 = covalent_radii[element2]
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
              kptc = kpt
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
              kptc = kpt
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
        kptc = kpt
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
              kptc = kpt
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
              kptc = kpt
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
        kptc = kpt
        Nelem1 = 3
        Nelem2 = 1
    #------------------------------------------------------------------------------
    elif lattce == 'fcc':
        print("Create the FCC structure (1 element)")
        lattice_type = 'FCC'
        re2a = 2.0/2.0**0.5
        if not lat == '':
            re = lat / re2a
        a = re * re2a
        if primitive_flag == 0:
            atoms = Atoms(f'{element2}4', 
                    positions=[(0, 0, 0),(0, 0.5*a, 0.5*a),(0.5*a, 0, 0.5*a),(0.5*a, 0.5*a, 0)], 
                    cell=[a, a, a], 
                    pbc=True)
            #kpt = 5
            kpt = 6 # 4 or 6
            kptc = kpt
            Nelem1 = 0
            Nelem2 = 4
        else:
            print("# primitive cell")
            atoms = Atoms(f'{element2}',
                    positions=[(0, 0, 0)],
                    cell=[[0, 0.5*a, 0.5*a], [0.5*a, 0, 0.5*a], [0.5*a, 0.5*a, 0]],
                    pbc=True)
            kpt = 9 # 4 or 6
            kptc = kpt
            Nelem1 = 0
            Nelem2 = 1
    elif lattce == 'hcp':
        print("Create the HCP structure (1 element)")
        primitive_flag == 0
        lattice_type = 'HCP (1 element)'
        re2a = 1.0 # = a/(np.sqrt(a**2 + (3/4)*c**2)/np.sqrt(3))
        if not lat == '':
            re = lat / re2a
        a = re * re2a
        c = a*np.sqrt(8/3) # c = a*np.sqrt(8/3) case: re = 1.0 (atomic distance = 1.0)
        covera = c/a
        atoms = Atoms(f'{element2}2', 
                positions=[(a, np.sqrt(3)/3*2*a, 0.75*c), (0, np.sqrt(3)/3*a, 0.25*c)], 
                cell=[(a, 0, 0), (-a/2, np.sqrt(3)*a/2, 0), (0, 0, c)], 
                pbc=True)
        kpt = 9 # 6 or 8
        kptc = 6
        Nelem1 = 0
        Nelem2 = 2
    elif lattce == 'bcc':
        print("Create the BCC structure (1 element)")
        lattice_type = 'BCC'
        re2a = 2.0/3.0**0.5
        if not lat == '':
            re = lat / re2a
        a = re * re2a
        if primitive_flag == 0:
            #atoms = bulk('{element2}', 'bcc', a)
            atoms = Atoms(f'{element2}2', 
                    positions=[(0, 0, 0),(0.5*a, 0.5*a, 0.5*a)], 
                    cell=[a, a, a], 
                    pbc=True)
            kpt = 8 # 6 or 8
            kptc = kpt
            Nelem1 = 0
            Nelem2 = 2
        else:
            atoms = Atoms(f'{element2}', 
                    positions=[(0, 0, 0)], 
                    cell=[(-0.5*a, 0.5*a, 0.5*a), (0.5*a, -0.5*a, 0.5*a), (0.5*a, 0.5*a, -0.5*a)],
                    pbc=True)
            kpt = 9 # 6 or 8 (Note: For K, kpt=9 and 20 gave the same results.)
            kptc = kpt
            Nelem1 = 0
            Nelem2 = 1
    elif lattce == 'sc':
        primitive_flag == 0
        print("Create the SC structure (1 element)")
        lattice_type = 'SC (1 element)'
        re2a = 1.0
        if not lat == '':
            re = lat / re2a
        a = re * re2a
        #atoms = bulk('{element2}', 'sc', a)
        atoms = Atoms(f'{element2}', 
                  positions=[(0, 0, 0)], 
                  cell=[a, a, a], 
                  pbc=True)
        kpt = 9 # 6 or 8
        kptc = kpt
        Nelem1 = 0
        Nelem2 = 1
    elif lattce == 'dia1':
        print("Create the Diamond structure (1 element)")
        lattice_type = 'DIA'
        re2a = 2.0/2.0**0.5
        if not lat == '':
            re = lat / re2a
        a = re * re2a
        if primitive_flag == 0:
            #atoms = bulk('{element2}', 'diamond', a)
            atoms = Atoms(f'{element2}8', 
                    positions=[(0, 0, 0), (0.5*a, 0.5*a, 0), (0.5*a, 0, 0.5*a), (0, 0.5*a, 0.5*a), 
                               (0.25*a, 0.75*a, 0.75*a), (0.25*a, 0.25*a, 0.25*a), (0.75*a, 0.75*a, 0.25*a), (0.75*a, 0.25*a, 0.75*a)], 
                    cell=[a, a, a], 
                    pbc=True)
            #kpt = 5
            kpt = 6 # 4 or 6
            kptc = kpt
            Nelem1 = 0
            Nelem2 = 8
        else:
            print("# primitive cell")
            atoms = Atoms(f'{element2}2',
                    positions=[(0, 0, 0),(0.25*a, 0.25*a, 0.25*a)],
                    cell=[[0, 0.5*a, 0.5*a], [0.5*a, 0, 0.5*a], [0.5*a, 0.5*a, 0]],
                    pbc=True)
            kpt = 9 # 4 or 6
            kptc = kpt
            Nelem1 = 0
            Nelem2 = 2
    #------------------------------------------------------------------------------
    elif lattce == 'dim':
        primitive_flag == 0
        print("Create the dimer structure")
        lattice_type = 'DIM'
        a = 12.0
        re2a = a/re
        atoms = Atoms(f'{element1}{element2}', 
                positions=[(0.5*a, 0.5*a, 0.5*a+re/2),
                           (0.5*a, 0.5*a, 0.5*a-re/2)], 
                cell=[a, a, a+re], 
                pbc=True)
        Nelem1 = 1
        Nelem2 = 1
    elif lattce == 'ch4':
        primitive_flag == 0
        print("Create the CH4 structure")
        lattice_type = 'CH4'
        a = 12.0
        re2a = a/re
        atoms = Atoms(f'{element1}{element2}4', 
                positions=[(0.5*a,    0.5*a,    0.5*a   ),  # Carbon atom
                           (0.5*a+re, 0.5*a+re, 0.5*a+re),  # Hydrogen atoms
                           (0.5*a-re, 0.5*a-re, 0.5*a+re),  # Hydrogen atoms
                           (0.5*a+re, 0.5*a-re, 0.5*a-re),  # Hydrogen atoms
                           (0.5*a-re, 0.5*a+re, 0.5*a-re)], # Hydrogen atoms
                cell=[a+re*np.sqrt(2/3), a+re*np.sqrt(2/3), a+re*np.sqrt(2/3)], 
                pbc=True)
        Nelem1 = 1
        Nelem2 = 4
    #------------------------------------------------------------------------------
    elif lattce == 'dim1':
        primitive_flag == 0
        print("Create the dimer structure (1 element)")
        lattice_type = 'DIM (1 element)'
        a = 12.0
        re2a = a/re
        #atoms = bulk('{element2}', 'sc', a)
        atoms = Atoms(f'{element2}2', 
                positions=[(0, 0,  re/2),
                           (0, 0, -re/2)], 
                cell=[a, a, a+re], 
                pbc=True)
        Nelem1 = 0
        Nelem2 = 2
    else:
        print("This code does not provide other structures. (Possible structures: b1, b2, dia, l12, or fcc, bcc, hcp, dia1, dim, ch4, dim1)")
    
    scaling_factor = 1.0
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
            'etot_conv_thr': 1.0e-4*len(atoms), # 1.36 meV/atom = about 1 meV/atom
            #'forc_conv_thr': 1.0e-3 # dafault value
            'disk_io': 'none',
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
            'diagonalization': 'david', # 'cg', 'david' (<= qe-6.8) or 'rmm-davidson' (>= qe-7.0)
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
    
    if lattce in ['fcc', 'hcp', 'bcc', 'sc', 'dia1', 'dim1']:
        input_data['control']['prefix'] = f'{lattce}_{element2}'
        input_data['system']['ecutwfc'] = pseudopotentials[element2]['cutoff_wfc']
        input_data['system']['ecutrho'] = pseudopotentials[element2]['cutoff_rho']
    
    if cutoff == 0:
        pass
    elif cutoff > 0:
        input_data['system']['ecutwfc'] = cutoff/Rydberg
        input_data['system']['ecutrho'] = cutoff*4.0/Rydberg
    else:
        input_data['system']['ecutwfc'] = 520/Rydberg
        input_data['system']['ecutrho'] = 520*4.0/Rydberg
    
    if lattce in ['dim', 'ch4', 'dim1']:
        calc = Espresso(pseudopotentials=pseudopotentials_dict, input_data=input_data, kpts=(1,1,1), koffset=False, nspin=nspin, command=f'mpirun -np {mpi_num_procs} pw.x < espresso.pwi > espresso.pwo')
    else:
        calc = Espresso(pseudopotentials=pseudopotentials_dict, input_data=input_data, kpts=(kpt, kpt, kptc), koffset=True, command=f'mpirun -np {mpi_num_procs} pw.x < espresso.pwi > espresso.pwo')
        #calc = Espresso(pseudopotentials=pseudopotentials_dict, input_data=input_data, kpts=(kpt, kpt, kptc), nspin=nspin, command=f'mpirun -np {mpi_num_procs} pw.x < espresso.pwi > espresso.pwo')
    atoms.set_calculator(calc)
    
    # Negative candidate: Cr, Mn, Co, Ni, O
    print(f'{element1} mag:',start_mag[element1])
    print(f'{element2} mag:',start_mag[element2])
    smag1 = start_mag[element1]/0.0625
    smag2 = start_mag[element2]/0.0625
    if lattce in ['fcc', 'hcp', 'bcc', 'sc', 'dia1', 'dim1', 'v1fcc', 'v1bcc', 'v1hcp', 'v1sc', 'v1dia1']:
        smag1 = smag2
    if magnetic_type_flag == 1:
        print('ferro magnetic calculation (e.g., Fe, Co, Ni)')
        if lattce in ['l12']:
            atoms.set_initial_magnetic_moments([smag1/3, smag1/3, smag1/3, smag2])
        else:
            atoms.set_initial_magnetic_moments([smag1] * len(atoms))
    elif magnetic_type_flag == -1:
        print('anti-ferro magnetic calculation (e.g., Cr)')
        if lattce in ['l12']:
            #atoms.set_initial_magnetic_moments([smag1/3, smag1/3, smag1/3, -smag2])
            smag1 = (smag1*3+smag2)/4
            atoms.set_initial_magnetic_moments([smag1/3, smag1/3, smag1/3, -smag1])
        elif len(atoms) == 1:
            atoms.set_initial_magnetic_moments([smag1])
        elif len(atoms) == 2:
            #atoms.set_initial_magnetic_moments([smag1, -smag2])
            smag1 = (smag1+smag2)/2
            atoms.set_initial_magnetic_moments([smag1, -smag1])
    elif magnetic_type_flag == -2:
        print('anti-ferri magnetic calculation (e.g., Mn)')
        if lattce in ['l12']:
            smag1 = (smag1*3+smag2)/4
            atoms.set_initial_magnetic_moments([smag1/3*1.03, smag1/3*1.03, smag1/3*1.03, -smag1*0.91])
        elif len(atoms) == 1:
            atoms.set_initial_magnetic_moments([smag1])
        elif len(atoms) == 2:
            smag1 = (smag1+smag2)/2
            atoms.set_initial_magnetic_moments([smag1*1.1, -smag1*0.9])
            #atoms.set_initial_magnetic_moments([smag1, -smag2*0.9])
    else:
        # default = 0.0 in ASE
        pass
    
    #-----------------------------------------------------------------------------
    # search optimized structure with vc-relax
    if lattce in ['hcp', 'dim', 'ch4', 'dim1']:
        print("search optimized structure with vc-relax")
        input_data['control']['calculation'] = 'vc-relax'
        input_data['control']['forc_conv_thr'] = 1.0e-3 # dafault value
        input_data['control']['nstep'] = 1000
        scaled_cell = original_cell * scaling_factor
        atoms.set_cell(scaled_cell, scale_atoms=True)
        try:
            opt = BFGS(atoms)
            opt.run(fmax=0.0514) # 1e-3*51.422 [eV/A]
            #opt.run(fmax=0.02) # max force <= 0.02 [eV/A]
            #energy = atoms.get_total_energy()
            #print(f'E = {energy} [eV]')
            #opt_cell = atoms.get_cell()
            #print(f'optimized cell = {opt_cell}')
            #-------------------------------------
            #positions = atoms.get_positions(wrap=True)
            #re = np.linalg.norm(positions[0] - positions[1])
            #re2a = opt_cell[0][0]/re
            #print(f'Distance, re [A] = {re}')
            #print(f're/a = {re2a}')
            #print(f'c/a = {opt_cell[2][2]/opt_cell[0][0]}')
        except Exception as e:
            pass
            #print(f"Optimization failed: {e}")
            #with open("error_log.txt", "a") as file:
            #    file.write(f"Optimization failed: {e}: {lattce}-{element1}-{element2}\n")
            #    file.write(f"  -> use c = sqrt(8/3) * a = 1.633 * a \n")
        # Path to your espresso.pwo file
        file_path = 'espresso.pwo'
        # Get the last cell parameters and atomic positions
        last_cell_params, last_atomic_elements, last_atomic_positions = get_last_cell_and_positions(file_path)
        print("Last CELL_PARAMETERS (angstrom):")
        for param in last_cell_params:
            print(param)
        print("\nLast ATOMIC_POSITIONS (angstrom):")
        for position in last_atomic_positions:
            print(position)
        atoms.set_cell(last_cell_params, scale_atoms=True)
        atoms.set_positions(last_atomic_positions)
        opt_cell = atoms.get_cell()
        positions = atoms.get_positions(wrap=True)
        ad = np.linalg.norm(positions[0] - positions[1])
        print(f'Atomic distance, re [A] = {re}')
        if ad >= a and lattce == 'hcp':
            re = a
        elif ad < a and lattce == 'hcp':
            re = ad
        print(f'Nearest neighbor Distance, re [A] = {re}')
        re2a = opt_cell[0][0]/re
        print(f're/a = {re2a}')
        print(f'c/a = {opt_cell[2][2]/opt_cell[0][0]}')
    #-----------------------------------------------------------------------------
    
    dsfactor = 0.15
    # The minimum setting for a downward convex search is "scaling_factor = 1.0 - dsfactor*1.0".
    scaling_factor = 1.0 - dsfactor*2.0 # Note: stop caluclation at Ga for dsfactor = 0.12 and scaling_factor = 1.0 - dsfactor*3.0.
    
    original_cell = atoms.get_cell()
    scaled_cell = original_cell * scaling_factor
    atoms.set_cell(scaled_cell, scale_atoms=True)
    
    if lattce in ['hcp', 'dim', 'ch4', 'dim1', 'v1hcp']:
        print(f'Calculation: Conventional Cell')
        print(f'start Cell([{original_cell[0,0]},{original_cell[1,1]},{original_cell[2,2]}])')
        bovera = original_cell[1][1]/original_cell[0][0]
        covera = original_cell[2][2]/original_cell[0][0]
    else:
        print(f'Calculation: Primitive Cells')
        print(f'start {original_cell}')
        bovera = 1.0
        covera = 1.0
    
    #-----------------------------------------------------------------------------
    if lattce in ['fcc', 'bcc', 'sc', 'dia1']:
        timeout=60*3
    else:
        timeout=60*10
    file_path='espresso.pwo'
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
            try:
                check_file_update(file_path, timeout)
            except Exception as e:
                print(f"The output file has not been updated for more than {timeout/60} minutes.")
                with open("error_log.txt", "a") as file:
                    file.write(f"The output file has not been updated for more than {timeout/60} minutes.\n")
                return "Error-3"
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
            if lattce in ['fcc', 'bcc', 'hcp', 'sc', 'dia1']:
                print(f"Optimization failed for {element2} with error: {e}")
                #with open("error_log.txt", "a") as file:
                #    file.write(f"Optimization failed for {element2} with error: {e} \n")
            else:
                print(f"Optimization failed for {element1}-{element2} with error: {e}")
                #with open("error_log.txt", "a") as file:
                #    file.write(f"Optimization failed for {element2} with error: {e} \n")
            if good_flag == 1:
                return "Error-3"
            if retries >= max_retries:
                print("Max retries reached. Skipping this combination.")
                return "Error-1"
            else:
                good_flag = 0
                continue
        if re*scaling_factor > 6.0:
            with open("error_log.txt", "a") as file:
                file.write(f"The distance between the nearest neighboring atoms exceeds 6.0 A for {lattce}-{element1}-{element2}.\n")
                file.write(f"set re = {re} A for {lattce}-{element1}-{element2}.\n")
            print(f"set re = {re} A for {lattce}-{element1}-{element2} (This mean scaling_factor = 1.0).")
            #scaling_factor = 6.0*(1-0.06)/re
            scaling_factor = 1.0
            break

    print("---------------------------------------")
    optimized_scaling_factor = scaling_factor
    print("using optimized_scaling_factor = ", optimized_scaling_factor)
    scaled_cell = original_cell * optimized_scaling_factor
    atoms.set_cell(scaled_cell, scale_atoms=True)
    print("cell = ", scaled_cell)
    #-----------------------------------------------------------------------------

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
    scaled_cell = original_cell * (6.0/re)
    atoms.set_cell(scaled_cell, scale_atoms=True)
    isolated_atom_energy2 = atoms.get_total_energy()/13.605693
    with open(f"isolated_atom_energy_{lattce}.csv", "a") as file:
        file.write(f"{element2}, {isolated_atom_energy2}\n")
    '''
    
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
    magnetic_moments = []
    
    volumes_per_atom = []
    energies_per_atom = []
    cohesive_energies_per_atom = []
    
    cells = []
    atomic_symbols = []
    atomic_positions = []
    
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
        
        # for lammps input data or potfit
        cells.append(atoms.get_cell().tolist())
        atomic_symbols.append(atoms.get_chemical_symbols())
        atomic_positions.append(atoms.get_positions().tolist())
        
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
        if magnetic_type_flag == 1:
            spin_char = 'spin_ferro'
        elif magnetic_type_flag == -1: # Cr
            spin_char = 'spin_anti-ferro'
        elif magnetic_type_flag == -2: # Mn
            spin_char = 'spin_anti-ferri'
        else:
            spin_char = 'spin'

    if PBEsol_flag == 0:
        DFT = 'PBE'
    else:
        DFT = 'PBEsol'
    
    directory = f'results_{DFT}{D_char}_{spin_char}_{lattce.upper()}'
    if not os.path.exists(directory):
        os.makedirs(directory)
    
    if lattce in ['fcc', 'bcc', 'hcp', 'sc', 'dia1', 'dim1']:
        element1 = '1element'

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
    if primitive_flag == 1 and lattce in ['b1', 'dia', 'fcc', 'dia1']:
        optimized_a = (v0 * len(atoms) * 4)**(1/3)
        optimized_b = optimized_a
        optimized_c = optimized_a
    elif primitive_flag == 1 and lattce in ['bcc']:
        optimized_a = (v0 * len(atoms) * 2)**(1/3)
        optimized_b = optimized_a
        optimized_c = optimized_a
    elif lattce == 'hcp':
        # V = np.sqrt(3)/2 * covera * a**3 -> a = (V*2/np.sqrt(3)/covera)**(1/3)
        optimized_a = (v0 * len(atoms) * 2/np.sqrt(3) / covera)**(1/3)
        optimized_b = optimized_a
        optimized_c = covera * optimized_a
    elif lattce == ['dim', 'ch4', 'dim1']:
        # V = a*(bovera*a)*(covera*a) -> a = (V/bovera/covera)**(1/3)
        optimized_a = (v0 * len(atoms) / bovera / covera)**(1/3)
        optimized_b = bovera * optimized_a
        optimized_c = covera * optimized_a
    else:
        optimized_a = (v0 * len(atoms))**(1/3)
        optimized_b = optimized_a
        optimized_c = optimized_a
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
        'Lattice Constant b (A)': optimized_b, # Values ​​in conventional cells.
        'Lattice Constant c (A)': optimized_c, # Values ​​in conventional cells.
        'b/a ratio': bovera, # b over a
        'c/a ratio': covera, # c over a
        'a/re ratio': re2a, # re to a
        'primitive cell': primitive_flag,
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
        'Forces (eV/A)': forces,
        #----------------------------------------------------------
        # For lammps input data
        'Lattice Vector': cells,
        'Atomic Positions': atomic_positions,
        'Atomic Symbols': atomic_symbols
        }
    if spin_flag == 0:
        pass
    else:
        return_data['Magnetic Moments (Bohr)'] = magnetic_moments
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
        if magnetic_type_flag == 1:
            spin_char = 'spin_ferro'
        elif magnetic_type_flag == -1: # Cr
            spin_char = 'spin_anti-ferro'
        elif magnetic_type_flag == -2: # Mn
            spin_char = 'spin_anti-ferri'
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
    result = calculate_properties(combination, omp_num_threads, mpi_num_procs, max_retries, lattce, lat, npoints, primitive_flag, PBEsol_flag, spin_flag, D_flag, cutoff, magnetic_type_flag)
    element1, element2 = combination
    if lattce in ['fcc', 'bcc', 'hcp', 'sc', 'dia1', 'dim1']:
        element1 = '1element'
    if result == "Error-1":
        with open("error_log.txt", "a") as file:
            file.write(f"Error-1, Max retries reached. Skipping this combination.: {element1}-{element2} in {DFT}{D_char}_{spin_char}_{lattce.upper()}\n")
        continue
    elif result == "Error-2":
        with open("error_log.txt", "a") as file:
            file.write(f"Error-2, It probably has not converged.: {element1}-{element2} in {DFT}{D_char}_{spin_char}_{lattce.upper()}\n")
        continue
    elif result == "Error-3":
        with open("error_log.txt", "a") as file:
            file.write(f"Error-3, Possibly an error related to output files not being updated.: {element1}-{element2} in {DFT}{D_char}_{spin_char}_{lattce.upper()}\n")
        continue
    elif result == "Error-eos-1":
        with open("error_log.txt", "a") as file:
            file.write(f"Error-eos-1, RuntimeError: Optimal parameters not found: Number of calls to function has reached maxfev = 1000.: {element1}-{element2} in {DFT}{D_char}_{spin_char}_{lattce.upper()}\n")
        continue
    results.append(result)

    with open(f'{directory}/{lattce}_{element1}-{element2}_{spin_char}.json', 'a') as jsonfile:
        json.dump(result, jsonfile, indent=4)
        jsonfile.write('\n')
'''
    with open(f'{directory}.csv', 'a', newline='') as csvfile:
        fieldnames = ['Element1', 'Element2']
        if lattce in ['fcc', 'bcc', 'hcp', 'sc', 'dia1', 'dim1']:
            # library.meam file
            fieldnames.extend([
                      'elt',
                      'lat',
                      'z',
                      'ielement',
                      'atwt',
                      'alat',
                      'esub',
                      ])
        else:
            # XX.meam file
            fieldnames.extend([
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
                      ])
        fieldnames.extend([
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
                      # fitting data for stable structure
                      #'C11', 'C12', 'C22', 'C33', 'C23', 'C13', 'C44', 'C55', 'C66', 
                      #-------------------------
                      # fitting data
                      'Volumes (A^3)', 
                      'Energies (eV)', 
                      'Cohesive Energies (eV)', 
                      'Stress Tensor per Volume (GPa)',
                      'Forces (eV/A)',
                      #-----------------------------------------------
                      # For lammps input data
                      'Lattice Vector',
                      'Atomic Positions',
                      'Atomic Symbols'
                      ])
        if spin_flag == 0:
            pass
        else:
            fieldnames.append('Magnetic Moments (Bohr)')

        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

        if i == 0:
            writer.writeheader()

        row_data = {
            'Element1': result['Element1'],
            'Element2': result['Element2']
            }
        if lattce in ['fcc', 'bcc', 'hcp', 'sc', 'dia1', 'dim1']:
            # library.meam file
            row_data.update({
                'elt': result['Element2'],
                'lat': result['Lattice Type'],
                'z': CN[lattce],
                'ielement': atomic_numbers[result['Element2']],
                'atwt': atomic_masses[result['Element2']],
                'alat': result['Lattice Constant a (A)'], # Values ​​in conventional cells.
                'esub': result['Cohesive Energy (eV/atom)'],
                })
        else:
            # XX.meam file
            row_data.update({
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
                })
        row_data.update({
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
            #----------------------------------------------------------
            # fitting data
            'Volumes (A^3)': result['Volumes (A^3)'],
            'Energies (eV)': result['Energies (eV)'],
            'Cohesive Energies (eV)': result['Cohesive Energies (eV)'],
            #-----------------------------------------------
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
            'Forces (eV/A)': result['Forces (eV/A)'],
            #-----------------------------------------------
            #For lammps input file
            'Lattice Vector': result['Lattice Vector'],
            'Atomic Positions': result['Atomic Positions'],
            'Atomic Symbols': result['Atomic Symbols']
            })
        if spin_flag == 0:
            pass
        else:
            row_data['Magnetic Moments (Bohr)'] = result['Magnetic Moments (Bohr)']
        writer.writerow(row_data)
    
    # Generate the potfit text file output for each volume and cohesive energy
    natoms = result['Atoms']
    re = result['Nearest Neighbor Distance (A)']
    la = result['Lattice Constant a (A)']
    lc = result['Lattice Constant c (A)']
    v0 = result['Optimized Volume (A^3/atom)']
    for idx, (volume, cohesive_energy, stress, force) in enumerate(zip(result['Volumes (A^3)'], 
              result['Cohesive Energies (eV)'], result['Stress Tensor per Volume (GPa)'], result['Forces (eV/A)'])):
        
        # primitive cell
        if lattce == 'bcc':
            ap = (volume * 2) ** (1/3)
        else:
            ap = (volume * 4) ** (1/3)
        
        # conventional cell
        if lattce in ['hcp', 'dim', 'ch4', 'dim1']:
            ac = la * (volume/v0)**(1/3)
            cc = lc * (volume/v0)**(1/3)
            ren = re * (volume/v0)**(1/3)
        else:
            ac = (volume) ** (1/3)
        
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
        #--------------------------------------------------------------------------
        elif lattce == 'fcc':
           if primitive_flag == 0:
               types=[0,0,0,0]
               positions=[(0, 0, 0),(0, 0.5*ac, 0.5*ac),(0.5*ac, 0, 0.5*ac),(0.5*ac, 0.5*ac, 0)]
               X = [ac, 0,  0 ]
               Y = [0,  ac, 0 ]
               Z = [0,  0,  ac]
           else:
               types=[0]
               positions=[(0, 0, 0)]
               X = [0, 0.5*ap, 0.5*ap]
               Y = [0.5*ap, 0, 0.5*ap]
               Z = [0.5*ap, 0.5*ap, 0]
        elif lattce == 'hcp':
           types=[0,0]
           #cc = ac*np.sqrt(8/3) # c = a*np.sqrt(8/3) case: re = 1.0 (atomic distance = 1.0)
           positions=[(la, np.sqrt(3)/3*2*la, 0.75*lc), (0, np.sqrt(3)/3*la, 0.25*lc)]
           X = [la, 0,  0 ]
           Y = [-la/2,  np.sqrt(3)*la/2, 0 ]
           Z = [0,  0,  lc]
        elif lattce == 'bcc':
           if primitive_flag == 0:
               types=[0]
               positions=[(0, 0, 0)]
               X = [-0.5*ap,  0.5*ap,  0.5*ap]
               Y = [ 0.5*ap, -0.5*ap,  0.5*ap]
               Z = [ 0.5*ap,  0.5*ap, -0.5*ap]
           else:
               types=[0,0]
               positions=[(0, 0, 0),(0.5*ac, 0.5*ac, 0.5*ac)]
               X = [ac, 0,  0 ]
               Y = [0,  ac, 0 ]
               Z = [0,  0,  ac]
        elif lattce == 'sc':
           types=[0]
           positions=[(0, 0, 0)]
           X = [ac, 0,  0 ]
           Y = [0,  ac, 0 ]
           Z = [0,  0,  ac]
        elif lattce == 'dia1':
           if primitive_flag == 0:
               types=[0,0,0,0,0,0,0,0]
               positions=[(0, 0, 0), (0.5*ac, 0.5*ac, 0), (0.5*ac, 0, 0.5*ac), (0, 0.5*ac, 0.5*ac), 
                          (0.25*ac, 0.75*ac, 0.75*ac), (0.25*ac, 0.25*ac, 0.25*ac), (0.75*ac, 0.75*ac, 0.25*ac), 
                          (0.75*ac, 0.25*ac, 0.75*ac)]
               X = [ac, 0,  0 ]
               Y = [0,  ac, 0 ]
               Z = [0,  0,  ac]
           else:
               types=[0,0]
               positions=[(0, 0, 0),(0.25*ap, 0.25*ap, 0.25*ap)]
               X = [0, 0.5*ap, 0.5*ap]
               Y = [0.5*ap, 0, 0.5*ap]
               Z = [0.5*ap, 0.5*ap, 0]
        #--------------------------------------------------------------------------
        elif lattce == 'dim':
           types=[0,1]
           positions=[(0.5*ac, 0.5*ac, 0.5*ac+ren/2),
                      (0.5*ac, 0.5*ac, 0.5*ac-ren/2)]
           X = [ac, 0,  0 ]
           Y = [0,  ac, 0 ]
           Z = [0,  0,  cc]
        elif lattce == 'ch4':
           types=[0,1,1,1,1]
           positions=[(0.5*ac,     0.5*ac,     0.5*ac    ),  # Carbon atom
                      (0.5*ac+ren, 0.5*ac+ren, 0.5*ac+ren),  # Hydrogen atoms
                      (0.5*ac-ren, 0.5*ac-ren, 0.5*ac+ren),  # Hydrogen atoms
                      (0.5*ac+ren, 0.5*ac-ren, 0.5*ac-ren),  # Hydrogen atoms
                      (0.5*ac-ren, 0.5*ac+ren, 0.5*ac-ren)]  # Hydrogen atoms
           X = [ac, 0,  0 ]
           Y = [0,  ac, 0 ]
           Z = [0,  0,  ac]
        #------------------------------------------------------------------------------
        elif lattce == 'dim1':
           types=[0,0]
           positions=[(0.5*ac, 0.5*ac, 0.5*ac+ren/2),(0.5*ac, 0.5*ac, 0.5*ac-ren/2)]
           X = [ac, 0,  0 ]
           Y = [0,  ac, 0 ]
           Z = [0,  0,  cc]
        else:
           print("This code does not provide other structures. (Possible structures: b1, b2, dia, l12, or fcc, bcc, hcp, dia1, dim, ch4, dim1)")
        
        # xyz_array = [[pos[0], pos[1], pos[2]] for pos in positions]
        x_coords = [pos[0] for pos in positions]
        y_coords = [pos[1] for pos in positions]
        z_coords = [pos[2] for pos in positions]
        
        #print(f"## check {natoms} vs. {len(types)}")
        
        with open(f'{directory}/potfit_{lattce}_{element1}-{element2}_{spin_char}.config', 'a') as txtfile:
            txtfile.write(f"#N {natoms} 1\n")
            if lattce in ['fcc', 'bcc', 'hcp', 'sc', 'dia1', 'dim1']:
                txtfile.write(f"#C {element2}\n")
            else:
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
'''
print(f"Calculations are complete and results are saved to json file.")
print(f"----------------------------------------------------------------------")
print(f"----------------------------------------------------------------------")
