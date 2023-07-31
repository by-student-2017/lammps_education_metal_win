clc;close all;clear;
%%
ev2kgm2 = 1.60218e-19;
ev2kgnm2 = ev2kgm2*1e18;

L = [340,360,380,400,440,480,520];
E_LJ_REBO = [-7412.278529264697,-9998.449564084382,-13128.407150134939,-16929.775609677094,-25717.585240396587,-35389.48325016617,-45876.5685137255];
E_memb_REBO = [1864.5772951903891,1792.8614507167158,1938.7827538508675,2108.493352333151,2181.005210429436,2182.07152639281,2192.6325962292603];
E_bend_REBO = [135.12914344644855,123.99493837086112,115.67482885863866,111.19867272307215,110.4469743967125,111.88596508642591,113.05258756911458];

L = [340,360,370,380,390,400,440,480,520];
E_LJ_REBO = [-7412.278529264697,-9998.449564084382,-11473.08532023178,-13128.407150134939,-14949.939767845184,-16929.775609677094,-25717.585240396587,-35389.48325016617,-45876.5685137255];
E_memb_REBO = [1864.5772951903891,1792.8614507167158,1858.469685871429,1938.7827538508675,2050.6601361148737,2108.493352333151,2181.005210429436,2182.07152639281,2192.6325962292603];
E_bend_REBO = [135.12914344644855,123.99493837086112,116.80316512098747,115.67482885863866,110.17447797956973,111.19867272307215,110.4469743967125,111.88596508642591,113.05258756911458];


A = L.^2*3^0.5/2;

Lt = [340,360,380,400,440,480,520];
figure()
f1 = plot(L,E_memb_REBO/ev2kgnm2./A,'*-','LineWidth',1.5);
xlabel('L (nm)','Interpreter','latex')
ylabel('membrane energy (eV/nm$^2$)','Interpreter','latex')
set(gca,'FontSize',15)
xticks(Lt)
xlim([330,530])
% ylim([0.045,0.105])


figure()
plot(L,E_bend_REBO/ev2kgnm2./A,'*-','LineWidth',1.5)
xlabel('L (nm)','Interpreter','latex')
ylabel('bending energy (eV/nm$^2$)','Interpreter','latex')
set(gca,'FontSize',15)
xticks(Lt)
xlim([330,530])
ylim([0.0025,0.009])

figure()
plot(L,E_LJ_REBO/ev2kgnm2./A,'*-','LineWidth',1.5)
xlabel('L (nm)','Interpreter','latex')
ylabel('LJ energy (eV/nm$^2$)','Interpreter','latex')
set(gca,'FontSize',15)
xticks(Lt)
xlim([330,530])
% ylim([-1.3,-0.5])

% figure()
% hold on
% plot(L,E_memb_REBO/ev2kgnm2,'*-','LineWidth',1)
% plot(L,E_bend_REBO/ev2kgnm2,'*-','LineWidth',1)
% xlabel('L (nm)','Interpreter','latex')
% % ylabel('E\_LJ (eV)','Interpreter','latex')
% set(gca,'FontSize',18)
% xticks(L)
% xlim([350,530])