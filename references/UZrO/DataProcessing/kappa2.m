function [Output] = kappa(fluxlog,tmpprofile,lattice)
%% kappa calculates the thermal conductivity given the three input files listed in inputs.
% See kappa.m for more details.

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

Area = z*y;

HeatFlux = B(:,4)./(B(:,2)*2*Area);
Time = B(:,2);

dQ = diff(HeatFlux);
dQ =movmean(dQ,5);
%[g,d]=min(dQ);
d=20000;
HeatFlux=HeatFlux(d:end,:); %eV/A^2ps
start = round(0.002*d,0);
dT = TmpGradient(start:end,:);
dT = mean(dT);
HeatFlux=mean(HeatFlux);

dZdT = x/dT; %A/K

kappa=HeatFlux*dZdT; %eV/A.ps

Energy=1.60218E-19;	%J/eV
Distance=10000000000; %	A/m
Time=1E+12;	%ps/s

kappa=kappa*Energy*Distance*Time;

Output = [kappa,z];

end

