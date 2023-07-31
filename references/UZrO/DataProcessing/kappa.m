function [Output] = kappa(fluxlog,tmpprofile,lattice)
%% kappa calculates the thermal conductivity given the three input files listed in inputs.

%This part opens the temperature profile data and reads the data into a
%variable A. The temperature gradient is then summed on both sides of the
%box. Temperature profile is a repeating set of 21 values due to the 20
%slices used in input. These are separated using the for loop. The
%difference between the 11th and 20th and 1st and 11th segments is taken at
%each point, every 1050 timesteps.

fid = fopen(tmpprofile);
k=0;
formatspec = '%f %f %f %f';
numlines=19;

while ~feof( fid )
    	k = k+1;
    	Data(k,:) = textscan(fid,formatspec,numlines,'CommentStyle','#'); 
end
fclose( fid );
A = cell2mat(Data);

k=0;
for n=21:21:length(A)
    k=k+1;
    o=n-20;
    m=n-19;
    Ave=A(m:n,:);
    TmpGradient(k,:)=Ave(11,4)-Ave(1,4);
    TmpGradient2(k,:)=Ave(11,4)-Ave(20,4);
    Time(k,:)=A(o,1)*0.002;
end
TmpGradient=TmpGradient+TmpGradient2;


%%

%This section retrieves the data found in the flux log and converts it into
%a matrix for use in the script. The data contained in lattice is also
%retrieved in order to determine the box size and consequently area of the
%x-y face. Heat flux is then calculated as per the manuscript. Q/2*A*T

fid = fopen(fluxlog);
k=0;
formatspec = '%f %f %f %f';
while ~feof( fid )
    	k = k+1;
    	Data2(k,:) = textscan(fid,formatspec,'Headerlines',1); 
end
fclose( fid );

B=cell2mat(Data2);

fid = fopen(lattice);

formatspec = '%f %f %f';
    
    	Data3 = textscan(fid,formatspec,'Headerlines',5); 
fclose( fid );

C = cell2mat(Data3);
x=C(1,2)-C(1,1);
y=C(2,2)-C(2,1);
z=C(3,2)-C(3,1);

Area = x*y;

HeatFlux = B(:,4)./(B(:,2)*2*Area);
Time = B(:,2);

% d is the timestep at which the calculations are used. Before this the
% simulation is not at steady state. kappa is calculated and converted to
% units of W/mK. Heatflux is given as a vector and then the mean is
% calculated. The output is stored in a variable Output which contains the
% kappa value and z value.

d=20000;
HeatFlux=HeatFlux(d:end,:); %eV/A^2ps
start = round(0.002*d,0);
dT = TmpGradient(start:end,:);
dT = mean(dT);
HeatFlux=mean(HeatFlux);

dZdT = z/dT; %A/K

kappa=HeatFlux*dZdT; %eV/A.ps

Energy=1.60218E-19;	%J/eV
Distance=10000000000; %	A/m
Time=1E+12;	%ps/s

kappa=kappa*Energy*Distance*Time;

Output = [kappa,z];

end

