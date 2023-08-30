% MATLAB CODE FOR CORE-ONLY DATA FILE
%**********************************************************
% Reading atom coordinates and boundary
%**********************************************************
function Core_only_data_file
 clc
 
 r = dlmread('ZnS_3x3x3_sorted.xyz',' ',2,0);
 N = 6;
 a = 3.8227 * N;
 b = 6.62111 * N;
 c = 6.2607 * N;
 Write_lAMMPS_CoreShell(r)
end
%**********************************************************
% Setting conditions for bonds generation 
%**********************************************************
function [bond, nbonds] = find_bonds(atom,a,b,c,PERIODIC)
 n = length(atom(:,1));
 nbonds = 0;
 for i = 1:n 
 atomA(i,:) = atom(i,:);
 for j = 1:n
 atomB(j,:) = atom(j,:);
 if atomA(i,1) ~= atomB(j,1) && atomA(i,1) == 2 
&& atomB(j,1) == 1
 xl = abs(atomA(i,2) - atomB(j,2));
 yl = abs(atomA(i,3) - atomB(j,3));
 zl = abs(atomA(i,4) - atomB(j,4));
 if(PERIODIC)
 if (xl > a / 2.0)
 xl = a - xl;
 end
if (yl > b / 2.0)
 yl = b - yl;
 end
if (zl > c / 2.0)
 zl = c - zl;
 end
 end
 d = sqrt(xl * xl + yl * yl + zl * zl);
 if (d <= 2.37 + 0.1 && d >= 1.25)
 nbonds = nbonds+1;
bond(nbonds,:) = [nbonds 1 i j];
 end
 end
 end
 end
end
%**********************************************************
% Setting conditions for angles generation 
%**********************************************************
function [angle,nangle] = find_angles(bond)
 n = length(bond(:,1));
 nangle = 1;
 angle(nangle,:) = [0 0 0];
 for i = 1:n
 for j = 1:n
 if bond(i,1) ~= bond(j,1) && bond(i,4) == 
bond(j,4)
 temp(1,:) = [bond(i,3) bond(j,4) 
bond(j,3)];
 temp2(1,:) = [bond(j,3) bond(j,4) 
bond(i,3)];
 if ismember(temp2,angle,'rows') == false
 angle(nangle,:) = [temp];
nangle = nangle+1;
 end
 end
 end
 end
 nangle = nangle - 1;
end
%**********************************************************
% Output to LAMMPS data file 
%**********************************************************
function Write_lAMMPS_CoreShell(p)
 n = length(p(:,1));
 N = 6;
 a = 3.8227 * N;
 b = 6.62111 * N;
 c = 6.2607 * N;
 xlo = -a/2;
 xhi = a/2;
 ylo = -b/2;
 yhi = b/2;
 zlo = -c/2;
 zhi = c/2;
 
 [bond, nbonds] = find_bonds(p,a,b,c,1);
 [angle,nangle] = find_angles(bond)
 
 charge = [2.0 0.0; -2.0 0]; 
 fId = fopen('ZnS_3x3x3_CoreCore.data','w');
 fprintf(fId,'LAMMPS data file for ZnO ...\n\n')
 fprintf(fId,'%d atoms\n',n)
 fprintf(fId,'%d bonds\n',0)
 fprintf(fId,'%d angles\n',nangle)
 fprintf(fId,'%d dihedrals\n',0)
 fprintf(fId,'%d impropers\n\n\n',0)
 fprintf(fId,'%d atom types\n',2)
 fprintf(fId,'%d bond types\n',0)
 fprintf(fId,'%d angle types\n',1)
 fprintf(fId,'%d dihedral types\n',0)
 fprintf(fId,'%d improper types\n\n\n',0)
 fprintf(fId,'%f\t %f\t xlo xhi\n',xlo,xhi)
 fprintf(fId,'%f\t %f\t ylo yhi\n',ylo,yhi)
 fprintf(fId,'%f\t %f\t zlo zhi\n\n\n',zlo,zhi)
 fprintf(fId,'Masses\n\n');
 fprintf(fId,'1 65.38\n')
 fprintf(fId,'2 32.059\n')
%**********************************************************
% Setting number of atoms generation 
%**********************************************************
 fprintf(fId,'Atoms\n\n');
 natoms = 1;
 for i = 1:n
 fprintf(fId,'%d %d %d %f %f %f 
%f\n',natoms,i,p(i,1),charge(p(i,1),1),p(i,2),p(i,3),p(i,4)
);
 natoms = natoms + 1; 
 end
%**********************************************************
% Setting number of angles generation 
%**********************************************************
 
 fprintf(fId,'\n\nAngles\n\n');
 
for i = 1:nangle
% Core-Core-Core
 fprintf(fId,'%d %d %d %d
%d\n',i,1,angle(i,1),angle(i,2),angle(i,3));
 
 
 end
 
 fclose(fId);
 
end