function [isSB]=isSB(line_num) 
  if mod(line_num,2)==0 
    isSB=1; % SHORT BRIDGE LINE 
  else 
    isSB=0; % LONG BRIDGE LINE 
  end 
end 

%SB: even rows 
%LB: ODD rows
