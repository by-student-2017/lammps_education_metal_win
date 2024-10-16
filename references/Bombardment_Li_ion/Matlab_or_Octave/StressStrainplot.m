d = dir('NaClStrain500k.def1.txt'); % load data

for i = 1:length(d)
  fname = d(i).name
  A = importdata(fname)
  strain = A.data(:,1)
  stress = A.data(:,2)

  plot(strain,stress, 'r--')
  legend('500 K');
  axis([0 0.2 0 2.5]);
  xticks(0:0.02:0.2);
  yticks(0:0.25:2.5);
  grid on;
  axis manual;
  xlabel('Strain (Dimensionless)'); % add axis labels and plot title
  ylabel('Stress (GPa)');
  title('Stress-strain curve NaCl');
  set(gca, 'FontSize', 12, 'FontName', 'Arial');
end
