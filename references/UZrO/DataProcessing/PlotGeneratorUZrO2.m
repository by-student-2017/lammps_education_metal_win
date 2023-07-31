clc
clear all
close all

% This file collates all data for the paper Thermophysical Properties of
% (U,Zr)O2 mixed oxides and produces the figures seen within the paper.

% Setting the default interpreter to latex format
set(0,'defaulttextInterpreter','latex')

% Calling the Lattice Parameter, LP,  function in order to extract the data 
% from the input files 'xyz.txt and assigning them to variables'

[U0Tet,U0Tetb]=LP('ZrO2Tet.txt',10224,12);
[U25,U25b]=LP('U25.txt',12000,10);
[U50,U50b]=LP('U50.txt',12000,10);
[U75,U75b]=LP('U75.txt',12000,10);
[U100,U100b]=LP('UO2.txt',12000,10);


% T1 and T2 are the temperature variables used with L923 and L3000 (Lattice
% Parameter of UO2 from 275-923 and 923-3000 K using the equations from
% Fink et al.

T1 = [275:1:923];
T2 = [923:1:3000];
L923 = 5.468.*(9.9734*10^-1 + 9.802*10^-6.*T1 - 2.705*10^-10.*T1.^2 + 4.391*10^-13.*T1.^3);
L3000 = 5.468.*(9.9672*10^-1 + 1.179*10^-5.*T2 - 2.429*10^-9.*T2.^2 + 1.219*10^-12.*T2.^3);

% Plotting the results of Lattice Parameter against Temperature and
% Composition. Plot size set for paper width and saved as eps file

figure('Renderer', 'painters', 'Position', [10 10 560 420])
p1=plot(U25b(1:end,2),U25b(1:end,11),'s','Color',rgb('SeaGreen'),'LineWidth',1,'MarkerSize',10);
hold on
p2=plot(U50b(:,2),U50b(:,11),'^','Color',rgb('Teal'),'LineWidth',1,'MarkerSize',10);
p3=plot(U75b(:,2),U75b(:,11),'d','Color',rgb('DodgerBlue'),'LineWidth',1,'MarkerSize',10);
p4=plot(U100b(:,2),U100b(:,11),'x','Color',rgb('Navy'),'LineWidth',2,'MarkerSize',10);
p5=plot(T1,L923,'--',T2,L3000,'--','Color',rgb('Salmon'),'LineWidth',3,'MarkerSize',10);
h=legend([p4 p3 p2 p1],'UO_2','(U_7_5,Zr_2_5)O_2','(U_5_0,Zr_5_0)O_2','(U_2_5,Zr_7_5)O_2','NumColumns',2,'Location','NorthWest');
set(h,'Position',[0.144047619047619,0.749603179428314,0.624999986801828,0.17261904279391]);
x = [0.75 0.7];
y = [0.25 0.68];
annotation('textarrow',x,y,'String','Martin 1988','FontSize',18,'FontName','Arial')
legend boxoff
box off
xlabel('Temperature (K)')
ylabel('Lattice Parameter (\AA)','interpreter','latex')
set(gca,'FontSize',18,'FontName','Arial')
axis([250 3050, 5.2 5.8])
hold off
print -depsc2 UZrO2/Plots/LP.eps

%%

% Open and retrieve experimental result data from Igawa 2001. These results
% contain the lattice parameter for ZrO2 tetragonal.

fileID = fopen('Igawa2001.txt');
ZrLP = textscan(fileID,'%f %f %f','HeaderLines',1);
fclose(fileID);
ZrLP = cell2mat(ZrLP);

% Variable cut removes the data from points beyond the transition of ZrO2
% at 1900 K
cut = (1800-275)/25;

%Plotting the ZrO2 tetragonal lattice parameter as a function of
%temperature and setting plot width to fit next to above plot

figure('Renderer', 'painters', 'Position', [10 10 0.66*560 420])
p1=plot(U0Tetb(1:cut,2),U0Tetb(1:cut,5)/12,'o','Color',rgb('DarkGreen'),'LineWidth',1,'MarkerSize',10);
hold on
p2=plot(U0Tetb(1:cut,2),U0Tetb(1:cut,7)/12,'o','Color',rgb('DarkGreen'),'MarkerSize',10,'LineWidth',1,'MarkerFaceColor',rgb('DarkGreen'));
p3=plot(ZrLP(:,1),ZrLP(:,2)*10,'o','Color',rgb('Black'),'LineWidth',2,'MarkerSize',5,'MarkerFaceColor',rgb('Black'));
p5=plot(ZrLP(:,1),ZrLP(:,3)*10,'o','Color',rgb('Black'),'LineWidth',2,'MarkerSize',5,'MarkerFaceColor',rgb('Black'));
legend([p1,p2,p3],'a','c','Expt. Igawa 2001','Location','West')
legend boxoff
box off
xlabel('Temperature (K)')
%ylabel('Lattice Parameter (\AA)','interpreter','latex')
set(gca,'FontSize',18,'FontName','Arial')
axis([250 1850, 3.5 5.5])
hold off
print -depsc2 UZrO2/Plots/LPZrO2.eps
%%

%Plotting the thermal expansion coefficient with temperature

figure(4)

p2=plot(U25(1:end,1),U25(1:end,4),'s','Color',rgb('SeaGreen'),'LineWidth',2);
hold on
p3=plot(U50(:,1),U50(:,4),'^','Color',rgb('Teal'),'LineWidth',2);
p4=plot(U75(:,1),U75(:,4),'d','Color',rgb('DodgerBlue'),'LineWidth',2);
p5=plot(U100(:,1),U100(:,4),'x','Color',rgb('Navy'),'LineWidth',2,'MarkerFaceColor',rgb('Blue'));
p1=plot(U0Tet(1:cut,1),U0Tet(1:cut,4),'o','Color',rgb('DarkGreen'),'LineWidth',2,'MarkerFaceColor',rgb('DarkGreen'));

legend([p1 p2 p3 p4 p5], 'ZrO_2','(U_2_5,Zr_7_5)O_2','(U_5_0,Zr_5_0)O_2','(U_7_5,Zr_2_5)O_2','UO_2','Location','NorthWest')
legend boxoff
box off
xlabel('Temperature (K)')
ylabel('Thermal Expansion Coefficient \(\alpha\) \((\times 10^{-6} K^{-1})\)')
set(gca,'FontSize',12,'FontName','Arial')
axis([350 3050, 5 30])
hold off
print -depsc2 UZrO2/Plots/Alpha.eps

%%

% Plotting the heat capacity as a function of temperature and composition

figure(6)

p2=plot(U25(:,1),U25(:,3),'s','Color',rgb('SeaGreen'),'LineWidth',2);
hold on
p3=plot(U50(:,1),U50(:,3),'^','Color',rgb('Teal'),'LineWidth',2);
p4=plot(U75(:,1),U75(:,3),'d','Color',rgb('DodgerBlue'),'LineWidth',2);
p5=plot(U100(:,1),U100(:,3),'x','Color',rgb('Navy'),'LineWidth',2);
p6=plot(U0Tet(1:(cut),1),U0Tet(1:(cut),3),'o','Color',rgb('DarkGreen'),'MarkerFaceColor',rgb('DarkGreen'));

legend([ p6 p2 p3 p4 p5], 'ZrO_2','(U_2_5,Zr_7_5)O_2','(U_5_0,Zr_5_0)O_2','(U_7_5,Zr_2_5)O_2','UO_2','Location','NorthWest')
legend boxoff
box off
xlabel('Temperature (K)')
ylabel('Heat Capacity $C_p$ ($kJ/kg.K$)')
set(gca,'FontSize',12,'FontName','Arial')
axis([350 3050, 75 150])
hold off
print -depsc2 UZrO2/Plots/HeatCapacity.eps
%%

% The following section opens text files containing experimental data which
% is then put into variables to be plotted with results. The 

fileID = fopen('Mastromarino.txt');
MP = textscan(fileID,'%f %f %f');
fclose(fileID);
MP = cell2mat(MP);
liquidus=MP(:,2);
CompLL = MP(:,1);
Error = MP(:,3);

fileID = fopen('Lambertson.txt');
MP = textscan(fileID,'%f,%f');
fclose(fileID);
MP=cell2mat(MP);
A=MP(:,1);
B=MP(:,2)+273;

fileID = fopen('LambertsonSolidus.txt');
MP = textscan(fileID,'%f,%f');
fclose(fileID);
MP=cell2mat(MP);
C=MP(:,1);
D=MP(:,2)+273;

fileID = fopen('MastromarinoSolidus.txt');
MP = textscan(fileID,'%f,%f');
fclose(fileID);
MP=cell2mat(MP);
E=(MP(:,1));
F=MP(:,2);

fileID = fopen('MastromarinoLiquidus.txt');
MP = textscan(fileID,'%f,%f');
fclose(fileID);
MP=cell2mat(MP);
G=(MP(:,1));
H=MP(:,2);

fileID = fopen('LambertsonData.txt');
MP = textscan(fileID,'%f %f %f %s');
fclose(fileID);
MP=MP(:,1:3);
MP = cell2mat(MP);
Liquid=MP(1:7,3)+273;
LiquidComp = MP(1:7,1);
Solid=MP(8:42,3)+273;
SolidComp=MP(8:42,1);
Solidliquid=MP(43:end,3)+273;
Comp = MP(43:end,1);
y=0;

for x=1:length(Solid)
    
    if Solid(x,1)>2750
        y=y+1;
        Solid(x,1);
        Solid2(y,:)=Solid(x,:);
        Comp2(y,:)=SolidComp(x,:);
    end

end

% X is the composition and Y is the melting point in K from the results of
% the melting point simulations, SD is the error introduced, +- 25 K as
% this was the highest resolution that was used.

X = [25,50,75,100];
Y = [3225, 3125,3025,3000];
SD = [ 25, 25, 25, 25];

%Plotting the melting point as a function of composition against the
%experimental values.

figure(7)

p1=errorbar(X,Y,SD,'d','LineWidth',1.3,'CapSize',5);
hold on
p2=errorbar(CompLL,liquidus,Error,'o','LineWidth',1.3,'MarkerSize',5,'Color',rgb('DimGray'),'MarkerFaceColor',rgb('DimGray'),'CapSize',5);
p3=plot(LiquidComp,Liquid,'o','LineWidth',2,'MarkerSize',5,'Color',rgb('Black'));
p4=plot(Comp2,Solid2,'s','LineWidth',2,'MarkerSize',7,'Color',rgb('Black'));
p5=plot(Comp,Solidliquid,'>','LineWidth',2,'MarkerSize',5,'Color',rgb('Black'));
p6=plot(A,B,':','Color',rgb('Black'),'LineWidth',3);
p7=plot(C,D,':','Color',rgb('Black'),'LineWidth',3);
p8=plot(E,F,'--','Color',rgb('DimGray'),'LineWidth',2);
p9=plot(G,H,'--','Color',rgb('DimGray'),'LineWidth',2);

legend([p2,p3,p4,p5,p1],'Liquid_M','Liquid_L','Solid_L','Solid+Liquid_L','This Work','Position',[0.161309528386309,0.525396825396825,0.244642852566072,0.28333332531509])
legend boxoff
box off
xlabel('\% UO\(_2\)','interpreter','latex')
ylabel('Temperature (K)')
set(gca,'FontSize',12,'FontName','Arial')
axis([-1 101, 2740 3260])
hold off

print -depsc2 UZrO2/Plots/MeltingPoint.eps
%%

% This file contains the bulk extrapolated results for the thermal
% conductivity which has been produced using the ThermalConductivity.m
% mfile

fileID = fopen('kappa.bulk.txt');
kappa = textscan(fileID,'%f %f %f\n','HeaderLines',1);
fclose(fileID);
kappa = cell2mat(kappa);

% The below separates the data from 'kappa.bulk.txt' into individual
% variables. 

U0kapparig = kappa(1:6,:);
U0Xdirkappa = kappa(7:12,:);
U0Ydirkappa = kappa(7:12,:);
U0kappatemp = U0kapparig(:,2);
U0kappa = (U0kapparig+U0Xdirkappa+U0Ydirkappa)/3 ;
U25kappa = kappa(13:17,:);
U50kappa = kappa(18:22,:);
U75kappa = kappa(23:27,:);
U100kappa = kappa(28:32,:);

% The below takes the formula used for calculating thermal conductivity
% from work by Cooper et al. and Fink 2000 for use in plotting. Also taken
% is the results from Eichler 2001 for ZrO2.

T = [500:10:2000];
Cooper = 1./(-1.36*10^-2 + 2.32*10^-4.*T);
t=T/1000;
Fink = 100./(7.5408+17.692.*t + 3.6142.*t.^2) + (6400./(t.^(5/2))).*exp(-16.35./t);

   fileID = fopen('ConductivityEichler2001ZrO2.txt');
    kZrO2 = textscan(fileID,'%f, %f','HeaderLines',0);
    fclose(fileID);
    kZrO2 = cell2mat(kZrO2);
    kZrO2 = kZrO2(3:end,:);
    Temp = kZrO2(:,1)+273;

% This figure plots the thermal conductivities for the cubic species (>25%
% UO2. 

figure(8)
  
    p2=plot(U25kappa(:,2),U25kappa(:,1),'s','Color',rgb('SeaGreen'),'LineWidth',2,'MarkerSize',8);
    hold on
    p3=plot(U50kappa(:,2),U50kappa(:,1),'^','Color',rgb('Teal'),'LineWidth',2,'MarkerSize',8);
    p4=plot(U75kappa(:,2),U75kappa(:,1),'d','Color',rgb('DodgerBlue'),'LineWidth',2,'MarkerSize',8);
    p5=plot(U100kappa(:,2),U100kappa(:,1),'x','Color',rgb('Navy'),'LineWidth',2,'MarkerSize',8);
    p6=plot(T,Fink,'','Color',rgb('Black'),'LineWidth',3);
    p7=plot(T,Cooper,'--','Color',rgb('Navy'),'LineWidth',3);
   
    legend([p2 p3 p4 p5 p6 p7], '(U_2_5,Zr_7_5)O_2','(U_5_0,Zr_5_0)O_2','(U_7_5,Zr_2_5)O_2','UO_2','Expt. Fink 2000','MD Cooper 2015','Location','NorthEast')
    legend boxoff
    box off
    xlabel('Temperature (K)')
    ylabel('Thermal Conductivity k (W/m.K)')
    set(gca,'FontSize',18,'FontName','Arial')
    axis([450 2050, 1.5 12.5])
    hold off
    print -depsc2 UZrO2/Plots/kappa.eps
    
   % This figure plots the thermal conductivity for ZrO2 with its
   % directional components and bulk conductivity
   
    figure(9)
    p2=plot(U0kappatemp,U0kappa(:,1),'o','Color',rgb('DarkGreen'),'MarkerFaceColor',rgb('DarkGreen'),'MarkerSize',8);
    hold on
    p1=plot(Temp,kZrO2(:,2),'','Color', rgb('Black'),'LineWidth',3)
    p3=plot(U0kapparig(:,2),U0kapparig(:,1),'o','Color',rgb('Orange'),'LineWidth',2,'MarkerSize',8);
    p4=plot(U0Xdirkappa(:,2),U0Xdirkappa(:,1),'o','Color',rgb('Indigo'),'LineWidth',2,'MarkerSize',8);
    legend([p1,p2,p3,p4],'Expt. YSZ','ZrO2 Bulk','ZrO_2 a_3_3','ZrO_2 a_1_1','Location','NorthEast')
    legend boxoff
    box off
    xlabel('Temperature (K)')
    %ylabel('Thermal Conductivity $\kappa$ (W/m.K)')
    set(gca,'FontSize',18,'FontName','Arial')
    axis([250 1300,-0.5 20])
    hold off
    print -depsc2 UZrO2/Plots/kappazro2.eps
    
%%
% The following section opens text files which contain radial distribution
% function data for ZrO2 to plot. Coord300K variable is reused for each
% for simplicity in copying and pasting. Values at 300K are saved to
% Coord300KO.

       fileID = fopen('300K.txt');
    Coord300K = textscan(fileID,'%f %f %f','HeaderLines',3);
    fclose(fileID);
   Coord300KO = cell2mat(Coord300K);
   
   fileID = fopen('600K.txt');
    Coord300K = textscan(fileID,'%f %f %f','HeaderLines',3);
    fclose(fileID);
   Coord500K = cell2mat(Coord300K);
   
   fileID = fopen('900K.txt');
    Coord300K = textscan(fileID,'%f %f %f','HeaderLines',3);
    fclose(fileID);
   Coord1000K = cell2mat(Coord300K);
   
   fileID = fopen('1200K.txt');
    Coord300K = textscan(fileID,'%f %f %f','HeaderLines',3);
    fclose(fileID);
   Coord1500K = cell2mat(Coord300K);
   
   fileID = fopen('1500K.txt');
    Coord300K = textscan(fileID,'%f %f %f','HeaderLines',3);
    fclose(fileID);
   Coord1600K = cell2mat(Coord300K);
   
   fileID = fopen('1800K.txt');
    Coord300K = textscan(fileID,'%f %f %f','HeaderLines',3);
    fclose(fileID);
   Coord1700K = cell2mat(Coord300K);
     fileID = fopen('2100K.txt');
    Coord300K = textscan(fileID,'%f %f %f','HeaderLines',3);
    fclose(fileID);
   Coord1800K = cell2mat(Coord300K);

   % This figure plots the RDF for the cation sublattice as a
   % function of temperature.
   
   figure(10)
   plot(Coord300KO(:,2),Coord300KO(:,3),'.','MarkerSize',10,'Color',rgb('Navy'))
   hold on
   plot(Coord500K(:,2),Coord500K(:,3)+5,'.','MarkerSize',10,'Color',rgb('DodgerBlue'))
   plot(Coord1000K(:,2),Coord1000K(:,3)+9,'.','MarkerSize',10,'Color',rgb('LightSeaGreen'))
   plot(Coord1500K(:,2),Coord1500K(:,3)+12,'.','MarkerSize',10,'Color',rgb('DarkGreen'))
   plot(Coord1600K(:,2),Coord1600K(:,3)+15,'.','MarkerSize',10,'Color',rgb('Teal'))
   plot(Coord1700K(:,2),Coord1700K(:,3)+17,'.','MarkerSize',10,'Color',rgb('Orange'))
   plot(Coord1800K(:,2),Coord1800K(:,3)+19,'.','MarkerSize',10,'Color',rgb('FireBrick'))
   
  annotation('textbox',[0.3,0.83,0.1,0.1],'String','(a) Oxygen Sublattice','FontSize',18,'FontName','Arial','EdgeColor','none')
  annotation('textbox',[0.75,0.18,0.1,0.1],'String','300 K','FontSize',18,'FontName','Arial','EdgeColor','none')
  annotation('textbox',[0.75,0.53,0.1,0.1],'String','1200 K','FontSize',18,'FontName','Arial','EdgeColor','none')
  annotation('textbox',[0.75,0.75,0.1,0.1],'String','2100 K','FontSize',18,'FontName','Arial','EdgeColor','none')



   xlabel('Pair Separation Distance (\AA)','interpreter','latex')
   ylabel('Radial Distribution Function g(r)')
   legend('300 K','2000 K','Location','NorthEast')
   set(gca,'FontSize',18,'FontName','Arial')
   box off
   legend boxoff
   hold off
   axis([2 8,0 25])
   hLeg=legend();
    set(hLeg,'visible','off')
    print -depsc2 UZrO2/Plots/RDF.eps
    
    
 % The following section opens text files which contain radial distribution
% function data for ZrO2 to plot. Coord300K variable is reused for each
% for simplicity in copying and pasting. Values at 300K are saved to
% Coord300KO.

           fileID = fopen('300KS.txt');
    Coord300K = textscan(fileID,'%f %f %f','HeaderLines',3);
    fclose(fileID);
   Coord300KOS = cell2mat(Coord300K);
   
   fileID = fopen('600KS.txt');
    Coord300K = textscan(fileID,'%f %f %f','HeaderLines',3);
    fclose(fileID);
   Coord500K = cell2mat(Coord300K);
   
   fileID = fopen('900KS.txt');
    Coord300K = textscan(fileID,'%f %f %f','HeaderLines',3);
    fclose(fileID);
   Coord1000K = cell2mat(Coord300K);
   
   fileID = fopen('1200KS.txt');
    Coord300K = textscan(fileID,'%f %f %f','HeaderLines',3);
    fclose(fileID);
   Coord1500K = cell2mat(Coord300K);
   
   fileID = fopen('1500KS.txt');
    Coord300K = textscan(fileID,'%f %f %f','HeaderLines',3);
    fclose(fileID);
   Coord1600K = cell2mat(Coord300K);
   
   fileID = fopen('1800KS.txt');
    Coord300K = textscan(fileID,'%f %f %f','HeaderLines',3);
    fclose(fileID);
   Coord1700K = cell2mat(Coord300K);
     fileID = fopen('2100KS.txt');
    Coord300K = textscan(fileID,'%f %f %f','HeaderLines',3);
    fclose(fileID);
   Coord1800K = cell2mat(Coord300K);

   
   % This figure plots the RDF for the cation sublattice as a
   % function of temperature.
   
   figure(11)
   plot(Coord300KOS(:,2),Coord300KOS(:,3),'.','MarkerSize',10,'Color',rgb('Navy'))
   hold on
   plot(Coord500K(:,2),Coord500K(:,3)+7,'.','MarkerSize',10,'Color',rgb('DodgerBlue'))
   plot(Coord1000K(:,2),Coord1000K(:,3)+10,'.','MarkerSize',10,'Color',rgb('LightSeaGreen'))
   plot(Coord1500K(:,2),Coord1500K(:,3)+14,'.','MarkerSize',10,'Color',rgb('DarkGreen'))
   plot(Coord1600K(:,2),Coord1600K(:,3)+18,'.','MarkerSize',10,'Color',rgb('Teal'))
   plot(Coord1700K(:,2),Coord1700K(:,3)+21,'.','MarkerSize',10,'Color',rgb('Orange'))
   plot(Coord1800K(:,2),Coord1800K(:,3)+24,'.','MarkerSize',10,'Color',rgb('FireBrick'))
       annotation('textbox',[0.3,0.83,0.1,0.1],'String','(b) Cation Sublattice','FontSize',18,'FontName','Arial','EdgeColor','none')
        annotation('textbox',[0.75,0.2,0.1,0.1],'String','300 K','FontSize',18,'FontName','Arial','EdgeColor','none')
         annotation('textbox',[0.75,0.53,0.1,0.1],'String','1200 K','FontSize',18,'FontName','Arial','EdgeColor','none')
         annotation('textbox',[0.75,0.77,0.1,0.1],'String','2100 K','FontSize',18,'FontName','Arial','EdgeColor','none')
   xlabel('Pair Separation Distance (\AA)','interpreter','latex')
   %ylabel('Radial Distribution Function g(r)')
   hLeg=legend();
    set(hLeg,'visible','off')
   set(gca,'FontSize',18,'FontName','Arial')
   box off
  
   hold off
   axis([3 8,0 30])
    print -depsc2 UZrO2/Plots/RDFStruct.eps
    
  
