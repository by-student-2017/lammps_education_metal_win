#!/bin/bash

lattices=("fcc" "bcc" "sc" "dia1" "hcp")
file_path="run_1element_or_alloy_v1.0.py"
temp_file_path="temp_run.py"

for lattice in "${lattices[@]}"
do
    # Read the original file and replace 'XXXXXXXXXX' with the lattice value
    sed "s/XXXXXXXXXX/$lattice/g" $file_path > $temp_file_path
    
    # Execute the temporary file
    echo "Running with lattice: $lattice"
    python3 $temp_file_path
    
    # Optionally, remove the temporary file
    rm $temp_file_path
    rm -r out
done