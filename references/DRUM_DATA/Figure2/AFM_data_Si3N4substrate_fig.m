clc
clear
close all 
load AFM_data_Si3N4substrate

figure()
mesh(data)
hold on
set(gca,'FontSize',15)
zlim([-60 100])
ylim([0 900/1000*256])
xlim([0 900/1000*256])
xticks([0 256/2 256])
xticklabels({'0','500','1000'})
yticks([0 256/2 256])
yticklabels({'0','500','1000'})
xlabel("\bf X (nm)",'FontSize',20)
ylabel("\bf Y (nm)",'FontSize',20)
set(gca,'ztick',[])
set(gca,'zticklabel',[])
hcb = colorbar;
hcb.Title.String = "nm";
caxis([-60 0])
set(gca,'FontSize',20)
view(-45,40)
hold off
