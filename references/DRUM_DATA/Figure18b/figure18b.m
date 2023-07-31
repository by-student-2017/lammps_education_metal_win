clc;clear;close all;

% define colours:
dark_blue = [0 0.4470 0.7410];
dark_orange = [0.8500 0.3250 0.0980];
dark_yellow = [0.9290 0.6940 0.1250];
light_green = [0.4660 0.6740 0.1880];
light_blue = [0.3010 0.7450 0.9330];
dark_purple = [0.4940 0.1840 0.5560];
dark_red = [0.6350 0.0780 0.1840];
coral = [248, 131, 121]./255;
dark_emerald = [0, 153, 18]./255;


%%
figure()
hold on
load REBO_strain
plot(x_line_CM-10,v_line_CM,'LineWidth',1,'Color',dark_yellow)
plot(x_line_MS-10,v_line_MS,'--','LineWidth',2,'Color',dark_purple)

load SW_strain
plot(x_line_CM-10,v_line_CM,'LineWidth',1,'Color',dark_orange)
plot(x_line_MS-10,v_line_MS,'--','LineWidth',2,'Color',light_blue)
set(gca,'FontSize',12) 

hold off
legend('CM REBO','MS REBO',...
       'CM SW',...
       'MS SW',...
       'Interpreter','latex','location','south')
set(gca,'FontSize',18)
xlim([-20,20])
ylim(1e-3*[2,12])
xlabel('$x_1$ (nm)','Interpreter','latex')
ylabel('Principal strain','Interpreter','latex')
