function Core_shell_simulation
 clc
 format short
 
 rn = load('ZnS_3x3x3_0.1K_Z_-100000000_lattice.txt');
 rp = load('ZnS_3x3x3_0.1K_Z_100000000_lattice.txt');
 
V = 20569.64;
 
% Charge of electron
 e = 1.6021766208 * 10^-19;
 q = 2 * e;
 
 dP3du = (4*(-2.06))/(sqrt(3)*(3.281^2))
 dudE3 = -2.3;
 e33 = -0.44 + dP3du*dudE3
 
 z_dir = 5;
 r = dlmread('ZnS_0.1K_Z_SS_U_-100000000.0.atom',' 
',9,0);
 a = rn(1,3) 
 b = rn(1,4) 
 c = rn(1,5)
 V = rn(1,6) 
 
 Pv_0 = Polarization(r,z_dir,V)
 Zn_O = Uk(r)
 c = c
 u_0 = Zn_O/c
 
 Pa_0 = (-4 * q * u_0)/(sqrt(3) * a^2 * 10^-20)
 
 
 [E_n,P_a_n,U_n] = Polarization_a(rn,'ZnS_0.1K_Z_SS_U_-
100000000.');
 [E_p,P_a_p,U_p] = 
Polarization_a(rp,'ZnS_0.1K_Z_SS_U_100000000.');
 
% Strain
 E_n = E_n(length(E_n):-1:1);
 E = [E_n,E_p];
% Polarizations
 P_a_n = P_a_n(length(P_a_n):-1:1);
 P_a = [P_a_n,P_a_p]
 
% Coordinate faction
 U_n = U_n(length(U_n):-1:1);
 U = [U_n,U_p];
 
% Volume parameters
 V_n = rn(:,6);
 V_n = V_n(length(V_n):-1:1);
 Vc = [V_n;rp(:,6)]';
 
 [E_n,P_v_n] = Polarization_V(rn,'ZnS_0.1K_Z_SS_U_-
100000000.',z_dir);
 [E_p,P_v_p] = 
Polarization_V(rp,'ZnS_0.1K_Z_SS_U_100000000.',z_dir);
 P_v_n = P_v_n(length(P_v_n):-1:1);
 P_v = [P_v_n,P_v_p]
 
 
% Experimental Value 
 e_a_int_Die = -0.182 * -6.94
% Plot for dU/dE 
figure(1)
 plot(E,U,'sk','LineWidth',3,'MarkerSize',10)
 p = polyfit(E,U,2);
 f = polyval(p,E);
 hold on
 plot(E,f,'--k','LineWidth',3,'MarkerSize',10)
 xlabel('\epsilon_3','fontweight','bold','fontsize',15)
 ylabel('u (eV)','fontweight','bold','fontsize',15)
 legend('Wright (2004) potential','linear Fit of 
u','fontweight','bold','fontsize',20)
 
set(gca,'fontweight','bold',"linewidth",3,'fontsize',25)
 box on
 dUdE = p(2)
 
 
% Plot for dP/dU
figure(2)
 plot(U,P_v,'--k','LineWidth',3,'MarkerSize',10)
 p = polyfit(U,P_v,1);
 f = polyval(p,U);
 hold on
 plot(U,f,'sk','LineWidth',3,'MarkerSize',10)
 xlabel('U(eV)','fontweight','bold','fontsize',15')
 ylabel('P_v (C/m^2)','fontweight','bold','fontsize',15)
 
set(gca,'fontweight','bold',"linewidth",3,'fontsize',25)
 box on
 dP_vdU = p(1)
 
% Using left side of proper piezoelectric constants
 e_v_int_l = dP_vdU * dUdE 
 
% Plot for dP/dE 
figure(3)
 plot(E,P_v,'--b','LineWidth',3,'MarkerSize',10)
 p = polyfit(E,P_v,2);
 f = polyval(p,E);
 hold on
 plot(E,f,'sr','LineWidth',3,'MarkerSize',10)
 xlabel([char(949)],'fontweight','bold','fontsize',15)
 ylabel('P_v (C/m^2)','fontweight','bold','fontsize',15)
 
set(gca,'fontweight','bold',"linewidth",3,'fontsize',25)
 box on
 dP_vdE = p(2)
 
 
% Plot for dP_a/dU 
figure(4)
 plot(U,P_a,'--b','LineWidth',3,'MarkerSize',10)
 p1 = polyfit(U,P_a,1);
 f = polyval(p1,U);
 hold on
 plot(U,f,'sr','LineWidth',3,'MarkerSize',10)
 xlabel('U (eV)','fontweight','bold','fontsize',15)
 ylabel('P_a (C/m^2)','fontweight','bold','fontsize',15)
 
set(gca,'fontweight','bold',"linewidth",3,'fontsize',25)
 box on
 dP_adU = p1(1)
% Using right side of proper piezoelectric constants
 e_a_int_r = dP_adU * dUdE 
% Plot for dP_a/dE 
figure(5)
 plot(E,P_a,'--b','LineWidth',3,'MarkerSize',10)
 p = polyfit(E,P_a,2);
 f = polyval(p,E);
 hold on
 plot(E,f,'sr','LineWidth',3,'MarkerSize',10)
 xlabel([char(949)],'fontweight','bold','fontsize',15)
 ylabel('P_a (C/m^2)','fontweight','bold','fontsize',15)
 
set(gca,'fontweight','bold',"linewidth",3,'fontsize',25)
 box on
 dP_adE = p(2)
% Calculate 𝑒33
0
 e_a_0 = dP_adE - e_a_int_r
 
% Plot for dE/dV 
figure(6)
 plot(E,Vc,'--k','LineWidth',3,'MarkerSize',10)
 p = polyfit(E,Vc,2);
 f = polyval(p,E);
 hold on
 plot(E,f,'sk','LineWidth',3,'MarkerSize',10)
 xlabel('\epsilon_3','fontweight','bold','fontsize',15)
 ylabel('V (A^3)','fontweight','bold','fontsize',15)
 legend('linear Fit of V - Wright 
2004','fontweight','bold','fontsize',20)
 
set(gca,'fontweight','bold',"linewidth",3,'fontsize',25)
 box on
 
% Plot for compare dP_a/dE with dP_v/dE 
figure(7) 
plot(E,P_a,'sk',E,P_v,'ok','LineWidth',3,'MarkerSize',10)
 p = polyfit(E,P_a,2)
 f_a = polyval(p,E);
 p = polyfit(E,P_v,2)
 f_v = polyval(p,E);
 hold on
 plot(E,f_a,'-.k',E,f_v,'--
k','LineWidth',3,'MarkerSize',10)
 xlabel('\epsilon_3','fontweight','bold','fontsize',15)
 ylabel('P_3-core-core 
(C/m^2)','fontweight','bold','fontsize',15)
 legend('P_3(u) - Wright 2004','P_3(v) - Wright 
2004','linear Fit of 
P_3','fontweight','bold','fontsize',20)
 
set(gca,'fontweight','bold',"linewidth",3,'fontsize',25)
 box on
 
% Plot for compare dP_a/dU with dP_v/dU 
figure(8) 
plot(U,P_a,'sk',U,P_v,'ok','LineWidth',3,'MarkerSize',10)
 p1 = polyfit(U,P_a,1)
 f_a = polyval(p1,U);
 p2 = polyfit(U,P_v,1)
 f_v = polyval(p2,U);
 hold on
 plot(U,f_a,'sk',U,f_v,'--
k','LineWidth',3,'MarkerSize',10)
 xlabel('u (eV)','fontweight','bold','fontsize',15)
 ylabel('P_3-core-core 
(C/m^2)','fontweight','bold','fontsize',15)
 legend('P_3(u) - Wright 2004','P_3(v) - Wright 
2004','fontweight','bold','fontsize',20)
 
set(gca,'fontweight','bold',"linewidth",3,'fontsize',25)
 box on
 
hold off
% Calculate P3 using coordinate fraction u 
function [E,P,U] = Polarization_a(r1,s)
 q = 2.0 * e;
 n = length(r1(:,1)); 
 for i = 1:n 
 st = append(s,int2str(r1(i,1)),'.atom');
 r2 = dlmread(st,' ',9,0);
 Zn_O = Uk(r2);
 a = r1(i,3); 
 c = r1(i,5);
 c_a = c/a;
 u = Zn_O/c;
 U(i) = u;
 P(i) = (-4 * q * u)/(sqrt(3) * a^2 * 10^-20);
 dP_adu = (-4 * q)/(sqrt(3) * a^2 * 10^-20)
 E(i) = r1(i,2);
 end
 end
% Calculate P3 using volume
 function [E,P] = Polarization_V(r1,s,dir)
 n = length(r1(:,1)); 
 for i = 1:n 
 V = r1(i,6);
 st = append(s,int2str(r1(i,1)),'.atom');
 r2 = dlmread(st,' ',9,0);
 P(i) = Polarization_CS(r2,dir,V);
 E(i) = r1(i,2);
 end
 end
 
end
% Calculate Polarization P3
function [P3] = Polarization(r,dir,V)
 e = 1.6021766208 * 10^-19; % C
 z1 = 2.0; % Valence electrons
 z2 = -2.0; % 
 n = length(r(:,1));
 sum = 0;
 for i = 1:n;
 type = r(i,2);
 ri = r(i,dir) * 10^-10; % from A to m
 if(type == 1)
% fprintf('element = Zn charge = 2\n');
 sum = sum + (z1 * e) * ri;
 elseif (type ==2)
% fprintf('element = S charge = -2\n');
 sum = sum + (z2 * e) * ri;
 end
 end
 P3 = sum/V;
 P3 = P3 / (10^-10)^3;
end
% Calculate coordinate fraction u
function u = Uk(r)
 u = 1;
 n = length(r(:,1));
 sum = 0;
 counter = 0;
 for i = 1:n
 id1 = r(i,1);
 type1 = r(i,2);
 for j = 1:n
 id2 = r(j,1);
 type2 = r(j,2);
 if (type1 == 1 && type2 == 2)
 x1 = r(i,3);
 y1 = r(i,4);
 z1 = r(i,5);
x2 = r(j,3);
 y2 = r(j,4);
 z2 = r(j,5);
 if abs(x2-x1) < 0.3 && abs(y2-y1) < 0.3 && 
abs(z2-z1) <= 2.6
 d = sqrt( (z2-z1)^2 );
sum = sum + d;
counter = counter + 1;
 end
 end
 end
 u = sum/counter;
 end
end
function [P3] = Polarization_CS(r,dir,V)
e = 1.6021766208 * 10^-19;
% Charge of Core, Core, Shell, Shell
z = [2.00, 1.030610, 0.0, -3.030610]; 
% z = [2.00, -2.0, 0.0, 0.0];
 n = length(r(:,1));
 sum = 0;
 for i = 1:n;
 type = r(i,2);
 ri = r(i,dir) * 10^-10; % from A to m
 sum = sum + (z(type) * e) * ri; % C.m
 end
 P3 = sum/V;
 P3 = P3 / (10^-10)^3;
end
