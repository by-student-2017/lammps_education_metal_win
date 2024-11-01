function [k0] = k0(T) 
  kB=8.6173324e-5; % Boltzmann constant (eV/K) 
  h = 4.135667516e-15; %Planck constant (eV s) 
  k0=2.0*kB*T/h; 
end 