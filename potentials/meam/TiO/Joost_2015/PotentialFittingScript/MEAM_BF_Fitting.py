#---------------------------------------------------------------------------------------#
#
# This work is licensed under a Creative Commons Attribution 3.0 License
# http://creativecommons.org/licenses/by/3.0/
#
# Please cite:
# 	W.J. Joost, S. Ankem, M.M. Kuklja
# 	"A modified embedded atom method potential for the titanium-oxygen system"
# 	Modelling and Simulation in Materials Science and Engineering
# 	Vol. 23, pp. 015006 (2015)
#	doi:10.1088/0965-0393/23/1/015006
# if you publish work that uses or modifies this script.
#
# Helpful definitions for understanding this script:
#	- "Parameter" refers to a parameter for a MEAM potential, such as the screening min
#	and max distances, the alpha parameter, etc.
#	- "Parameter set" refers to a list with one value for each of the parameters you are
#   fitting. For example, if you are fitting rho, Cmin(1,1,2), and Cmax(1,1,2) a parameter
#   set could be [2.50,1.00,2.00] where rho=2.50, Cmin(1,1,2)=1.00, and Cmax(1,1,2)=2.00.
#
# This Python script can be used to fit MEAM parameters in LAMMPS.
# The script takes as input desired test values for any number of MEAM parameters
# and produces a list of all possible parameter sets from the combinations of the
# provided test parameters. LAMMPS calculations are run for each parameter set and 
# the calculated characteristics are saved to allow further use, such as searching
# for a best fit.
#
# To run this script, you must have LAMMPS compiled as a Python library following the
# instructions in the LAMMPS documentation. Run this script in the directory with 
# the LAMMPS input files. The script periodically writes to the LAMMPS input file 
# containing the parameter values, which must be formatted to match the structure in the 
# accompanying example file. You can also change the format in this script to match your
# own file.
# 
# This script runs in parallel using the pypar package in Python. To run on a single
# processor, simply comment out or remove any references to pypar in the script.
#
# This example uses 9 test values for each of 4 different parameters, producing a total
# of 6,561 complete parameter sets to test.
# This example runs two different LAMMPS calculations per parameter set.
#
# The command to run this script with mpi (on, for example, 2 cores) is
# 	mpirun -np 2 python MEAM_BF_Fitting.py
#
# The command to run this script on a single core is
#	python MEAM_BF_Fitting.py
#
#--------------------------------------------------------------------------------------#

import pypar
import sys
import math
import itertools

# varbs is a list of several sub-lists. Each sub-list is the desired test values for a
# particular parameter. The order of sub-lists here corresponds to the order of the
# parameters in the "inp" variable below.

varbs = [[0.25,0.35,0.45,0.55,0.65,0.75,0.85,0.95,1.05],
         [2.15,2.25,2.35,2.45,2.55,2.65,2.75,2.85,3.25],
         [1.86,1.91,1.96,2.01,2.06,2.11,2.16,2.21,2.26],
         [2.66,2.71,2.76,2.81,2.86,2.91,2.96,3.01,3.06]]

# pars is a list of several sub-lists. Each sub-list is a parameter set needed to run a 
# single calculation. The total number of parameter sets will 
# depend on the number of parameters and the number of test values per parameter. 

pars = list(itertools.product(*varbs))

it = 0


# The following loop runs once per parameter set, runs some number of LAMMPS calculations
# (relaxes 2 structures in this example), and writes the desired results to an output
# file.

for it in range (0, len(pars)):

    meam = open("TiOpar.meam", "r+")

	# inp contains the parameters being fit, written in an acceptable format for use in
	# LAMMPS. Change the parameters listed here (and correspondingly in the TiOpar.meam
	# file) in order to change which parameters are included in fitting.
   
    inp = (["Cmin(1,2,2) = ", str(pars[it][0]), "\n"
             "Cmax(1,2,2) = ", str(pars[it][1]), "\n"
             "Cmin(2,2,1) = ", str(pars[it][2]), "\n"
             "Cmax(2,2,1) = ", str(pars[it][3]), "\n"])

    meam.writelines(inp)
    
    meam.close()
    
    from lammps import lammps

    lmp = lammps()
    
    # This command executes a LAMMPS calculation using the input file in.Ti3O2. You can
    # call any viable LAMMPS input file here and it will be run. The variable names in
    # the argument of the lmp.extract_variable functions MUST correspond to the variable
    # names assigned in the LAMMPS input file. See the example input file for more
    # details.
    
    lmp.file("in.Ti3O2")
    print "Proc %d out of %d procs has" % (pypar.rank(),pypar.size()),lmp
    
    a_Ti3 = lmp.extract_variable("aleng",None,0)
    y_Ti3 = lmp.extract_variable("yleng",None,0)
    xy_Ti3 = lmp.extract_variable("shear",None,0)
    c_Ti3 = lmp.extract_variable("cleng",None,0)
    En_Ti3 = lmp.extract_variable("teng",None,0)
    xz_Ti3 = lmp.extract_variable("shear2",None,0)
    
    lmp.close()        

    lmp = lammps()
    
    # You can run any number of independent LAMMPS input files. This example runs 2:
    # in.Ti3O2 and in.aTiO.
   
    lmp.file("in.aTiO")
    print "Proc %d out of %d procs has" % (pypar.rank(),pypar.size()),lmp
    
    a_aTi = lmp.extract_variable("aaleng",None,0)
    y_aTi = lmp.extract_variable("ayleng",None,0)
    xy_aTi = lmp.extract_variable("ashear",None,0)
    c_aTi = lmp.extract_variable("acleng",None,0)
    En_aTi = lmp.extract_variable("ateng",None,0)
    xz_aTi = lmp.extract_variable("ashear2",None,0)
    
    lmp.close()
       
    calc = [1] * 12

    # calc is a list to hold values calculated during this loop    

    calc[0] = a_aTi
    calc[1] = y_aTi
    calc[2] = c_aTi
    calc[3] = xy_aTi
    calc[4] = xz_aTi
    calc[5] = En_aTi
    calc[6] = a_Ti3
    calc[7] = y_Ti3
    calc[8] = c_Ti3
    calc[9] = xy_Ti3
    calc[10] = xz_Ti3
    calc[11] = En_Ti3

    if pypar.rank() == 0:
        print it
    
    	# the parameter set (pars) and calculated characteristics (calc) are written
    	# to a text file. At the end of the run, this file will contain one line for
    	# each parameter set with the corresponding calculated characteristics. You can
    	# sort this file, for example, as a function of the smallest residual error from
    	# the target values of the characteristics.
       
        wrtfl = open("fitresults.txt", "a")

        wrtfl.write(str(pars[it][0]))
        wrtfl.write(" ")
        wrtfl.write(str(pars[it][1]))
        wrtfl.write(" ")
        wrtfl.write(str(pars[it][2]))
        wrtfl.write(" ")
        wrtfl.write(str(pars[it][3]))
        wrtfl.write(" ")
        wrtfl.write(str(calc))
        wrtfl.write("\n")
        
        wrtfl.close()

    it += 1

print ( str(it) + " iterations - Job's Done!")
pypar.finalize()
