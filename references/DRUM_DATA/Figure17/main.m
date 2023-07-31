clc;clear;close all;
p_choice = 1;
potential = {'REBO','SW'};
colormap = {1e-3*[2 7],1e-3*[0 10]};
%% MD
eval(['load MS_',potential{p_choice}])
figure()
hold on
axis equal 
scatter(xpos,ypos,[],E_prin,'filled')
xlabel('X (nm)')
ylabel('Y (nm)')
set(gca,'FontSize',18)
colorbar
caxis(colormap{p_choice})
title(['Pincipal strain MS (potential = ',potential{p_choice},')'])
hold off
%% CM
figure()
exyz = load(strcat('CM_',potential{p_choice},'.csv'));
hold on
axis equal 
scatter(exyz(:,2),exyz(:,3),[],exyz(:,1),'filled')
xlabel('X (nm)')
ylabel('Y (nm)')
set(gca,'FontSize',18)
colorbar
caxis(colormap{p_choice})
title(['Pincipal strain CM (potential = ',potential{p_choice},')'])
hold off

p_choice = 2;
potential = {'REBO','SW'};
colormap = {1e-3*[2 7],1e-3*[0 10]};
%% MD
eval(['load MS_',potential{p_choice}])
figure()
hold on
axis equal 
scatter(xpos,ypos,[],E_prin,'filled')
xlabel('X (nm)')
ylabel('Y (nm)')
set(gca,'FontSize',18)
colorbar
caxis(colormap{p_choice})
title(['Pincipal strain MS (potential = ',potential{p_choice},')'])
hold off
%% CM
figure()
exyz = load(strcat('CM_',potential{p_choice},'.csv'));
hold on
axis equal 
scatter(exyz(:,2),exyz(:,3),[],exyz(:,1),'filled')
xlabel('X (nm)')
ylabel('Y (nm)')
set(gca,'FontSize',18)
colorbar
caxis(colormap{p_choice})
title(['Pincipal strain CM (potential = ',potential{p_choice},')'])
hold off

