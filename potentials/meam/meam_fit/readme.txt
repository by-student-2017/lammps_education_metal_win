## VEeeeeeeeery Important !!!!!
The legacy version of the Materials Project, which was useful, will be closed in September 2025. 
Important information such as formation energy and CIF data is missing from the new version.

Environment construction
1. sudo apt update
2. sudo apt -y install lammps ase
3. pip3 install bayesian-optimization==1.4.3
4. pip3 install pyswarms==1.3.0
5. sudo apt install -y python3-scipy
6. pip3 install numpy=1.20
  (5.5 pip3 uninstall numpy)


Preparation of calculation conditions
1. Put the cif file of the structure you want to fit into "cif_data".
2. Enter the cif name and information in data.json. Add it as in the example for Ru. 
  (Only structures in cif_data will be subject to fitting calculations, so you don't need to worry about it.)
3. Use Bayesian_fit.py to set the number of ncpus for parallelization and the initial value (x0 to x9).
4. Enter the values ​​of alpha, alat, and Ec in library_template.meam 
  (this is not subject to fitting).
1 element: Ec (exp), alat (DFT), B (DFT)
Alloy: assume Ec by using of delta(I,J) (DFT) , re (DFT), B (DFT)
Note: It would have been nice if all the data were experimental values, but since there are none, 
DFT is used. Since the Ec of DFT differs greatly from the experimental value for Fe, etc., 
Ec is calculated using the experimental value, and in the case of alloys, 
the difference between the experimental value and DFT is used to calculate it.

Run
1. python3 Bayesian_fit.py
   (Or python3 particle_swarm_fit.py)
Note: With the Nelder-Mead method, even if good values ​​are obtained by fitting, the results will be unacceptable, such as b0 becoming 0.0.

Look at the log json file and select the one with the highest fit value.
If you are happy with the final result, just change XX in library.meam to the name of the element that was the subject of the cif fit.

It may be difficult if you are new to coding, but if you rewrite this, it is possible to fit binary systems, etc. 
If you target XX.meam instead of library.meam, you can also fit Cmin, etc. 

data.json
Surface Energy (J/m2)
Energy, gGB (J/m2)
In "evalulation_template.py", J/m^2 is converted to eV/A^2 because the Materials Project does not fully describe eV/A^2.

From the Ec, alat, and re of library.meam for Ru in 1NN-MEAM, it can be estimated that the experimental cohesive energy and the DFT bulk modulus (B) are used. As an aside, the sublimation energy is 6.299 and the experimental B is 220 [GPa].

For Ec, see element_data.xlsx
For alpha, see meam_converter.xlsx (need data: lattice (type), Ec, La (lattice constant, a) = alat, B (Bulk modulus, e.g., Bv, Bvrh, etc) [GPa]) 

The results of the fit can only show the closest to the optimal value because they change depending on the data and number of data, the evaluation function, and the weighting method. It can be said that there are as many results of the fit as there are people.

Nd: I tried to fit the data from the Materials Project by changing Ec, re, and alpha. I tried searching with the Nelder-Mead method, but b0 to b3 and t1 to t3 showed optimal fit results even with 2NN-MEAM. However, the elastic constants of BCC (C11 to C66) did not fit well, so they were excluded from the fit.
