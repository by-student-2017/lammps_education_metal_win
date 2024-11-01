function [P_hop,H_properties]=surrounding_probabilities ... 
  (iy,ix,nY,nX,H_loc,H_properties,P_hop,kss,ksl,kls,kll) 
  
  %==== down ============================================================ 
  if iy==1 
    surr_y=nY; 
  else 
    surr_y=iy-1; 
  end 
  surr_x=ix; 
  
  iH=H_loc(surr_y,surr_x); 
  if iH>0 
    %recalculate its neighbour 
    H_properties(iH,:)=single_properties(surr_y,surr_x,nY,nX,H_loc); 
    %recalculate its probability 
    P_hop(iH,:)=phop(iH,H_properties,kss,ksl,kls,kll);  
  end
  
  %==== right ========================================================== 
  if ix==nX 
    surr_x=1; 
  else 
    surr_x=ix+1; 
  end 
  surr_y=iy; 
  
  iH=H_loc(surr_y,surr_x); 
  if iH>0 
    %recalculate its neighbour
    H_properties(iH,:)=single_properties(surr_y,surr_x,nY,nX,H_loc); 
    %recalculate its probability 
    P_hop(iH,:)=phop(iH,H_properties,kss,ksl,kls,kll);  
  end 
  
  %==== up ============================================================= 
  if iy==nY 
    surr_y=1; 
  else 
    surr_y=iy+1; 
  end 
  surr_x=ix; 
  
  iH=H_loc(surr_y,surr_x); 
  if iH>0 
    %recalculate its neighbour 
    H_properties(iH,:)=single_properties(surr_y,surr_x,nY,nX,H_loc); 
    %recalculate its probability 
    P_hop(iH,:)=phop(iH,H_properties,kss,ksl,kls,kll);  
  end 
  
  %==== left ====
  if ix==1 
    surr_x=nX; 
  else 
    surr_x=ix-1; 
  end 
  surr_y=iy; 
  
  iH=H_loc(surr_y,surr_x); 
  if iH>0 
    %recalculate its neighbour 
    H_properties(iH,:)=single_properties(surr_y,surr_x,nY,nX,H_loc); 
    %recalculate its probability 
    P_hop(iH,:)=phop(iH,H_properties,kss,ksl,kls,kll);  
  end
  
  %==== CENTER ========================================================= 
  iH=H_loc(iy,ix); 
  if iH>0 
    %recalculate its neighbour 
    H_properties(iH,:)=single_properties(iy,ix,nY,nX,H_loc); 
    %recalculate its probability 
    P_hop(iH,:)=phop(iH,H_properties,kss,ksl,kls,kll);  
  end 
end 
