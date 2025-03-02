clc;clear;close all
%% Data 
strain = [1.918*10^(-4) 1.11*10^(-4) 8.23*10^(-5) 6.33*10^(-5) 4.41*10^(-5)];
radius = [10 13 15 17 20]; % (unit: nm)
curvature = 1./radius;
%% Find optimal line 
A = zeros(2,2);% matrix
b = zeros(1,2); 
c = curvature.^2;
sum1 = 0; sum2 = 0;
for i = 1:size(strain,2)
        sum1 = sum1 + (strain(i)-mean(strain))*(c(i)-mean(c));
        sum2 = sum2 + (c(i)-mean(c))^2;
end
slope = sum1/sum2;
b = mean(strain) - slope*mean(c);
%% Figure 
figure()
hold on 
errorbar(c,strain,10^-3*[0.0063,0.0041,0.0042,0.0022,0.0033],'-o','MarkerSize',5 ...
    ,'MarkerEdgeColor','blue','MarkerFaceColor','blue');
plot(c,c*slope+b,':','Linewidth',2)
legend(['$(\mathbf{E}_{\rm Mo})_{11}$ (MS result)'],['$(\mathbf{E}_{\rm Mo})_{11}= C*\vert\mathbf{\kappa}_{1}\vert^2$ (C=0.02 nm$^2$)'],'Interpreter','latex','Location','northwest')
set(gca,'FontSize',18)
xlabel('$\vert\mathbf{\kappa}_{1}\vert^2 (\rm {nm}^{-2})$','Interpreter','latex')
ylabel('$(\mathbf{E}_{\rm Mo})_{11}$','Interpreter','latex')
set(gca,'FontSize',18)
hold off
