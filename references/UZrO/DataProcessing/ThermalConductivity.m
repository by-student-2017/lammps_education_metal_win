%%
clc
clear all
close all

% ThermalConductivity.m mfile uses the kappa.m and kapp2.m function files
% in order to collect the individual thermal conductivities for each box
% size (5x5x20, 5x5x40 and 5x5x60) and determine the bulk conductivity.
% Following this the values are saved to a txt file for use in the
% PlotGeneratorUZrO2.m file. 

i=0;
n=0;
j=0;
p=0;
temporary=0;

%These loops are used to find each of the requisite files required by
%kappa.m function files. Three files are required for each
%'*.flux_log.out', '*.lattice.out' and '*.tmp_profile.out'
%The names are generated using the composition and temperature. Below
%G=length of box direction used, x,y or z. T = temperature. x = composition. ZrO2 is done
%separately for both x and z directions. The results are saved to a text
%file titled 'kappa.bulk.txt'. kappa and kappa2 are identical save that
%kappa 2 changes the direction used for calculations.

for x=0
    dee=x;
x=num2str(x);
y=strcat('U',x);




    
    for T=[300, 500, 750, 1000, 1250, 1500]
        temporary = temporary+1;
    t=num2str(T);
    s=strcat(t,'K');
   

         for G=20:20:60
            n=n+1;
            g=num2str(G);
            h=strcat('5x5x',g);
            fluxlog = fullfile('ThermalConductivity',y,s,h,'flux_log.out');
            tmpprofile = fullfile('ThermalConductivity',y,s,h,'tmp_profile.out');
            lattice = fullfile('ThermalConductivity',y,s,h,'lattice.out'); 
            z(n,:) = kappa(fluxlog,tmpprofile,lattice);
                        
            
        end
            p=p+1;
            zee = 1./[z(n-2,2);z(n-1,2);z(n,2)];
            k = 1./[z(n-2,1);z(n-1,1);z(n,1)];
            
             zPad=[ones(length(zee),1) zee];
        slope = zPad\k;
        R = zPad*slope;
         Rsq = 1 - sum((k - R).^2)/sum((k - mean(k)).^2);

        invkappa = slope(1,1);
        invkappa=abs(invkappa);
        k1(temporary,:) = 1/invkappa;
        Temp(temporary,:) = T;
        Comp(temporary,:) = dee;
            
    end
    
   
end

for x=0
    dee=x;
x=num2str(x);
y=strcat('U',x,'Xdirection');




    
    for T=[300, 500, 750, 1000, 1250, 1500]
        temporary = temporary+1;
    t=num2str(T);
    s=strcat(t,'K');
   

         for G=20:20:60
            n=n+1;
            g=num2str(G);
            h=strcat('5x5x',g);
            fluxlog = fullfile('ThermalConductivity',y,s,h,'flux_log.out');
            tmpprofile = fullfile('ThermalConductivity',y,s,h,'tmp_profile.out');
            lattice = fullfile('ThermalConductivity',y,s,h,'lattice.out'); 
            z(n,:) = kappa2(fluxlog,tmpprofile,lattice);
                        
            
        end
            p=p+1;
            zee = 1./[z(n-2,2);z(n-1,2);z(n,2)];
            k = 1./[z(n-2,1);z(n-1,1);z(n,1)];
            
             zPad=[ones(length(zee),1) zee];
        slope = zPad\k;
        R = zPad*slope;
         Rsq = 1 - sum((k - R).^2)/sum((k - mean(k)).^2);

        invkappa = slope(1,1);
        invkappa=abs(invkappa);
        k1(temporary,:) = 1/invkappa;
        Temp(temporary,:) = T;
        Comp(temporary,:) = dee;
            
    end
    
   
end


for x=25:25:100
    dee=x;
x=num2str(x);
y=strcat('U',x);




    
    for T=[300, 500, 1000, 1500, 2000]
        temporary = temporary+1;
    t=num2str(T);
    s=strcat(t,'K');
   

         for G=20:20:60
            n=n+1;
            g=num2str(G);
            h=strcat('5x5x',g);
            fluxlog = fullfile('ThermalConductivity',y,s,h,'flux_log.out');
            tmpprofile = fullfile('ThermalConductivity',y,s,h,'tmp_profile.out');
            lattice = fullfile('ThermalConductivity',y,s,h,'lattice.out'); 
            z(n,:) = kappa(fluxlog,tmpprofile,lattice);
                        
            
        end
            p=p+1;
            zee = 1./[z(n-2,2);z(n-1,2);z(n,2)];
            k = 1./[z(n-2,1);z(n-1,1);z(n,1)];
            
             zPad=[ones(length(zee),1) zee];
        slope = zPad\k;
        R = zPad*slope;
         Rsq = 1 - sum((k - R).^2)/sum((k - mean(k)).^2);

        invkappa = slope(1,1);
        invkappa=abs(invkappa);
        k1(temporary,:) = 1/invkappa;
        Temp(temporary,:) = T;
        Comp(temporary,:) = dee;
            
    end
    
   
end

%%


John = [k1,Temp,Comp];
fileID = fopen('UZrO2/ThermalConductivity/kappa.bulk.txt','w');
fprintf(fileID, 'kappa Temperature Composition \n');
for i=1:length(John)
fprintf(fileID,'%f %f %f\n',John(i,:));
end
fclose(fileID);

