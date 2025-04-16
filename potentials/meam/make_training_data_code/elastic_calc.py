import json
import csv
from itertools import combinations
from ase import Atoms
from ase.calculators.espresso import Espresso
from ase.optimize import BFGS
from ase.eos import EquationOfState
from ase.units import Bohr, Rydberg, kJ, kB, fs, Hartree, mol, kcal
from ase.dft.kpoints import monkhorst_pack
from ase.build import bulk, make_supercell
import numpy as np
import os
import copy

elements = ['Al']
lattices = ['fcc', 'bcc', 'sc', 'dia1', 'hcp', 'dim1']

top_file_name = '1element_data_PBE_start-spin-mag-0'

def calculate_elastic_constants(atoms, calc, normal_strains, shear_strains):
    initial_stress_tensor = calc.get_stress()
    print(f'initial_stress_tensor: {initial_stress_tensor}')
    # Returns an array of the six independent components of the symmetric stress tensor, 
    # in the traditional Voigt order (xx, yy, zz, yz, xz, xy) or as a 3x3 matrix. Default is Voigt order.
    # Voigt: s11 -> 0, s22 -> 2, s33 -> 2, s23 -> 3, s13 -> 4, s12 -> 5
    # https://mineralscloud.github.io/cij/tutorial/tensor-symmetry.html
    
    # Normal strains for C11, C12, etc.
    normal_stresses = {'C11': [], 'C12': [], 'C22': [], 'C33': [], 'C23': [], 'C13': []}
    initial_atoms = atoms.copy()
    for strain in normal_strains:
        print("# Apply strain in Xx direction and get stress in Xx direction for C11")
        normal_atoms = copy.deepcopy(initial_atoms) # Create a deep copy of initial_atoms
        strain_matrix = normal_atoms.get_cell() + [[strain, 0, 0], [0, 0, 0], [0, 0, 0]] # Xx = 1
        normal_atoms.set_cell(strain_matrix, scale_atoms=True)
        normal_atoms.set_calculator(calc)
        opt = BFGS(normal_atoms)
        opt.run(fmax=0.02)
        normal_stress = normal_atoms.get_stress()
        normal_stresses['C11'].append((normal_stress[0] - initial_stress_tensor[0]) / strain) # Xx = 1
        print(f'{normal_stress}')

        print("# Apply strain in Yy direction and get stress in Yy direction for C22")
        normal_atoms = copy.deepcopy(initial_atoms) # Create a deep copy of initial_atoms
        strain_matrix = normal_atoms.get_cell() + [[0, 0, 0], [0, strain, 0], [0, 0, 0]] # Yy = 2
        normal_atoms.set_cell(strain_matrix, scale_atoms=True)
        normal_atoms.set_calculator(calc)
        opt = BFGS(normal_atoms)
        opt.run(fmax=0.02)
        normal_stress = normal_atoms.get_stress()
        normal_stresses['C22'].append((normal_stress[1] - initial_stress_tensor[1]) / strain) # Yy = 2
        print(f'{normal_stress}')

        print("# Apply strain in Zz direction and get stress in Zz direction for C33")
        normal_atoms = copy.deepcopy(initial_atoms) # Create a deep copy of initial_atoms
        strain_matrix = normal_atoms.get_cell() + [[0, 0, 0], [0, 0, 0], [0, 0, strain]] # Zz = 3
        normal_atoms.set_cell(strain_matrix, scale_atoms=True)
        normal_atoms.set_calculator(calc)
        opt = BFGS(normal_atoms)
        opt.run(fmax=0.02)
        normal_stress = normal_atoms.get_stress()
        normal_stresses['C33'].append((normal_stress[2] - initial_stress_tensor[2]) / strain) # Zz = 3
        print(f'{normal_stress}')

    C11 = np.mean(normal_stresses['C11']) * 160.21766208
    C22 = np.mean(normal_stresses['C22']) * 160.21766208
    C33 = np.mean(normal_stresses['C33']) * 160.21766208
    print(C11,C22,C33)

    for strain in normal_strains:
        print("# Apply strain in Yz direction and get stress in Xx direction for C12")
        normal_atoms = copy.deepcopy(initial_atoms) # Create a deep copy of initial_atoms
        strain_matrix = normal_atoms.get_cell() + [[0, 0, 0], [0, strain, 0], [0, 0, 0]]  # Yy = 2
        normal_atoms.set_cell(strain_matrix, scale_atoms=True)
        normal_atoms.set_calculator(calc)
        opt = BFGS(normal_atoms)
        opt.run(fmax=0.02)
        normal_stress = normal_atoms.get_stress()
        normal_stresses['C12'].append((normal_stress[0] - initial_stress_tensor[0]) / strain) # Xx = 1
        print(f'{normal_stress}')

        print("# Apply strain in Zz direction and get stress in Yy direction for C23")
        normal_atoms = copy.deepcopy(initial_atoms) # Create a deep copy of initial_atoms
        strain_matrix = normal_atoms.get_cell() + [[0, 0, 0], [0, 0, 0], [0, 0, strain]] # Zz = 3
        normal_atoms.set_cell(strain_matrix, scale_atoms=True)
        normal_atoms.set_calculator(calc)
        opt = BFGS(normal_atoms)
        opt.run(fmax=0.02)
        normal_stress = normal_atoms.get_stress()
        normal_stresses['C23'].append((normal_stress[1] - initial_stress_tensor[1]) / strain) # Yy = 2
        print(f'{normal_stress}')

        print("# Apply strain in Zz direction and get stress in Xx direction for C13")
        normal_atoms = copy.deepcopy(initial_atoms) # Create a deep copy of initial_atoms
        strain_matrix = normal_atoms.get_cell() + [[0, 0, 0], [0, 0, 0], [0, 0, strain]] # Zz = 3
        normal_atoms.set_cell(strain_matrix, scale_atoms=True)
        normal_atoms.set_calculator(calc)
        opt = BFGS(normal_atoms)
        opt.run(fmax=0.02)
        normal_stress = normal_atoms.get_stress()
        normal_stresses['C13'].append((normal_stress[0] - initial_stress_tensor[0]) / strain) # Xx = 1
        print(f'{normal_stress}')

    C12 = np.mean(normal_stresses['C12']) * 160.21766208
    C23 = np.mean(normal_stresses['C23']) * 160.21766208
    C13 = np.mean(normal_stresses['C13']) * 160.21766208
    print(C12,C23,C13)

    shear_stresses = {'C44': [], 'C55': [], 'C66': []}
    for strain in shear_strains:
        print("# Apply strain in Yz direction and get stress in Yz direction for C44")
        shear_atoms = copy.deepcopy(initial_atoms) # Create a deep copy of initial_atoms
        strain_matrix = normal_atoms.get_cell() + [[0, 0, 0], [0, 0, strain], [0, 0, 0]] # Yz = 4
        normal_atoms.set_cell(strain_matrix, scale_atoms=True)
        shear_atoms.set_calculator(calc)
        opt = BFGS(normal_atoms)
        opt.run(fmax=0.02)
        shear_stress = shear_atoms.get_stress()
        shear_stresses['C44'].append((shear_stress[3] - initial_stress_tensor[3]) / strain) # Yz = 4
        print(f'{normal_stress}')

        print("# Apply strain in Xz direction and get stress in Xz direction for C55")
        shear_atoms = copy.deepcopy(initial_atoms) # Create a deep copy of initial_atoms
        strain_matrix = normal_atoms.get_cell() + [[0, 0, strain], [0, 0, 0], [0, 0, 0]] # Xz = 5
        normal_atoms.set_cell(strain_matrix, scale_atoms=True)
        shear_atoms.set_calculator(calc)
        opt = BFGS(normal_atoms)
        opt.run(fmax=0.02)
        shear_stress = shear_atoms.get_stress()
        shear_stresses['C55'].append((shear_stress[4] - initial_stress_tensor[4]) / strain) # Xz = 5
        print(f'{normal_stress}')

        print("# Apply strain in Xy direction and get stress in Xy direction for C66")
        shear_atoms = copy.deepcopy(initial_atoms) # Create a deep copy of initial_atoms
        strain_matrix = normal_atoms.get_cell() + [[0, strain, 0], [0, 0, 0], [0, 0, 0]] # Xy = 6
        normal_atoms.set_cell(strain_matrix, scale_atoms=True)
        shear_atoms.set_calculator(calc)
        opt = BFGS(normal_atoms)
        opt.run(fmax=0.02)
        shear_stress = shear_atoms.get_stress()
        shear_stresses['C66'].append((shear_stress[5] - initial_stress_tensor[5]) / strain) # Xy = 6
        print(f'{normal_stress}')

    C44 = np.mean(shear_stresses['C44']) * 160.21766208
    C55 = np.mean(shear_stresses['C55']) * 160.21766208
    C66 = np.mean(shear_stresses['C66']) * 160.21766208
    print(C44,C55,C66)
    
    Bv = ((C11+C22+C33)/3 + 2*(C12+C13+C23)/3)/3
    Gv = (C11+C22+C33-C12-C13-C23)/15 + (C44+C55+C66)/5
    G1 = (C44+C55+C66)/3
    G2 = ((C11+C22+C33)/3 - (C12+C13+C23)/3)/2
    Po = 1.0/(1.0+(C11+C22+C33)/(C12+C13+C23))

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
        'Bulk Modulus, Bv': Bv,
        'Shear Modulus, Gv': Gv,
        'Shear Modulus, G1': G1,
        'Shear Modulus, G2': G2,
        'Poisson Ratio': Po
    }

# Dummy: Am = Cr-antiferromagnetic, Cm=Mn-antiferrimagnetic
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
    "Pa": 0.05,  "U": 0.05, "Np": 0.05, "Pu": 0.05, "XX": 0.01, "Am": 0.05, "Cm": 0.05
}

cohesive_energy = [0.0] * len(lattices)
formation_energy = [0.0] * len(lattices)
lattce_boltz = [0.0] * len(lattices)
lattce_rate = [0.0] * len(lattices)
DFT = 'PBE'
spin_char = 'spin'
kbT = 8.617333262e-5 * 300  # at 300 K
for element in elements:
    i = 0
    Z = 0.0
    for lattice in lattices:  # Corrected variable name
        # Load the JSON file
        file_path = f'./{top_file_name}/results_{DFT}_{spin_char}_{lattice.upper()}/{lattice}_1element-{element}_{spin_char}.json'
        try:
            with open(file_path, 'r') as f:
                data = json.load(f)
            cohesive_energy[i] = data.get("Cohesive Energy (eV/atom)", None)  # Corrected the key format
        except FileNotFoundError:
            print(f"File not found: {element}-{lattice}")
            i += 1
            continue
        i += 1
    cohesive_energy_sorted_indices = np.argsort(cohesive_energy)[::-1]
    cohesive_energy_sorted = [cohesive_energy[i] for i in cohesive_energy_sorted_indices]
    lattices_sorted = [lattices[i] for i in cohesive_energy_sorted_indices]
    formation_energy_sorted = cohesive_energy_sorted[0] - np.array(cohesive_energy_sorted)
    
    print("Lattices Sorted:", lattices_sorted)
    print("Cohesive Energy Sorted:", cohesive_energy_sorted)
    print("Formation Energy Sorted:", np.round(formation_energy_sorted, 3))
    
    # Calculate Boltzmann factors in one go
    lattce_boltz = np.exp(np.array(cohesive_energy_sorted) / kbT)
    Z = np.sum(lattce_boltz)
    #print(lattce_boltz)
    print('Distribution function, Z:',Z)
    
    lattce_rate = lattce_boltz / Z * 100.0
    print('Rate [%]:', np.round(lattce_rate, 1))
    
    stable_lattice = lattices_sorted[0]
    # Load the JSON file
    file_path = f'./{top_file_name}/results_{DFT}_{spin_char}_{stable_lattice.upper()}/{stable_lattice}_1element-{element}_{spin_char}.json'
    with open(file_path, 'r') as f:
        data = json.load(f)
    
    # Extract necessary data
    element1 = data["Element1"]
    if element1 == '1element':
       element1 = 'XX'
    element2 = data["Element2"]
    a = data["Lattice Constant a (A)"]
    c = data["Lattice Constant c (A)"]
    structure_type = data["Lattice Type"].lower()
    
    kpt = 19 # MProj: 19
    kptc = 19 # MProj: 19
    # Correct structure types
    if structure_type == 'sc (1 element)':
        structure_type = 'sc'
        atoms = bulk(element, structure_type, a, cubic=True)
    elif structure_type == 'hcp (1 element)':
        structure_type = 'hcp'
        atoms = bulk(element, structure_type, a, c, orthorhombic=True)
        kptc = 12 # MProj: 12
    elif structure_type == 'dia':
        structure_type = 'diamond'
        atoms = bulk(element, structure_type, a, cubic=True)
    else:
        atoms = bulk(element, structure_type, a, cubic=True)
    
    pseudo_dir = DFT
    if pseudo_dir == 'PBE':
        with open('PBE/PSlibrary_ONCV_GBRV_mix_PBE_v2.json', 'r') as f:
            pseudopotentials = json.load(f)
    else:
        with open('PBEsol/PSlibrary_ONCV_GBRV_mix_PBEsol_v2.json', 'r') as f:
            pseudopotentials = json.load(f)
    
    nspin = 2

    pseudopotentials_dict = {
        element1: pseudopotentials[element1]['filename'],
        element2: pseudopotentials[element2]['filename']
    }
    input_data = {
        'control': {
            'calculation': 'scf',
            'restart_mode': 'from_scratch',
            'prefix': f'{stable_lattice}_{element1}_{element2}',
            'pseudo_dir': f'{pseudo_dir}',
            'outdir': './out',
            'tprnfor': True, # Forces will be printed
            'tstress': True, # Stress will be printed
            'nstep': 50,   # for MD or structure optimization (default = 50)
            'etot_conv_thr': 1.0e-4*len(atoms), # 1.36 meV/atom <= about 1 meV/atom
            #'forc_conv_thr': 1.0e-3 # dafault value
            'disk_io': 'low',
        },
        'system': {
            # 700/520 = 1.34615384615, MProj: 700 [eV]
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
            'nosym': True, # <- for stress calculation
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
    
    D_flag = 0
    
    if D_flag == 0:
        input_data['system']['vdw_corr'] = 'none'
    elif D_flag == 1:
        input_data['system']['vdw_corr'] = 'dft-d'
    elif D_flag == 2:
        input_data['system']['vdw_corr'] = 'dft-d3'
        input_data['system']['dftd3_threebody'] = False
    elif D_flag == 3:
        input_data['system']['vdw_corr'] = 'dft-d3'
    
    if stable_lattice in ['fcc', 'hcp', 'bcc', 'sc', 'dia1', 'dim1', 'v1fcc', 'v1bcc', 'v1hcp', 'v1sc', 'v1dia1']:
        input_data['control']['prefix'] = f'{stable_lattice}_{element2}'
        input_data['system']['ecutwfc'] = pseudopotentials[element2]['cutoff_wfc']
        input_data['system']['ecutrho'] = pseudopotentials[element2]['cutoff_rho']
    
    cutoff = 0
    
    if cutoff == 0:
        pass
    elif cutoff > 0:
        input_data['system']['ecutwfc'] = cutoff/Rydberg
        input_data['system']['ecutrho'] = cutoff*4.0/Rydberg
    else:
        input_data['system']['ecutwfc'] = 700/Rydberg
        input_data['system']['ecutrho'] = 700*4.0/Rydberg
    
    mpi_num_procs = 8 # Test CPU: 12th Gen Intel(R) Core(TM) i7-12700
    omp_num_threads = 1
    os.environ['OMP_NUM_THREADS'] = f'{omp_num_threads}'
    
    if stable_lattice in ['dim', 'ch4', 'dim1']:
        calc = Espresso(pseudopotentials=pseudopotentials_dict, input_data=input_data, kpts=(1,1,1), koffset=False, nspin=nspin, command=f'mpirun -np {mpi_num_procs} pw.x < espresso.pwi > espresso.pwo')
    else:
        calc = Espresso(pseudopotentials=pseudopotentials_dict, input_data=input_data, kpts=(kpt, kpt, kptc), nspin=nspin, command=f'mpirun -np {mpi_num_procs} pw.x < espresso.pwi > espresso.pwo')
        #calc = Espresso(pseudopotentials=pseudopotentials_dict, input_data=input_data, kpts=(kpt, kpt, kptc), koffset=True, nspin=nspin, command=f'mpirun -np {mpi_num_procs} pw.x < espresso.pwi > espresso.pwo')
        #calc = Espresso(pseudopotentials=pseudopotentials_dict, input_data=input_data, kpts=(kpt, kpt, kptc), nspin=nspin, command=f'mpirun -np {mpi_num_procs} pw.x < espresso.pwi > espresso.pwo')
    atoms.set_calculator(calc)
    
    '''
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
            atoms.set_initial_magnetic_moments([smag1/4, smag1/4, smag1/4, smag1/4, smag2])
        else:
            atoms.set_initial_magnetic_moments([smag1] * len(atoms))
    elif magnetic_type_flag == -1:
        print('anti-ferro magnetic calculation (e.g., Cr)')
        if lattce ['l12']:
            atoms.set_initial_magnetic_moments([smag1/4, smag1/4, smag1/4, smag1/4, -smag2])
        elif len(atoms) == 1:
            atoms.set_initial_magnetic_moments([smag1])
        elif len(atoms) == 2:
            atoms.set_initial_magnetic_moments([smag1, -smag2])
    elif magnetic_type_flag == -2:
        print('anti-ferro magnetic calculation (e.g., Mn)')
        if lattce ['l12']:
            atoms.set_initial_magnetic_moments([smag1/4, smag1/4, smag1/4, smag1/4, -smag2])
        elif len(atoms) == 1:
            atoms.set_initial_magnetic_moments([smag1])
        elif len(atoms) == 2:
            atoms.set_initial_magnetic_moments([smag1, -smag2*0.9])
    else:
        # default = 0.0 in ASE
        pass
    '''
    
    print("---------------------------------")
    print(f"initial stress tensor calculation: {stable_lattice}")
    input_data['control']['calculation'] = 'scf'
    atoms.set_calculator(calc)
    calc.calculate(atoms) # or energy = atoms.get_potential_energy()
    
    input_data['control']['calculation'] = 'relax'
    # Deformation (epsilon, strain)
    # Baskes (1994).: 1.0e-3
    # Elastic (lammps example): 1.0e-6*lattice constant
    # Phase0 manual: 0.001 = 1.0e-3 [au] (au = bohr = 0.529 Angstrom)
    # Materials Project: -0.01, -0.005, 0.005, 0.01
    elastic_constants_final = calculate_elastic_constants(atoms, calc, [-0.01, 0.01], [-0.01, 0.01])
    
    with open(f'./{stable_lattice}_{element1}-{element2}_{spin_char}_elastic.json', 'a') as jsonfile:
        json.dump(elastic_constants_final, jsonfile, indent=4)
        jsonfile.write('\n')