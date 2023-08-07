# APPENDIX E, DATA VARIATION SCRIPT

# Made by Ben Dankesreiter in January of 2021 to create large sets of similar LAMMPS scripts organized by folder.
# OS: Linux Mint 19.3 Tricia (Should work for all Ubuntu and Debian derivatives)
# Python3

import subprocess as sp
import math
import os

# Preset the data ranges, necessary files, and total volume of simulation box here
# USER, CHANGE THESE FOR DATASET
hpercent = [0,4.5,8.6]
density = [2.2] # g/cm^3
volume = 0.0000012*0.0000004*0.0000002 # cm^3
copylist = ['CH.airebo', 'DLC.in', 'quanah_new2021.sh']

# Initialize matrices
m1Cnumber = [range(len(hpercent)) for spam in range(len(density))]
m2Cnumber = [range(len(hpercent)) for spam in range(len(density))]
m1Hnumber = [range(len(hpercent)) for spam in range(len(density))]
m2Hnumber = [range(len(hpercent)) for spam in range(len(density))]

# Calculate the proper number of atoms in simulation box for each dataset
for foo in range(len(density)):
	mass = density[foo]*volume
	for bar in range(len(hpercent)):
		m1Cnumber[foo][bar] = mass/(1.994*10**(-23))
		m1Hnumber[foo][bar] = hpercent[bar]*m1Cnumber[foo][bar]/100
		m2Hnumber[foo][bar] = m1Cnumber[foo][0]*hpercent[bar]/100
		m2Cnumber[foo][bar] = m1Cnumber[foo][0]-m2Hnumber[foo][bar]

# Print dataset for review
print('Data sets generating....\n')
print('Method 1 Carbon set\n')
print(m1Cnumber)
print('\n')
print('Method 1 Hydrogen set\n')
print(m1Hnumber)
print('\n')
print('Method 2 Carbon set\n')
print(m2Cnumber)
print('\n')
print('Method 2 Hydrogen set\n')
print(m2Hnumber)
print('\n')

# Function to copy and alter files for each method.
def filemaker(method,hpercent,density,Cnumber,Hnumber,copylist):
	# Make a method folder
	cmd = 'mkdir ' + './' + str(method)
	status = sp.call(cmd, shell=True)
	jobcount = 0
	for i in range(len(Cnumber)):
		# Put density folders in the method folder
		cmdi = 'mkdir ' + './' + str(method) + '/' + str(int(round((10*density[i]))))
		status = sp.call(cmdi, shell=True)
		for j in range(len(Hnumber[i])):
			# Put percentage folders in the density folders
			cmdj = 'mkdir ' + './' + str(method) + '/' + str(int(round((10*density[i])))) + '/' + str(int(hpercent[j]*10))
			status = sp.call(cmdj, shell=True)
			# Copy this list of folders into each percentage file (dataset)
			for k in copylist:
				cmdk = 'cp ' + k + ' ./' + str(method) + '/' + str(int(round((10*density[i])))) + '/' + str(int(hpercent[j]*10))
				status = sp.call(cmdk, shell=True)
			# Modify the Lammps input file to have the correct number of atoms for H and C
			# Have to use absolute location here
			loc = os.getcwd() + '/' + str(method) + '/' + str(int(round((10*density[i])))) + '/' + str(int(hpercent[j]*10)) + '/DLC.in'
			script = open(loc, 'r')
			script1 = script.readlines()
			# USER, CHANGE THESE LINES TO VARY YOUR INPUT SCRIPTS
			script1[8] = 'create_atoms 1 random ' + str(int(round((Cnumber[i][j])))) + ' 26547 box\n'
			script1[9] = 'create_atoms 2 random ' + str(int(round((Hnumber[i][j])))) + ' 56148 box\n'
			script = open(loc, 'w')
			script.writelines(script1)
			script.close()
	print(str(jobcount) + ' input scripts have been created for Method ' + str(method))
# Activate the function for each method set
go = filemaker(1,hpercent,density,m1Cnumber,m1Hnumber,copylist)
print('Method 1 datasets created')
go2 = filemaker(2,hpercent,density,m2Cnumber,m2Hnumber,copylist)
print('Method 2 datasets created\n\nFinished!')