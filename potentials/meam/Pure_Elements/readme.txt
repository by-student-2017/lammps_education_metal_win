#-----------------------------------------------------------
# Single crystal
# If it doesn't work, delete all elements except the ones you need in library.meam.
pair_style meam
pair_coeff * * library.meam Fe Fe.meam Fe
#-----------------------------------------------------------
# When there is no combination that can be found. 
# If you can find a match even qualitatively or semi-quantitatively, you're lucky.
# To improve accuracy, it is necessary to optimize lattice, Ec, re, alpha, Cmin, and Cmax using DFT or other methods.
# Mixture rules may be used for Cmin and Cmax.
# If it doesn't work, delete all elements except the ones you need in library.meam.
pair_style meam
pair_coeff * * library.meam Fe C NULL Fe C
#-----------------------------------------------------------

1.       Fe, Cr, Mo, W, V, Nb, Ta
Second Nearest-Neighbor Modified Embedded Atom Method Potentials for BCC Transition Metals
Byeong-Joo Lee, M.I. Baskes, Hanchul Kim and Yang Koo Cho, Phys. Rev. B. 64, 184102 (2001).: https://doi.org/10.1103/PhysRevB.64.184102

2.       Cu, Ag, Au, Ni, Pd, Pt, Al, Pb
Semi-empirical atomic potentials for the FCC metals Cu, Ag, Au, Ni, Pd, Pt, Al and Pb based on first and second nearest-neighbor modified embedded atom method
Byeong-Joo Lee, Jae-Hyeok Shim and M.I. Baskes, Phys. Rev. B. 68, 144112 (2003).: https://doi.org/10.1103/PhysRevB.68.144112

3.       Ti, Zr
Modified Embedded Atom Method Interatomic Potentials for Ti and Zr
Young-Min Kim, Byeong-Joo Lee and M.I. Baskes, Phys. Rev. B 74, 014101 (2006).: https://doi.org/10.1103/PhysRevB.74.014101

4.       Co & Co-Al
Atomistic modeling of pure Co and Co-Al system
Wei-Ping Dong, Hyun-Kyu Kim, Won-Seok Ko, Byeong-Moon Lee and Byeong-Joo Lee, CALPHAD 38, 7-16 (2012).: https://doi.org/10.1016/j.calphad.2012.04.001

5.       C
A Modified Embedded Atom Method Interatomic Potential for Carbon
Byeong-Joo Lee and Jin Wook Lee, CALPHAD 29, 7-16 (2005).: https://doi.org/10.1016/j.calphad.2005.02.003

6.       Si
A Modified Embedded Atom Method Interatomic Potential for Silicon
Byeong-Joo Lee, CALPHAD 31, 95-104 (2007).: https://doi.org/10.1016/j.calphad.2006.10.002

7.       Ge
A Modified Embedded Atom Method Interatomic Potential for Germanium
Eun Ha Kim, Young-Han Shin and Byeong-Joo Lee, CALPHAD 32, 34-42 (2008).: https://doi.org/10.1016/j.calphad.2007.12.003

8.       Y
Modified embedded-atom method interatomic potentials for pure Y and V-Pd-Y ternary system
Won-Seok Ko, Byeong-Joo Lee, Modelling Simul. Mater. Sci. Eng. 21, 085008 (2013).: DOI 10.1088/0965-0393/21/8/085008

9.       In
A Modified Embedded Atom Method Interatomic Potential for Indium
Eun Cheol Do, Young-Han Shin, Byeong-Joo Lee , CALPHAD 32, 82-88 (2008).: https://doi.org/10.1016/j.calphad.2007.08.004

10.      P
Atomistic Modeling of an impurity element and a metal-impurity system: pure P and Fe-P system
Won-Seok Ko, Nack. J. Kim and Byeong-Joo Lee, Journal of Physics: Condensed Matter 24, 225002 (2012).: DOI 10.1088/0953-8984/24/22/225002

10.      Li
Atomistic modeling of pure Li and Mg-Li System
Young-Min Kim, In-Ho Jung and Byeong-Joo Lee, MSMSE 20, 035005 (2012).: DOI 10.1088/0965-0393/20/3/035005

11.      Na
Second nearest-neighbor modified embedded atom method interatomic potentials for the Na unary and Na-Sn binary systems
Yongmin Kim, Won-Seok Ko and Byeong-Joo Lee, Computational Materials Science 185, 109953 (2020).: https://doi.org/10.1016/j.commatsci.2020.109953

12.      Mg
Atomistic modeling of pure Mg and Mg-Al System
Young-Min Kim, Nack J. Kim and Byeong-Joo Lee, CALPHAD 33, 650-657 (2009).: https://doi.org/10.1016/j.calphad.2009.07.004

13.      Ca
Modified embedded-atom method interatomic potentials for Mg-X (X = Y, Sn, Ca) binary systems
Ki-Hyun Kim, Jong Bae Jeon and Byeong-Joo Lee, CALPHAD 48, 27-34 (2015).: https://doi.org/10.1016/j.calphad.2014.10.001

14.      Mn
Modified embedded-atom method interatomic potentials for pure Mn and Fe-Mn system
Young-Min Kim, Young-Han Shin and Byeong-Joo Lee, Acta Materialia 57, 474-482 (2009).: https://doi.org/10.1016/j.actamat.2008.09.031

15.      Zn
Modified embedded-atom method interatomic potentials for pure Zn and Mg-Zn binary system
Hyo-Sun Jang, Kyeong-Min Kim and Byeong-Joo Lee, CALPHAD 60, 200-207 (2018).: https://doi.org/10.1016/j.calphad.2018.01.003

16.      Cd
Modified embedded-atom method potential for cadmium
M. O. Zacate, Hyperfine Interactions (2019) 240: 100.: https://doi.org/10.1007/s10751-019-1640-5

17.      B
Development of a 2NN-MEAM potential for boron
S. Xiao et al., J. Micromechanics Mol. Phys. 5 (2020) 2050008.: https://doi.org/10.1142/S2424913020500083

18.      Tc
Cohesive Relations for Surface Atoms in the Iron-Technetium Binary System
C. D. Taylor, J. Metall. 2011.:  doi:10.1155/2011/954170.: https://doi.org/10.1155/2011/954170

19.      Bi
Amodified embedded-atom method interatomic potential for bismuth
H. Zhou et al., Modelling Simul. Mater. Sci. Eng. 29 (2021) 065008.: https://doi.org/10.1088/1361-651X/ac095c

20.      Ga
Atomistic model of gallium
M. I. Baskes et al., Phys. Rev. B 66 (2002) 104107.: https://doi.org/10.1103/PhysRevB.66.104107

21.      Be
Modified Embedded Atom Method Potential for Modeling the Thermodynamic Properties of High Thermal Conductivity Beryllium Oxide
J. Wei et al., ACS Omega 2019, 4, 4, 6339-6346.: https://pubs.acs.org/doi/full/10.1021/acsomega.9b00174

22.      Co
"Modified embedded-atom method interatomic potentials for the Co-Cr, Co-Fe, Co-Mn, Cr-Mn and Mn-Ni binary systems"
Won-Mi Choi, Yongmin Kim, Donghyuk Seol and Byeong-Joo Lee, Compu. Mater. Sci. 130 (2017) 121-129.: https://doi.org/10.1016/j.commatsci.2017.01.002

23.       U
"On the accurate description of uranium metallic phases: a MEAM interatomic potential approach"
J.R. Fernández, and M.I. Pascuet, Modelling and Simulation in Materials Science and Engineering, 22(5), 055019. DOI: 10.1088/0965-0393/22/5/055019.

24.       Sn
"Atomistic Simulations of Pure Tin Based on a New Modified Embedded-Atom Method Interatomic Potential"
W.-S. Ko, D.-H. Kim, Y.-J. Kwon, and M. Lee, Metals, 8 (2018) 900.: https://doi.org/10.3390/met8110900

25.       N
H.-K. Kim et al., Journal of Materials Research, 25 (2010) 1288-1297.: https://doi.org/10.1557/jmr.2010.0182

26.       H
W.-S. Ko et al., J. Mater. Res. 26 (2011) 1552-1560.: https://doi.org/10.1557/jmr.2011.95
Note: In H2, nn2(1,1)=0 is treated as 1NN-MEAM. In combination with other elements, for example, nn2(1,2)=1, it is treated as 2NN-MEAM.
