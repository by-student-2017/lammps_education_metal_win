function [solution]=GetHopH(RN,P_hop) %RN:random number 0 - P_total 
  solution=zeros(1,2); %1: Hopping H index 2: jumping direction: 1234->down right up left 
  TotalH=length(P_hop);
  
  iH_flag=0; 
  for iH=1:1:TotalH 
    for is=1:1:4  %side 
      if RN<= P_hop(iH,is) 
        iH_flag=1; 
        break 
      else 
        RN=RN-P_hop(iH,is); 
      end 
    end 
    
    if iH_flag==1 
      break 
    end 
  end
  
  if iH_flag==0 
    disp('Did not find the jumping H, GetHopH.m') 
  end 
  
  solution(1)=iH; 
  solution(2)=is; 

end 
