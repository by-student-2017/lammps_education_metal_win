function [k]=k(Eb,T) 
  kB=8.6173324e-5; 
  k=k0(T)*exp(-Eb/(kB*T)); 
end 