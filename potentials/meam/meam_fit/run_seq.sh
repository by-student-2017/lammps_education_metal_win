#!/bin/bash

# Define file paths
file_path_Bay="Bayesian_fit.py"
file_path_Nel="Nelder-Mead_fit.py"
file_path_Par="particle_swarm_fit.py"

calc_dir="out"

# H                                                                   He
# Li  Be                                           B   C   N   O   F  Ne
# Na  Mg                                          Al  Si   P   S  Cl  Ar
#  K  Ca  Sc  Ti   V  Cr  Mn  Fe  Co  Ni  Cu  Zn  Ga  Ge  As  Se  Br  Kr
# Rb  Sr   Y  Zr  Nb  Mo  Tc  Ru  Rh  Pd  Ag  Cd  In  Sn  Sb  Te   I  Xe
# Cs  Ba  La 
#         Ce  Pr  Nd  Pm  Sm  Eu  Gd  Tb  Dy  Ho  Er  Tm  Yb  Lu 
#             Hf  Ta   W  Re  Os  Ir  Pt  Au  Hg  Tl  Pb  Bi  Po  At  Ra
#         Rn  Fr  Ac  Th  Pa   U  Np  Pu

# sc: As Sb Bi S Se Te
# fcc: In La Pm Ir Ac Th Pa Pu
# bcc: Cu U Np Br I Rb K
# hcp: Sc Ru Pr Sm Eu Gd Tb Dy Ho Er Tm Yb Lu Re Os Hg
elements=(Sc Ru Pr Sm Eu Gd Tb Dy Ho Er Tm Yb Lu Re Os Hg) # <- Enter the element you want to calculate (Note: Time Consumption: Approx. 4 elements/hour)

ncpu=1

for element in "${elements[@]}"; do
    
    #-----
    file_path="evalulation_template_seq.py"
    code=$(<"$file_path")
    
    # Replace 'Xelement' with the element value
    modified_code="${code//Xelement/$element}"
    
    # Write the modified code to a temporary file
    temp_file_path="evalulation_template.py"
    echo "$modified_code" > "$temp_file_path"
    #-----
    
    
    #-----
    file_path="json2library_template.py"
    code=$(<"$file_path")
    
    # Replace 'Xelement' with the element value
    modified_code="${code//Xelement/$element}"
    
    # Write the modified code to a temporary file
    temp_file_path="json2library.py"
    echo "$modified_code" > "$temp_file_path"
    #-----
    
    
    #-----
    file_path="Bayesian_fit_template.py"
    code=$(<"$file_path")
    
    # Replace 'Xelement' with the element value
    modified_code="${code//Xelement/$element}"
    modified_code="${modified_code//XXncpu/$ncpu}"
    
    # Write the modified code to a temporary file
    temp_file_path="Bayesian_fit.py"
    echo "$modified_code" > "$temp_file_path"
    #-----
    
    
    #-----
    file_path="Nelder-Mead_fit_template.py"
    code=$(<"$file_path")
    
    # Replace 'Xelement' with the element value
    modified_code="${code//Xelement/$element}"
    modified_code="${modified_code//XXncpu/$ncpu}"
    
    # Write the modified code to a temporary file
    temp_file_path="Nelder-Mead_fit.py"
    echo "$modified_code" > "$temp_file_path"
    #-----
    
    
    #-----
    file_path="particle_swarm_fit_template.py"
    code=$(<"$file_path")
    
    # Replace 'Xelement' with the element value
    modified_code="${code//Xelement/$element}"
    modified_code="${modified_code//XXncpu/$ncpu}"
    
    # Write the modified code to a temporary file
    temp_file_path="particle_swarm_fit.py"
    echo "$modified_code" > "$temp_file_path"
    #-----
    
    python3 json2library.py
    
    #-----
    # Create the element directory (if it doesn't exist)
    element_dir="Bayesian/${element}"
    mkdir -p "$element_dir"
    python3 "$file_path_Bay" | tee log.txt
    mv XX.meam "$element_dir"
    mv library.meam "$element_dir"
    mv results.txt "$element_dir"
    mv results_sort.txt "$element_dir"
    mv logs.json "$element_dir"
    mv log.txt "$element_dir"
    #-----
    # Collect garbage
    sync; echo 3 > /proc/sys/vm/drop_caches
    
    #-----
    element_dir="Nelder-Mead/${element}"
    mkdir -p "$element_dir"
    python3 "$file_path_Nel" | tee log.txt
    mv XX.meam "$element_dir"
    mv library.meam "$element_dir"
    mv results.txt "$element_dir"
    mv results_sort.txt "$element_dir"
    mv log.txt "$element_dir"
    #-----
    # Collect garbage
    sync; echo 3 > /proc/sys/vm/drop_caches
    
    #-----
    element_dir="particle_swarm/${element}"
    mkdir -p "$element_dir"
    python3 "$file_path_Par" | tee log.txt
    mv XX.meam "$element_dir"
    mv library.meam "$element_dir"
    mv results.txt "$element_dir"
    mv results_sort.txt "$element_dir"
    mv report.log "$element_dir"
    mv log.txt "$element_dir"
    #-----
    # Collect garbage
    sync; echo 3 > /proc/sys/vm/drop_caches
done
