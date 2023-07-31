clc
clear all
close all

TotalAtoms=12000; % The total number of atoms in the script
N = TotalAtoms/3; % Number of Atoms to be repositioned
X=rand(1,N); % Generate a random number for each of the atoms
P=0.25; % The ratio of U:Zr desired
F=0; % Setting up variable

l=0; % Setting up variable
Check=0; % Setting up variable

% While loop which gives a value of 2 or 3 based on the random
% number generated in X. Check gives the value which should be compared to
% the desired ratio.

Delta = 1000;
if Delta<=0.001
l=N;
else
    l=0;
   
while l<N;
    l=l+1;
    if X(1,l)<P
        J(1,l)=2;
        F=F+1;
    else J(1,l)=3;
        
    end
      Check=F/N;  
          
end
Delta=Check-P;
end