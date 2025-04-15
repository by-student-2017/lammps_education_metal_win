#from ase.build import bulk, make_supercell
#from ase.calculators.espresso import Espresso
#from ase.io import write, read
import numpy as np
import json

elements = ['Co']
lattices = ['fcc', 'bcc', 'sc', 'dia1', 'hcp', 'dim1']

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
        file_path = f'./1element_data_{DFT}/results_{DFT}_{spin_char}_{lattice.upper()}/{lattice}_1element-{element}_{spin_char}.json'
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
