function [H_loc]=Adjust_H_num(H_loc,nY,nX,H_rate)
  TotalH=sum(sum(H_loc)); 
  DesiredH=round(H_rate*nX*nY); 
  
  if TotalH==DesiredH 
    %nothing to do, GOODBYE.  
  elseif TotalH<DesiredH % add a few H
    H_diff=DesiredH-TotalH; 
    ic=0; 
    for ix=1:1:nX 
      for iy=2:2:nY %only add to short bridge 
        if H_loc(iy,ix)==0 
          H_loc(iy,ix) =1; 
          ic=ic+1; 
          if ic>=H_diff 
            return  
          end % if
        end % if
      end % for
    end % for
  else % remove a few 
    H_diff=TotalH-DesiredH; 
    ic=0; 
    for ix=1:1:nX 
      for iy=1:1:nY  
        if H_loc(iy,ix)>0 
          H_loc(iy,ix) =0; 
          ic=ic+1; 
          if ic>=H_diff 
            return  
          end % if
        end % if
      end % for
    end % for
  end % else
end % function
