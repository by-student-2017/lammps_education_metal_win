function EAM_Potential_DYNAMO
 clc
 format short
 % Present Working directory
 pwd

 global fId;

 % Pd and PdH
 x_Pd = [2.054085 0.216817 8.414105 7.221224 0.999999 3.316887];
 x_PdH = [0.589510 1.104827 0.942490 2.145808 0.942201...
 0.740938 2.373944 1.702142 8.370790 62.343273...
 0.000100 1.187000 1.300000 3.474173 4.903820];

 fId = fopen('PdAgCuH.eam.alloy','w');

 % re fit scaling only mixing rule potential

 S_AgPd = 1.8319;
 S_PdAg = 1.1063;

 % Pd Expermintal data
 [aFcce,EcFcce,c11e,c12e,c44e,~,Eve,aBcce,EcBcce] = parameters('Pd');

 % PdPd
 re = aFcce/sqrt(2);
 Fe = EcFcce-Eve;
 N = 4;
 V = aFcce^3/N;
 fe = EcFcce/V;
 x = [x_Pd, x_PdH];
 Xi = x(1);
 phie = x(2);
 S = x(3);
 B = x(4);
 n = x(5);
 rhoe = x(6);
 fe_S = S_PdAg*EcFcce/V;
 rhoe_S = S_PdAg*rhoe;

 % Phi_HH
 DHH = x(7);
 aHH = x(8);
 bHH = x(9);
 % f_HH
 CH = x(10);
 DH = x(11);

 % Phi_PdH
 DPdH = x(12);
 aPdH = x(13);
 bPdH = x(14);
 % F_H
 aH = x(15);
 bH = x(16);
 cH = x(17);
 dH = x(18);
 %
 r0PdH = x(19);
 r0HH = x(20);
 rho0H = x(21);

 % Pd data
 % Rho PdPd fitting parameters
 X0_PdPd = [fe_S,Xi,re];
 % F PdPd fitting parameters
 X1_PdPd = [Fe,rhoe_S,n];
 % Phi PdPd fitting parametters
 X2_PdPd = [phie,S,B,re];

 % F PdPd fitting parameters
 X_F_PdPd = [Fe,rhoe,n,0,0];
 % f Pd
 X_f_PdPd = [fe,Xi,re];
 % Phi PdPd fitting parametters
 X_Phi_PdPd = [phie,S,B,re];

 x_Ag = [1.584768032776473 0.154164182657381 8.491335427574112...
 7.183185289310671 1.022270092304303 2.213230197455566];

 % Ag Experimental data
 [aFcce_Ag,EcFcce_Ag,C11e_Ag,C12e_Ag,C44e_Ag,Bme_Ag,...
 Eve_Ag,aBcce_Ag,EcBcce_Ag] = parameters('Ag');

 re = aFcce_Ag/sqrt(2);
 Fe = EcFcce_Ag-Eve_Ag;
 N = 4;
 V = aFcce_Ag^3/N;
 fe = EcFcce_Ag/V;

 % Ag Fitting Parameters
 Xi = x_Ag(1);
 phie = x_Ag(2);
 S = x_Ag(3);
 B = x_Ag(4);
 n = x_Ag(5);
 rhoe = x_Ag(6);

 fe_S = S_AgPd*EcFcce_Ag/V;
 rhoe_S = S_AgPd*rhoe;

 % Rho PdPd fitting parameters
 X0_AgAg = [fe_S,Xi,re];
 % F PdPd fitting parameters
 X1_AgAg = [Fe,rhoe_S,n];
 % Phi PdPd fitting parametters
 X2_AgAg = [phie,S,B,re];

 X_Phi_PdAg = [X0_PdPd X0_AgAg X2_PdPd X2_AgAg];

 % F AgAg fitting parameters
 X_F_AgAg = [Fe,rhoe,n,0,0];
 % f Pd
 X_f_AgAg = [fe,Xi,re];
 % Phi PdPd fitting parametters
 X_Phi_AgAg = [phie,S,B,re];

 % H data
 % F_H
 X_F_HH = [aH,bH,cH,dH,rho0H];
 % rho_HH
 X_f_HH = [CH,DH,0];
 % Phi_HH
 X_phi_HH = [DHH,aHH,bHH,r0HH];

 % PdH data
 % Vectores of fitting parameters
 X_Phi_PdH = [DPdH,aPdH,bPdH,r0PdH];

 % PdAgH untransformed fit 1 f = 0.4417
 X_Phi_AgH = [1.476745339175117 1.967649395899897 ...
 1.741864506174084 1.850016663067700];
 % X_Phi_AgH = [1 1 1 1];

 % Phi_HH, rho_HH, F_H
 X_Phi_HH = [X_phi_HH, X_f_HH, X_F_HH];

 %Parameters for PdCu
 S_PdCu = 1.7097;
 S_CuPd = 1.3419;

 [aFcce,EcFcce,c11e,c12e,c44e,~,Eve,aBcce,EcBcce] = parameters('Pd');

 % PdPd
 re = aFcce/sqrt(2);
 Fe = EcFcce-Eve;
 N = 4;
 V = aFcce^3/N;
 fe = EcFcce/V;
 x = [x_Pd, x_PdH];
 Xi = x(1);
 phie = x(2);
 S = x(3);
 B = x(4);
 n = x(5);
 rhoe = x(6);
 fe_S = S_PdCu*EcFcce/V;
 rhoe_S = S_PdCu*rhoe;

 % Phi_HH
 DHH = x(7);
 aHH = x(8);
 bHH = x(9);
 % f_HH
 CH = x(10);
 DH = x(11);

 % Phi_PdH
 DPdH = x(12);
 aPdH = x(13);
 bPdH = x(14);
 % F_H
 aH = x(15);
 bH = x(16);
 cH = x(17);
 dH = x(18);
 %
 r0PdH = x(19);
 r0HH = x(20);
 rho0H = x(21);

 % Pd data
 % Rho PdPd fitting parameters
 X0_PdPd = [fe_S,Xi,re];
 % F PdPd fitting parameters
 X1_PdPd = [Fe,rhoe_S,n];
 % Phi PdPd fitting parametters
 X2_PdPd = [phie,S,B,re];

 x_Cu = [2.504500 0.175425 8.713725...
 6.906629 0.560027 3.648665];

 % Cu Experimental data
 [aFcce_Cu,EcFcce_Cu,C11e_Cu,C12e_Cu,C44e_Cu,Bme_Cu,...
 Eve_Cu,aBcce_Cu,EcBcce_Cu] = parameters('Cu');
 re = aFcce_Cu/sqrt(2);
 Fe = EcFcce_Cu-Eve_Cu;
 N = 4;
 V = aFcce_Cu^3/N;
 fe = EcFcce_Cu/V;

 % Cu Fitting Parameters
 Xi = x_Cu(1);
 phie = x_Cu(2);
 S = x_Cu(3);
 B = x_Cu(4);
 n = x_Cu(5);
 rhoe = x_Cu(6);
 fe_S = S_CuPd*EcFcce_Cu/V;
 rhoe_S = S_CuPd*rhoe;

 % Rho CuCu fitting parameters
 X0_CuCu = [fe_S,Xi,re];
 % F CuCu fitting parameters
 X1_CuCu = [Fe,rhoe_S,n];
 % Phi CuCu fitting parametters
 X2_CuCu = [phie,S,B,re];

 X_Phi_PdCu = [X0_PdPd X0_CuCu X2_PdPd X2_CuCu];

 % F CuCu fitting parameters
 X_F_CuCu = [Fe,rhoe,n,0,0];
 % f Cu
 X_f_CuCu = [fe,Xi,re];
 % Phi CuCu fitting parametters
 X_Phi_CuCu = [phie,S,B,re];

 % PdH data
 X_Phi_PdH = [DPdH,aPdH,bPdH,r0PdH];

 % PdCuH untransformed fit 1 f = 0.258
 X_Phi_CuH = [0.780004347905691 2.100001766883917 ...
 1.799998446869885 1.900008190080419];

 % Phi_HH, rho_HH, F_H
 X_Phi_HH = [X_phi_HH, X_f_HH, X_F_HH];
 %Parameters for AgCu

 S_AgCu = 1.4626;
 S_CuAg = 1.6275;

 [aFcce_Ag,EcFcce_Ag,C11e_Ag,C12e_Ag,C44e_Ag,Bme_Ag,...
 Eve_Ag,aBcce_Ag,EcBcce_Ag] = parameters('Ag');
 re = aFcce_Ag/sqrt(2);
 Fe = EcFcce_Ag-Eve_Ag;
 N = 4;
 V = aFcce_Ag^3/N;
 fe = EcFcce_Ag/V;

 % Ag Fitting Parameters
 Xi = x_Ag(1);
 phie = x_Ag(2);
 S = x_Ag(3);
 B = x_Ag(4);
 n = x_Ag(5);
 rhoe = x_Ag(6);
 fe_S = S_AgCu*EcFcce_Ag/V;
 rhoe_S = S_AgCu*rhoe;

 % Rho PdPd fitting parameters
 X0_AgAg = [fe_S,Xi,re];
 % F PdPd fitting parameters
 X1_AgAg = [Fe,rhoe_S,n];
 % Phi PdPd fitting parametters
 X2_AgAg = [phie,S,B,re];

 [aFcce_Cu,EcFcce_Cu,C11e_Cu,C12e_Cu,C44e_Cu,Bme_Cu,...
 Eve_Cu,aBcce_Cu,EcBcce_Cu] = parameters('Cu');
 re = aFcce_Cu/sqrt(2);
 Fe = EcFcce_Cu-Eve_Cu;
 N = 4;
 V = aFcce_Cu^3/N;
 fe = EcFcce_Cu/V;

 % Cu Fitting Parameters
 Xi = x_Cu(1);
 phie = x_Cu(2);
 S = x_Cu(3);
 B = x_Cu(4);
 n = x_Cu(5);
 rhoe = x_Cu(6);
 fe_S = S_CuAg*EcFcce_Cu/V;
 rhoe_S = S_CuAg*rhoe;

 % Rho CuCu fitting parameters
 X0_CuCu = [fe_S,Xi,re];
 % F CuCu fitting parameters
 X1_CuCu = [Fe,rhoe_S,n];
 % Phi CuCu fitting parametters
 X2_CuCu = [phie,S,B,re];

 X_Phi_AgCu = [X0_AgAg X0_CuCu X2_AgAg X2_CuCu];

 phi = {'phi_PdPd';'phi_PdAg';'phi_AgAg';'phi_PdCu';'phi_AgCu';...
 'phi_CuCu';'phi_PdH';'phi_AgH';'phi_CuH';'phi_HH'};
 f = {'f_PdPd';'f_AgAg';'f_CuCu';'f_HH'};
 F = {'F_Pd';'F_Ag';'F_Cu';'F_H'};

 [m n] = size(X_phi_HH);
 X_Phi = zeros(length(phi),n);
 X_Phi(1,1:length(X_Phi_PdPd)) = X_Phi_PdPd;
 X_Phi(2,1:length(X_Phi_PdAg)) = X_Phi_PdAg;
 X_Phi(3,1:length(X_Phi_AgAg)) = X_Phi_AgAg;
 X_Phi(4,1:length(X_Phi_PdCu)) = X_Phi_PdCu;
 X_Phi(5,1:length(X_Phi_AgCu)) = X_Phi_AgCu;
 X_Phi(6,1:length(X_Phi_CuCu)) = X_Phi_CuCu;
 X_Phi(7,1:length(X_Phi_PdH)) = X_Phi_PdH;
 X_Phi(8,1:length(X_Phi_AgH)) = X_Phi_AgH;
 X_Phi(9,1:length(X_Phi_CuH)) = X_Phi_CuH;
 X_Phi(10,1:length(X_Phi_HH)) = X_Phi_HH;

 X_f = [X_f_PdPd; X_f_AgAg; X_f_CuCu; X_f_HH];
 X_F = [X_F_PdPd; X_F_AgAg; X_F_CuCu; X_F_HH];

 % element used to use
 element = ['Pd';'Ag';'Cu';'H '];
 edata = {46,106.42,3.89,'FCC'; 47,107.87,4.09,'FCC'; ...
 29,63.546,3.615,'FCC'; 1,1.01,3.38,'FCC'};
 rc = 5.35;
 nr = 3000;
 nrho = nr;
 dr = rc/nr;
 drho = 50/nrho;
 r = [0:dr:nr*dr];
 rho = [0:drho:drho*nrho];
 alloy = ['Pd';'Ag';'Cu';'H '];

 WritePotential_setf2(alloy,element,edata,nrho,drho,nr,dr,rc,rho,...
 r,f,X_f,F,X_F,phi,X_Phi)
 fclose(fId);
end

function WritePotential_setf2(alloy,element,edata,nrho,drho,nr,dr,rc,rho,...
  r,f,X_f,F,X_F,phi,X_phi)
 global fId;
 fprintf(fId,'setfl format\n');
 s = alloy(1,:);
 for i = 2:length(alloy(:,1))
   s = cat(2,s,alloy(i,:));
 end
 fprintf(fId,'%s functions (universal3)\n',s);
 fprintf(fId,'%s functions (universal3)\n',s);
 fprintf(fId,'%d %s %s %s %s\n',length(alloy(:,1)),alloy(1,:),...
 alloy(2,:),alloy(3,:),alloy(4,:));
 fprintf(fId,'%d\t%e\t%d\t%e\t%e\n',nrho,drho,nr,dr,rc);
 for i = 1:length(alloy(:,1))
   for index = 1:length(element)
     if alloy(i,:) == element(index,:)
       Fp = str2func(char(F(index,:)));
       X1 = X_F(index,:);
       EF = Embidding_function_2(rho,Fp,X1);
       fp = str2func(char(f(index,:)));
       X2 = X_f(index,:);
       Ef = Electron_density_2(r,fp,X2);

       numedata = cell2mat(edata(index,1:3));
       fprintf(fId,'%d\t%6.3f\t%6.3f\t',numedata(1,:));
       % structure = string(cell2mat(edata(index,4:end))); % matlab
       structure = char(cell2mat(edata(index, 4:end))); % octave
       fprintf(fId,'%s\n',structure);

       Write_F(rho,EF);
       Write_f(r,Ef);
     end
   end
 end
 for index = 1:length(phi)
   phip = str2func(char(phi(index,:)));
   X3 = X_phi(index,:);
   [PHI,RPHI] = Two_body_potential(r,phip,X3);
   Write_rPHI(r,PHI);
 end
end

function FF = Embidding_function_2(rho,F,X)
  for i=1:length(rho)
    if rho(i) ~= 0
      FF(i) = F(rho(i),X);
    else
      FF(i) = 0;
    end
  end
end

function ff = Electron_density_2(r,f,X)
 for i = 1:length(r)
   ff(i) = f(r(i),X);
 end
end

function [PHI,RPHI] = Two_body_potential(r,phi,X)
 for i = 1:length(r)
   PHI(i) = phi(r(i),X);
   RPHI(i) = r(i)*PHI(i);
 end
end

% Park & Hijazi phi_PdPd
function f = phi_PdPd(rij,X)
 phie = X(1);
 S = X(2);
 B = X(3);
 re = X(4);
 f = -phie*(1+S*(rij/re-1))*exp(-B*(rij/re-1));
end

% dphidr_H
function f = dphidr_PdPd(r,X)
 phie = X(1);
 S = X(2);
 B = X(3);
 re = X(4);
 f = (-1/re)*(phie*S*exp(-B*(r/re-1))+B*phi_PdPd(r,X));
end

% d2phidr2_H
function f = d2phidr2_PdPd(r,X)
 phie = X(1);
 S = X(2);
 B = X(3);
 re = X(4);
 f = (B/re)*((phie*S/re)*exp(-B*(r/re-1))-dphidr_PdPd(r,X));
end

% Electron density
function f = f_PdPd(rij,X)
 fe = X(1);
 Xi = X(2);
 re = X(3);
 f = fe*exp(-Xi*(rij-re));
end

% Park & Hijazi F_P
function f = F_Pd(rho,X)
 f = 0;
 Fe = X(1);
 rhoe = X(2);
 n = X(3);
 if rho > 0.0
 f = -Fe*(1-n*log(rho/rhoe))*(rho/rhoe)^n;
 end
end

% Zhou PhiHH Equation (5.7) page 62
% QHH(r) = DHH(HH_exp_?_HH_r ? r0,HH__ ? _HH_exp_?_HH_r ? r0,HH ,
function f = phi_HH_u(rij,X)
 DHH = X(1);
 alphaHH = X(2);
 betaHH = X(3);
 r0HH = X(4);
 f = DHH*(betaHH*exp(-alphaHH*(rij-r0HH)) - alphaHH*exp(-betaHH*(rij-r0HH)));
end

function f = dphidr_HH_u(r,X)
 DHH = X(1);
 alphaHH = X(2);
 betaHH = X(3);
 r0HH = X(4);
 f = DHH*( -alphaHH * betaHH*exp(-alphaHH*(r-r0HH)) ...
 + betaHH*alphaHH*exp(-betaHH*(r-r0HH)) );
end

% d2phidr2_H
function f = d2phidr2_HH_u(r,X)
 DHH = X(1);
 alphaHH = X(2);
 betaHH = X(3);
 r0HH = X(4);
 f = DHH*( (alphaHH^2) * betaHH*exp(-alphaHH*(r-r0HH)) ...
 -(betaHH^2)*alphaHH*exp(-betaHH*(r-r0HH)) );
end

% H-H normalized pair potential as a function of interatomic distance rij
function f = phi_HH(rij,X)
209
 X2_HH = X(1:1:4);
 X0_HH = X(5:1:7);
 X1_HH = X(8:1:12);
 rho0H = X(12);
 f = phi_HH_u(rij,X2_HH) + 2 * dFdrho_H_u(rho0H,X1_HH) * f_HH(rij,X0_HH);
end

% First derivative of H-H normalized pair potential with respect to rij
function f = dphidr_HH(rij,X)
 X2_HH = X(1:1:4);
 X0_HH = X(5:1:7);
 X1_HH = X(8:1:12);
 rho0H = X(12);
 f = dphidr_HH_u(rij,X2_HH) + 2 * dFdrho_H_u(rho0H,X1_HH) * ...
 dfdr_HH(rij,X0_HH);
end

% Second derivative of H-H normalized pair potential with respect to rij
function f = d2phidr2_HH(rij,X)
 X2_HH = X(1:1:4);
 X0_HH = X(5:1:7);
 X1_HH = X(8:1:12);
 rho0H = X(12);
 f = d2phidr2_HH_u(rij,X2_HH) + 2 * dFdrho_H_u(rho0H,X1_HH) * ...
 d2fdr2_HH(rij,X0_HH);
end

% H Atomic Electron Density as a function of interatomic distance
function f = f_HH(r,X)
 CH = X(1);
 DH = X(2);
 f = CH*exp(-DH*r);
end

% First derivative H Atomic Electron Density with respect to rij
function f = dfdr_HH(r,X)
 CH = X(1);
 DH = X(2);
 f = -DH*CH*exp(-DH*r);
end

% Second derivative H Atomic Electron Density with respect to rij
function f = d2fdr2_HH(r,X)
 CH = X(1);
 DH = X(2);
 f = (DH^2)*CH*exp(-DH*r);
end

% H unormalized Embedding Energy function
function f = F_H_u(rho,X)
 aH = X(1);
 bH = X(2);
 cH = X(3);
 dH = X(4);
 EH = 0.0540638;
 f = -cH * ( (1/(2+dH))*(rho+EH)^(2+dH) - ((aH + bH)/(1+dH))*...
 (rho+EH)^(1+dH) + ((aH * bH)/dH) *(rho+EH)^dH );
end

% First derivative of H unnormalized Embedding function with respect to Rho
function f = dFdrho_H_u(rho,X)
 aH = X(1);
 bH = X(2);
 cH = X(3);
 dH = X(4);
 EH = 0.0540638;
 f = -cH * ( (rho+EH)^(1+dH) - (aH + bH) * (rho+EH)^(dH) +...
 (aH * bH) *(rho+EH)^(dH-1) );
end

% Second derivative of H unnormalized Embedding function with respect to Rho
function f = d2Fdrho2_H_u(rho,X)
 aH = X(1);
 bH = X(2);
 cH = X(3);
 dH = X(4);
 EH = 0.0540638;
 f = -cH * ( (1+dH)*(rho+EH)^(dH) - dH*(aH + bH) * (rho+EH)^(dH-1) + ...
 (dH-1)*(aH * bH) *(rho+EH)^(dH-2) );
end

% H normalized Embedding Energy function
function f = F_H(rho,X)
 X1_HH = X(1:1:4);
 rho0H = X(5);
 f = F_H_u(rho,X1_HH) - dFdrho_H_u(rho0H,X1_HH) * rho;
end

% First derivative of H normalized Embedding function with
respect to Rho
function f = dFdrho_H(rho,X)
 X1_HH = X(1:1:4);
 rho0H = X(5);
 f = dFdrho_H_u(rho,X1_HH) - dFdrho_H_u(rho0H,X1_HH);
end

% Second derivative of H normalized Embedding function with
respect to Rho
function f = d2Fdrho2_H(rho,X)
 X1_HH = X(1:1:4);
 f = d2Fdrho2_H_u(rho,X1_HH);
end

% Pd-H pair potential as a function of interatomic destance rij
function f = phi_PdH(r,X)
 DPdH = X(1);
 alphaPdH = X(2);
 betaPdH = X(3);
 r0PdH = X(4);
 f = DPdH*( betaPdH*exp(-alphaPdH*(r-r0PdH)) - ...
 alphaPdH*exp(-betaPdH*(r-r0PdH)) );
end

% First derivative of Pd-H pair potential with respect to interatomic
% destance rij
function f = dphidr_PdH(r,X)
 DPdH = X(1);
 alphaPdH = X(2);
 betaPdH = X(3);
 r0PdH = X(4);
 f = DPdH*( -alphaPdH*betaPdH*exp(-alphaPdH*(r-r0PdH)) +...
 betaPdH*alphaPdH*exp(-betaPdH*(r-r0PdH)) );
end

% Second derivative of Pd-H pair potential with respect to interatomic
% destance rij
function f = d2phidr2_PdH(r,X)
 DPdH = X(1);
 alphaPdH = X(2);
 betaPdH = X(3);
 r0PdH = X(4);
 f = DPdH*( (alphaPdH^2)*betaPdH*exp(-alphaPdH*(r-r0PdH)) -...
 (betaPdH^2)*alphaPdH*exp(-betaPdH*(r-r0PdH)) );
end

function [afcce,Ecfcce,c11e,c12e,c44e,Bme,Eve,abcce,Ecbcce,cpre] ...
  = parameters(el)
 index = 1;
 elements = ['Ag';'Al';'Au';'Cu';'Ni';'Pd';'Pt';'Hi'];
 for i = 1:length(elements)
   x = elements(i,:);
   if el == x
     index = i;
   end
 end
 afcc = [4.09;4.05;4.08;3.615;3.52;3.89;3.92;3.38];
 Ecfcc = [2.85;3.36;3.93;3.54;4.45;3.91;5.77;2.119];
 c11 = [1.24;1.14;1.86;1.70;2.465;2.341;3.47;0.0];
 c12 = [0.934;0.619;1.57;1.225;1.473;1.761;2.51;0.0];
 c44 = [0.461;0.316;0.42;0.758;1.247;0.712;0.765;0.05];
 cpr = [1,1,1,1,1,1,1,0.05];
 % Unrelaxed
 Evfcc = [1.1;0.866;0.9;1.3;1.70;1.54;1.60;0.0];
 % Relaxed
 % Evfcc = [1.3;1.1;0.75;0.9;1.60;1.40;1.50;0.0];
 B = [1.04;0.793;1.67;1.38;1.804;1.95;2.83;0.50];
 abcc = [3.32;3.3;3.18;2.87;2.89;3.16;3.21;0.0];
 Ecbcc = [1;1;1;3.49;1;1;1;1];
 afcce = afcc(index);
 Ecfcce = Ecfcc(index);
 Eve = Evfcc(index);
 c11e = c11(index);
 c12e = c12(index);
 c44e = c44(index);
 Bme = B(index);
 abcce = abcc(index);
 Ecbcce = Ecbcc(index);
 cpre = cpr(index);
end

function [afcce,Ecfcce] = PdH_parameters(el)
 index1 = 1;
 elements = ['Pd000H';'PdH000';'PdH025';'PdH050';'PdH075';...
 'PdH100';'PdHT50';'PdHT75'];
 [n,m] = size(elements);
 for i = 1:n
   x = elements(i,:);
   if el == x
     index1 = i;
   end
 end

 % From Sandia Paper
 a = [3.38;3.89;3.9421;4.0007;4.0593;4.1179;4.0007;4.0593];
 Ec = [2.119;3.91;3.64024;3.48770;3.37031;3.26966;3.50000;3.50000];
 afcce = a(index1);
 Ecfcce = Ec(index1);
end

function Write_F(rho,F)
 global fId;
 for i = 1:5:length(rho)-1
   for j = 0:4
     fprintf(fId,'%20.16e\t',F(i+j));
   end
   fprintf(fId,'\n');
 end
end

function Write_f(r,f)
 global fId;
 for i = 1:5
   f(length(r)-i)=0;
 end
 for i = 1:5:length(r)-1
   for j = 0:4
     fprintf(fId,'%20.16e\t',f(i+j));
   end
   fprintf(fId,'\n');
 end
end

function Write_rPHI(r,PHI)
 global fId;
 for i = 1:5
   PHI(length(r)-i)=0;
 end
 for i = 1:5:length(r)-1
   for j = 0:4
     fprintf(fId,'%20.16e\t',r(i+j)*PHI(i+j));
   end
   fprintf(fId,'\n');
 end
end

function f = phi_PdAg(rij,X)
 X0_a = X(1:3);
 X0_b = X(4:6);
 X2_a = X(7:10);
 X2_b = X(11:14);
 f_a = f_PdPd(rij,X0_a);
 f_b = f_PdPd(rij,X0_b);
 phi_a = phi_PdPd(rij,X2_a);
 phi_b = phi_PdPd(rij,X2_b);
 f = .5*( f_b*f_a^-1*phi_a + f_a*f_b^-1*phi_b );
end

function f = phi_AgCu(rij,X)
 X0_a = X(1:3);
 X0_b = X(4:6);
 X2_a = X(7:10);
 X2_b = X(11:14);
 f_a = f_AgAg(rij,X0_a);
 f_b = f_AgAg(rij,X0_b);
 phi_a = phi_AgAg(rij,X2_a);
 phi_b = phi_AgAg(rij,X2_b);
 f = .5*( f_b*f_a^-1*phi_a + f_a*f_b^-1*phi_b );
end

function f = phi_PdCu(rij,X)
 X0_a = X(1:3);
 X0_b = X(4:6);
 X2_a = X(7:10);
 X2_b = X(11:14);
 f_a = f_PdPd(rij,X0_a);
 f_b = f_PdPd(rij,X0_b);
 phi_a = phi_PdPd(rij,X2_a);
 phi_b = phi_PdPd(rij,X2_b);
 f = .5*( f_b*f_a^-1*phi_a + f_a*f_b^-1*phi_b );
end

function f = phi_AgH(r,X)
 DPdH = X(1);
 alphaPdH = X(2);
 betaPdH = X(3);
 r0PdH = X(4);
 f = DPdH*( betaPdH*exp(-alphaPdH*(r-r0PdH)) - ...
 alphaPdH*exp(-betaPdH*(r-r0PdH)) );
end

function f = phi_CuH(r,X)
 DPdH = X(1);
 alphaPdH = X(2);
 betaPdH = X(3);
 r0PdH = X(4);
 f = DPdH*( betaPdH*exp(-alphaPdH*(r-r0PdH)) - ...
 alphaPdH*exp(-betaPdH*(r-r0PdH)) );
end

function f = f_AgAg(rij,X)
 fe = X(1);
 Xi = X(2);
 re = X(3);
 f = fe*exp(-Xi*(rij-re));
end

function f = f_CuCu(rij,X)
 fe = X(1);
 Xi = X(2);
 re = X(3);
 f = fe*exp(-Xi*(rij-re));
end

% Park & Hijazi F_P
function f = F_Ag(rho,X)
 f = 0;
 Fe = X(1);
 rhoe = X(2);
 n = X(3);
 if rho > 0.0
   f = -Fe*(1-n*log(rho/rhoe))*(rho/rhoe)^n;
 end
end

function f = F_Cu(rho,X)
 f = 0;
 Fe = X(1);
 rhoe = X(2);
 n = X(3);
 if rho > 0.0
   f = -Fe*(1-n*log(rho/rhoe))*(rho/rhoe)^n;
 end
end

% Park & Hijazi phi_AgAg
function f = phi_AgAg(rij,X)
 phie = X(1);
 S = X(2);
 B = X(3);
 re = X(4);
 f = -phie*(1+S*(rij/re-1))*exp(-B*(rij/re-1));
end

function f = phi_CuCu(rij,X)
 phie = X(1);
 S = X(2);
 B = X(3);
 re = X(4);
 f = -phie*(1+S*(rij/re-1))*exp(-B*(rij/re-1));
end
