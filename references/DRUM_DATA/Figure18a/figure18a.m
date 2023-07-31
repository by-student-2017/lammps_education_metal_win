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
r_20 = -20:40/1000:20;
d2_N100_An16_R16_a2_I_D17a_na2 = load('Nel100_A-16_R16_a2_I_D17.46a_na2.csv');
k_Mo_REBO = load('cos_L40_REBO_max_abseig_cross.csv');
k_Mo_SW = load('cos_L40_SW_max_abseig_cross.csv');
%%
figure()
hold on
plot(d2_N100_An16_R16_a2_I_D17a_na2(:,1)+r_20',k_Mo_REBO,'LineWidth',1.0,'Color',dark_yellow)
plot(d2_N100_An16_R16_a2_I_D17a_na2(:,1)+r_20',k_Mo_SW,'LineWidth',1.0,'Color',dark_orange)

load data_REBO_Mo_K_tensor % Curvature tensor 
K = - K;
K_prin1 = 0.5*(K(:,1)+K(:,2)) + 0.5 * (4*K(:,3).^2+(K(:,1)-K(:,2)).^2).^0.5;
K_prin2 = 0.5*(K(:,1)+K(:,2)) - 0.5 * (4*K(:,3).^2+(K(:,1)-K(:,2)).^2).^0.5;
K_prin = max(abs(K_prin1),abs(K_prin2));
id_MS_REBO = find(abs(ypos-20*3^0.5/2)<0.1);
plot(xpos(id_MS_REBO)-10,K_prin(id_MS_REBO),'--','LineWidth',2,'Color',dark_purple)

load data_SW_MO_K_tensor % Curvature tensor 
K = - K;
K_prin1 = 0.5*(K(:,1)+K(:,2)) + 0.5 * (4*K(:,3).^2+(K(:,1)-K(:,2)).^2).^0.5;
K_prin2 = 0.5*(K(:,1)+K(:,2)) - 0.5 * (4*K(:,3).^2+(K(:,1)-K(:,2)).^2).^0.5;
K_prin = max(abs(K_prin1),abs(K_prin2));
id_MS_SW = find(abs(ypos-20*3^0.5/2)<0.1);
plot(xpos(id_MS_SW)-10,K_prin(id_MS_SW),'--','LineWidth',2,'Color',light_blue)


set(gca,'FontSize',12) 
hold off
legend('CM REBO','CM SW',...
       'MS REBO','MS SW',...
       'Interpreter','latex','location','north')
set(gca,'FontSize',18)
xlim([-20,20])
ylim([-0.01,0.25])
xlabel('$x_1$ (nm)','Interpreter','latex')
ylabel('Spectral radius of \boldmath${\kappa}$','Interpreter','latex')

