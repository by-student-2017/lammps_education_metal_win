import gc
#import shutil
import os

file_path_Bay = 'Bayesian_fit.py'
file_path_Nel = 'Nelder-Mead_fit.py'
file_path_Par = 'particle_swarm_fit.py'

calc_dir = 'out'

elements = ['Er'] # <- Enter the element you want to calculate (Note: Time Consumption: Approx. 4 elements/hour)

for element in elements:
    
    file_path = 'evalulation_template_seq.py'
    with open(file_path, 'r') as file:
        code = file.read()
    
    # Replace 'Xelement' with the element value
    modified_code = code.replace('Xelement', element)
    
    # Write the modified code to a temporary file
    temp_file_path = 'evalulation_template.py'
    with open(temp_file_path, 'w') as temp_file:
        temp_file.write(modified_code)
    
    # Create the element directory (if it doesn't exist)
    element_dir = f'{element}-Bayesian/{element}'
    if not os.path.exists(element_dir):
        os.makedirs(element_dir)
    os.system(f'python3 {file_path_Bay} | tee log.txt')
    os.system(f'mv XX.meam {element_dir}')
    os.system(f'mv library.meam {element_dir}')
    os.system(f'mv results.txt {element_dir}')
    os.system(f'mv logs.json {element_dir}')
    os.system(f'mv log.txt {element_dir}')
    
    gc.collect()
    
    element_dir = f'{element}-Nelder-Mead/{element}'
    if not os.path.exists(element_dir):
        os.makedirs(element_dir)
    os.system(f'python3 {file_path_Nel} | tee log.txt')
    os.system(f'mv XX.meam {element_dir}')
    os.system(f'mv library.meam {element_dir}')
    os.system(f'mv results.txt {element_dir}')
    os.system(f'mv log.txt {element_dir}')
    
    gc.collect()
    
    element_dir = f'{element}-particle_swarm/{element}'
    if not os.path.exists(element_dir):
        os.makedirs(element_dir)
    os.system(f'python3 {file_path_Par} | tee log.txt')
    os.system(f'mv XX.meam {element_dir}')
    os.system(f'mv library.meam {element_dir}')
    os.system(f'mv results.txt {element_dir}')
    os.system(f'mv report.log {element_dir}')
    os.system(f'mv log.txt {element_dir}')