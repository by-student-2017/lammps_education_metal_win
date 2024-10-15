d = dir('C:\LAMMPS\NaClStrain500k.def1.txt'); % load data

for i = 1:length(d)
 fname = d(i).name
 A = importdata(fname)
 strain = A.data(:,1)
 stress = A.data(:,2)
 
 plot(strain,stress) 
 xlabel('Strain'); % add axis labels and plot title
 ylabel('Stress');
 title('Stress-strain curve NaCl');
end
