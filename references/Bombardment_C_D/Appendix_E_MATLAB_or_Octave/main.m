% Appendix E: MATLAB Scripts for Hydrogen Diffusion on Tungsten (001) 
% Reconstructed Surface

% Hydrogen diffusion on W (001) reconstructed plane 
% a kMC simulation 
two_d_parameters; % load predefined parameters 

% odd  line: ALL LONG BRIDGE 
% even line: ALL SHORT BRIDGE 
H_loc=zeros(nY,nX); % H location. 0=unoccupied site; 1=occupied site 

rng(123456); % random number seed 

SBrate=Initial_H_coverage_rate*Initial_H_SB_coverage_rate *2 ; 
LBrate=Initial_H_coverage_rate*(1-Initial_H_SB_coverage_rate)*2; 

% initial random H distribution 
for iy=1:1:nY 
  if isSB(iy)==1 % even row number, all short bridge 
    for ix=1:1:nX 
      if rand(1)<=SBrate 
        H_loc(iy,ix) = H_loc(iy,ix)+1; 
      end 
    end 
  else 
    for ix=1:1:nX 
      if rand(1)<=LBrate 
        H_loc(iy,ix) = H_loc(iy,ix)+1; 
      end 
    end 
  end 
end 

% adjust the H number 

H_loc=Adjust_H_num(H_loc,nY,nX,Initial_H_coverage_rate); 
TotalH = sum(sum(H_loc)); 

if TotalH ~= round(Initial_H_coverage_rate*nX*nY)
  disp('NUMBER OF H IS NOT EXACT! mainfile.m') 
end

H_properties = zeros(TotalH,7); % 1,2:iy,ix; 3: num of neighbour 4,5,6,7: down, right, up, left 

itmp=0;

% get neighbors 
% Y positive means [UP]. nY is the top lattice. 
for iy=1:1:nY 
  for ix=1:1:nX 
    if H_loc(iy,ix)>0 
      itmp=itmp+1; 
      H_loc(iy,ix)=itmp; % STORE the H index in "H_loc" 
      H_properties(itmp,:)=single_properties(iy,ix,nY,nX,H_loc); 
    end 
  end 
end

kss=k(Ess,T); 
ksl=k(Esl,T); 
kll=k(Ell,T); 
kls=k(Els,T); 

Num_cycles = floor( max_step/cycle_step ); 
displacement= zeros(TotalH,2); % displacement Y(is 1) and X(is 2) 
D_array=zeros(1,Num_cycles); 
cycle_data_save=zeros(Num_cycles, 5); %1-4 hopping numbers; 5 time; 6 accumulated displacement 
Num_of_neighbors=zeros(max_step,6); % number of neighbors, 1-4, 5=0 neighbors;6=LB number

P_hop=zeros(TotalH,4); %hopping probability of each H 

%calculate hopping probability. They are just k, not cumulated. We do it in 
%a different way. 
for iH=1:1:TotalH 
  P_hop(iH,:)=phop(iH,H_properties,kss,ksl,kls,kll);  
end 
P_total=sum(sum(P_hop));
time=0.0; %current time 
step=0;   %current step 
ic=0;     %number of cycles 
t_cycle=0.0; % time advabce in each cycle 
while time<t_end && step < max_step 
  %determin the hopping atom and hopping direction 
  this_hop = GetHopH(rand(1)*P_total,P_hop); 
  iH=this_hop(1); % H index 
  %perform the hopping atom 
  iy=H_properties(iH,1); 
  ix=H_properties(iH,2);
  
  %calculate time before moving the H 
  dt=-1/P_total*log(rand(1)); 
  
  %get the new location 
  
  [new_y,new_x]=new_xy(iH,this_hop(2),H_properties,nX,nY); 
  %MOVE THE HYDROGEN 
  H_loc(new_y,new_x)=iH; 
  H_loc(iy,ix)=0;
  
  % Redo all surrounding probabilities 
  [P_hop,H_properties]=surrounding_probabilities ... 
  (iy,ix,nY,nX,H_loc,H_properties,P_hop,kss,ksl,kls,kll);
  
  [P_hop,H_properties]=surrounding_probabilities ...
  (new_y,new_x,nY,nX,H_loc,H_properties,P_hop,kss,ksl,kls,kll); 
  
  P_total=sum(sum(P_hop)); 
  
  % do some statistics 
  if this_hop(2)==1 % Y-
    displacement(iH,1)=displacement(iH,1)-dy; 
  elseif this_hop(2)==2 %X+
    displacement(iH,2)=displacement(iH,2)+dx; 
  elseif this_hop(2)==3 %Y+
    displacement(iH,1)=displacement(iH,1)+dy; 
  elseif this_hop(2)==4 %X-
    displacement(iH,2)=displacement(iH,2)-dx; 
  else 
    disp('Wrong hopping direction, main.m') 
  end
  
  cycle_data_save(ic+1,this_hop(2))=cycle_data_save(ic+1,this_hop(2))+1; 
  t_cycle=t_cycle+dt;
  
  Num_of_neighbors=CountNeighbor(Num_of_neighbors,step+1,H_properties,TotalH);
  
  % advance time and step 
  time=time+dt; 
  step=step+1;
  
  if mod(step,cycle_step)==0 
    ic=ic+1; 
    
    for iH=1:TotalH
      D_array(ic)=D_array(ic)+displacement(iH,1)*displacement(iH,1) ...
      +displacement(iH,2)*displacement(iH,2); 
    end 
    
    D_array(ic)=D_array(ic)/(2.0*2.0*t_cycle)/1e20/cycle_step; % 1e20 is the 1e10^2. conbe 
    D_array(ic)=D_array(ic)*( cycle_step/TotalH ); 
    displacement=displacement*0.0; 
    cycle_data_save(ic,5)=t_cycle;
    
    t_cycle=0.0;
  end 
end % end of while

% diffusion coefficient 
disp(['D (m2/s): ',num2str(mean(D_array(ignored_cycle+1:Num_cycles))),' +- ',... 
num2str(std(D_array(ignored_cycle+1:Num_cycles)))])

% number of neighbors
disp( ['Rate of H having 0 neighbor: ', ... 
num2str( mean(Num_of_neighbors( ignored_cycle*cycle_step+ 1:max_step ,5))/TotalH ), ... 
' +- ',num2str( std(Num_of_neighbors( ignored_cycle*cycle_step+1:max_step ,5))/TotalH ) ] )
disp( ['Rate of H having 1 neighbor: ', ... 
num2str( mean(Num_of_neighbors( ignored_cycle*cycle_step+1:max_step ,1))/TotalH ), ... 
' +- ',num2str( std(Num_of_neighbors( ignored_cycle*cycle_step+1:max_step ,1))/TotalH ) ] ) 
disp( ['Rate of H having 2 neighbor: ', ...
num2str( mean(Num_of_neighbors( ignored_cycle*cycle_step+1:max_step ,2))/TotalH ), ... 
' +- ',num2str( std(Num_of_neighbors( ignored_cycle*cycle_step+1:max_step ,2))/TotalH ) ] )
disp( ['Rate of H having 3 neighbor: ', ... 
num2str( mean(Num_of_neighbors( ignored_cycle*cycle_step+1:max_step ,3))/TotalH ), ...
' +-',num2str( std(Num_of_neighbors( ignored_cycle*cycle_step+1:max_step ,3))/TotalH ) ] ) 
disp( ['Rate of H having 4 neighbor: ', ...
num2str( mean(Num_of_neighbors( ignored_cycle*cycle_step+1:max_step ,4))/TotalH ), ...
' +- ',num2str( std(Num_of_neighbors( ignored_cycle*cycle_step+1:max_step ,4))/TotalH ) ] )
disp( ['Rate of H located at Long Bridge: ', ...
num2str( mean(Num_of_neighbors( ignored_cycle*cycle_step+1:max_step ,6))/TotalH ), ...
' +- ',num2str( std(Num_of_neighbors( ignored_cycle*cycle_step+1:max_step ,6))/TotalH ) ] ) 
