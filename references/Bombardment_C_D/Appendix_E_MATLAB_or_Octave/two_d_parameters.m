nX=100;  
nY=100; % nY must be an EVEN number

Ess=0.43; % activation energy SHORT bridge to SHORT bridge (Unit: eV) 
Esl=0.65; % activation energy SHORT bridge to LONG  bridge (Unit: eV) 
Els=0.21; % activation energy LONG  bridge to SHORT bridge (Unit: eV) 
Ell=0.43; % activation energy LONG  bridge to LONG  bridge (Unit: eV) 
dx=3.165/sqrt(2.0);   % (Unit: 1meter = 1E-10 A) 
dy=3.165/sqrt(2.0);   % hopping distance 

ie=0; 
if ie==1 
  Ess=0.45; % activation energy SHORT bridge to SHORT bridge (Unit: eV) 
  Esl=0.67; % activation energy SHORT bridge to LONG  bridge (Unit: eV) 
  Els=0.24; % activation energy LONG  bridge to SHORT bridge (Unit: eV) 
  Ell=0.48; % activation energy LONG  bridge to LONG  bridge (Unit: eV)  
end 

Initial_H_coverage_rate=0.02; % 0 to 1 
Initial_H_SB_coverage_rate=1.0; % 0 to 1, short bridge coverage

T=200; % temperature, in kelvin 
t_end=1.0; % simulation end time (unit: second) 

cycle_step=round(Initial_H_coverage_rate*nX*nY); %program will do statistic within those number of steps 
max_step=110*cycle_step; %program will stop when reaching this step 
ignored_cycle=10; 

kB=8.6173324e-5; % Boltzmann constant (eV/K) 
h = 4.135667516e-15; %Planck constant (eV s) 
