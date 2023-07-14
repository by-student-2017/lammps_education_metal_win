This directory contains LAMMPS input scripts for description of anharmonic potentials, data files for description of system geometry, Hessian files describing how force constants are assigned, and a LAMMPS potential file for SNAP parameters in GaN. All units abide by "metal" units in LAMMPS. File descriptions are listed below:
----------------------------------------------------------------------------------------------------
in.m3h - LAMMPS file describing anharmonic part of the TITEP+M3H potential.
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
in.m3a - LAMMPS file describing anharmonic part of the TITEP+M3A potential.
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
in.snap - LAMMPS file describing anharmonic part of the TITEP+SNAP potential.
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
data.m3h - LAMMPS data file describing geometry and assignment of bonds/angles in TITEP+M3H.
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
data.m3a - LAMMPS data file describing geometry and assignment of bonds/angles in TITEP+M3A.
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
data.gan - LAMMPS data file describing geometry in GaN.
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
hessian.m3h - Describes assignment of harmonic force constants for each bond in TITEP+M3H.
            - First 9 numbers are "ij" force constants, ordered like: xx, xy, xz, yx, yy, yz, zx, zy, zz.
            - Last 9 numbers are "ji".
            - Incorporate these numbers into a TITEP bond style, or contact authors for an updated version.
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
hessian.m3a - Describes assignment of harmonic force constants for each bond in TITEP+M3A.
            - First 9 numbers are "ij" force constants, ordered like: xx, xy, xz, yx, yy, yz, zx, zy, zz.
            - Last 9 numbers are "ji".
            - Incorporate these numbers into a TITEP bond style, or contact authors for an updated version.
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
hessian.gan - Describes assignment of harmonic force constants for each pair and Cartesian direction.
            - Each line contains 5 numbers: (1) index of atom i, (2) Cartesian component of i, (3) index of atom j, (4) Cartesian component of atom j, (5) force constant value. 
            - Incorporate these numbers into a TITEP pair style, or contact authors for an updated version.
----------------------------------------------------------------------------------------------------
