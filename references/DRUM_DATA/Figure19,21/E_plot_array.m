%% Load data 
clc;clear;close all;
% Input parameter
L = 400;

figure()
exyz = load(sprintf('e_Mo_L%d_C0.048_p2_REBO_2D.csv',L));
hold on
axis equal 
for i = [-1,0,1]
    for j = [-1,0,1]
        s = scatter(exyz(:,2)+i*L-j*L/2-L/4,exyz(:,3)+j*L*1.732/2-L/4*1.732,[],exyz(:,1), ...
            'filled');
        s.SizeData = 5;
    end
end
axis equal 
hold off
% colormap winter
hcb = colorbar;
set(hcb.Title,'Interpreter','latex','FontSize',15)
% hcb.Title.String = "$\mathrm{nm^{-1}}$";
% caxis([0.001,0.011])
caxis([0.005,0.02])
set(gca,'FontSize',15)
xlabel("$x_1$ (nm)",'FontSize',20,'Interpreter','latex')
ylabel("$x_2$ (nm)",'FontSize',20,'Interpreter','latex')