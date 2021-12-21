# Edge Dislocation Part-1, FCC materials 
- This input files gives detailed analysis on how to understand edge dislocation in FCC materials.
- windows version
- Original version made by NextZenStudent


## run
	click run.bat or lmp_serial.exe -in ED.lmp


## check results
	go to cfg file and click *.cfg file
	see log.lammps file


## Original version (made by NextZenStudent)
- https://www.youtube.com/watch?v=zE_SQEEy6Ic&list=PLUEA3pjJY3dCWgiLFkzJly_nwqKq8w1_J&index=1


NextZenStudent

Twitter: https://twitter.com/NextZenStudent
Instagram: https://www.instagram.com/nextzenstud...
Website: https://nextzenstudent.com

The Github repository contains the LAMMPS code and required files to get an edge dislocation

2 important points to note here
1) minimize etol ftol maxiter maxeval
etol = stopping tolerance for energy (unitless)
ftol = stopping tolerance for force (force units)
maxiter = max iterations of minimizer
maxeval = max number of force/energy evaluations

reduce the number of maximum evaluations that is max number of force/energy evaluations

3) while dumping the output file - dump every 1 thermodynamic step
