function [Output,Answer] = LP(filename,NAtoms,BoxSize)
%LP calculates the thermal expansion coefficient and Heat capacity
% Requires inputs of filename, Number of atoms and BoxSize (or replications
% in each direction).

% The following opens the file and saves the data to a matrice for use
% later

fid = fopen(filename);
formatspec = '%f %f %f %f %f %f %f %f %f';
numlines = 1000;
N=5;
k = 0;
    while ~feof( fid )
    	k = k+1;
    	Data(k,1:9) = textscan(fid,formatspec,numlines,'HeaderLines', 1); 
    end
    
    fclose( fid );
A = cell2mat(Data);
k=0;
%%
% This for loop separates the data into temperature subsections.
% Answer contains all the raw data extracted from LAMMPS including the lattice
% parameter in each direction, enthalpy etc.

for i=3003:2002:length(A)
    j=i-100;
    k=k+1;
    Answer(k,:) = mean(A(j:i,:));
    
end

Answer=Answer(1:end-19,:);

% The thermal  is calculated below and a moving mean is used to
% smooth the thermal expansion derivative plot. Both the volumetric and
% linear thermal expansions are calculated. L is the lattice parameter
% calculated by taking the cube root of the volume and dividing by the
% replication factor.

L = Answer(:,4).^(1/3)/BoxSize;
La = L(6:end,:);
La = movmean(La,3);
L = movmean(L,3);

DeltaL = La-L(1:end-5,:);
DeltaL = DeltaL(1:end-5);

V = Answer(:,4);
Va = V(6:end,:);
Va = movmean(Va,3);
V = movmean(V,3);

DeltaV = Va - V(1:end-5,:);
DeltaV = DeltaV(1:end-5);

T=Answer(:,2);
Ta = T(6:end,:);
Ta = movmean(Ta,3);
T = movmean(T,3);

DeltaT = Ta-T(1:end-5,:);
DeltaT = DeltaT(1:end-5);

L2 = L(5:end-6,:);
V2 = V(5:end-6,:);

Alpha = (1./L2).*(DeltaL./DeltaT)*10^6;
Alpha = movmean(Alpha,2);
AlphaV = (1./V2).*(DeltaV./DeltaT)*10^6/3;
T2 = T(6:end-5,:);

% This section calculates the heat capacity using the enthalpy (H). A
% similar moving mean is used for smoothing here also.

NAvogadro = 6.0221409*10^23; %atoms/mol
eVperJ = 6.242*10^21; %eV/J

H = Answer(:,8)-Answer(1,8); %eV
H = H/eVperJ*NAvogadro/(NAtoms/3); %kJ/mol
Ha = H(6:end,:);
Ha = movmean(Ha,3);
H=movmean(H,3);
DeltaH = Ha-H(1:end-5);
DeltaH = DeltaH(1:end-5);
Cp = 1000* DeltaH./DeltaT;
Cp = movmean(Cp,2);


Output = [T2,Alpha,Cp,AlphaV];
Answer = [Answer,H,L];


end

