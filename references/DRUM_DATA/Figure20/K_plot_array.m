%% Load data 
clc;clear;close all;
%%
L = 400;

figure()
bxyz = load(sprintf('cos_L%d_REBO_max_abseig.csv',L));
randIndex = randperm(size(bxyz,1));
% bxyz = flip(bxyz);
% bxyz = bxyz(randIndex,:);
hold on
axis equal 
for i = [-1,0,1]
    for j = [-1,0,1]
        s = scatter(bxyz(:,2)+i*L-j*L/2-L/4,bxyz(:,3)+j*L*1.732/2-L/4*1.732,[],bxyz(:,1), ...
            'filled');
        s.SizeData = 5;
    end
end
axis equal 
hold off
hcb = colorbar;
set(hcb.Title,'Interpreter','latex','FontSize',15)
hcb.Title.String = "$\mathrm{nm^{-1}}$";
% caxis([0,0.155])
set(gca,'FontSize',15)
xlabel("$x_1$ (nm)",'FontSize',20,'Interpreter','latex')
ylabel("$x_2$ (nm)",'FontSize',20,'Interpreter','latex')
% xlim([-20.5,40.5])
% ylim([-5,40])