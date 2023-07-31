clc
clear
close all 
load AFM_data_Si3N4_substrate
data = data.*10^6*1000;

imagesc(data)
hold on 
axis equal
hold off


cutoff = 4;

% Input two points(index)
% x and y is flipped 

y1 = 90;x1 = 185;
y2 = 132;x2 = 168;

dis = sqrt((x2-x1)^2+(y2-y1)^2);
dis_alpha = dis/180*200/2 - dis/2;
slope = atan((y2-y1)/(x2-x1));
add_x = dis_alpha*cos(-slope);
add_y = dis_alpha*sin(-slope);

y1 = y1-add_y;y2 = y2+add_y;
x1 = x1+add_x;x2 = x2-add_x;

slope = (y2-y1)/(x2-x1);
a = -slope; b = 1; c = -y1+slope*x1;


% line equation, set nei list
num = 0;
for i = 1:size(data,1)
    for j = 1:size(data,2)
       x0 = i;y0 = j;
       dis = abs(a*x0+b*y0+c)/sqrt(a^2+b^2);
       if dis < cutoff*4
          num = num + 1;
          neilist(num,:) = [i,j,data(i,j)];
       end
    end
end

% Draw profile 
num_p = 100;
point_x = linspace(x1,x2,num_p);
point_y = linspace(y1,y2,num_p);

for i = 1:num_p
    xp = point_x(i) ; yp = point_y(i);
    num_sum = 1;
    sum = 0;
    for j = 1:num 
       xn = neilist(j,1); yn = neilist(j,2); dn = neilist(j,3);
       dis = sqrt((xp-xn)^2+(yp-yn)^2); 
       if dis < cutoff
           sum = sum+dn; num_sum = num_sum + 1;
       end
    end
    h(i) = sum/num_sum;
end
dis = sqrt((x1-x2)^2+(y1-y2)^2)*4;
line_dis = linspace(0-300,dis-300,num_p);

figure(1)
subplot(2,1,1);
imagesc(data)
hold on 
plot(point_y,point_x,'r','linewidth',6)
axis equal
xticks([0 256/2 256])
xticklabels({'0','500','1000'})
yticks([0 256/2 256])
yticklabels({'0','500','1000'})
% xlabel("\bf X (nm)",'FontSize',20)
% ylabel("\bf Y (nm)",'FontSize',20)
xlabel('$x_1$ (nm)','Interpreter','latex')
ylabel('$x_2$ (nm)','Interpreter','latex')
set(gca,'FontSize',16)
hold off


subplot(2,1,2); 

plot(line_dis,h-max(h),'linewidth',8)
hold on
% xlabel("\bf X (nm)",'FontSize',20)
% ylabel("\bf Y (nm)",'FontSize',20)

%%
L = 400;
r_long = -1000:0.1:1000;
R = 240;
cosSub_CM = (-R<r_long).*(r_long<R).*(0.5*(cos(pi/R.*r_long)+1)).^2 * -240;
cosSub_CM_left = (-R-L<r_long).*(r_long<R-L).*(0.5*(cos(pi/R.*(r_long+L))+1)).^2 * -240;
hold on
plot(r_long,cosSub_CM_left+cosSub_CM,'--','linewidth',8)
hold off
xlim([-305,-95])
ylim([-90,10])
hold off
xlabel('$TODO$ (nm)','Interpreter','latex')
ylabel('$x_3$ (nm)','Interpreter','latex')
legend('AFM','CM','Interpreter','latex','Location','south')
set(gca,'FontSize',16)

%%
cosSub_xyz = load('CM_sub.csv');
cosSub_z = cosSub_xyz(:,3);
cosSub_xyz(:,1) = cosSub_xyz(:,1) - mean(cosSub_xyz(:,1));
cosSub_xyz(:,2) = cosSub_xyz(:,2) - mean(cosSub_xyz(:,2));
alpha = 40/180*pi;
cosSub_xR = cos(alpha) * cosSub_xyz(:,1) - sin(alpha)  * cosSub_xyz(:,2);
cosSub_yR = sin(alpha) * cosSub_xyz(:,1) + cos(alpha)  * cosSub_xyz(:,2);
cosSub_XR = reshape(cosSub_xR,301,301);
cosSub_YR = reshape(cosSub_yR,301,301);
cosSub_Z = reshape(cosSub_z,301,301);
%
N_reduced = 20;
ij_reduced = floor(linspace(1,301,N_reduced));
cosSub_XR_reduced = zeros(N_reduced,N_reduced);
cosSub_YR_reduced = zeros(N_reduced,N_reduced);
cosSub_Z_reduced = zeros(N_reduced,N_reduced);
for i = 1:N_reduced
    for j = 1:N_reduced
        cosSub_XR_reduced(i,j) = cosSub_XR(ij_reduced(i),ij_reduced(j));
        cosSub_YR_reduced(i,j) = cosSub_YR(ij_reduced(i),ij_reduced(j));
        cosSub_Z_reduced(i,j) = cosSub_Z(ij_reduced(i),ij_reduced(j));
    end
end

figure(2)
hold on
%%%%%% CM
% cosSub = scatter3(cosSub_xR+630,cosSub_yR+630,cosSub_z,[],cosSub_z,'filled');
% cosSub = scatter3(cosSub_xR+630,cosSub_yR+630,cosSub_z, 'MarkerEdgeAlpha', 0.10, 'MarkerFaceAlpha', 0.10);
cosSub = mesh(cosSub_XR+630,cosSub_YR+630,cosSub_Z, 'edgecolor', 'k','EdgeAlpha',0.1,'FaceAlpha',0.3);
cosSub_grid = mesh(cosSub_XR_reduced+630,cosSub_YR_reduced+630,cosSub_Z_reduced, ...
         'edgecolor', 'k','EdgeAlpha',1,'FaceAlpha',0.1);
data = data - 2087.2;

[X,Y]=meshgrid(0:1000/255:1000,0:1000/255:1000);
AFM=mesh(X,Y,data,'EdgeAlpha',1,'FaceAlpha',1);
hold off
set(gca,'FontSize',15)
zlim([-60 50])
ylim([250 850])
xlim([250 980])
set(gca,'ztick',[])
set(gca,'zticklabel',[])
hcb = colorbar;
hcb.Title.String = "nm";
set(hcb,'position',[0.88,0.6,0.03,0.3])
caxis([-60 0])
view(155,61)

xlabel("$x_1$ (nm)",'FontSize',20,'Interpreter','latex')
ylabel("$x_2$ (nm)",'FontSize',20,'Interpreter','latex')
