import gc
import shutil
import os

# 1 elements
#lattices = ['fcc', 'bcc', 'sc', 'dia1', 'hcp']
#lattices = ['dim1']
#file_path = 'run_1element_or_alloy_v1.0.py'

# 2 pair
lattices = ['b1', 'b2', 'l12', 'dia']
file_path = 'run_alloy_v1.1.py'

# 2 pair
#lattices = ['b1', 'b2', 'l12', 'dia', 'ch4']
#file_path = 'run_1element_or_alloy_v1.1.py'

calc_dir = 'out'

elements = ['H','He'] # <- Enter the element you want to calculate (Note: Time Consumption: Approx. 4 elements/hour)

for element in elements:
    # Create the element directory (if it doesn't exist)
    element_dir = f"{element}-X"
    if not os.path.exists(element_dir):
        os.makedirs(element_dir)
    
    for lattice in lattices:
        gc.collect()
        
        with open(file_path, 'r') as file:
            code = file.read()
        
        # Replace 'YYYYYYYYYY' with the element value
        modified_code = code.replace('YYYYYYYYYY', element)
        
        # Replace 'XXXXXXXXXX' with the lattice value
        modified_code = modified_code.replace('XXXXXXXXXX', lattice)
        
        # Write the modified code to a temporary file
        temp_file_path = 'temp_run.py'
        with open(temp_file_path, 'w') as temp_file:
            temp_file.write(modified_code)
        
        # Execute the temporary file
        print(f"Running with lattice: {lattice}")
        os.system(f"python3 {temp_file_path}")
        
        # Remove the temporary file
        os.remove(temp_file_path)
        
        # Move results to the element directory
        for method in ['PBE', 'PBEsol']:
            results_dir = f"results_{method}_spin_{lattice}"
            if os.path.exists(results_dir):
                shutil.move(results_dir, element_dir)
                print(f"{results_dir} has been moved to {element_dir}.")
            
            results_csv = f"results_{method}_spin_{lattice}.csv"
            if os.path.exists(results_csv):
                shutil.move(results_csv, os.path.join(element_dir, results_dir))
                print(f"{results_csv} has been moved to {element_dir}/{results_dir} .")
        
        if os.path.exists(calc_dir):
            shutil.rmtree(calc_dir)
            print(f"{calc_dir} has been deleted.")
        else:
            print(f"{calc_dir} does not exist.")
    
    # Move error_log.txt to the element directory
    results_text = "error_log.txt"
    if os.path.exists(results_text):
        shutil.move(results_text, element_dir)
        print(f"{results_text} has been moved to {element_dir}.")

gc.collect()
