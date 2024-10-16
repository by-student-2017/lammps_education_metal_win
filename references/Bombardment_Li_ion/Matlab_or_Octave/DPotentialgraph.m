load BuckCafstanden2; % load data
set(0,'DefaultAxesColorOrder',[0 0 0], ...
 'DefaultAxesLineStyleOrder','-|--|-.|:')

% experimental data:
y1 = 27.2116*[0.1277D04 0.8631D02 0.1535D02 0.4024D01 0.1349D01 ...
  0.4060D00 0.2085D00 0.1670D-1 -0.9339D-1 -0.1530D00 -0.18748D00 ...
 -0.19396D00 -0.19535D00 -0.19587D00 -0.19588D00 -0.19575D00 -0.19510D00 ...
 -0.19255D00 -0.18886D00 -0.18449D00 -0.18215D00 -0.17974D00 -0.17482D00 ...
 -0.16490D00 -0.15315D00 -0.14260D00 -0.12499D00 -0.11112D00];
x1= 0.529177249*[0.1 0.5 1.0 1.5 2.0 2.5 2.7 3.0 3.3 3.6 4.0 4.2 4.3 ...
 4.4 4.45 4.5 4.6 4.8 5.0 5.2 5.3 5.4 5.6 6.0 6.5 7.0 8.0 9.0] ;

for i = 1:2:40000
  %x2(i,:)=BuckCafstanden2(i+1,1) - BuckCafstanden2(i,1);
  %y2(i,:)=BuckCafstanden2(i+1,2) + BuckCafstanden2(i,2);
  x2(i,:)=BuckCafstanden2(i+1,1);
  y2(i,:)=BuckCafstanden2(i+1,2);
end

x2((2:2:end),:) = []; % delete every other row (=0)
y2((2:2:end),:) = [];

%plot(x1,y1,x2,y2);
plot(x1, y1, 'r--', x2, y2, 'b-');
legend('calculated potential from Ref. 9','current simulation');
xlabel('Interatomic distance (Angstrom)'); % add axis labels and plot title
ylabel('Potential energy (eV)');
title('Diatomic potential energy of Na+Cl-');
yticks(-6:1:2);
xticks(-1:0.5:5);
axis([1 5 -6 2]);
axis manual;
set(gca, 'FontSize', 12, 'FontName', 'Arial');
