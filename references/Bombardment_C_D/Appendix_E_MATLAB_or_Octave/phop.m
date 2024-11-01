function [phop]=phop(iH,H_properties,kss,ksl,kls,kll)
  phop=zeros(1,4); 
  
  if H_properties(iH,4)==0 %down neighbor is empty 
    if isSB( H_properties(iH,1) )==1 % this is SB 
      phop(1)=ksl; 
    else 
      phop(1)=kls; 
    end 
  else 
    phop(1)=0;
  end
  
  if H_properties(iH,5)==0 %right neighbor is empty 
    if isSB( H_properties(iH,1) )==1 % this is SB 
      phop(2)=kss; 
    else 
      phop(2)=kll; 
    end 
  else 
    phop(2)=0; 
  end
  
  if H_properties(iH,6)==0 %up neighbor is empty 
    if isSB( H_properties(iH,1) )==1 % this is SB 
      phop(3)=ksl; 
    else 
      phop(3)=kls; 
    end 
  else 
    phop(3)=0; 
  end 
  
  if H_properties(iH,7)==0 %left neighbor is empty 
    if isSB( H_properties(iH,1) )==1 % this is SB 
      phop(4)=kss; 
    else 
      phop(4)=kll; 
    end 
  else 
    phop(4)=0; 
  end 
end
