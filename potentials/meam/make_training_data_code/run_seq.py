import os

# 1 elements
lattices = ['fcc', 'hcp', 'bcc', 'sc', 'dia1']
file_path = 'run_1element_or_alloy_v1.0.py'

# 2 pair
#lattices = ['b1', 'b2', 'dia', 'l12']
#file_path = 'run_alloy_v1.1.py'

# 2 pair
#lattices = ['b1', 'b2', 'dia', 'l12', 'ch4']
#file_path = 'run_1element_or_alloy_v1.1.py'

for lattice in lattices:
    with open(file_path, 'r') as file:
        code = file.read()
    
    # Replace 'XXXXXXXXXX' with the lattice value
    modified_code = code.replace('XXXXXXXXXX', lattice)
    
    # Write the modified code to a temporary file
    temp_file_path = 'temp_run.py'
    with open(temp_file_path, 'w') as temp_file:
        temp_file.write(modified_code)
    
    # Execute the temporary file
    print(f"Running with lattice: {lattice}")
    os.system(f"python {temp_file_path}")
    
    # Remove the temporary file
    os.remove(temp_file_path)