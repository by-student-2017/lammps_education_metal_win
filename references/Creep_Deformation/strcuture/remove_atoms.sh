#!/bin/bash

# Usage
# bash remove_atoms.sh 11.0 11.0 11.0

input_file="POSCAR"

output_file="output.POSCAR"

x_min=0.0
x_max=$1
y_min=0.0
y_max=$2
z_min=0.0
z_max=$3

awk -v xmin="$x_min" -v xmax="$x_max" -v ymin="$y_min" -v ymax="$y_max" -v zmin="$z_min" -v zmax="$z_max" '
{
    x = $1
    y = $2
    z = $3
    if (x < xmin || x > xmax || y < ymin || y > ymax || z < zmin || z > zmax) {
        print $0
    }
}' "$input_file" > "$output_file"

echo "The coordinates in the specified range have been deleted. The result is saved in $output_file."
