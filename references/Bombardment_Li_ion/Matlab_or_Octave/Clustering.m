% Clustering & C.O.M. calculations for OVITO export files
% Karun Datadien | last-update: 16-7-2013
%
% To use this program, only a few settings need to be made in the
% first few lines of code.
%
% 1. load the proper file. This is an exported 'xyz-file' from OVITO
% where all rows with atom types other than 3 - indicating Cl - are
% deleted. The file must be in the same directory as the matlab script.
%    Ovito -> (drag&drop "dump.NeutralClsFINALlowdensity_40000.cfg") ->
%     File -> Export File -> XYZ File (*), CLUSTERLODENSITY100ps ->
%     Particle.Identifier, X, Y, Z, c_Clustercount
%    remove 1st(number of atoms) and 2nd(comment) line in xyz file
% 2. change variables to the columns in which the
% appropriate values are stored.
%
% For example, the CLUSTERLODENSITY100ps file contains 5 columns:
% Atom-ID | X-pos | Y-pos | Z-pos | Cluster-ID
%
% So Xcol = 2, Ycol = 3, etc.

load CLUSTERLODENSITY100ps; % Load data.
Xcol = 2;
Ycol = 3;
Zcol = 4;
Ccol = 5;

R = length(CLUSTERLODENSITY100ps(:,1));

for i = 1:1:R %40 = number of atoms / rows in loaded file
  C(i,:)= CLUSTERLODENSITY100ps(i,Ccol); %get list of cluster-Id's
end

[h1 h2] = hist(C(:),unique(C));
h3 = unique(h1);
h3 = h3(end:-1:1);

%Gives the amount of atoms in each cluster:
for k=1:length(h3)
  if (h1==h3(k))
    disp(['There are ' num2str(h3(k)) ' atoms in these clusters: [ ' ...
      num2str(h2(h1)') ' ]']);
      %num2str(h2(h1==h3(k))') ' ]']);
  end
end

y=h1;
[f1 f2] = hist(y(:),unique(y));
f3 = unique(f1);
f3 = f3(end:-1:1);

%plot
figure; bar(f2,f1,0.5,'r');
 xlabel('# of atoms'); % add axis labels and plot title
 ylabel('# of clusters');
 title('Clustering of Cl');

%The next part is where a list with center of mass coordinates is built
V=0;
Clength = 0; %number of atoms in the cluster

for V = 1:1:R
  Clength = 0;
  for i = 1:1:R
    if(C(V,1) == C(i,1))
      X(i,:) = CLUSTERLODENSITY100ps(i,Xcol);
      Y(i,:) = CLUSTERLODENSITY100ps(i,Ycol);
      Z(i,:) = CLUSTERLODENSITY100ps(i,Zcol);
    else
      X(i,:) = 0; Y(i,:) = 0; Z(i,:) = 0;
    end
  end

  %finds out number of atoms in the cluste
  for i = 1:1:R
    if(X(i,:) > 0)
      Clength = Clength+1;
    else Clength = Clength;
    end
  end

  a=sum(X)/Clength; %COM X-direction of cluster
  b=sum(Y)/Clength; %Y
  c=sum(Z)/Clength; %Z

  disp(['Atom-ID: ' num2str(V) ', Center of mass (x,y,z) for cluster ' ...
    num2str(C(V,1)) ' is: [' num2str([a b c]) ']']);

  COM(V,:) = [a b c];
end

COM %output a list with the x,y,z C.O.M. coordinates of each cluster.
