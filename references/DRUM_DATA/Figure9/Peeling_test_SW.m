clc;clear all;close all;
%%
load MS_peeling_SW.mat
h1_CM = load('CM_h1_SW.csv');
h5_CM = load('CM_h5_SW.csv');
h11_CM = load('CM_h11_SW.csv');

x = 0:34.28/1000:34.28;

%%

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

x_substrate = 0:0.1:x(end);
y_substrate = zeros(1,length(x_substrate));

fig = figure('Color',[1 1 1]);
hold all
plot(x'+h1_CM(:,1),h1_CM(:,2)+1,'LineWidth',4,'Color',dark_yellow)
plot(x'+h5_CM(:,1),h5_CM(:,2)+5,'LineWidth',4,'Color',dark_orange)
plot(x'+h11_CM(:,1),h11_CM(:,2)+11,'LineWidth',4,'Color',dark_emerald)
plot(data_adhesion_profile_h1_SW(1,:,2),data_adhesion_profile_h1_SW(1,:,3),'--','LineWidth',3,'MarkerSize',5,'Color',dark_purple)
plot(data_adhesion_profile_h5_SW(1,:,2),data_adhesion_profile_h5_SW(1,:,3),'--','LineWidth',3,'MarkerSize',5,'Color',light_blue)
plot(data_adhesion_profile_h11_SW(1,:,2),data_adhesion_profile_h11_SW(1,:,3),'--','LineWidth',3,'MarkerSize',5,'Color',coral)

plot(x_substrate,y_substrate,'-.','LineWidth',3,'MarkerSize',5,'Color','k')
hold off

xlim([0,x(end)])
ylim([-0.5,12])
box on

legend('CM $h_p$=1\phantom{1} nm','CM $h_p$=5\phantom{1} nm','CM $h_p$=11 nm', ...
       'MS $h_p$=1\phantom{1} nm','MS $h_p$=5\phantom{1} nm','MS $h_p$=11 nm', 'Substrate', 'Interpreter','latex')
%title('peeling, fix R end')
xlabel('$x_{1}$ (nm)','Interpreter','latex')
ylabel('$x_{3}$ (nm)','Interpreter','latex')
set(gca,'FontSize',18)


% save plot in files:
% plot_name = "./Figures/peeling_test_results";
% saveas(fig,strcat(plot_name,'.fig'))
% saveas(fig,strcat(plot_name,'.jpg'))
% saveas(fig,strcat(plot_name,'.eps'),'epsc')
% saveas(fig,strcat(plot_name,'.pdf'))
