function [new_y,new_x]=new_xy(iH,direction,H_properties,nX,nY) 
  iy=H_properties(iH,1); % H location (to be moved) 
  ix=H_properties(iH,2); 
  new_x=ix; 
  new_y=iy;
  
  if direction==1 %down 
    if iy==1 
      new_y=nY; 
    else 
      new_y=iy-1; 
    end 
  elseif direction==2 %right 
    if ix==nX 
      new_x=1;  
    else 
      new_x=ix+1; 
    end 
  elseif direction==3 %up 
    if iy==nY 
      new_y=1;  
    else 
      new_y=iy+1; 
    end 
  elseif direction==4 %left 
    if ix==1 
      new_x=nX;  
    else 
      new_x=ix-1; 
    end 
  else 
    disp('Incorrect direction passed, new_xy.m')  
    new_y=-1; 
    new_x=-1; 
  end 
end
