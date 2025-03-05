import json
import os
from ase import Atoms
from ase.calculators.espresso import Espresso
from ase.units import Rydberg
import xml.etree.ElementTree as ET

#--------------------------------------------------------------------------------
# User input section
#------------------------------------------------------------------
DFT = 'PBE'  # PBE or PBEsol

json_file = f'PSlibrary_{DFT}.json'

# cutoff [eV], 0:read PP file, (520 eV is the main in the Materials Project, except Boron (700 eV)), negative value (< 0): 520 eV
cutoff = 0  # 550 eV = about 40 Ry, 900 eV = about 65 Ry

spin_flag = 1  # 0:non-spin, 1:spin, (default = 1)

# Set the number of OpenMP threads
omp_num_threads = 4
#------------------------------------------------------------------
# User input section: END
#--------------------------------------------------------------------------------

# Set the number of OpenMP threads
os.environ['OMP_NUM_THREADS'] = f'{omp_num_threads}'
mpi_num_procs = 1

# Load the pseudopotential data from the JSON file
print("Loading pseudopotential data...")
with open(f'{DFT}/{json_file}', 'r') as f:
    pseudopotentials = json.load(f)
print("Pseudopotential data loaded.")

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

# Function to calculate the energy of an isolated atom
def calculate_isolated_atom_energy(element, omp_num_threads):
    print(f"Calculating energy for isolated atom: {element}")
    # Define a simple cubic cell with 12 A (6 * 2 = 12 [Angstrom])
    atoms = Atoms(element, positions=[(0, 0, 0)], cell=[12, 12, 12])
    
    pseudo_file = os.path.join(f'./{DFT}', pseudopotentials[element]['filename'])
    valence_electrons = get_valence_electrons(pseudo_file)
    pseudopotentials[element]['valence_electrons'] = valence_electrons
    print(f'valence_electrons = {valence_electrons}')
    
    pseudopotentials_dict = {
        element: pseudopotentials[element]['filename']
    }
    input_data = {
        'control': {
            'calculation': 'scf',
            'restart_mode': 'from_scratch',
            'prefix': f'isolated_{element}',
            'pseudo_dir': f'./{DFT}',
            'outdir': './out',
            'etot_conv_thr': 1.0e-4 / 2,  # 0.68 meV/atom <= about 1 meV/atom
            'wf_collect': False,
            'disk_io': 'low',  # qe-7.2:'minimal', qe-7.3:'nowf'
        },
        'system': {
            'ecutwfc': pseudopotentials[element]['cutoff_wfc'],
            'ecutrho': pseudopotentials[element]['cutoff_rho'],
            'occupations': 'smearing',
            'smearing': 'mp',
            'degauss': 0.01,  # 0.01 = about 150 K, 0.02 = about 300 K, 0.01 is better for Equation of states (eos).
            #'vdw_corr': 'dft-d', # DFT-D2 (Semiempirical Grimme's DFT-D2. Optional variables)
        },
        'electrons': {
            'conv_thr': 1.0e-6 / 2
        }
    }
    
    if cutoff == 0:
        pass
    elif cutoff > 0:
        input_data['system']['ecutwfc'] = cutoff / Rydberg
        input_data['system']['ecutrho'] = cutoff * 4.0 / Rydberg
    else:
        input_data['system']['ecutwfc'] = 520 / Rydberg
        input_data['system']['ecutrho'] = 520 * 4.0 / Rydberg

    input_data['system']['nspin'] = 2 if spin_flag else 1

    calc = Espresso(pseudopotentials=pseudopotentials_dict, input_data=input_data, kpts=None, omp_num_threads=omp_num_threads, mpi_num_procs=mpi_num_procs)
    atoms.set_calculator(calc)
    
    energy = atoms.get_potential_energy()
    print(f"Energy for {element}: {energy} eV")
    return energy

# Calculate and add isolated atom energies to the pseudopotentials dictionary
print("Starting energy calculations for isolated atoms...")
elements = list(pseudopotentials.keys())
for i, element in enumerate(elements):
    isolated_atom_energy = calculate_isolated_atom_energy(element, omp_num_threads)
    pseudopotentials[element]['isolated_atom_energy'] = isolated_atom_energy

# Save the updated pseudopotential data to a new JSON file
print("Saving updated pseudopotential data...")
with open(f'{DFT}/new_{json_file}', 'w') as f:
    json.dump(pseudopotentials, f, indent=4)
print("Isolated atom energies and valence electrons have been calculated and added to the new JSON file.")
