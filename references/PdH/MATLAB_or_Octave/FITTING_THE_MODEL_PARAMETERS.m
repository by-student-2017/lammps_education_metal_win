function EAM_Parameters_Fitting
 % Use as of 03-13-2017
 warning off
 % Clear command window
 clc
 % Format size
 format short
 % Global variables for octahedral structure
 global ri_PdH100_OC
 global index_PdH100_OC_1
 global index_PdH100_OC_2
 % Global variables for tetrahedral structure
 global ri_PdH200_TE
 global index_PdH200_TE_1
 global index_PdH200_TE_2
 % Global elements type
 global element
 global type_1
 global type_2
 % load input files
 % 4x4x4 OC input file
 load PdH100_OC_SORTED.data;
 % 4x4x4 TE input file
 load PdH_TE_SORTED.data;
 % Atomic positions for Pd FCC structure
 ri_PdH100_OC = PdH100_OC_SORTED(:,:);
 ri_PdH200_TE = PdH_TE_SORTED(:,:);
 % Indices for OC central atoms
 ra_1 = [1 0 0 0];
 ra_2 = [2 1 1 1];
 % Indices for TE central atoms
 ra_1_TE = [1 0 0 0];
 ra_2_TE = [2 0.5 0.5 0.5];
 % Find atom index for OC structure using MATLAB find function
 index_PdH100_OC_1 = find(ismember(ri_PdH100_OC,ra_1,'rows'))
 index_PdH100_OC_2 = find(ismember(ri_PdH100_OC,ra_2,'rows'))
 % Find atom index for TE structure using MATLAB find function
 index_PdH200_TE_1 = find(ismember(ri_PdH200_TE,ra_1_TE,'rows'))
 index_PdH200_TE_2 = find(ismember(ri_PdH200_TE,ra_2_TE,'rows'))
 % Atom types
 type_1 = 1;
 type_2 = 2;
 % Pd Expermintal data
 element = 'Pd';
 [aFcce,EcFcce,c11e,c12e,c44e,~,Eve,aBcce,EcBcce] = parameters(element);
 % Pd Fitting Parameters
 re = aFcce/sqrt(2);
 Fe = EcFcce-Eve;
 rc = 1.75*aFcce;
 N = 4;
 V = aFcce^3/N;
 fe = EcFcce/V;
 xx = [2.0345 0.2152 8.5931 7.2641 1.0000 3.3442];
 % Pd Fitting Parameters
 Xi = xx(1);
 phie = xx(2);
 S = xx(3);
 B = xx(4);
 n = xx(5);
 rhoe = xx(6);
 % HH
 X0_H = [1,1,1,1,1];
 Xl_H = [0.1,0.1,0.1,0.1,0.1];
 Xu_H = [13,12,12,12,12];
 % PdH
 X0_PdH = [1,1,1];
 Xl_PdH = [0.1,0.1,0.1];
 Xu_PdH = [12,12,12];
 % FH
 X0_FH = [8 , 65, 0.000197047, 1.1886, 1.50964, 2.51980];
 Xl_FH = [6 , 40, 0.0001, 1.1870, 1.3, 1.0];
 Xu_FH = [12, 70, 2.0 ,2 , 2, 4];
 %
 X0_PdH = [X0_H, X0_PdH, X0_FH];
 Xl_PdH = [Xl_H, Xl_PdH, Xl_FH];
 Xu_PdH = [Xu_H, Xu_PdH, Xu_FH];
 %
 options.MaxFunEvals = 60000;
 options.TolFun = 1.00e-6;
 options.TolX = 1.00e-6;
 %
 [x,fval] = fmincon(@objfun,X0_PdH,[],[],[],[],Xl_PdH,Xu_PdH,[],options)
 % Write results
 fId = fopen('C:\MU-Papers-active\EAM\MATLAB-Code-02-07-
2017\BM\PdH_Fitting_Parameters','w');
 fprintf(fId,'%f\t',x);
 fclose(fId);
 % Phi_HH
 DHH = x(1);
 aHH = x(2);
 bHH = x(3);
 % f_HH
 CH = x(4);
 DH = x(5);
 rho0H = 7.98909;
 % Phi_PdH
 DPdH = x(6);
 aPdH = x(7);
 bPdH = x(8);
 % F_H
 aH = x(9);
 bH = x(10);
 cH = x(11);
 dH = x(12);
 %
 r0PdH = x(13);
 r0HH = x(14);
 % Rho PdPd fitting parameters
 X0_PdPd = [fe,Xi,re];
 % F PdPd fitting parameters
 X1_PdPd = [Fe,rhoe,n];
 % Phi PdPd fitting parametters
 X2_PdPd = [phie,S,B,re];
 % f_HH
 X0_HH = [CH,DH,rho0H];
 ri = ri_PdH100_OC;
 index = index_PdH100_OC_1;
 aFcce_H = 3.38;
 rc_1 = 1.75 * aFcce_H;
 rho0H = Rho(index,1,ri,3.38,rc_1,@f_HH,X0_HH)
 % f_H
 X0_HH = [CH,DH,rho0H];
 % F_H
 X1_HH = [aH,bH,cH,dH];
 % Phi_HH
 X2_HH = [DHH,aHH,bHH,r0HH];
 % Phi_HH, f_HH, F_H
 X22_HH = [X2_HH,X0_HH,X1_HH];
 % Vectores of fitting parameters
 X4_PdH = [DPdH,aPdH,bPdH,r0PdH];

%*************************************************************************
% For PdPd Fcc
%*************************************************************************
 ri = ri_PdH100_OC;
 index_Pd = index_PdH100_OC_1;
 aFcce_Pd = 3.89
 rc_1 = 1.75 * aFcce_Pd;
 rc_2 = -1;
 %
 N = 4;
 [Ec_Pd,dEda_Pd,C11_Pd,C12_Pd,C44_Pd,Bm_Pd,Ev_Pd] = ...
 fitProperties(ri,aFcce_Pd,N,index_Pd,1,1,...
 @f_PdPd,@dfdr_PdPd,@d2fdr2_PdPd,X0_PdPd,...
 @F_Pd,@dFdrho_Pd,@d2Fdrho2_Pd,X1_PdPd,...
 @phi_PdPd,@dphidr_PdPd,@d2phidr2_PdPd,X2_PdPd,rc_1,...
 2,0,@f_HH,@dfdr_HH,@d2fdr2_HH,X0_HH,...
 @phi_PdH,@dphidr_PdH,@d2phidr2_PdH,X4_PdH,rc_2)
 % Relationship between c' and bulk modulus with C11 and C12
 % for PdPd octahedral structure
 Cpr_Pd = (C11_Pd - C12_Pd)/2
 Bm_Pd = (C11_Pd + 2*C12_Pd)/3
%*************************************************************************
% For HH Fcc
%*************************************************************************
 ri = ri_PdH100_OC;
 index = index_PdH100_OC_1;
 aFcce_H = 3.38
 rc_1 = 1.75 * aFcce_H;
 rc_2 = -1;
 N = 4;
 [Ec_H,dEda_H,C11_H,C12_H,C44_H,Bm_H] = ...
 fitProperties(ri,aFcce_H,N,index,1,1,...
 @f_HH,@dfdr_HH,@d2fdr2_HH,X0_HH,...
 @F_H,@dFdrho_H,@d2Fdrho2_H,X22_HH,...
 @phi_HH,@dphidr_HH,@d2phidr2_HH,X22_HH,rc_1,...
 2,0,@f_PdPd,@dfdr_PdPd,@d2fdr2_PdPd,X0_PdPd,...
 @phi_PdH,@dphidr_PdH,@d2phidr2_PdH,X4_PdH,rc_2)
 %Relationship between c' and bulk modulus with C11 and C12
 % for HH structure
 Cpr_H = (C11_H - C12_H)/2
 Bm_H = (C11_H + 2*C12_H)/3
%*************************************************************************
% For PdH000 Fcc
%*************************************************************************
 ri = ri_PdH100_OC;
 index = index_PdH100_OC_1;
 [aFcce_PdH,Ece_PdH025] = PdH_parameters('PdH000');
 aFcce = aFcce_PdH
 rc_1 = 1.75 * 3.89;
 rc_2 = 1.75 * 3.38;
 % PdH000
 yy = 1.0;
 xx = 0.0;
 N = 4;
 % PdH
 [Ec_Pd_12,dEda_Pd_12,C11_Pd_12,C12_Pd_12,C44_Pd_12,Bm_Pd_12,Ev_Pd_12] =...
 fitProperties(ri,aFcce,N,index,1,yy,...
 @f_PdPd,@dfdr_PdPd,@d2fdr2_PdPd,X0_PdPd,...
 @F_Pd,@dFdrho_Pd,@d2Fdrho2_Pd,X1_PdPd,...
 @phi_PdPd,@dphidr_PdPd,@d2phidr2_PdPd,X2_PdPd,rc_1,...
 2,xx,@f_HH,@dfdr_HH,@d2fdr2_HH,X0_HH,...
 @phi_PdH,@dphidr_PdH,@d2phidr2_PdH,X4_PdH,rc_2);
 
% HPd
 [Ec_H_12,dEda_H_12,C11_H_12,C12_H_12,C44_H_12,Bm_H_12] = ...
 fitProperties(ri,aFcce,N,index,1,xx,...
 @f_HH,@dfdr_HH,@d2fdr2_HH,X0_HH,...
@F_H,@dFdrho_H,@d2Fdrho2_H,X22_HH,...
 @phi_HH,@dphidr_HH,@d2phidr2_HH,X22_HH,rc_2,...
 2,yy,@f_PdPd,@dfdr_PdPd,@d2fdr2_PdPd,X0_PdPd,...
 @phi_PdH,@dphidr_PdH,@d2phidr2_PdH,X4_PdH,rc_2);
 %
 X = xx/(1+xx);
 Ec_PdH000 = ( yy * Ec_Pd_12 + xx * Ec_H_12 )/(yy + xx)
 C11_PdH000 = ( yy * C11_Pd_12 + xx * C11_H_12)/(yy + xx)
 C12_PdH000 = ( yy * C12_Pd_12 + xx * C12_H_12)/(yy + xx)
 C44_PdH000 = ( yy * C44_Pd_12 + xx * C44_H_12)/(yy + xx)
 Bm_PdH000 = ( yy * Bm_Pd_12 + xx * Bm_H_12 )/(yy + xx)
 Cpr_PdH000 = (C11_PdH000 - C12_PdH000)/2
 Bm_PdH000 = (C11_PdH000 + 2*C12_PdH000)/3
%*************************************************************************
% For PdH100 Fcc
%*************************************************************************
 ri = ri_PdH100_OC;
 index = index_PdH100_OC_1;
 [aFcce_PdH,Ece_PdH100] = PdH_parameters('PdH100');
 aFcce = aFcce_PdH
 rc_1 = 1.75 * 3.89;
 rc_2 = 1.75 * 3.38;
 % PdH1.0
 yy = 1.0;
 xx = 1.0;
 N = 8;
 % PdH
 [Ec_Pd_12,dEda_Pd_12,C11_Pd_12,C12_Pd_12,C44_Pd_12,Bm_Pd_12,Ev_Pd_12] =...
 fitProperties(ri,aFcce,N,index,1,yy,...
 @f_PdPd,@dfdr_PdPd,@d2fdr2_PdPd,X0_PdPd,...
 @F_Pd,@dFdrho_Pd,@d2Fdrho2_Pd,X1_PdPd,...
 @phi_PdPd,@dphidr_PdPd,@d2phidr2_PdPd,X2_PdPd,rc_1,...
 2,xx,@f_HH,@dfdr_HH,@d2fdr2_HH,X0_HH,...
 @phi_PdH,@dphidr_PdH,@d2phidr2_PdH,X4_PdH,rc_2);
% HPd
 [Ec_H_12,dEda_H_12,C11_H_12,C12_H_12,C44_H_12,Bm_H_12] = ...
 fitProperties(ri,aFcce,N,index,1,xx,...
 @f_HH,@dfdr_HH,@d2fdr2_HH,X0_HH,...
 @F_H,@dFdrho_H,@d2Fdrho2_H,X22_HH,...
 @phi_HH,@dphidr_HH,@d2phidr2_HH,X22_HH,rc_2,...
 2,yy,@f_PdPd,@dfdr_PdPd,@d2fdr2_PdPd,X0_PdPd,...
 @phi_PdH,@dphidr_PdH,@d2phidr2_PdH,X4_PdH,rc_2);
%
 X = xx/(1+xx)
 Ec_PdH100 = ( yy * Ec_Pd_12 + xx * Ec_H_12 )/(yy + xx)
 C11_PdH100 = ( yy * C11_Pd_12 + xx * C11_H_12)/(yy + xx)
 C12_PdH100 = ( yy * C12_Pd_12 + xx * C12_H_12)/(yy + xx)
 C44_PdH100 = ( yy * C44_Pd_12 + xx * C44_H_12)/(yy + xx)
 Bm_PdH100 = ( yy * Bm_Pd_12 + xx * Bm_H_12 )/(yy + xx)
 dEda_PdH100 = ( yy * dEda_Pd_12 + xx * dEda_H_12)/(yy + xx)
 Cpr_PdH100 = (C11_PdH100 - C12_PdH100)/2
 Bm_PdH100 = (C11_PdH100 + 2*C12_PdH100)/3
 dH_mix_100 = Ec_PdH100 - 2*X*Ec_PdH100 - (1-2*X)*Ec_Pd
%*************************************************************************
% For PdH0.25 Fcc
%*************************************************************************
 ri = ri_PdH100_OC;
 index = index_PdH100_OC_1;
 [aFcce_PdH,Ece_PdH025] = PdH_parameters('PdH025');
 aFcce = aFcce_PdH
 rc_1 = 1.75 * 3.89;
 rc_2 = 1.75 * 3.38;
 % PdH0.25
 yy = 1.0;
 xx = 0.25;
 N = 5;
 % PdH
 [Ec_Pd_12,dEda_Pd_12,C11_Pd_12,C12_Pd_12,C44_Pd_12,Bm_Pd_12,Ev_Pd_12] =...
 fitProperties(ri,aFcce,N,index,1,yy,...
 @f_PdPd,@dfdr_PdPd,@d2fdr2_PdPd,X0_PdPd,...
 @F_Pd,@dFdrho_Pd,@d2Fdrho2_Pd,X1_PdPd,...
 @phi_PdPd,@dphidr_PdPd,@d2phidr2_PdPd,X2_PdPd,rc_1,...
 2,xx,@f_HH,@dfdr_HH,@d2fdr2_HH,X0_HH,...
 @phi_PdH,@dphidr_PdH,@d2phidr2_PdH,X4_PdH,rc_2);
 
% HPd
 [Ec_H_12,dEda_H_12,C11_H_12,C12_H_12,C44_H_12,Bm_H_12] = ...
 fitProperties(ri,aFcce,N,index,1,xx,...
 @f_HH,@dfdr_HH,@d2fdr2_HH,X0_HH,...
 @F_H,@dFdrho_H,@d2Fdrho2_H,X22_HH,...
 @phi_HH,@dphidr_HH,@d2phidr2_HH,X22_HH,rc_2,...
 2,yy,@f_PdPd,@dfdr_PdPd,@d2fdr2_PdPd,X0_PdPd,...
 @phi_PdH,@dphidr_PdH,@d2phidr2_PdH,X4_PdH,rc_2);
 %
 X = xx/(1+xx)
 Ec_PdH025 = ( yy * Ec_Pd_12 + xx * Ec_H_12 )/(yy + xx)
 C11_PdH025 = ( yy * C11_Pd_12 + xx * C11_H_12)/(yy + xx)
C12_PdH025 = ( yy * C12_Pd_12 + xx * C12_H_12)/(yy + xx)
 C44_PdH025 = ( yy * C44_Pd_12 + xx * C44_H_12)/(yy + xx)
 Bm_PdH025 = ( yy * Bm_Pd_12 + xx * Bm_H_12 )/(yy + xx)
 dEda_PdH025 = (yy * dEda_Pd_12 + xx * dEda_H_12)/(yy + xx)
 Cpr_PdH025 = (C11_PdH025 - C12_PdH025)/2
 Bm_PdH025 = (C11_PdH025 + 2*C12_PdH025)/3
 dH_mix_025 = Ec_PdH025 - 2*X*Ec_PdH100 - (1-2*X)*Ec_Pd
%*************************************************************************
% For PdH0.5 Fcc
%*************************************************************************
 ri = ri_PdH100_OC;
 index = index_PdH100_OC_1;
 [aFcce_PdH,Ece_PdH050] = PdH_parameters('PdH050');
 aFcce = aFcce_PdH
 rc_1 = 1.75 * 3.89;
 rc_2 = 1.75 * 3.38;
 % PdH0.5
 yy = 1.0;
 xx = 0.5;
 N = 6;
 [Ec_Pd_12,dEda_Pd_12,C11_Pd_12,C12_Pd_12,C44_Pd_12,Bm_Pd_12,Ev_Pd_12] =...
 fitProperties(ri,aFcce,N,index,1,yy,...
 @f_PdPd,@dfdr_PdPd,@d2fdr2_PdPd,X0_PdPd,...
 @F_Pd,@dFdrho_Pd,@d2Fdrho2_Pd,X1_PdPd,...
 @phi_PdPd,@dphidr_PdPd,@d2phidr2_PdPd,X2_PdPd,rc_1,...
 2,xx,@f_HH,@dfdr_HH,@d2fdr2_HH,X0_HH,...
 @phi_PdH,@dphidr_PdH,@d2phidr2_PdH,X4_PdH,rc_2);
 
%
 [Ec_H_12,dEda_H_12,C11_H_12,C12_H_12,C44_H_12,Bm_H_12] = ...
 fitProperties(ri,aFcce,N,index,1,xx,...
 @f_HH,@dfdr_HH,@d2fdr2_HH,X0_HH,...
 @F_H,@dFdrho_H,@d2Fdrho2_H,X22_HH,...
 @phi_HH,@dphidr_HH,@d2phidr2_HH,X22_HH,rc_2,...
 2,yy,@f_PdPd,@dfdr_PdPd,@d2fdr2_PdPd,X0_PdPd,...
 @phi_PdH,@dphidr_PdH,@d2phidr2_PdH,X4_PdH,rc_2);
 %
 X = xx/(1+xx)
 Ec_PdH050 = ( yy * Ec_Pd_12 + xx * Ec_H_12 )/(yy + xx)
 C11_PdH050 = ( yy * C11_Pd_12 + xx * C11_H_12)/(yy + xx)
 C12_PdH050 = ( yy * C12_Pd_12 + xx * C12_H_12)/(yy + xx)
 C44_PdH050 = ( yy * C44_Pd_12 + xx * C44_H_12)/(yy + xx)
 Bm_PdH050 = ( yy * Bm_Pd_12 + xx * Bm_H_12 )/(yy + xx)
 dEda_PdH050 = (yy * dEda_Pd_12 + xx * dEda_H_12)/(yy + xx)
 Cpr_PdH050 = (C11_PdH050 - C12_PdH050)/2
Bm_PdH050 = (C11_PdH050 + 2*C12_PdH050)/3
 dH_mix_050 = Ec_PdH050 - 2*X*Ec_PdH100 - (1-2*X)*Ec_Pd
%*************************************************************************
% For PdH0.75 Fcc
%*************************************************************************
 ri = ri_PdH100_OC;
 index = index_PdH100_OC_1;
 [aFcce_PdH,Ece_PdH075] = PdH_parameters('PdH075');
 aFcce = aFcce_PdH
 rc_1 = 1.75 * 3.89;
 rc_2 = 1.75 * 3.38;
 % PdH0.5
 yy = 1.0;
 xx = 0.75;
 N = 7;
 % PdH
 [Ec_Pd_12,dEda_Pd_12,C11_Pd_12,C12_Pd_12,C44_Pd_12,Bm_Pd_12,Ev_Pd_12] =...
 fitProperties(ri,aFcce,N,index,1,yy,...
 @f_PdPd,@dfdr_PdPd,@d2fdr2_PdPd,X0_PdPd,...
 @F_Pd,@dFdrho_Pd,@d2Fdrho2_Pd,X1_PdPd,...
 @phi_PdPd,@dphidr_PdPd,@d2phidr2_PdPd,X2_PdPd,rc_1,...
 2,xx,@f_HH,@dfdr_HH,@d2fdr2_HH,X0_HH,...
 @phi_PdH,@dphidr_PdH,@d2phidr2_PdH,X4_PdH,rc_2);
 
%
 [Ec_H_12,dEda_H_12,C11_H_12,C12_H_12,C44_H_12,Bm_H_12] = ...
 fitProperties(ri,aFcce,N,index,1,xx,...
 @f_HH,@dfdr_HH,@d2fdr2_HH,X0_HH,...
 @F_H,@dFdrho_H,@d2Fdrho2_H,X22_HH,...
 @phi_HH,@dphidr_HH,@d2phidr2_HH,X22_HH,rc_2,...
 2,yy,@f_PdPd,@dfdr_PdPd,@d2fdr2_PdPd,X0_PdPd,...
 @phi_PdH,@dphidr_PdH,@d2phidr2_PdH,X4_PdH,rc_2);
 % HPd
 X = xx/(1+xx)
 Ec_PdH075 = ( yy * Ec_Pd_12 + xx * Ec_H_12 )/(yy + xx)
 C11_PdH075 = ( yy * C11_Pd_12 + xx * C11_H_12 )/(yy + xx)
 C12_PdH075 = ( yy * C12_Pd_12 + xx * C12_H_12 )/(yy + xx)
 C44_PdH075 = ( yy * C44_Pd_12 + xx * C44_H_12 )/(yy + xx)
 Bm_PdH075 = ( yy * Bm_Pd_12 + xx * Bm_H_12 )/(yy + xx)
 dEda_PdH075 = ( yy * dEda_Pd_12 + xx * dEda_H_12)/(yy + xx)
 Cpr_PdH075 = (C11_PdH075 - C12_PdH075)/2
 Bm_PdH075 = (C11_PdH075 + 2*C12_PdH075)/3
 dH_mix_075 = Ec_PdH075 - 2*X*Ec_PdH100 - (1-2*X)*Ec_Pd
%*************************************************************************
% PdH0.25H0.25 TE
%*************************************************************************
 [aFcce_PdH,Ece_PdHT50] = PdH_parameters('PdHT50');
 ri = ri_PdH200_TE;
 index_1 = index_PdH200_TE_1;
 index_2 = index_PdH200_TE_2;
 aFcce = aFcce_PdH;
 rc_1 = 1.75 * 3.89;
 rc_2 = 1.75 * 3.38;
 yy = 1.0;
 xx = 0.25;
 N = 6;
 [Ec_Pd_12,dEda_Pd_12,C11_Pd_12,C12_Pd_12,C44_Pd_12,Bm_Pd_12] =...
 fitProperties(ri,aFcce,N,index_1,1,yy,...
 @f_PdPd,@dfdr_PdPd,@d2fdr2_PdPd,X0_PdPd,...
 @F_Pd,@dFdrho_Pd,@d2Fdrho2_Pd,X1_PdPd,...
 @phi_PdPd,@dphidr_PdPd,@d2phidr2_PdPd,X2_PdPd,rc_1,...
 2,xx,@f_HH,@dfdr_HH,@d2fdr2_HH,X0_HH,...
 @phi_PdH,@dphidr_PdH,@d2phidr2_PdH,X4_PdH,rc_2);
 
%
 [Ec_H_12,dEda_H_12,C11_H_12,C12_H_12,C44_H_12,Bm_H_12] = ...
 fitProperties(ri,aFcce,N,index_2,2,xx,...
 @f_HH,@dfdr_HH,@d2fdr2_HH,X0_HH,...
 @F_H,@dFdrho_H,@d2Fdrho2_H,X22_HH,...
 @phi_HH,@dphidr_HH,@d2phidr2_HH,X22_HH,rc_2,...
 1,yy,@f_PdPd,@dfdr_PdPd,@d2fdr2_PdPd,X0_PdPd,...
 @phi_PdH,@dphidr_PdH,@d2phidr2_PdH,X4_PdH,rc_2);
 % Cohesive energy and its derivative for PdH 0.5 tetrahedral structure
 Ec_PdHT50 = (yy * Ec_Pd_12 + 2*xx * Ec_H_12)/(yy + 2*xx);
 dEda_PdHT50 = (yy * dEda_Pd_12 + 2*xx * dEda_H_12)/(yy + 2*xx);
 % Elastic constants and bulk modulus for PdH 0.5 tetrahedral structure
 C11_PdHT50 = (yy * C11_Pd_12 + 2*xx * C11_H_12)/(yy + 2*xx);
 C12_PdHT50 = (yy * C12_Pd_12 + 2*xx * C12_H_12)/(yy + 2*xx);
 C44_PdHT50 = (yy * C44_Pd_12 + 2*xx * C44_H_12)/(yy + 2*xx);
 Bm_PdHT50 = (yy * Bm_Pd_12 + 2*xx * Bm_H_12 )/(yy + 2*xx);
 % Relationship between c' and bulk modulus with C11 and C12
 % for PdH 0.5 tetrahedral structure
 Cpr_PdHT50 = (C11_PdHT50 - C12_PdHT50)/2;
 Bm_PdHT50 = (C11_PdHT50 + 2*C12_PdHT50)/3;
%*************************************************************************
% PdH0.375H0.375 TE
%*************************************************************************
 [aFcce_PdH,Ece_PdHT75] = PdH_parameters('PdHT75');
 ri = ri_PdH200_TE;
 index_1 = index_PdH200_TE_1;
 index_2 = index_PdH200_TE_2;
 aFcce = aFcce_PdH;
 rc_1 = 1.75 * 3.89;
 rc_2 = 1.75 * 3.38;
 yy = 1.0;
 xx = 0.375;
 N = 7;
 [Ec_Pd_12,dEda_Pd_12,C11_Pd_12,C12_Pd_12,C44_Pd_12,Bm_Pd_12] =...
 fitProperties(ri,aFcce,N,index_1,1,yy,...
 @f_PdPd,@dfdr_PdPd,@d2fdr2_PdPd,X0_PdPd,...
 @F_Pd,@dFdrho_Pd,@d2Fdrho2_Pd,X1_PdPd,...
 @phi_PdPd,@dphidr_PdPd,@d2phidr2_PdPd,X2_PdPd,rc_1,...
 2,xx,@f_HH,@dfdr_HH,@d2fdr2_HH,X0_HH,...
 @phi_PdH,@dphidr_PdH,@d2phidr2_PdH,X4_PdH,rc_2);
 
%
 [Ec_H_12,dEda_H_12,C11_H_12,C12_H_12,C44_H_12,Bm_H_12] = ...
 fitProperties(ri,aFcce,N,index_2,2,xx,...
 @f_HH,@dfdr_HH,@d2fdr2_HH,X0_HH,...
 @F_H,@dFdrho_H,@d2Fdrho2_H,X22_HH,...
 @phi_HH,@dphidr_HH,@d2phidr2_HH,X22_HH,rc_2,...
 1,yy,@f_PdPd,@dfdr_PdPd,@d2fdr2_PdPd,X0_PdPd,...
 @phi_PdH,@dphidr_PdH,@d2phidr2_PdH,X4_PdH,rc_2);
 % Cohesive energy and its derivative for PdH 0.75 tetrahedral structure
 Ec_PdHT75 = (yy * Ec_Pd_12 + 2*xx * Ec_H_12)/(yy + 2*xx)
 dEda_PdHT75 = (yy * dEda_Pd_12 + 2*xx * dEda_H_12)/(yy + 2*xx)
 % Elastic constants and bulk modulus for PdH 0.75 tetrahedral structure
 C11_PdHT75 = (yy * C11_Pd_12 + 2*xx * C11_H_12)/(yy + 2*xx)
 C12_PdHT75 = (yy * C12_Pd_12 + 2*xx * C12_H_12)/(yy + 2*xx)
 C44_PdHT75 = (yy * C44_Pd_12 + 2*xx * C44_H_12)/(yy + 2*xx)
 Bm_PdHT75 = (yy * Bm_Pd_12 + 2*xx * Bm_H_12 )/(yy + 2*xx)
 % Relationship between c' and bulk modulus with C11 and C12
 % for PdH 0.75 tetrahedral structure
 Cpr_PdHT75 = (C11_PdHT75 - C12_PdHT75)/2
 Bm_PdHT75 = (C11_PdHT75 + 2*C12_PdHT75)/3
%*************************************************************************
% Plot Results
%*************************************************************************
 x = [0.0, 0.25, 0.5, 0.75, 1.0];
 % From Sandia Paper
 Eca = [-3.910;-3.64024;-3.48770;-3.37031;-3.26966];
 Ecc_Calc = [Ec_PdH000,Ec_PdH025,Ec_PdH050,Ec_PdH075,Ec_PdH100];
 C11_Calc = [C11_PdH000,C11_PdH025,C11_PdH050,C11_PdH075,C11_PdH100];
 C12_Calc = [C12_PdH000,C12_PdH025,C12_PdH050,C12_PdH075,C12_PdH100];
 C44_Calc = [C44_PdH000,C44_PdH025,C44_PdH050,C44_PdH075,C44_PdH100] * 100;
 Cpr_Calc = [Cpr_PdH000,Cpr_PdH025,Cpr_PdH050,Cpr_PdH075,Cpr_PdH100] * 100;
 Bm_Calc = [Bm_PdH000, Bm_PdH025, Bm_PdH050, Bm_PdH075, Bm_PdH100] * 100;
 % Cohesive Energy of Zhou
 Ecc_Zhou = [-3.91,-3.5626,-3.3233,-3.1563,-3.0390];
 % Bulk Modulus of Zhou and DFT
 Bm_Zhou = [1.95/1.6021766208,1.3379,1.3792,1.4537,1.5421] * 160.21766208;
 Bm_DFT = [1.95,1.41,1.27,1.24,1.21] * 100;
 % C44 of Zhou and DFT
 C44_Zhou = [0.712/1.6021766208,0.3163,0.294,0.2691,0.2351] * 160.21766208;
 C44_DFT = [0.712/1.6021766208,0.4590,0.420,0.3820,0.3440] * 160.21766208;
 
% C' of Zhou and DFT
 Cpr_Zhou = [0.181/1.6021766208,0.1503,0.1649,0.1791,0.1893] * 160.21766208;
 Cpr_DFT = [0.181/1.6021766208,0.0550,0.1350,0.1640,0.1460] * 160.21766208;
 % Comparison Cohesive Energy plot of this work with Zhou and DFT
 figure(1)
 plot(x,Ecc_Calc,'black:',x,Ecc_Zhou,'black--',x,Eca,'black.-','markersize',3, 'linewidth',3)
 xlabel('x','fontsize',24)
 ylabel('Ec/ (eV)','fontsize',18)
 legend('This Work','Zhou','adjusted DFT')
 set(gca,'FontSize',24,'FontWeight','bold','linewidth',3)
 % Comparison C44 plot of this work with Zhou and DFT
 figure(2)
 plot(x,C44_Calc,'black:',x,C44_Zhou,'black--',x,C44_DFT,'black.-','markersize',3, 'linewidth',3)
 legend('Calc','Zhou','DFT')
 ylabel('C44 (GPa)','fontsize',18)
 xlabel('x','fontsize',24)
 set(gca,'FontSize',24,'FontWeight','bold','linewidth',3)
 % Comparison bulk modulus plot of this work with Zhou and DFT
 figure(3)
 plot(x,Bm_Calc,'black:',x,Bm_Zhou,'black--',x,Bm_DFT,'black.-','markersize',3, 'linewidth',3)
 legend('Calc','Zhou','DFT')
 xlabel('X','fontsize',24)
 ylabel('Bm (GPa)','fontsize',18)
 set(gca,'FontSize',24,'FontWeight','bold','linewidth',3)
 % Comparison C' plot of this work with Zhou and DFT
 figure(4)
 plot(x,Cpr_Calc,'black:',x,Cpr_Zhou,'black--',x,Cpr_DFT,'black.-','markersize',3, 'linewidth',3)
 legend('Calc','Zhou','DFT')
 xlabel('X','fontsize',24)
 ylabel('Cpr (GPa)','fontsize',18)
 set(gca,'FontSize',24,'FontWeight','bold','linewidth',3)
 % Plot for C11 and C12
 figure(5)
 plot(x,C11_Calc,'black:',x,C12_Calc, 'black.-','markersize',3, 'linewidth',3)
 legend('C11','C12','CPr')
 xlabel('X','fontsize',24)
 ylabel('GPa','fontsize',18)
 set(gca,'FontSize',24,'FontWeight','bold','linewidth',3)
 % Comparison Two Body Potential plot of this work with Zhou and DFT
 figure(6)
 j = 1;
 
 for r = 1.0:0.01:5.35
 Phi_HH(j) = phi_HH(r,X22_HH);
 Phi_PdH(j) = phi_PdH(r,X4_PdH);
 j = j + 1;
 end
 r = [1.0:0.01:5.35];
 plot(r,Phi_HH,'black-',r,Phi_PdH,'black-.','markersize',3, 'linewidth',3)
 xlabel('r/r_o','fontsize',24)
 ylabel('Two Body Potential / (eV)','fontsize',24)
 legend('HH','PdH')
 set(gca,'FontSize',24,'FontWeight','bold','linewidth',3)
 axis([1,6,-2,1])
 xL = xlim;
 line(xL, [0 0],'linewidth',3); %x-axis
 % Comparison Embedding Energy plot of this work with Zhou and DFT
 figure(7)
 j = 1;
 for rho = 0:0.1:50
 FH(j) = F_H(rho,X22_HH);
 j = j + 1;
 end
 rho = [0:0.1:50];
 plot(rho,FH,'black-.','markersize',3, 'linewidth',3);
 xlabel('Rho','fontsize',24)
 ylabel('Embedding Energy / (eV)','fontsize',24)
 legend('H')
 set(gca,'FontSize',24,'FontWeight','bold','linewidth',3)
 % Comparison Electron Density plot of this work with Zhou and DFT
 figure(8)
 j = 1;
 for r = 0:0.1:5.35
 % As in Zhou and SANDIA Papers
 fHH(j) = f_HH(r,X0_HH);
 j = j + 1;
 end
 r = [0:0.1:5.35];
 plot(r,fHH,'black-.','markersize',3, 'linewidth',3)
 xlabel('r (A^o)','fontsize',24)
 ylabel('Rho','fontsize',18)
 legend('H','fontsize',2)
 set(gca,'FontSize',12,'FontWeight','bold','linewidth',3)
end

%*************************************************************************
% Optimization Function
%*************************************************************************
function f = objfun(x)
 global ri_PdH100_OC;
 global ri_PdH200_TE;
 % Global variables for octahedral structure
 global index_PdH100_OC_1;
 % Global variables for tetrahedral structure
 global index_PdH200_TE_1
 global index_PdH200_TE_2
 %
 [aFcce_Pd,EcFcce_Pd,C11e_Pd,C12e_Pd,C44e_Pd,Bme_Pd,Eve_Pd,aBcce_Pd,...
 EcBcce_Pd] = parameters('Pd');
 %
 [aFcce_H,EcFcce_H,C11e_H,C12e_H,C44e_H,Bme_H,Eve_H,aBcce_H,EcBcce_H,...
 Cpre_H] = parameters('Hi');
 %
 re = aFcce_Pd/sqrt(2);
 Fe = EcFcce_Pd-Eve_Pd;
 rc = 1.75 * aFcce_Pd;
 N = 4;
 V = aFcce_Pd^3/N;
 fe = EcFcce_Pd/V;
 xx = [3.0000 0.2131 8.6577 7.1766 0.7096 3.1225];
 % Pd fitting parameters
 Xi = xx(1);
 phie = xx(2);
 S = xx(3);
 B = xx(4);
 n = xx(5);
 rhoe = xx(6);
 % H
 DHH = x(1);
 aHH = x(2);
 bHH = x(3);
 % f_HH
 CH = x(4);
 DH = x(5);
 rho0H = 7.98909;
 % Phi_PdH
 DPdH = x(6);
 aPdH = x(7);
 bPdH = x(8);
 % F_H
 aH = x(9);
 bH = x(10);
 cH = x(11);
 dH = x(12);
 %
 r0PdH = x(13);
 r0HH = x(14);
 % Fitting Parameters for Pd
 % Rho PdPd fitting parameters
 X0_PdPd = [fe,Xi,re];
 % F PdPd fitting parameters
 X1_PdPd = [Fe,rhoe,n];
 % Phi PdPd fitting parametters
 X2_PdPd = [phie,S,B,re];
 %
 ri = ri_PdH100_OC;
 index = index_PdH100_OC_1;
 aFcce_Pd = 3.89;
 rc_1 = 1.75 * aFcce_Pd;
 rho0Pd = Rho(index,1,ri,3.89,rc_1,@f_PdPd,X0_PdPd);
 % Rho HH fitting parameters
 X0_HH = [CH,DH,rho0H];
 %
 ri = ri_PdH100_OC;
 index = index_PdH100_OC_1;
 aFcce_H = 3.38;
 rc_1 = 1.75 * aFcce_H;
 rho0H = Rho(index,1,ri,3.38,rc_1,@f_HH,X0_HH);
 %
 X0_HH = [CH,DH,rho0H];
 % F HH fitting parameters
 X1_HH = [aH,bH,cH,dH];
 % Phi HH fitting parametters
 X2_HH = [DHH,aHH,bHH,r0HH];
 %
 X22_HH = [X2_HH,X0_HH,X1_HH];
 % Phi PdH fitting parametters
 X4_PdH = [DPdH,aPdH,bPdH,r0PdH];
%*************************************************************************
% PdPd Fcc
%*************************************************************************
 ri = ri_PdH100_OC;
 index = index_PdH100_OC_1;
 [aFcce_Pd,EcFcce_Pd] = PdH_parameters('PdH000');
 aFcce = aFcce_Pd;
 rc_1 = 1.75 * aFcce_Pd;
 rc_2 = -1;
 yy = 1;
 xx = 0;
 N = 4;
 [Ec_Pd,dEda_Pd,C11_Pd,C12_Pd,C44_Pd,Bm_Pd,Ev_Pd] = ...
 fitProperties(ri,aFcce_Pd,N,index,1,yy,...
 @f_PdPd,@dfdr_PdPd,@d2fdr2_PdPd,X0_PdPd,...
 @F_Pd,@dFdrho_Pd,@d2Fdrho2_Pd,X1_PdPd,...
 @phi_PdPd,@dphidr_PdPd,@d2phidr2_PdPd,X2_PdPd,rc_1,...
 2,xx,@f_HH,@dfdr_HH,@d2fdr2_HH,X0_HH,...
 @phi_PdH,@dphidr_PdH,@d2phidr2_PdH,X4_PdH,rc_2);
%*************************************************************************
% HH Fcc
%*************************************************************************
 ri = ri_PdH100_OC;
 index = index_PdH100_OC_1;
 aFcce_H = 3.38;
 rc_1 = 1.75 * aFcce_H;
 rc_2 = -1;
 N = 4;
 [Ec_H,dEda_H,C11_H,C12_H,C44_H,Bm_H] = fitProperties(ri,aFcce_H,...
 N,index,1,1,@f_HH,@dfdr_HH,@d2fdr2_HH,X0_HH,...
 @F_H,@dFdrho_H,@d2Fdrho2_H,X22_HH,...
 @phi_HH,@dphidr_HH,@d2phidr2_HH,X22_HH,rc_1,...
 2,0,@f_PdPd,@dfdr_PdPd,@d2fdr2_PdPd,X0_PdPd,...
 @phi_PdH,@dphidr_PdH,@d2phidr2_PdH,X4_PdH,rc_2);
 % Relationship between c' and bulk modulus with C11 and C12
 % for PdH 0.75 tetrahedral structure
 Cpr_H = (C11_H - C12_H)/2;
 Bm_H = (C11_H + 2*C12_H)/3;
 %
 d8 = 1000 * (Ec_H + EcFcce_H)^2;
 d9 = 1 * (C44_H - C44e_H)^2;
 d10 = 1000 * (dEda_H)^2;
 %
 if (Bm_H > Bme_H)
 d11 = 0;
 else
 d11 = 1 * (Bm_H - Bme_H)^2;
 end
 d12 = 1 * (Cpr_H - Cpre_H)^2;
%*************************************************************************
% PdH100 Fcc
%*************************************************************************
 [aFcce_PdH,Ece_PdH100] = PdH_parameters('PdH100');
 ri = ri_PdH100_OC;
 index = index_PdH100_OC_1;
 aFcce = aFcce_PdH;
 rc_1 = 1.75 * 3.89;
 rc_2 = 1.75 * 3.38;
 yy = 1;
 xx = 1;
 N = 4 * (yy+xx);
 [Ec_Pd_12,dEda_Pd_12,C11_Pd_12,C12_Pd_12,C44_Pd_12,Bm_Pd_12] =...
 fitProperties(ri,aFcce,N,index,1,yy,...
 @f_PdPd,@dfdr_PdPd,@d2fdr2_PdPd,X0_PdPd,...
 @F_Pd,@dFdrho_Pd,@d2Fdrho2_Pd,X1_PdPd,...
 @phi_PdPd,@dphidr_PdPd,@d2phidr2_PdPd,X2_PdPd,rc_1,...
 2,xx,@f_HH,@dfdr_HH,@d2fdr2_HH,X0_HH,...
 @phi_PdH,@dphidr_PdH,@d2phidr2_PdH,X4_PdH,rc_2);
 % Cohesive energy and its derivative for PdH 0.25 octahedral structure
 [Ec_H_12,dEda_H_12,C11_H_12,C12_H_12,C44_H_12,Bm_H_12] = ...
 fitProperties(ri,aFcce,N,index,1,xx,...
 @f_HH,@dfdr_HH,@d2fdr2_HH,X0_HH,...
 @F_H,@dFdrho_H,@d2Fdrho2_H,X22_HH,...
 @phi_HH,@dphidr_HH,@d2phidr2_HH,X22_HH,rc_2,...
 2,yy,@f_PdPd,@dfdr_PdPd,@d2fdr2_PdPd,X0_PdPd,...
 @phi_PdH,@dphidr_PdH,@d2phidr2_PdH,X4_PdH,rc_2);
 % Elastic constants and bulk modulus for PdH 0.25 octahedral structure
 Ec_PdH100 = (yy * Ec_Pd_12 + xx * Ec_H_12)/(yy + xx);
 dEda_PdH100 = (yy * dEda_Pd_12 + xx * dEda_H_12)/(yy + xx);
 
% Elastic constants and bulk modulus for PdH 0.25 octahedral structure
 C11_PdH100 = (yy * C11_Pd_12 + xx * C11_H_12)/(yy + xx);
 C12_PdH100 = (yy * C12_Pd_12 + xx * C12_H_12)/(yy + xx);
 C44_PdH100 = (yy * C44_Pd_12 + xx * C44_H_12)/(yy + xx);
 Bm_PdH100 = (yy * Bm_Pd_12 + xx * Bm_H_12 )/(yy + xx);
 % Relationship between c' and bulk modulus with C11 and C12
 % for PdH 0.25 octahedral structure
 Cpr_PdH100 = (C11_PdH100 - C12_PdH100)/2;
 Bm_PdH100 = (C11_PdH100 + 2*C12_PdH100)/3;
 %
 d16 = 1 * (Ec_PdH100 + Ece_PdH100)^2;
 d16a = 1 * (dEda_PdH100)^2;
 % Sandia Paper Page 171
 d16b = 1 * (Cpr_PdH100 - 0.1460*1.6021766208)^2;
 d16c = 1 * (C44_PdH100 - 0.3440*1.6021766208)^2;
 if (Bm_PdH100 > 1.050*1.6021766208)
 d16d = 0;
 else
 d16d = 1 * (Bm_PdH100 - 1.050*1.6021766208)^2;
 end
% d16 = 1 * (Bm_PdH100 - 1.21)^2;
%*************************************************************************
% PdH025 Fcc
%*************************************************************************
 [aFcce_PdH,Ece_PdH025] = PdH_parameters('PdH025');
 ri = ri_PdH100_OC;
 index = index_PdH100_OC_1;
 aFcce = aFcce_PdH;
 rc_1 = 1.75 * 3.89;
 rc_2 = 1.75 * 3.38;
 yy = 1;
 xx = 0.25;
 N = 4 * (yy+xx);
 [Ec_Pd_12,dEda_Pd_12,C11_Pd_12,C12_Pd_12,C44_Pd_12,Bm_Pd_12] =...
 fitProperties(ri,aFcce,N,index,1,yy,...
 @f_PdPd,@dfdr_PdPd,@d2fdr2_PdPd,X0_PdPd,...
 @F_Pd,@dFdrho_Pd,@d2Fdrho2_Pd,X1_PdPd,...
 @phi_PdPd,@dphidr_PdPd,@d2phidr2_PdPd,X2_PdPd,rc_1,...
 2,xx,@f_HH,@dfdr_HH,@d2fdr2_HH,X0_HH,...
 @phi_PdH,@dphidr_PdH,@d2phidr2_PdH,X4_PdH,rc_2);
 
%
 [Ec_H_12,dEda_H_12,C11_H_12,C12_H_12,C44_H_12,Bm_H_12] = ...
 fitProperties(ri,aFcce,N,index,1,xx,...
 @f_HH,@dfdr_HH,@d2fdr2_HH,X0_HH,...
 @F_H,@dFdrho_H,@d2Fdrho2_H,X22_HH,...
 @phi_HH,@dphidr_HH,@d2phidr2_HH,X22_HH,rc_2,...
2,yy,@f_PdPd,@dfdr_PdPd,@d2fdr2_PdPd,X0_PdPd,...
 @phi_PdH,@dphidr_PdH,@d2phidr2_PdH,X4_PdH,rc_2);
 % Cohesive energy and its derivative for PdH 0.25 octahedral structure
 Ec_PdH025 = (yy * Ec_Pd_12 + xx * Ec_H_12)/(yy + xx);
 dEda_PdH025 = (yy * dEda_Pd_12 + xx * dEda_H_12)/(yy + xx);
 % Elastic constants and bulk modulus for PdH 0.25 octahedral structure
 C11_PdH025 = (yy * C11_Pd_12 + xx * C11_H_12)/(yy + xx);
 C12_PdH025 = (yy * C12_Pd_12 + xx * C12_H_12)/(yy + xx);
 C44_PdH025 = (yy * C44_Pd_12 + xx * C44_H_12)/(yy + xx);
 Bm_PdH025 = (yy * Bm_Pd_12 + xx * Bm_H_12 )/(yy + xx);
 % Relationship between c' and bulk modulus with C11 and C12
 % for PdH 0.25 octahedral structure
 Cpr_PdH025 = (C11_PdH025 - C12_PdH025)/2;
 Bm_PdH025 = (C11_PdH025 + 2*C12_PdH025)/3;
 X = xx/(1+xx);
 dH_mix_025 = Ec_PdH025 - 2*X*Ec_PdH100 - (1-2*X)*Ec_Pd;
 %
 d13 = 1 * (Ec_PdH025 + Ece_PdH025)^2;
 d13a = 1 * (dEda_PdH025)^2;
 % Sandia Paper Page 171
 d13b = 1 * (Cpr_PdH025 - 0.055*1.6021766208)^2;
 d13c = 1 * (C44_PdH025 - 0.459*1.6021766208)^2;
 if (Bm_PdH025 > 1.050*1.6021766208)
 d13d = 0;
 else
 d13d = 1 * (Bm_PdH025 - 1.050*1.6021766208)^2;
 end
% d13 = 1 * (Bm_PdH025 - 1.41)^2;
 d13e = 1 * (dH_mix_025 - 0.12)^2;
%*************************************************************************
% PdH050 Fcc
%*************************************************************************
 [aFcce_PdH,Ece_PdH050] = PdH_parameters('PdH050');
 ri = ri_PdH100_OC;
 index = index_PdH100_OC_1;
 aFcce = aFcce_PdH;
 yy = 1;
 xx = 0.5;
 N = 4 * (yy+xx);
 [Ec_Pd_12,dEda_Pd_12,C11_Pd_12,C12_Pd_12,C44_Pd_12,Bm_Pd_12] =...
 fitProperties(ri,aFcce,N,index,1,yy,...
 @f_PdPd,@dfdr_PdPd,@d2fdr2_PdPd,X0_PdPd,...
 @F_Pd,@dFdrho_Pd,@d2Fdrho2_Pd,X1_PdPd,...
 @phi_PdPd,@dphidr_PdPd,@d2phidr2_PdPd,X2_PdPd,rc_1,...
 2,xx,@f_HH,@dfdr_HH,@d2fdr2_HH,X0_HH,...
@phi_PdH,@dphidr_PdH,@d2phidr2_PdH,X4_PdH,rc_2);
 %
 [Ec_H_12,dEda_H_12,C11_H_12,C12_H_12,C44_H_12,Bm_H_12] = ...
 fitProperties(ri,aFcce,N,index,1,xx,...
 @f_HH,@dfdr_HH,@d2fdr2_HH,X0_HH,...
 @F_H,@dFdrho_H,@d2Fdrho2_H,X22_HH,...
 @phi_HH,@dphidr_HH,@d2phidr2_HH,X22_HH,rc_2,...
 2,yy,@f_PdPd,@dfdr_PdPd,@d2fdr2_PdPd,X0_PdPd,...
 @phi_PdH,@dphidr_PdH,@d2phidr2_PdH,X4_PdH,rc_2);
 % Cohesive energy and its derivative for PdH 0.75 octahedral structure
 Ec_PdH050 = (yy * Ec_Pd_12 + xx * Ec_H_12)/(yy + xx);
 dEda_PdH050 = (yy * dEda_Pd_12 + xx * dEda_H_12)/(yy + xx);
 % Elastic constants and bulk modulus for PdH 0.75 octahedral structure
 C11_PdH050 = (yy * C11_Pd_12 + xx * C11_H_12)/(yy + xx);
 C12_PdH050 = (yy * C12_Pd_12 + xx * C12_H_12)/(yy + xx);
 C44_PdH050 = (yy * C44_Pd_12 + xx * C44_H_12)/(yy + xx);
 Bm_PdH050 = (yy * Bm_Pd_12 + xx * Bm_H_12 )/(yy + xx);
 % Relationship between c' and bulk modulus with C11 and C12
 % for PdH 0.5 octahedral structure
 Cpr_PdH050 = (C11_PdH050 - C12_PdH050)/2;
 Bm_PdH050 = (C11_PdH050 + 2*C12_PdH050)/3;
 X = xx/(1+xx);
 dH_mix_050 = Ec_PdH050 - 2*X*Ec_PdH100 - (1-2*X)*Ec_Pd;
 %
 d14 = 1 * (Ec_PdH050 + Ece_PdH050)^2;
 d14a = (dEda_PdH050)^2;
 % Sandia Paper Page 171
 d14b = 1 * (Cpr_PdH050 - 0.135*1.6021766208)^2;
 d14c = 1 * (C44_PdH050 - 0.420*1.6021766208)^2;
 if (Bm_PdH050 > 1.050*1.6021766208)
 d14d = 0;
 else
 d14d = 1 * (Bm_PdH050 - 1.050*1.6021766208)^2;
 end
% d14 = 1 * (Bm_PdH050 - 1.27)^2;
 d14e = 1 * (dH_mix_050 - 0.02)^2;
%*************************************************************************
% PdH050 Fcc
%*************************************************************************
 [aFcce_PdH,Ece_PdH075] = PdH_parameters('PdH075');
 ri = ri_PdH100_OC;
 index = index_PdH100_OC_1;
 aFcce = aFcce_PdH;
 yy = 1;
 xx = 0.75;
N = 4 * (yy+xx);
 [Ec_Pd_12,dEda_Pd_12,C11_Pd_12,C12_Pd_12,C44_Pd_12,Bm_Pd_12] =...
 fitProperties(ri,aFcce,N,index,1,yy,...
 @f_PdPd,@dfdr_PdPd,@d2fdr2_PdPd,X0_PdPd,...
 @F_Pd,@dFdrho_Pd,@d2Fdrho2_Pd,X1_PdPd,...
 @phi_PdPd,@dphidr_PdPd,@d2phidr2_PdPd,X2_PdPd,rc_1,...
 2,xx,@f_HH,@dfdr_HH,@d2fdr2_HH,X0_HH,...
 @phi_PdH,@dphidr_PdH,@d2phidr2_PdH,X4_PdH,rc_2);
 %
 [Ec_H_12,dEda_H_12,C11_H_12,C12_H_12,C44_H_12,Bm_H_12] = ...
 fitProperties(ri,aFcce,N,index,1,xx,...
 @f_HH,@dfdr_HH,@d2fdr2_HH,X0_HH,...
 @F_H,@dFdrho_H,@d2Fdrho2_H,X22_HH,...
 @phi_HH,@dphidr_HH,@d2phidr2_HH,X22_HH,rc_2,...
 2,yy,@f_PdPd,@dfdr_PdPd,@d2fdr2_PdPd,X0_PdPd,...
 @phi_PdH,@dphidr_PdH,@d2phidr2_PdH,X4_PdH,rc_2);
 % Cohesive energy and its derivative for PdH 0.75 octahedral structure
 Ec_PdH075 = (yy * Ec_Pd_12 + xx * Ec_H_12)/(yy + xx);
 dEda_PdH075 = (yy * dEda_Pd_12 + xx * dEda_H_12)/(yy + xx);
 % Elastic constants and bulk modulus for PdH 0.75 octahedral structure
 C11_PdH075 = (yy * C11_Pd_12 + xx * C11_H_12)/(yy + xx);
 C12_PdH075 = (yy * C12_Pd_12 + xx * C12_H_12)/(yy + xx);
 C44_PdH075 = (yy * C44_Pd_12 + xx * C44_H_12)/(yy + xx);
 Bm_PdH075 = (yy * Bm_Pd_12 + xx * Bm_H_12 )/(yy + xx);
 % Relationship between c' and bulk modulus with C11 and C12
 % for PdH 0.75 octahedral structure
 Cpr_PdH075 = (C11_PdH075 - C12_PdH075)/2;
 Bm_PdH075 = (C11_PdH075 + 2*C12_PdH075)/3;
 X = xx/(1+xx);
 dH_mix_075 = Ec_PdH075 - 2*X*Ec_PdH100 - (1-2*X)*Ec_Pd;
 
 %
 d15 = 1 * (Ec_PdH075 + Ece_PdH075)^2;
 d15a = (dEda_PdH075)^2;
 % Sandia Paper Page 171
 d15b = 1 * (Cpr_PdH075 - 0.164*1.6021766208)^2;
 d15c = 1 * (C44_PdH075 - 0.382*1.6021766208)^2;
 if (Bm_PdH075 > 1.050*1.6021766208)
 d15d = 0;
 else
 d15d = 1 * (Bm_PdH075 - 1.050*1.6021766208)^2;
 end
% d15 = 1 * (Bm_PdH075 - 1.24)^2;
 d15e = 1 * (dH_mix_075 - (-0.08))^2;
%*************************************************************************
%PdH0.25H0.25 TE
%*************************************************************************
 [aFcce_PdH,Ece_PdHT50] = PdH_parameters('PdHT50');
 ri = ri_PdH200_TE;
 index_1 = index_PdH200_TE_1;
 index_2 = index_PdH200_TE_2;
 aFcce = aFcce_PdH;
 yy = 1.0;
 xx = 0.25;
 N = 4*(yy + 2*xx);
 [Ec_Pd_12,dEda_Pd_12,C11_Pd_12,C12_Pd_12,C44_Pd_12,Bm_Pd_12] =...
 fitProperties(ri,aFcce,N,index_1,1,yy,...
 @f_PdPd,@dfdr_PdPd,@d2fdr2_PdPd,X0_PdPd,...
 @F_Pd,@dFdrho_Pd,@d2Fdrho2_Pd,X1_PdPd,...
 @phi_PdPd,@dphidr_PdPd,@d2phidr2_PdPd,X2_PdPd,rc_1,...
 2,xx,@f_HH,@dfdr_HH,@d2fdr2_HH,X0_HH,...
 @phi_PdH,@dphidr_PdH,@d2phidr2_PdH,X4_PdH,rc_2);
 %
 [Ec_H_12,dEda_H_12,C11_H_12,C12_H_12,C44_H_12,Bm_H_12] = ...
 fitProperties(ri,aFcce,N,index_2,2,xx,...
 @f_HH,@dfdr_HH,@d2fdr2_HH,X0_HH,...
 @F_H,@dFdrho_H,@d2Fdrho2_H,X22_HH,...
 @phi_HH,@dphidr_HH,@d2phidr2_HH,X22_HH,rc_2,...
 1,yy,@f_PdPd,@dfdr_PdPd,@d2fdr2_PdPd,X0_PdPd,...
 @phi_PdH,@dphidr_PdH,@d2phidr2_PdH,X4_PdH,rc_2);
 % Cohesive energy and its derivative for PdH 0.5 tetrahedral structure
 Ec_PdHT50 = (yy * Ec_Pd_12 + 2*xx * Ec_H_12)/(yy + 2*xx);
 dEda_PdHT50 = (yy * dEda_Pd_12 + 2*xx * dEda_H_12)/(yy + 2*xx);
 % Elastic constants and bulk modulus for PdH 0.5 tetrahedral structure
 C11_PdHT50 = (yy * C11_Pd_12 + 2*xx * C11_H_12)/(yy + 2*xx);
 C12_PdHT50 = (yy * C12_Pd_12 + 2*xx * C12_H_12)/(yy + 2*xx);
 C44_PdHT50 = (yy * C44_Pd_12 + 2*xx * C44_H_12)/(yy + 2*xx);
 Bm_PdHT50 = (yy * Bm_Pd_12 + 2*xx * Bm_H_12 )/(yy + 2*xx);
 % Relationship between c' and bulk modulus with C11 and C12 for
 % PdH 0.5 tetrahedral structure
 Cpr_PdHT50 = (C11_PdHT50 - C12_PdHT50)/2;
 Bm_PdHT50 = (C11_PdHT50 + 2*C12_PdHT50)/3;
 %
 if (Ec_PdHT50 > -Ece_PdHT50)
 d17 = 0;
 else
 d17 = 1 * (Ec_PdHT50 + Ece_PdHT50)^2;
 end
 d17a = 1 * (dEda_PdHT50)^2;
 % Sandia Paper Page 171
 d17b = 1 * (Cpr_PdHT50 - 0.163*1.6021766208)^2;
 d17c = 1 * (C44_PdHT50 - 0.381*1.6021766208)^2;
 d17d = 1 * (Bm_PdHT50 - 1.050*1.6021766208)^2;
%*************************************************************************
%PdH0.375H0.375 TE
%*************************************************************************
 [aFcce_PdH,Ece_PdHT75] = PdH_parameters('PdHT75');
 ri = ri_PdH200_TE;
 index_1 = index_PdH200_TE_1;
 index_2 = index_PdH200_TE_2;
 aFcce = aFcce_PdH;
 yy = 1.0;
 xx = 0.375;
 N = 4*(yy + 2*xx);
 [Ec_Pd_12,dEda_Pd_12,C11_Pd_12,C12_Pd_12,C44_Pd_12,Bm_Pd_12] =...
 fitProperties(ri,aFcce,N,index_1,1,yy,...
 @f_PdPd,@dfdr_PdPd,@d2fdr2_PdPd,X0_PdPd,...
 @F_Pd,@dFdrho_Pd,@d2Fdrho2_Pd,X1_PdPd,...
 @phi_PdPd,@dphidr_PdPd,@d2phidr2_PdPd,X2_PdPd,rc_1,...
 2,xx,@f_HH,@dfdr_HH,@d2fdr2_HH,X0_HH,...
 @phi_PdH,@dphidr_PdH,@d2phidr2_PdH,X4_PdH,rc_2);
 
%
 [Ec_H_12,dEda_H_12,C11_H_12,C12_H_12,C44_H_12,Bm_H_12] = ...
 fitProperties(ri,aFcce,N,index_2,2,xx,...
 @f_HH,@dfdr_HH,@d2fdr2_HH,X0_HH,...
 @F_H,@dFdrho_H,@d2Fdrho2_H,X22_HH,...
 @phi_HH,@dphidr_HH,@d2phidr2_HH,X22_HH,rc_2,...
 1,yy,@f_PdPd,@dfdr_PdPd,@d2fdr2_PdPd,X0_PdPd,...
 @phi_PdH,@dphidr_PdH,@d2phidr2_PdH,X4_PdH,rc_2);
 % Cohesive energy and its derivative for PdH 0.75 tetrahedral structure
 Ec_PdHT75 = (yy * Ec_Pd_12 + 2*xx * Ec_H_12)/(yy + 2*xx);
 dEda_PdHT75 = (yy * dEda_Pd_12 + 2*xx * dEda_H_12)/(yy + 2*xx);
 % Elastic constants and bulk modulus for PdH 0.75 tetrahedral structure
 C11_PdHT75 = (yy * C11_Pd_12 + 2*xx * C11_H_12)/(yy + 2*xx);
 C12_PdHT75 = (yy * C12_Pd_12 + 2*xx * C12_H_12)/(yy + 2*xx);
 C44_PdHT75 = (yy * C44_Pd_12 + 2*xx * C44_H_12)/(yy + 2*xx);
 Bm_PdHT75 = (yy * Bm_Pd_12 + 2*xx * Bm_H_12 )/(yy + 2*xx);
 % Relationship between c' and bulk modulus with C11 and C12
 Cpr_PdHT75 = (C11_PdHT75 - C12_PdHT75)/2;
 Bm_PdHT75 = (C11_PdHT75 + 2*C12_PdHT75)/3;
 %
 if (Ec_PdHT75 > -Ece_PdHT75)
 d18 = 0;
 else
 d18 = 1 * (Ec_PdHT75 + Ece_PdHT75)^2;
 end
 d18a = 1 * (dEda_PdHT75)^2;
 % Sandia Paper Page 171
 d18b = 1 * (Cpr_PdHT75 - 0.163*1.6021766208)^2;
 d18c = 1 * (C44_PdHT75 - 0.381*1.6021766208)^2;
 d18d = 1 * (Bm_PdHT75 - 1.050*1.6021766208)^2;
%**************************************************************************
% Minimize Error
%**************************************************************************
f = sqrt( d8 + d9 + d10 + d11 + d12 + ...
 d13 + d14 + d15 + d16 + ...
 d17 + d18 + ...
 d13a + d13b + d13c + d13d + d13e + ...
 d14a + d14b + d14c + d14d + d14e + ...
 d15a + d15b + d15c + d15d + d15e + ...
 d16a + d16b + d16c + d16d + ...
 d17a + d17b + d17c + d17d + ...
 d18b + d18c + d18d)
end
%************************************************************************
%
%************************************************************************
function [Ec_,dEda_]= fitProperties_1(r,a,N,index,t1,y,f_11,dfdr_11,d2fdr2_11,X0,...
 F,dFdrho,d2Fdrho2,X1,phi_11,dphidr_11,d2phidr2_11,X2,rc_1,...
 t2,x,f_22,dfdr_22,d2fdr2_22,X3,phi_12,dphidr_12,d2phidr2_12,X4,rc_2)
 Ec_ = Ec(r,a,index,t1,y,f_11,X0,F,X1,phi_11,X2,rc_1,t2,x,f_22,X3,phi_12,X4,rc_2);
 dEda_ = dEda(r,a,index,t1,y,f_11,dfdr_11,X0,dFdrho,X1,dphidr_11,X2,rc_1,...
 t2,x,f_22,dfdr_22,X3,dphidr_12,X4,rc_2);
end
%************************************************************************
% Property Functions Used In Parameters Fitting
%************************************************************************
function [Ec_,dEda_,C11,C12,C44,Bm_,Ev_] = fitProperties(r,a,N,index,...
 t1,y,f_11,dfdr_11,d2fdr2_11,X0,F,dFdrho,d2Fdrho2,X1,phi_11,...
 dphidr_11,d2phidr2_11,X2,rc_1,t2,x,f_22,dfdr_22,d2fdr2_22,X3,...
 phi_12,dphidr_12,d2phidr2_12,X4,rc_2)
 % Cohesive Energy
 Ec_ = Ec(r,a,index,t1,y,f_11,X0,F,X1,phi_11,X2,rc_1,t2,x,f_22,X3,...
 phi_12,X4,rc_2);
 % First Derivative of Ec with respect to a
 dEda_ = dEda(r,a,index,t1,y,f_11,dfdr_11,X0,dFdrho,X1,dphidr_11,X2,...
 rc_1,t2,x,f_22,dfdr_22,X3,dphidr_12,X4,rc_2);
 % C11 Elastic Constant
 C11 = Cijkl(1,1,1,1,r,a,N,index,t1,y,f_11,dfdr_11,d2fdr2_11,X0,...
 dFdrho,d2Fdrho2,X1,dphidr_11,d2phidr2_11,X2,rc_1,...
 t2,x,f_22,dfdr_22,d2fdr2_22,X3,dphidr_12,d2phidr2_12,X4,rc_2);
 % C12 Elastic Constant
 C12 = Cijkl(1,1,2,2,r,a,N,index,t1,y,f_11,dfdr_11,d2fdr2_11,X0,...
 dFdrho,d2Fdrho2,X1,dphidr_11,d2phidr2_11,X2,rc_1,...
 t2,x,f_22,dfdr_22,d2fdr2_22,X3,dphidr_12,d2phidr2_12,X4,rc_2);
 % C44 Elastic Constant
 C44 = Cijkl(2,3,2,3,r,a,N,index,t1,y,f_11,dfdr_11,d2fdr2_11,X0,...
 dFdrho,d2Fdrho2,X1,dphidr_11,d2phidr2_11,X2,rc_1,...
 t2,x,f_22,dfdr_22,d2fdr2_22,X3,dphidr_12,d2phidr2_12,X4,rc_2);
 % Bulk Modulus
 Bm_ = Bm(r,a,N,index,t1,y,f_11,dfdr_11,d2fdr2_11,X0,...
 dFdrho,d2Fdrho2,X1,d2phidr2_11,X2,rc_1,t2,x,f_22,dfdr_22,...
 d2fdr2_22,X3,d2phidr2_12,X4,rc_2);
 % Vacancy Formation
 Ev_ = 0;
 % Ev_ = Ev(index,t1,a,phi_11,X2,f_11,X0,F,X1,r,rc_1);
end
%************************************************************************
% Cohesive Energy for Interstitial Solid Solution
%************************************************************************
function f = Ec(ri,a,index,t1,y,f_11,X0,F_11,X1,phi_11,X2,rc_1,t2,x,...
 f_22,X3,phi_12,X4,rc_2)
 %
 Rho_12 = 0;
 Phi_12 = 0;
 %
 Rho_11 = y * Rho(index,t1,ri,a,rc_1,f_11,X0);
 Phi_11 = y * Phi(index,t1,ri,a,rc_1,phi_11,X2);
 %
 if nargin == 19
 Rho_12 = x * Rho(index,t2,ri,a,rc_2,f_22,X3);
 Phi_12 = x * Phi(index,t2,ri,a,rc_2,phi_12,X4);
 end
 %
 Rho_1 = Rho_11 + Rho_12;
 F_1 = F_11(Rho_1,X1);
 f = F_1 + 0.5 * Phi_11 + 0.5 * Phi_12;
end
%**************************************************************************
% Elestic Constants for an Interstitial Solid Solution
%**************************************************************************
function f = Cijkl(i,j,k,l,r,a,N,index,t1,y,f_11,dfdr_11,d2fdr2_11,X0,...
 dFdrho,d2Fdrho2,X1,dphidr_11,d2phidr2_11,X2,rc_1,t2,...
 x,f_22,dfdr_22,d2fdr2_22,X3,dphidr_12,d2phidr2_12,X4,rc_2)
 %
 Rho_12 = 0;
 Vij_12 = 0;
 Vkl_12 = 0;
 Wijkl_12 = 0;
 Bijkl_12 = 0;
 %
 Rho_11 = y * Rho(index,t1,r,a,rc_1,f_11,X0);
 Vij_11 = y * Vij(index,t1,r,a,rc_1,dfdr_11,X0,i,j,0,0);
 Vkl_11 = y * Vij(index,t1,r,a,rc_1,dfdr_11,X0,0,0,k,l);
 Wijkl_11 = y * Wijkl(index,t1,r,a,rc_1,dfdr_11,d2fdr2_11,X0,i,j,k,l);
 Bijkl_11 = y * Bijkl(index,t1,r,a,rc_1,dphidr_11,d2phidr2_11,X2,i,j,k,l);
 %
 if nargin == 31
 Rho_12 = x * Rho(index,t2,r,a,rc_2,f_22,X3);
 Vij_12 = x * Vij(index,t2,r,a,rc_2,dfdr_22,X3,i,j,0,0);
 Vkl_12 = x * Vij(index,t2,r,a,rc_2,dfdr_22,X3,0,0,k,l);
 Wijkl_12 = x * Wijkl(index,t2,r,a,rc_2,dfdr_22,d2fdr2_22,X3,i,j,k,l);
 Bijkl_12 = x * Bijkl(index,t2,r,a,rc_2,dphidr_12,d2phidr2_12,X4,i,j,k,l);
 end
 Rho_1 = Rho_11 + Rho_12;
 dFdrho_1 = dFdrho(Rho_1,X1);
 d2Fdrho2_1 = d2Fdrho2(Rho_1,X1);
 % Elastic constants Cijkl
 V = (a^3)/N;
 Cijkl = (1/V)*( d2Fdrho2_1*(Vij_11 + Vij_12)*(Vkl_11 + Vkl_12) +...
 dFdrho_1*(Wijkl_11 + Wijkl_12) + Bijkl_11 + Bijkl_12 );
 f = Cijkl * 1.602176462;
end
%************************************************************************
% Stress for an Interstitial solid solution
%************************************************************************
function f = S(i,j,r,a,N,index,t1,y,f_11,dfdr_11,X0,dFdrho,X1,dphidr_11,X2,rc_1,...
 t2,x,f_22,dfdr_22,X3,dphidr_12,X4,rc_2)
 Rho_12 = 0;
 Vij_12 = 0;
 Aij_12 = 0;
 %
 Rho_11 = y * Rho(index,t1,r,a,rc_1,f_11,X0);
 Vij_11 = y * Vij(index,t1,r,a,rc_1,dfdr_11,X0,i,j,0,0);
 Aij_11 = y * Aij(index,t1,r,a,rc_1,dphidr_11,X2,i,j,0,0);
 if nargin == 24
 Rho_12 = x * Rho(index,t2,r,a,rc_2,f_22,X3);
 Vij_12 = x * Vij(index,t2,r,a,rc_2,dfdr_22,X3,i,j,0,0);
 Aij_12 = x * Aij(index,t2,r,a,rc_2,dphidr_12,X4,i,j,0,0);
 end
 Rho_1 = Rho_11 + Rho_12;
 dFdrho_1 = dFdrho(Rho_1,X1);
 V = (a^3)/N;
 f = (1/V) * (Aij_11 + Aij_12 + dFdrho_1 * (Vij_11 + Vij_12));
end
%**************************************************************************
% First derivative of Cohesive Energy with respect to a for an
% Interstitial solid solution
%**************************************************************************
function f = dEda(ri,a,index,t1,y,f_11,dfdr_11,X0,dFdrho,X1,dphidr_11,X2,rc_1,...
 t2,x,f_22,dfdr_22,X3,dphidr_12,X4,rc_2)
 %
 Rho_12 = 0;
 dRhoda_12 = 0;
 dPhida_12 = 0;
 %
 Rho_11 = y * Rho(index,t1,ri,a,rc_1,f_11,X0);
 dRhoda_11 = y * dRhoda(index,t1,ri,a,rc_1,dfdr_11,X0);
 dPhida_11 = y * dPhida(index,t1,ri,a,rc_1,dphidr_11,X2);
 %
 if nargin == 21
 Rho_12 = x * Rho(index,t2,ri,a,rc_2,f_22,X3);
 dRhoda_12 = x * dRhoda(index,t2,ri,a,rc_2,dfdr_22,X3);
 dPhida_12 = x * dPhida(index,t2,ri,a,rc_2,dphidr_12,X4);
 end
 %
 Rho_1 = Rho_11 + Rho_12;
 dRhoda_1 = dRhoda_11 + dRhoda_12;
 dFda_1 = dFda(dFdrho,Rho_1,dRhoda_1,X1);
 f = dFda_1 + 0.5 * dPhida_11 + 0.5 * dPhida_12;
end
%************************************************************************
% Second derivative of Cohesive Energy with respect to a for Interstitial
% Solid Solution
%************************************************************************
function f = d2Eda2(ri,a,index,t1,y,f_11,dfdr_11,d2fdr2_11,X0,...
 dFdrho,d2Fdrho2,X1,d2phidr2_11,X2,rc_1,t2,x,...
 f_22,dfdr_22,d2fdr2_22,X3,d2phidr2_12,X4,rc_2)
 %
 Rho_12 = 0;
 dRhoda_12 = 0;
 d2Rhoda2_12 = 0;
 d2Phida2_12 = 0;
 %
 Rho_11 = y * Rho(index,t1,ri,a,rc_1,f_11,X0);
 dRhoda_11 = y * dRhoda(index,t1,ri,a,rc_1,dfdr_11,X0);
 d2Rhoda2_11 = y * d2Rhoda2(index,t1,ri,a,rc_1,d2fdr2_11,X0);
 d2Phida2_11 = y * d2Phida2(index,t1,ri,a,rc_1,d2phidr2_11,X2);
 %
 if nargin == 24
 Rho_12 = x * Rho(index,t2,ri,a,rc_2,f_22,X3);
 dRhoda_12 = x * dRhoda(index,t2,ri,a,rc_2,dfdr_22,X3);
 d2Rhoda2_12 = x * d2Rhoda2(index,t2,ri,a,rc_2,d2fdr2_22,X3);
 d2Phida2_12 = x * d2Phida2(index,t2,ri,a,rc_2,d2phidr2_12,X4);
 end
 Rho_1 = Rho_11 + Rho_12;
 dRhoda_1 = dRhoda_11 + dRhoda_12;
 d2Rhoda2_1 = d2Rhoda2_11 + d2Rhoda2_12;
 d2Fda2_1 = d2Fda2(dFdrho,d2Fdrho2,Rho_1,dRhoda_1,d2Rhoda2_1,X1);
 f = d2Fda2_1 + 0.5 * d2Phida2_11 + 0.5 * d2Phida2_12;
end
%************************************************************************
% Bulk modulous
%************************************************************************
function f = Bm(ri,a,N,index,t1,y,f_11,dfdr_11,d2fdr2_11,X0,...
 dFdrho,d2Fdrho2,X1,d2phidr2_11,X2,rc_1,t2,x,f_22,...
 dfdr_22,d2fdr2_22,X3,d2phidr2_12,X4,rc_2)
 d2Eda2_ = 0;
 %
 if nargin == 16
 d2Eda2_ = d2Eda2(ri,a,index,t1,y,f_11,dfdr_11,d2fdr2_11,X0,...
 dFdrho,d2Fdrho2,X1,d2phidr2_11,X2,rc_1);
 end
 if nargin == 25
 d2Eda2_ = d2Eda2(ri,a,index,t1,y,f_11,dfdr_11,d2fdr2_11,X0,...
 dFdrho,d2Fdrho2,X1,d2phidr2_11,X2,rc_1,t2,x,f_22,...
 dfdr_22,d2fdr2_22,X3,d2phidr2_12,X4,rc_2);
 end
 V = a^3/N;
 f = ((a)^2/(9.0*V))*d2Eda2_;
 f = f * 1.602176462;
end
%************************************************************************
% Vacancy formation Energy
%************************************************************************
function f = Ev(index,type,a,phi,X0,f,X1,F,X2,rij,rc)
 sum0 = 0;
 sum1 = 0;
 sum2 = 0;
 rho = Rho(index,type,rij,a,rc,f,X1);
 n = length(rij(:,1));
 for i = 1:n
 id = rij(i,1);
 if i ~= index && id == type
 l1 = (a/2)*rij(i,2);
 l2 = (a/2)*rij(i,3);
 l3 = (a/2)*rij(i,4);
 ri = sqrt(l1^2+l2^2+l3^2);
 if ri <= rc
 q0 = phi(ri,X0);
 f1 = f(ri,X1);
 sum0 = sum0 + q0;
 sum1 = sum1 + F(rho,X2);
 sum2 = sum2 + F(rho-f1,X2);
 end
 end
 end
 f = -0.5 * sum0 + sum2 - sum1;
end
%*************************************************************************
% The Embedding Atom Model EAM
%*************************************************************************
% Total pair potential energy for a central atom as function of interatomic
% distance
% index: array index of central atom
% type : Id of atom type
% ri : atoms position in Lattice Crystal Structure
% a : the lattice constant
% rc : the cuttof radius
% phi : the pair potential function
% X : array of pair potential parameters
function f = Phi(index,type,ri,a,rc,phi,X)
 f = Sumfunc(index,type,ri,a,rc,phi,X);
end
% Total first derivative of pair potential with respect to interatomic
% distance rij
function f = dPhidr(index,type,ri,a,rc,dphidr,X)
 f = Sumfunc(index,type,ri,a,rc,dphidr,X);
end
% Total second derivative of pair potential with respect to interatomic
% distance rij
function f = d2Phidr2(index,type,ri,a,rc,d2phidr2,X)
 f = Sumfunc(index,type,ri,a,rc,d2phidr2,X);
end
% Total first derivative of pair potential with respect to a
function f = dPhida(index,type,ri,a,rc,dphidr,X)
 f = SumfuncM(index,type,ri,a,rc,dphidr,X);
end
% Total second derivative of pair potential with respect to a
function f = d2Phida2(index,type,ri,a,rc,d2phidr2,X)
 f = SumfuncM2(index,type,ri,a,rc,d2phidr2,X);
end
% Total Electron Density for a central atom as function of interatomic
% distance
% index: array index of central atom
% type : Id of atom type
% ri : atoms position in Lattice Crystal Structure
% a : the lattice constant
% rc : the cuttof radius
% f : the atomic density function
% X : array of atomic density function parameters
function f = Rho(index,type,ri,a,rc,f,X)
 f = Sumfunc(index,type,ri,a,rc,f,X);
end
% Total first derivative of electron density with respect to interatomic
% distance rij
function f = dRhodr(index,type,ri,a,rc,dfdr,X)
 f = Sumfunc(index,type,ri,a,rc,dfdr,X);
end
% Total second derivative of electron density with respect to interatomic
% distance rij
function f = d2Rhodr2(index,type,ri,a,rc,d2fdr2,X)
 f = Sumfunc(index,type,ri,a,d2fdr2,X);
end
% Total first derivative of electron density with respect a
function f = dRhoda(index,type,ri,a,rc,dfdr,X)
 f = SumfuncM(index,type,ri,a,rc,dfdr,X);
end
% Total second derivative of electron density with respect a
function f = d2Rhoda2(index,type,ri,a,rc,d2fdr2,X)
 f = SumfuncM2(index,type,ri,a,rc,d2fdr2,X);
end
% Total first derivative of electron density with respect ri,rj,rk, and rl
function f = dRhodrij(index,type,ri,a,rc,dfdr,X,i,j,k,l)
 f = Sumfuncrijkl(index,type,ri,a,rc,dfdr,X,i,j,k,l,1);
end
% second derivative of electron density of rij
function f = d2Rhodr2ijkl(index,type,ri,a,rc,dfdr,X,i,j,k,l)
 f = Sumfuncrijkl(index,type,ri,a,rc,dfdr,X,i,j,k,l,2);
end
% First derivative of Atomic Electron Density with respect to ri
function f = dfdri(index,type,ri,a,rc,dfdr,X,i,j,k,l)
 f = Sumfuncrijkl(index,type,ri,a,rc,dfdr,X,i,j,k,l,1);
end
% First derivative of Atomic Electron Density with respect to ri,rj,rk
% and rl
function f = dfdrijkl(index,type,ri,a,rc,dfdr,X,i,j,k,l)
 f = Sumfuncrijkl(index,type,ri,a,rc,dfdr,X,i,j,k,l,3);
end
% Second derivative of Atomic Electron Density with respect to ri,rj,rk
% and rl
function f = d2fdr2ijkl(index,type,ri,a,rc,d2fdr2,X,i,j,k,l)
 f = Sumfuncrijkl(index,type,ri,a,rc,d2fdr2,X,i,j,k,l,2);
end
% First derivative of pair potential with respect to ri
function f = dphidri(index,type,ri,a,rc,dphidr,X,i,j,k,l)
 f = Sumfuncrijkl(index,type,ri,a,rc,dphidr,X,i,j,k,l,1);
end
% First derivative of pair potential with respect to ri,rj,rk and rl
function f = dPhidrijkl(index,type,ri,a,rc,dphidr,X,i,j,k,l)
 f = Sumfuncrijkl(index,type,ri,a,rc,dphidr,X,i,j,k,l,3);
end
% Second derivative of pair potential with respect to ri,rj,rk and rl
function f = d2Phidr2ijkl(index,type,ri,a,rc,d2phidr2,X,i,j,k,l)
 f = Sumfuncrijkl(index,type,ri,a,rc,d2phidr2,X,i,j,k,l,2);
end
% Function Used in the calculations of Elastic Constants at equlibrum
function f = Vij(index,type,ri,a,rc,dfdr,X,i,j,k,l)
 f = delta(i,j) * delta(k,l)*dfdri(index,type,ri,a,rc,dfdr,X,i,j,k,l);
end
% Function Used in the calculations of Elastic Constants at equlibrum
function f = Wijkl(index,type,ri,a,rc,dfdr,d2fdr2,X,i,j,k,l)
 f = d2fdr2ijkl(index,type,ri,a,rc,d2fdr2,X,i,j,k,l) - ...
 dfdrijkl(index,type,ri,a,rc,dfdr,X,i,j,k,l)+ ...
 delta(i,l) * dfdri(index,type,ri,a,rc,dfdr,X,0,0,k,l);
end
% Function Used in the calculations of Elastic Constants at equlibrum
function f = Bijkl(index,type,ri,a,rc,dphidr,d2phidr2,X,i,j,k,l)
 f = d2Phidr2ijkl(index,type,ri,a,rc,d2phidr2,X,i,j,k,l) - ...
 dPhidrijkl(index,type,ri,a,rc,dphidr,X,i,j,k,l)+ ...
 delta(i,l) * dphidri(index,type,ri,a,rc,dphidr,X,0,0,k,l);
 f = 0.5 * f;
end
%**************************************************************************
% Park Hijazi Pd EAM Potential and Derivatives
%**************************************************************************
% Pd Embedding Energy Function as a function of electron density
function f = F_Pd(rho,X)
 Fe = X(1);
 rhoe = X(2);
 n = X(3);
 f = -Fe*(1-n*log(rho/rhoe))*(rho/rhoe)^n;
end
% First derivative of Pd Embedding Energy Function with respect to
% electron density
function f = dFdrho_Pd(rho,X)
 Fe = X(1);
 rhoe = X(2);
 n = X(3);
 F = F_Pd(rho,X);
 f = (Fe*n/rho)*(rho/rhoe)^n+(n/rhoe)*F*(rho/rhoe)^(-1);
end
% Second derivative of Pd Embedding Energy Function with respect to
% electron density
function f = d2Fdrho2_Pd(rho,X)
 Fe = X(1);
 rhoe = X(2);
 n = X(3);
 F = F_Pd(rho,X);
 dF = dFdrho_Pd(rho,X);
 f = -(n/rho^2)*Fe*(rho/rhoe)^n+(n^2/rho)*(1/rhoe)*Fe*(rho/rhoe)^(n-1)+...
 (n/rhoe)*dF*(rho/rhoe)^(-1)-(n/rhoe^2)*F*(rho/rhoe)^(-2);
end
% First derivative of Pd Embedding Energy Function with respect to rij
function f = dFdr(dFdrho,rho,dRhodr,X)
 f = dFdrho(rho,X) * dRhodr;
end
% Second derivative of Pd Embedding Energy Function with respect to rij
function f = d2Fdr2(dFdrho,d2Fdrho2,rho,dRhodr,d2Rhodr2,X)
 f = d2Fdrho2(rho,X) * dRhodr^2 + dFdrho(rho,X) * d2Rhodr2;
end
% First derivative of Pd Embedding Energy Function with respect to a
function f = dFda(dFdrho,rho,dRhoda,X)
 f = dFdrho(rho,X) * dRhoda;
end
% Second derivative of Pd Embedding Energy Function with respect to a
function f = d2Fda2(dFdrho,d2Fdrho2,rho,dRhoda,d2Rhoda2,X)
 f = d2Fdrho2(rho,X) * dRhoda^2 + dFdrho(rho,X) * d2Rhoda2;
end
% Pd Atomic Electron Density as a function of interatomic distance rij
function f = f_PdPd(rij,X)
 fe = X(1);
 Xi = X(2);
 re = X(3);
 f = fe*exp(-Xi*(rij-re));
end
% First derivative Pd Atomic Electron Density function with respect to rij
function f = dfdr_PdPd(rij,X)
 fe = X(1);
 Xi = X(2);
 re = X(3);
 f = -fe*Xi*exp(-Xi*(rij-re));
end
% First derivative Pd Atomic Electron Density function with respect to rij
function f = d2fdr2_PdPd(rij,X)
 fe = X(1);
 Xi = X(2);
 re = X(3);
 f = fe*Xi^2*exp(-Xi*(rij-re));
end
% Pd-Pd pair potential as a function of interatomic distance rij
function f = phi_PdPd(rij,X)
 phie = X(1);
 S = X(2);
 B = X(3);
 re = X(4);
 f = -phie*(1+S*(rij/re-1))*exp(-B*(rij/re-1));
end
% First derivative of Pd-Pd pair potential with respect to rij
function f = dphidr_PdPd(r,X)
 phie = X(1);
 S = X(2);
 B = X(3);
 re = X(4);
 f = (-1/re)*(phie*S*exp(-B*(r/re-1))+B*phi_PdPd(r,X));
end
% Second derivative of Pd-Pd pair potential with respect to rij
function f = d2phidr2_PdPd(r,X)
 phie = X(1);
 S = X(2);
 B = X(3);
 re = X(4);
 f = (B/re)*((phie*S/re)*exp(-B*(r/re-1))-dphidr_PdPd(r,X));
end
%**************************************************************************
% Hydrogen EAM Potential and Derivatives
%**************************************************************************
% H-H unnormalized pair potential as a function of interatomic distance rij
function f = phi_HH_u(rij,X)
 DHH = X(1);
 alphaHH = X(2);
 betaHH = X(3);
 r0HH = X(4);
 f = DHH*(betaHH*exp(-alphaHH*(rij-r0HH)) - ...
 alphaHH*exp(-betaHH*(rij-r0HH)));
end
% First derivative of H-H unnormalized pair potential with respect to rij
function f = dphidr_HH_u(r,X)
 DHH = X(1);
 alphaHH = X(2);
 betaHH = X(3);
 r0HH = X(4);
 f = DHH*( -alphaHH * betaHH*exp(-alphaHH*(r-r0HH)) +...
 betaHH*alphaHH*exp(-betaHH*(r-r0HH)) );
end
% Secon derivative of H-H unnormalized pair potential with respect to rij
function f = d2phidr2_HH_u(r,X)
 DHH = X(1);
 alphaHH = X(2);
 betaHH = X(3);
 r0HH = X(4);
 f = DHH*( (alphaHH^2) * betaHH*exp(-alphaHH*(r-r0HH)) - ...
 (betaHH^2)*alphaHH*exp(-betaHH*(r-r0HH)) );
end
% H-H normalized pair potential as a function of interatomic distance rij
function f = phi_HH(rij,X)
 rho0H = X(7);
 X0_HH = X(5:1:7);
 X1_HH = X(8:1:11);
 f = phi_HH_u(rij,X) + 2 * dFdrho_H_u(rho0H,X1_HH) * f_HH(rij,X0_HH);
end
% First derivative of H-H normalized pair potential with respect to rij
function f = dphidr_HH(rij,X)
 rho0H = X(7);
 X0_HH = X(5:1:7);
 X1_HH = X(8:1:11);
 f = dphidr_HH_u(rij,X) + 2 * dFdrho_H_u(rho0H,X1_HH) * ...
 dfdr_HH(rij,X0_HH);
end
% Second derivative of H-H normalized pair potential with respect to rij
function f = d2phidr2_HH(rij,X)
 rho0H = X(7);
 X0_HH = X(5:1:7);
 X1_HH = X(8:1:11);
 f = d2phidr2_HH_u(rij,X) + 2 * dFdrho_H_u(rho0H,X1_HH) * ...
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
 rho0H = X(7);
 X1_HH = X(8:1:11);
 f = F_H_u(rho,X1_HH) - dFdrho_H_u(rho0H,X1_HH) * rho;
end
% First derivative of H normalized Embedding function with respect to Rho
function f = dFdrho_H(rho,X)
 rho0H = X(7);
 X1_HH = X(8:1:11);
 f = dFdrho_H_u(rho,X1_HH) - dFdrho_H_u(rho0H,X1_HH);
end
% Second derivative of H normalized Embedding function with respect to Rho
function f = d2Fdrho2_H(rho,X)
 X1_HH = X(8:1:11);
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
 f = DPdH*( (alphaPdH^2)*betaPdH*exp(-alphaPdH*(r-r0PdH)) - ...
 (betaPdH^2)*alphaPdH*exp(-betaPdH*(r-r0PdH)) );
end
%*************************************************************************
% Summation function
%*************************************************************************
function f = Sumfunc(index,type,ri,a,rc,func,X)
 f = 0;
 cl1 = (a/2)*ri(index,2);
 cl2 = (a/2)*ri(index,3);
 cl3 = (a/2)*ri(index,4);
 n = length(ri(:,1));
 for i = 1:n
 id = ri(i,1);
 if i ~= index && id == type
 l1 = (a/2)*ri(i,2);
 l2 = (a/2)*ri(i,3);
 l3 = (a/2)*ri(i,4);
 rij = sqrt((l1-cl1)^2 + (l2-cl2)^2 + (l3-cl3)^2);
 if rij <= rc
 f = f + func(rij,X);
 end
 end
 end
end
function f = SumfuncMP(index,type,ri,a,rc,func,X,p)
 f = 0;
 cl1 = (a/2)*ri(index,2);
 cl2 = (a/2)*ri(index,3);
 cl3 = (a/2)*ri(index,4);
 n = length(ri(:,1));
 for i = 1:n
 id = ri(i,1);
 if i ~= index && id == type
 l1 = (a/2)*ri(i,2);
 l2 = (a/2)*ri(i,3);
 l3 = (a/2)*ri(i,4);
 rij = sqrt((l1-cl1)^2 + (l2-cl2)^2 + (l3-cl3)^2);
if rij <= rc
 f = f + func(rij,X) * (rij/a)^p;
 end
 end
 end
end
function f = SumfuncM(index,type,ri,a,rc,func,X)
 f = 0;
 cl1 = (a/2)*ri(index,2);
 cl2 = (a/2)*ri(index,3);
 cl3 = (a/2)*ri(index,4);
 n = length(ri(:,1));
 for i = 1:n
 id = ri(i,1);
 if i ~= index && id == type
 l1 = (a/2)*ri(i,2);
 l2 = (a/2)*ri(i,3);
 l3 = (a/2)*ri(i,4);
 rij = sqrt((l1-cl1)^2 + (l2-cl2)^2 + (l3-cl3)^2);
 if rij <= rc
 f = f + func(rij,X) * rij/a;
 end
 end
 end
end
%
function f = SumfuncM2(index,type,ri,a,rc,func,X)
 f = 0;
 cl1 = (a/2)*ri(index,2);
 cl2 = (a/2)*ri(index,3);
 cl3 = (a/2)*ri(index,4);
 n = length(ri(:,1));
 for i = 1:n
 id = ri(i,1);
 if i ~= index && id == type
 l1 = (a/2)*ri(i,2);
 l2 = (a/2)*ri(i,3);
 l3 = (a/2)*ri(i,4);
 rij = sqrt((l1-cl1)^2 + (l2-cl2)^2 + (l3-cl3)^2);
 if rij <= rc
 f = f + func(rij,X) * (rij/a)^2;
 end
 end
 end
end
%
function f = Sumfuncrijkl(index,type,r,a,rc,func,X,i,j,k,l,p)
 f = 0;
 ri = 1;
 rj = 1;
 rk = 1;
 rl = 1;
 cl(1) = (a/2)*r(index,2);
 cl(2) = (a/2)*r(index,3);
 cl(3) = (a/2)*r(index,4);
 n = length(r(:,1));
 for ii = 1:n
 id = r(ii,1);
 if ii ~= index && id == type
 l1(1) = (a/2)*r(ii,2);
 l1(2) = (a/2)*r(ii,3);
 l1(3) = (a/2)*r(ii,4);
 rij = sqrt((l1(1)-cl(1))^2 + (l1(2)-cl(2))^2 + (l1(3)-cl(3))^2);
 if rij < rc
 if i ~= 0
 ri = l1(i)-cl(i);
 end
 if j ~= 0
 rj = l1(j)-cl(j);
 end
 if k ~= 0
 rk = l1(k)-cl(k);
 end
 if l ~= 0
 rl = l1(l)-cl(l);
 end
 f = f + func(rij,X) * ri*rj*rk*rl/rij^p;
 end
 end
 end
end
%
function f = delta(i,j)
 if(i == j)
 f = 1;
 else
 f = 0;
 end
end
%*************************************************************************
% Expermental data for FCC metals
%************************************************************************
function [afcce,Ecfcce,c11e,c12e,c44e,Bme,Eve,abcce,Ecbcce,cpre]...
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
 c44 = [0.461;0.316;0.42;0.758;1.247;0.712;0.765;0.05*1.6021766208];
 cpr = [1;1;1;1;1;1;1;0.05*1.6021766208];
 Evfcc = [1.1;0.866;0.9;1.3;1.70;1.54;1.60;0.0];
 B = [1.04;0.793;1.67;1.38;1.804;1.95;2.83;0.5*1.6021766208];
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
%*************************************************************************
% Expermental and bb-initio data for PdH
%************************************************************************
function [afcce,Ecfcce,C44,Cpr,Bm] = PdH_parameters(el)
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
 a = [3.38;3.89;3.9421;4.0007;4.0593;4.1179;4.0007;4.0593];
 Ec = [2.119;3.91;3.64024;3.48770;3.37031;3.26966;3.50000;3.50000];
 % Elastic Constants
 C44 = [0.05,0.71/1.6021766208,0.459,0.42,0.382,0.3440,...
 0.3810,0.3810] * 1.6021766208;
 Cpr = [0.05,1/1.6021766208,0.055,0.135,0.164,0.146,...
 0.1630,0.1630] * 1.6021766208;
 Bm = [0.50,1.95/1.6021766208,1.025,2.125,1.05,1.775,...
 1.0,1.0] * 1.6021766208;
 afcce = a(index1);
 Ecfcce = Ec(index1);
end
