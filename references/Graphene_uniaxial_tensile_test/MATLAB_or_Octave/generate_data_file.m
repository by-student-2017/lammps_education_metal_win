%% Dimensions of the graphene sheet
wid=50; % Angstroms
len=50;
ccbl=1.396; % c-c bond according to airebo

%% Unit cell
unitx=ccbl*2*(1+cos(pi/3)); % length of unit cell along x direction
unity=ccbl*2*cos(pi/6);
ux=floor(wid/unitx);
uy=floor(len/unity);

%% Positions of the first 4 atoms
x(1,1)=ccbl*cos(pi/3);
x(1,2)=x(1,1)+ccbl;
x(2,1)=0;
x(2,2)=ccbl*(1+2*cos(pi/3));
y(1,1)=0;
y(1,2)=0;
y(2,1)=ccbl*cos(pi/6);
y(2,2)=ccbl*cos(pi/6);

%% Repeting along x direction
for i=1: ux
x(1,(i*2)+1)=x(1,(i-1)*2+1)+ccbl*2*(1+cos(pi/3));

x(1,(i*2)+2)=x(1,(i-1)*2+2)+ccbl*2*(1+cos(pi/3));
x(2,(i*2)+1)=x(2,(i-1)*2+1)+ccbl*2*(1+cos(pi/3));
x(2,(i*2)+2)=x(2,(i-1)*2+2)+ccbl*2*(1+cos(pi/3));
y(1,(i*2)+1)=y(1,(i-1)*2+1);
y(1,(i*2)+2)=y(1,(i-1)*2+2);
y(2,(i*2)+1)=y(2,(i-1)*2+1);
y(2,(i*2)+2)=y(2,(i-1)*2+2);
end

%% Repeting along y direction
for i=1:uy
x((i*2)+1,:)=x((i-1)*2+1,:);
x((i*2)+2,:)=x((i-1)*2+2,:);
y((i*2)+1,:)=y((i-1)*2+1,:)+ccbl*cos(pi/6)*2;
y((i*2)+2,:)=y((i-1)*2+2,:)+ccbl*cos(pi/6)*2;
end
Numofatoms= size(x,1)*size(x,2)

%% Combining x and y coordinates
x=reshape(x,Numofatoms,1);
y=reshape(y,Numofatoms,1);
coord=zeros(Numofatoms,3);
coord(:,1)=x;
coord(:,2)=y;
figure
plot(coord(:,1),coord(:,2),'o')
axis equal

%% Writing coordinates on a LAMMPS input data file
number=size(coord,1);
fid = fopen('data.graphene','w');
for i=1:number
fprintf(fid,'%d 1 %f %f %f \n',i,coord(i,1),coord(i,2),rand/10);
end
fclose(fid);
