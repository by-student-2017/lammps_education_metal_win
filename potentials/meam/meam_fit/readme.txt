Note: In "Cmax < Cmin" case, Atutomatically set Cmax = 2.8
Note: For a new run, you must to remove logs.json

Environment construction
1. sudo apt update
2. sudo apt -y install lammps
3. pip3 install bayesian-optimization==1.4.3


Preparation of calculation conditions
1. Put the cif file of the structure you want to fit into "cif_data".
2. Enter the cif name and information in data.json. Add it as in the example for Ca. 
  (Only structures in cif_data will be subject to fitting calculations, so you don't need to worry about it.)
3. Use Bayesian_fit.py to set the number of ncpus for parallelization and the initial value (x0 to x7).
4. Enter the values ​​of alpha, alat, and Ec in library_template.meam 
  (this is not subject to fitting).

Run
1. python3 Bayesian_fit.py

Look at the log json file and select the one with the highest fit value.
If you are happy with the final result, just change XX in library.meam to the name of the element that was the subject of the cif fit.

It may be difficult if you are new to coding, but if you rewrite this, it is possible to fit binary systems, etc. 
If you target XX.meam instead of library.meam, you can also fit Cmin, etc. 
