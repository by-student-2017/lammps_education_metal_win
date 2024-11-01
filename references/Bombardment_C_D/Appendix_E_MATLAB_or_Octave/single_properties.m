% contain neighbor info
function [single_H_properties]=single_properties(iy,ix,nY,nX,H_loc) 
  single_H_properties=zeros(1,7); 
  iH=H_loc(iy,ix); 
  
  if iH>0 
    single_H_properties(1)=iy; 
    single_H_properties(2)=ix; 
    % down 
    if iy==1 
      if H_loc(nY,ix)>0 
        single_H_properties(4)=1; 
      end 
    else 
      if H_loc(iy-1,ix)>0 
        single_H_properties(4)=1; 
      end 
    end
    
    % up 
    if iy==nY 
      if H_loc(1,ix)>0 
        single_H_properties(6)=1; 
      end 
    else 
      if H_loc(iy+1,ix)>0 
        single_H_properties(6)=1; 
      end 
    end
    
    % left 
    if ix==1 
      if H_loc(iy,nX)>0 
        single_H_properties(7) =1; 
      end 
    else 
      if H_loc(iy,ix-1)>0 
        single_H_properties(7) =1; 
      end 
    end 
    
    %right 
    if ix==nX 
      if H_loc(iy,1)>0 
        single_H_properties(5) =1; 
      end 
    else 
      if H_loc(iy,ix+1)>0 
        single_H_properties(5) =1; 
      end 
    end 
    
    single_H_properties(3)=sum(single_H_properties(4:7)); 
    
  else 
    disp('H index <= 0 (single_properties.m)') 
  end 
end