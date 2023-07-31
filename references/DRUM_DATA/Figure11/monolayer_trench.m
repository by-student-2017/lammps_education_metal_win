clc;close all;clear all;
%%
R = 16;
r_20 = -20:40/1000:20;
trench_sub = (-R<r_20).*(r_20<R).*(0.5*(cos(pi/16.*r_20)+1)).^2 * -16;
substrate = load('substrate.csv');
CM_REBO = load('CM_trench_REBO.csv');
CM_SW = load('CM_trench_SW.csv');
load MS_trench_REBO.mat
MD_An16_REBO = data;
load MS_trench_SW.mat
MD_An16_SW = data;
%%
% define colors:
dark_blue = [0 0.4470 0.7410];
dark_orange = [0.8500 0.3250 0.0980];
dark_yellow = [0.9290 0.6940 0.1250];
light_green = [0.4660 0.6740 0.1880];
light_blue = [0.3010 0.7450 0.9330];
dark_purple = [0.4940 0.1840 0.5560];
dark_red = [0.6350 0.0780 0.1840];
coral = [248, 131, 121]./255;
dark_emerald = [0, 153, 18]./255;

fig = figure('Color',[1 1 1]);

hold all
% CM
plot(CM_REBO(:,1)+r_20',...
    CM_REBO(:,2),'LineWidth',2,'Color',dark_yellow) 
plot(CM_SW(:,1)+r_20',...
    CM_SW(:,2),'LineWidth',2,'Color',dark_orange) 
% MD
plot(MD_An16_REBO(1,:),MD_An16_REBO(2,:),'--','LineWidth',2,'Color',dark_purple)
plot(MD_An16_SW(1,:),MD_An16_SW(2,:),'--','LineWidth',2,'Color',light_blue) 
% Substrate
plot(r_20,substrate,'k-.','LineWidth',2)
%
a = area(r_20,trench_sub,-17);
a.FaceAlpha = 0.2;
a.FaceColor = 'k';
% add zoom box:
plot([5,15],[-2,-2],'k--',[5,15],[1,1],'k--',[5,5],[-2,1],'k--',[15,15],[-2,1],'k--')
set(gca,'FontSize',12) 
box on 
hold off

legend('MS REBO','MS SW',...
       'CM REBO','CM SW','Substrate','location','southeast',...
       'Interpreter','latex')

xlabel('x (nm)','Interpreter','latex')
ylabel('z (nm)','Interpreter','latex')
set(gca,'FontSize',18)
xlim([-20,20])
ylim([-17,2])
%% Zoomed Plot
fig2 = figure('Color',[1 1 1]);
hold all
% CM
plot(CM_REBO(:,1)+r_20',...
    CM_REBO(:,2),'LineWidth',2,'Color',dark_yellow) 
plot(CM_SW(:,1)+r_20',...
    CM_SW(:,2),'LineWidth',2,'Color',dark_orange) 
% MD
plot(MD_An16_REBO(1,:),MD_An16_REBO(2,:),'--','LineWidth',2,'Color',dark_purple)
plot(MD_An16_SW(1,:),MD_An16_SW(2,:),'--','LineWidth',2,'Color',light_blue) 
% Substrate
plot(r_20,substrate,'k-.','LineWidth',2)
a = area(r_20,trench_sub,-17);
a.FaceAlpha = 0.2;
a.FaceColor = 'k';
set(gca,'FontSize',12) 
box on 
hold off

legend('MS REBO','MS SW',...
       'CM REBO','CM SW','Substrate','location','southeast',...
       'Interpreter','latex')

xlabel('x (nm)','Interpreter','latex')
ylabel('z (nm)','Interpreter','latex')
set(gca,'FontSize',18)
xlim([5,15])
ylim([-2,1])

