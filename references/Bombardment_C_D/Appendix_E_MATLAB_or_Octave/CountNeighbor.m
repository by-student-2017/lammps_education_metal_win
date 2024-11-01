function [Num_of_neighbors]=CountNeighbor(Num_of_neighbors,is,H_properties,nH) 
  % is: step index 
  Num_of_neighbors(is,1)=length(find(H_properties(:,3)==1 ));
  Num_of_neighbors(is,2)=length(find(H_properties(:,3)==2 )); 
  Num_of_neighbors(is,3)=length(find(H_properties(:,3)==3 )); 
  Num_of_neighbors(is,4)=length(find(H_properties(:,3)==4 )); 
  Num_of_neighbors(is,5)=length(find(H_properties(:,3)==0 ));
  
  Num_of_neighbors(is,6)=length(find( rem(H_properties(:,1),2) ==1 )); 
  
  if sum(Num_of_neighbors(is,1:5))~=nH 
    disp( 'mismatch, CountNeighbor.m' )  
  end
end
