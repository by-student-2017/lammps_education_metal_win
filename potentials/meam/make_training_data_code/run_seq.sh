#!/bin/bash

elements=("H" "Al") # Enter the elements you want to calculate

lattices=("b1" "b2" "l12" "dia")
file_path="run_alloy_v1.1.py"

temp_file_path="temp_run.py"

calc_dir="out"

for element in "${elements[@]}"
do
    # Create the element directory (if it doesn't exist)
    element_dir="${element}-X"
    if [ ! -d "$element_dir" ]; then
        mkdir "$element_dir"
    fi
    
    for lattice in "${lattices[@]}"
    do
        # Read the original file and replace 'YYYYYYYYYY' with the element value and 'XXXXXXXXXX' with the lattice value
        sed "s/YYYYYYYYYY/$element/g; s/XXXXXXXXXX/$lattice/g" $file_path > $temp_file_path
        
        # Execute the temporary file
        echo "Running with element: $element and lattice: $lattice"
        python3 $temp_file_path
        
        # Optionally, remove the temporary file
        rm $temp_file_path
        
        # Move results to the element directory
        for method in "PBE" "PBEsol"
        do
            results_dir="results_${method}_spin_${lattice^^}"
            if [ -d "$results_dir" ]; then
                mv "$results_dir" "$element_dir"
                echo "$results_dir has been moved to $element_dir."
            fi
            
            results_csv="results_${method}_spin_${lattice^^}.csv"
            if [ -f "$results_csv" ]; then
                mv "$results_csv" "$element_dir/$results_dir"
                echo "$results_csv has been moved to $element_dir/$results_dir."
            fi
        done
        
        if [ -d "$calc_dir" ]; then
            rm -r "$calc_dir"
            echo "$calc_dir has been deleted."
        else
            echo "$calc_dir does not exist."
        fi
    done
    
    # Move error_log.txt to the element directory
    results_text="error_log.txt"
    if [ -f "$results_text" ]; then
        mv "$results_text" "$element_dir"
        echo "$results_text has been moved to $element_dir."
    fi
done
