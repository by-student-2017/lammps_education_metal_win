Check_Fit.m
function Check_Fit(x,plots1,plots2)
 warning off
 format short

 % Global variables
 global ri_PdH100_OC;
 global index_PdH100_OC_1;

 global ri_PdCuH000;
 global index_PdCuH000_Pd
 global index_PdCuH000_Cu

 global a_PdCuH025_o1;
 global a_PdCuH025_o2;
 global a_PdCuH025_T;
 global a_PdCuH050_O1_O2;
 global a_PdCuH050_O2_O2;
 global a_PdCuH050_T;
 global a_PdCuH075_O1_O2_O2;
 global a_PdCuH075_O2_O2_O2;
 global a_PdCuH075_T;
 global a_PdCuH100_O1_O2_O2_O2;
 global a_PdCuH100_T;

 global Ec_exp_PdCuH000;
 global Ec_exp_PdCuH025_O1;
 global Ec_exp_PdCuH025_O2;
 global Ec_exp_PdCuH025_T;
 global Ec_exp_PdCuH050_O1_O2;
 global Ec_exp_PdCuH050_O2_O2;
 global Ec_exp_PdCuH050_T;
 global Ec_exp_PdCuH075_O1_O2_O2;
 global Ec_exp_PdCuH075_O2_O2_O2;
 global Ec_exp_PdCuH075_T;
 global Ec_exp_PdCuH100_O1_O2_O2_O2;
 global Ec_exp_PdCuH100_T;

 global a_PdCuH025_TE1
 global a_PdCuH050_TE3_TE4
 global a_PdCuH050_TE1_TE8
 global a_PdCuH075_TE1_TE2_TE3
 global a_PdCuH075_TE1_TE2_TE8
 global a_PdCuH075_TE5_TE6_TE7
 global a_PdCuH100_TE1_TE2_TE3_TE4
 global a_PdCuH100_TE1_TE2_TE7_TE8
 global a_PdCuH100_TE1_TE5_TE6_TE7

 global Ec_exp_PdCuH025_TE1
 global Ec_exp_PdCuH050_TE3_TE4
 global Ec_exp_PdCuH050_TE1_TE8
 global Ec_exp_PdCuH075_TE1_TE2_TE3
 global Ec_exp_PdCuH075_TE1_TE2_TE8
 global Ec_exp_PdCuH075_TE5_TE6_TE7
 global Ec_exp_PdCuH100_TE1_TE2_TE3_TE4
 global Ec_exp_PdCuH100_TE1_TE2_TE7_TE8
 global Ec_exp_PdCuH100_TE1_TE5_TE6_TE7

 global ri_PdCuH025_o1;
 global index_PdCuH025_o1_Pd
 global index_PdCuH025_o1_Cu
 global index_PdCuH025_o1_H

 global ri_PdCuH025_o2;
 global index_PdCuH025_o2_Pd
 global index_PdCuH025_o2_Cu
 global index_PdCuH025_o2_H

 global ri_PdCuH025_T_25_25_25;
 global index_PdCuH025_T_Pd_25_25_25
 global index_PdCuH025_T_Cu_25_25_25
 global index_PdCuH025_T_H_25_25_25

 global ri_PdCuH025_T_75_75_75;
 global index_PdCuH025_T_Pd_75_75_75
 global index_PdCuH025_T_Cu_75_75_75
 global index_PdCuH025_T_H_75_75_75

 global ri_PdCuH025_T_25_75_75;
 global index_PdCuH025_T_Pd_25_75_75
 global index_PdCuH025_T_Cu_25_75_75
 global index_PdCuH025_T_H_25_75_75

 global ri_PdCuH050_O1_O2;
 global index_PdCuH050_O1_O2_Pd
 global index_PdCuH050_O1_O2_Cu
 global index_PdCuH050_O1_O2_H_O1
 global index_PdCuH050_O1_O2_H_O2

 global ri_PdCuH050_O2_O2;
 global index_PdCuH050_O2_O2_Pd
 global index_PdCuH050_O2_O2_Cu
 global index_PdCuH050_O2_O2_H

 global ri_PdCuH075_O1_O2_O2;
 global index_PdCuH075_O1_O2_O2_Pd
 global index_PdCuH075_O1_O2_O2_Cu
 global index_PdCuH075_O1_O2_O2_H_O1
 global index_PdCuH075_O1_O2_O2_H_O2

 global ri_PdCuH075_O2_O2_O2;
 global index_PdCuH075_O2_O2_O2_Pd
 global index_PdCuH075_O2_O2_O2_Cu
 global index_PdCuH075_O2_O2_O2_H

 global ri_PdCuH075_T;
 global index_PdCuH075_T_Pd
 global index_PdCuH075_T_Cu
 global index_PdCuH075_T_H

 global ri_PdCuH100_O1_O2_O2_O2;
 global index_PdCuH100_O1_O2_O2_O2_Pd
 global index_PdCuH100_O1_O2_O2_O2_Cu
 global index_PdCuH100_O1_O2_O2_O2_H_O1
 global index_PdCuH100_O1_O2_O2_O2_H_O2

 global ri_PdCuH100_T;
 global index_PdCuH100_T_Pd
 global index_PdCuH100_T_Cu
 global index_PdCuH100_T_H

 global NP
 global NP2
 global NP3

 global x_Pd
 global x_Cu

 global S_Cu
 global S_Pd

 global x_PdH

 global rc_1
 global rc_2
 global rc_3

 % Pd Experimental data

[aFcce_Pd,EcFcce_Pd,C11e_Pd,C12e_Pd,C44e_Pd,Bme_Pd,Eve_Pd,aBcce_Pd,...
 EcBcce_Pd] = parameters('Pd');

 re = aFcce_Pd/sqrt(2);
 Fe = EcFcce_Pd-Eve_Pd;
 N = 4;
 V = aFcce_Pd^3/N;
 fe = EcFcce_Pd/V;
 fe_S = S_Pd*EcFcce_Pd/V;

 % Pd Fitting Parameters
 Xi = x_Pd(1);
 phie = x_Pd(2);
 S = x_Pd(3);
 B = x_Pd(4);
 n = x_Pd(5);
 rhoe = x_Pd(6);

 % Rho PdPd fitting parameters
 X0_PdPd = [fe,Xi,re];
 X0_PdPd_S = [fe_S,Xi,re];
 % F PdPd fitting parameters
 X1_PdPd = [Fe,rhoe,n];
 % Phi PdPd fitting parametters
 X2_PdPd = [phie,S,B,re];

 % Cu Experimental data
[aFcce_Cu,EcFcce_Cu,C11e_Cu,C12e_Cu,C44e_Cu,Bme_Cu,Eve_Cu,aBcce_Cu,...
 EcBcce_Cu] = parameters('Cu');
 re = aFcce_Cu/sqrt(2);
 Fe = EcFcce_Cu-Eve_Cu;
 N = 4;
 V = aFcce_Cu^3/N;
 fe = EcFcce_Cu/V;
 fe_S = S_Cu*EcFcce_Cu/V;

 % Cu Fitting Parameters
 Xi = x_Cu(1);
 phie = x_Cu(2);
 S = x_Cu(3);
 B = x_Cu(4);
 n = x_Cu(5);
 rhoe = x_Cu(6);

 % Rho PdPd fitting parameters
 X0_CuCu = [fe,Xi,re];
 X0_CuCu_S = [fe_S,Xi,re];
 % F PdPd fitting parameters
 X1_CuCu = [Fe,rhoe,n];
 % Phi PdPd fitting parametters
 X2_CuCu = [phie,S,B,re];

 X5_PdCu = [X0_PdPd_S X0_CuCu_S X2_PdPd X2_CuCu];

 % Phi_HH
 DHH = x_PdH(1);
 aHH = x_PdH(2);
 bHH = x_PdH(3);
 % f_HH
 CH = x_PdH(4);
 DH = x_PdH(5);
 % Phi_PdH
 DPdH = x_PdH(6);
 aPdH = x_PdH(7);
 bPdH = x_PdH(8);
 % F_H
 aH = x_PdH(9);
 bH = x_PdH(10);
 cH = x_PdH(11);
 dH = x_PdH(12);
 %
 r0PdH = x_PdH(13);
 r0HH = x_PdH(14);

 % f_HH
 X0_HH = [CH,DH];

 % rho0H calculation
 rho0H = 4.903820;

 % F HH fitting parameters
 X1_HH = [aH,bH,cH,dH,rho0H];
 % Phi HH fitting parameters
 X2_HH = [DHH,aHH,bHH,r0HH];
 X22_HH = [X2_HH,X0_HH,X1_HH];
 % Phi PdH fitting parameters
 X4_PdH = [DPdH,aPdH,bPdH,r0PdH];

 % Phi_CuH
 DCuH = x(1);
 aCuH = x(2);
 bCuH = x(3);
 r0CuH = x(4);

 % Phi CuH fitting parameters
 X4_CuH = [DCuH,aCuH,bCuH,r0CuH];

 index_Pd = index_PdCuH000_Pd;
 index_Cu = index_PdCuH000_Cu;
 a = 3.821;

 ri = ri_PdCuH000;

 XX = 1;
 YY = 1;
 ZZ = 1;

 xx = 0.75;
 yy = 0.25;

 % Pd Central
 Ec_Pd_12 = Ec3(ri,a,index_Pd,1,XX,...
 @f_PdPd,X0_PdPd,...
 @F_Pd,X1_PdPd,...
 @phi_PdPd,X2_PdPd,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdCu,X5_PdCu,rc_1);

 % Cu Central
 Ec_Cu_12 = Ec3(ri,a,index_Cu,2,YY,...
 @f_PdPd,X0_CuCu,...
 @F_Pd,X1_CuCu,...
 @phi_PdPd,X2_CuCu,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdCu,X5_PdCu,rc_1);

 Ec_Pd075Cu025H000 = ( xx * Ec_Pd_12 + yy * Ec_Cu_12 )/(xx + yy)

%***************************************************************
% For Pd075Cu025H025_O1
%***************************************************************
 ri = ri_PdCuH025_o1;
 index_Pd = index_PdCuH025_o1_Pd;
 index_Cu = index_PdCuH025_o1_Cu;
 index_H = index_PdCuH025_o1_H;
 a = a_PdCuH025_o1;

 XX = 1;
 YY = 1;
 ZZ = 1;

 xx = 0.75;
 yy = 0.25;
 zz = 0.25;

 % Pd Central
 Ec_Pd_12 = Ec3(ri,a,index_Pd,1,XX,...
 @f_PdPd,X0_PdPd,...
 @F_Pd,X1_PdPd,...
 @phi_PdPd,X2_PdPd,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_PdH,rc_1);

 % Cu Central
 Ec_Cu_12 = Ec3(ri,a,index_Cu,2,YY,...
 @f_PdPd,X0_CuCu,...
 @F_Pd,X1_CuCu,...
 @phi_PdPd,X2_CuCu,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_CuH,rc_1);

 % H Central
 Ec_H_12 = Ec3(ri,a,index_H,3,ZZ,...
 @f_HH,X0_HH,...
 @F_H,X22_HH,...
 @phi_HH,X22_HH,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdH,X4_PdH,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdH,X4_CuH,rc_1);

 Ec_Pd075Cu025H025_O1 = ( xx * Ec_Pd_12 + yy * Ec_Cu_12 + ...
 zz * Ec_H_12)/(xx + yy + zz)

%***************************************************************
% For Pd075Cu025H025_O2
%***************************************************************
 ri = ri_PdCuH025_o2;
 index_Pd = index_PdCuH025_o2_Pd;
 index_Cu = index_PdCuH025_o2_Cu;
 index_H = index_PdCuH025_o2_H;
 a = a_PdCuH025_o2;

 XX = 1;
 YY = 1;
 ZZ = 1;

 xx = 0.75;
 yy = 0.25;
 zz = 0.25;

 % Pd Central
 Ec_Pd_12 = Ec3(ri,a,index_Pd,1,XX,...
 @f_PdPd,X0_PdPd,...
 @F_Pd,X1_PdPd,...
 @phi_PdPd,X2_PdPd,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_PdH,rc_1);

 % Cu Central
 Ec_Cu_12 = Ec3(ri,a,index_Cu,2,YY,...
 @f_PdPd,X0_CuCu,...
 @F_Pd,X1_CuCu,...
 @phi_PdPd,X2_CuCu,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_CuH,rc_1);

 % H Central
 Ec_H_12 = Ec3(ri,a,index_H,3,ZZ,...
 @f_HH,X0_HH,...
 @F_H,X22_HH,...
 @phi_HH,X22_HH,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdH,X4_PdH,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdH,X4_CuH,rc_1);

 Ec_Pd075Cu025H025_O2 = ( xx * Ec_Pd_12 + yy * Ec_Cu_12 + ...
 zz * Ec_H_12)/(xx + yy + zz)

%***************************************************************
% For Pd075Cu025H025_TE1
%***************************************************************
 ri = ri_PdCuH025_T_25_25_25;
 index_Pd = index_PdCuH025_T_Pd_25_25_25;
 index_Cu = index_PdCuH025_T_Cu_25_25_25;
 index_H = index_PdCuH025_T_H_25_25_25;

 a = a_PdCuH025_T;

 XX = 1;
 YY = 1;
 ZZ = 1;

 xx = 0.75;
 yy = 0.25;
 zz = 0.25;

 % Pd Central
 Ec_Pd_12 = Ec3(ri,a,index_Pd,1,XX,...
 @f_PdPd,X0_PdPd,...
 @F_Pd,X1_PdPd,...
 @phi_PdPd,X2_PdPd,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_PdH,rc_1);

 % Cu Central
 Ec_Cu_12 = Ec3(ri,a,index_Cu,2,YY,...
 @f_PdPd,X0_CuCu,...
 @F_Pd,X1_CuCu,...
 @phi_PdPd,X2_CuCu,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_CuH,rc_1);

 % H Central
 Ec_H_12 = Ec3(ri,a,index_H,3,ZZ,...
 @f_HH,X0_HH,...
 @F_H,X22_HH,...
 @phi_HH,X22_HH,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdH,X4_PdH,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdH,X4_CuH,rc_1);

 Ec_Pd075Cu025H025_TE1 = ( xx * Ec_Pd_12 + yy * Ec_Cu_12 + ...
 zz * Ec_H_12)/(xx + yy + zz)

%***************************************************************
% For Pd075Cu025H025_TE8
%***************************************************************
 ri = ri_PdCuH025_T_75_75_75;
 index_Pd = index_PdCuH025_T_Pd_75_75_75;
 index_Cu = index_PdCuH025_T_Cu_75_75_75;
 index_H = index_PdCuH025_T_H_75_75_75;

 a = a_PdCuH025_T;

 XX = 1;
 YY = 1;
 ZZ = 1;

 xx = 0.75;
 yy = 0.25;
 zz = 0.25;

 % Pd Central
 Ec_Pd_12 = Ec3(ri,a,index_Pd,1,XX,...
 @f_PdPd,X0_PdPd,...
 @F_Pd,X1_PdPd,...
 @phi_PdPd,X2_PdPd,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_PdH,rc_1);

 % Cu Central
 Ec_Cu_12 = Ec3(ri,a,index_Cu,2,YY,...
 @f_PdPd,X0_CuCu,...
 @F_Pd,X1_CuCu,...
 @phi_PdPd,X2_CuCu,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_CuH,rc_1);

 % H Central
 Ec_H_12 = Ec3(ri,a,index_H,3,ZZ,...
 @f_HH,X0_HH,...
 @F_H,X22_HH,...
 @phi_HH,X22_HH,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdH,X4_PdH,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdH,X4_CuH,rc_1);

 Ec_Pd075Cu025H025_TE8 = ( xx * Ec_Pd_12 + yy * Ec_Cu_12 + ...
 zz * Ec_H_12)/(xx + yy + zz)

%***************************************************************
% For Pd075Cu025H025_TE6
%***************************************************************
 ri = ri_PdCuH025_T_25_75_75;
 index_Pd = index_PdCuH025_T_Pd_25_75_75;
 index_Cu = index_PdCuH025_T_Cu_25_75_75;
 index_H = index_PdCuH025_T_H_25_75_75;

 a = a_PdCuH025_T;

 XX = 1;
 YY = 1;
 ZZ = 1;

 xx = 0.75;
 yy = 0.25;
 zz = 0.25;

 % Pd Central
 Ec_Pd_12 = Ec3(ri,a,index_Pd,1,XX,...
 @f_PdPd,X0_PdPd,...
 @F_Pd,X1_PdPd,...
 @phi_PdPd,X2_PdPd,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_PdH,rc_1);

 % Cu Central
 Ec_Cu_12 = Ec3(ri,a,index_Cu,2,YY,...
 @f_PdPd,X0_CuCu,...
 @F_Pd,X1_CuCu,...
 @phi_PdPd,X2_CuCu,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_CuH,rc_1);

 % H Central
 Ec_H_12 = Ec3(ri,a,index_H,3,ZZ,...
 @f_HH,X0_HH,...
 @F_H,X22_HH,...
 @phi_HH,X22_HH,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdH,X4_PdH,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdH,X4_CuH,rc_1);

 Ec_Pd075Cu025H025_TE6 = ( xx * Ec_Pd_12 + yy * Ec_Cu_12 + ...
 zz * Ec_H_12)/(xx + yy + zz)

%***************************************************************
% For Pd075Cu025H025_O1_O2
%***************************************************************
 ri = ri_PdCuH050_O1_O2;
 index_Pd = index_PdCuH050_O1_O2_Pd;
 index_Cu = index_PdCuH050_O1_O2_Cu;
 index_H = index_PdCuH050_O1_O2_H_O1;
 % index_H = index_PdCuH050_O1_O2_H_O2;
 a = a_PdCuH050_O1_O2;

 XX = 1;
 YY = 1;
 ZZ = 1;

 xx = 0.75;
 yy = 0.25;
 zz = 0.50;

 % Pd Central
 Ec_Pd_12 = Ec3(ri,a,index_Pd,1,XX,...
 @f_PdPd,X0_PdPd,...
 @F_Pd,X1_PdPd,...
 @phi_PdPd,X2_PdPd,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_PdH,rc_1);

 % Cu Central
 Ec_Cu_12 = Ec3(ri,a,index_Cu,2,YY,...
 @f_PdPd,X0_CuCu,...
 @F_Pd,X1_CuCu,...
 @phi_PdPd,X2_CuCu,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_CuH,rc_1);

 % O1 H Central
 Ec_H_12 = Ec3(ri,a,index_H,3,ZZ,...
 @f_HH,X0_HH,...
 @F_H,X22_HH,...
 @phi_HH,X22_HH,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdH,X4_PdH,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdH,X4_CuH,rc_1);

 Ec_Pd075Cu025H050_O1_O2_O1central = ( xx * Ec_Pd_12 + yy ...
 * Ec_Cu_12 + zz * Ec_H_12)/(xx + yy + zz)

%***************************************************************
% For Pd075Cu025H025_O1_O2
%***************************************************************
 ri = ri_PdCuH050_O1_O2;
 index_Pd = index_PdCuH050_O1_O2_Pd;
 index_Cu = index_PdCuH050_O1_O2_Cu;
 % index_H = index_PdCuH050_O1_O2_H_O1;
 index_H = index_PdCuH050_O1_O2_H_O2;

 a = a_PdCuH050_O1_O2;

 XX = 1;
 YY = 1;
 ZZ = 1;

 xx = 0.75;
 yy = 0.25;
 zz = 0.50;

 % Pd Central
 Ec_Pd_12 = Ec3(ri,a,index_Pd,1,XX,...
 @f_PdPd,X0_PdPd,...
 @F_Pd,X1_PdPd,...
 @phi_PdPd,X2_PdPd,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_PdH,rc_1);

 % Cu Central
 Ec_Cu_12 = Ec3(ri,a,index_Cu,2,YY,...
 @f_PdPd,X0_CuCu,...
 @F_Pd,X1_CuCu,...
 @phi_PdPd,X2_CuCu,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_CuH,rc_1);

 % O2 H Central
 Ec_H_12 = Ec3(ri,a,index_H,3,ZZ,...
 @f_HH,X0_HH,...
 @F_H,X22_HH,...
 @phi_HH,X22_HH,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdH,X4_PdH,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdH,X4_CuH,rc_1);

 Ec_Pd075Cu025H050_O1_O2_O2central = ( xx * Ec_Pd_12 + yy ...
 * Ec_Cu_12 + zz * Ec_H_12)/(xx + yy + zz)

%***************************************************************
% For Pd075Cu025H025_O1_O2
%***************************************************************
 ri = ri_PdCuH050_O1_O2;
 index_Pd = index_PdCuH050_O1_O2_Pd;
 index_Cu = index_PdCuH050_O1_O2_Cu;
 index_H_O1 = index_PdCuH050_O1_O2_H_O1;
 index_H_O2 = index_PdCuH050_O1_O2_H_O2;

 a = a_PdCuH050_O1_O2;

 XX = 1;
 YY = 1;
 ZZ = 1;

 xx = 0.75;
 yy = 0.25;
 zz = 0.25;
 zzz = 0.25;

 % Pd Central
 Ec_Pd_12 = Ec3(ri,a,index_Pd,1,XX,...
 @f_PdPd,X0_PdPd,...
 @F_Pd,X1_PdPd,...
 @phi_PdPd,X2_PdPd,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_PdH,rc_1);

 % Cu Central
 Ec_Cu_12 = Ec3(ri,a,index_Cu,2,YY,...
 @f_PdPd,X0_CuCu,...
 @F_Pd,X1_CuCu,...
 @phi_PdPd,X2_CuCu,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_CuH,rc_1);

 % H Central
 Ec_H_12 = Ec3(ri,a,index_H_O1,3,ZZ,...
 @f_HH,X0_HH,...
 @F_H,X22_HH,...
 @phi_HH,X22_HH,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdH,X4_PdH,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdH,X4_CuH,rc_1);

 % H Central
 Ec_H_22 = Ec3(ri,a,index_H_O2,3,ZZ,...
 @f_HH,X0_HH,...
 @F_H,X22_HH,...
 @phi_HH,X22_HH,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdH,X4_PdH,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdH,X4_CuH,rc_1);

 Ec_Pd075Cu025H050_O1_O2 = ( xx * Ec_Pd_12 + yy * Ec_Cu_12 ...
 + zz * Ec_H_12 + zzz * Ec_H_22)/(xx + yy + zz + zzz)

%***************************************************************
% For Pd075Cu025H025_O2_O2
%***************************************************************
 ri = ri_PdCuH050_O2_O2;
 index_Pd = index_PdCuH050_O2_O2_Pd;
 index_Cu = index_PdCuH050_O2_O2_Cu;
 index_H = index_PdCuH050_O2_O2_H;

 a = a_PdCuH050_O2_O2;

 XX = 1;
 YY = 1;
 ZZ = 1;

 xx = 0.75;
 yy = 0.25;
 zz = 0.50;

 % Pd Central
 Ec_Pd_12 = Ec3(ri,a,index_Pd,1,XX,...
 @f_PdPd,X0_PdPd,...
 @F_Pd,X1_PdPd,...
 @phi_PdPd,X2_PdPd,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_PdH,rc_1);

 % Cu Central
 Ec_Cu_12 = Ec3(ri,a,index_Cu,2,YY,...
 @f_PdPd,X0_CuCu,...
 @F_Pd,X1_CuCu,...
 @phi_PdPd,X2_CuCu,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_CuH,rc_1);

 % H Central
 Ec_H_12 = Ec3(ri,a,index_H,3,ZZ,...
 @f_HH,X0_HH,...
 @F_H,X22_HH,...
 @phi_HH,X22_HH,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdH,X4_PdH,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdH,X4_CuH,rc_1);

 Ec_Pd075Cu025H050_O2_O2 = ( xx * Ec_Pd_12 + yy * Ec_Cu_12 + ...
 zz * Ec_H_12)/(xx + yy + zz)

%***************************************************************
% For Pd075Cu025H050_TE1_TE2
%***************************************************************
 global ri_PdCuH050_TE1_TE2;
 global index_PdCuH050_TE1_TE2_Pd
 global index_PdCuH050_TE1_TE2_Cu
 global index_PdCuH050_TE1_TE2_H_TE1
 global index_PdCuH050_TE1_TE2_H_TE2

 ri = ri_PdCuH050_TE1_TE2;
 index_Pd = index_PdCuH050_TE1_TE2_Pd;
 index_Cu = index_PdCuH050_TE1_TE2_Cu;
 index_H_TE1 = index_PdCuH050_TE1_TE2_H_TE1;
 index_H_TE2 = index_PdCuH050_TE1_TE2_H_TE2;

 a = a_PdCuH050_T;

 XX = 1;
 YY = 1;
 ZZ = 1;

 xx = 0.75;
 yy = 0.25;
 zz = 0.50;
 zzz = 0.25;

 % Pd Central
 Ec_Pd_12 = Ec3(ri,a,index_Pd,1,XX,...
 @f_PdPd,X0_PdPd,...
 @F_Pd,X1_PdPd,...
 @phi_PdPd,X2_PdPd,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_PdH,rc_1);

 % Cu Central
 Ec_Cu_12 = Ec3(ri,a,index_Cu,2,YY,...
 @f_PdPd,X0_CuCu,...
 @F_Pd,X1_CuCu,...
 @phi_PdPd,X2_CuCu,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_CuH,rc_1);

 % H Central
 Ec_H_12 = Ec3(ri,a,index_H_TE1,3,ZZ,...
 @f_HH,X0_HH,...
 @F_H,X22_HH,...
 @phi_HH,X22_HH,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdH,X4_PdH,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdH,X4_CuH,rc_1);

 Ec_Pd075Cu025H050_TE1_TE2__TE1central = ( xx * Ec_Pd_12 + ...
 yy * Ec_Cu_12 + zz * Ec_H_12)/(xx + yy + zz)

 % H Central
 Ec_H_22 = Ec3(ri,a,index_H_TE2,3,ZZ,...
 @f_HH,X0_HH,...
 @F_H,X22_HH,...
 @phi_HH,X22_HH,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdH,X4_PdH,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdH,X4_CuH,rc_1);

 Ec_Pd075Cu025H050_TE1_TE2 = ( xx * Ec_Pd_12 + yy * ...
 Ec_Cu_12 + zzz * Ec_H_12 + zzz * Ec_H_22)/(xx + yy + zzz + zzz)

 %***************************************************************
% For Pd075Cu025H050_TE1_TE8
%***************************************************************
 global ri_PdCuH050_TE1_TE8;
 global index_PdCuH050_TE1_TE8_Pd
 global index_PdCuH050_TE1_TE8_Cu
 global index_PdCuH050_TE1_TE8_H_TE1
 global index_PdCuH050_TE1_TE8_H_TE8

 ri = ri_PdCuH050_TE1_TE8;
 index_Pd = index_PdCuH050_TE1_TE8_Pd;
 index_Cu = index_PdCuH050_TE1_TE8_Cu;
 index_H_TE1 = index_PdCuH050_TE1_TE8_H_TE1;
 index_H_TE8 = index_PdCuH050_TE1_TE8_H_TE8;

 a = a_PdCuH050_T;

 XX = 1;
 YY = 1;
 ZZ = 1;

 xx = 0.75;
 yy = 0.25;
 zz = 0.50;
 zzz = 0.25;

 % Pd Central
 Ec_Pd_12 = Ec3(ri,a,index_Pd,1,XX,...
 @f_PdPd,X0_PdPd,...
 @F_Pd,X1_PdPd,...
 @phi_PdPd,X2_PdPd,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_PdH,rc_1);

 % Cu Central
 Ec_Cu_12 = Ec3(ri,a,index_Cu,2,YY,...
 @f_PdPd,X0_CuCu,...
 @F_Pd,X1_CuCu,...
 @phi_PdPd,X2_CuCu,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_CuH,rc_1);

 % H Central
 Ec_H_12 = Ec3(ri,a,index_H_TE1,3,ZZ,...
 @f_HH,X0_HH,...
 @F_H,X22_HH,...
 @phi_HH,X22_HH,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdH,X4_PdH,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdH,X4_CuH,rc_1);

 Ec_Pd075Cu025H050_TE1_TE8__TE1central = ( xx * Ec_Pd_12 + ...
 yy * Ec_Cu_12 + zz * Ec_H_12)/(xx + yy + zz)

 % H Central
 Ec_H_22 = Ec3(ri,a,index_H_TE8,3,ZZ,...
 @f_HH,X0_HH,...
 @F_H,X22_HH,...
 @phi_HH,X22_HH,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdH,X4_PdH,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdH,X4_CuH,rc_1);

 Ec_Pd075Cu025H050_TE1_TE8 = ( xx * Ec_Pd_12 + yy * ...
 Ec_Cu_12 + zzz * Ec_H_12+ zzz * Ec_H_22)/(xx + yy + zzz + zzz)

%***************************************************************
% For Pd075Cu025H050_TE3_TE4
%***************************************************************
 global ri_PdCuH050_TE3_TE4
 global index_PdCuH050_TE3_TE4_Pd
 global index_PdCuH050_TE3_TE4_Cu
 global index_PdCuH050_TE3_TE4_H_TE3
 global index_PdCuH050_TE3_TE4_H_TE4

 ri = ri_PdCuH050_TE3_TE4;
 index_Pd = index_PdCuH050_TE3_TE4_Pd;
 index_Cu = index_PdCuH050_TE3_TE4_Cu;
 index_H_TE3 = index_PdCuH050_TE3_TE4_H_TE3;
 index_H_TE4 = index_PdCuH050_TE3_TE4_H_TE4;

 a = a_PdCuH050_T;

 XX = 1;
 YY = 1;
 ZZ = 1;

 xx = 0.75;
 yy = 0.25;
 zz = 0.25;
 zzz = 0.25;

 % Pd Central
 Ec_Pd_12 = Ec3(ri,a,index_Pd,1,XX,...
 @f_PdPd,X0_PdPd,...
 @F_Pd,X1_PdPd,...
 @phi_PdPd,X2_PdPd,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_PdH,rc_1);

 % Cu Central
 Ec_Cu_12 = Ec3(ri,a,index_Cu,2,YY,...
 @f_PdPd,X0_CuCu,...
 @F_Pd,X1_CuCu,...
 @phi_PdPd,X2_CuCu,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_CuH,rc_1);

 % H Central
 Ec_H_12 = Ec3(ri,a,index_H_TE3,3,ZZ,...
 @f_HH,X0_HH,...
 @F_H,X22_HH,...
 @phi_HH,X22_HH,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdH,X4_PdH,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdH,X4_CuH,rc_1);

 % H Central
 Ec_H_22 = Ec3(ri,a,index_H_TE4,3,ZZ,...
 @f_HH,X0_HH,...
 @F_H,X22_HH,...
 @phi_HH,X22_HH,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdH,X4_PdH,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdH,X4_CuH,rc_1);

 Ec_Pd075Cu025H050_TE3_TE4 = ( xx * Ec_Pd_12 + yy * ...
 Ec_Cu_12 + zz * Ec_H_12 + zzz * Ec_H_22)/(xx + yy + zz + zzz)

%***************************************************************
% For Pd075Cu025H050_TE3_TE6
%***************************************************************
 global ri_PdCuH050_TE3_TE6
 global index_PdCuH050_TE3_TE6_Pd
 global index_PdCuH050_TE3_TE6_Cu
 global index_PdCuH050_TE3_TE6_H_TE3
 global index_PdCuH050_TE3_TE6_H_TE6

 ri = ri_PdCuH050_TE3_TE6;
 index_Pd = index_PdCuH050_TE3_TE6_Pd;
 index_Cu = index_PdCuH050_TE3_TE6_Cu;
 index_H_TE3 = index_PdCuH050_TE3_TE6_H_TE3;
 index_H_TE6 = index_PdCuH050_TE3_TE6_H_TE6;

 a = a_PdCuH050_T;

 XX = 1;
 YY = 1;
 ZZ = 1;

 xx = 0.75;
 yy = 0.25;
 zz = 0.25;
 zzz = 0.25;

 % Pd Central
 Ec_Pd_12 = Ec3(ri,a,index_Pd,1,XX,...
 @f_PdPd,X0_PdPd,...
 @F_Pd,X1_PdPd,...
 @phi_PdPd,X2_PdPd,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_PdH,rc_1);

 % Cu Central
 Ec_Cu_12 = Ec3(ri,a,index_Cu,2,YY,...
 @f_PdPd,X0_CuCu,...
 @F_Pd,X1_CuCu,...
 @phi_PdPd,X2_CuCu,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_CuH,rc_1);

 % H Central
 Ec_H_12 = Ec3(ri,a,index_H_TE3,3,ZZ,...
 @f_HH,X0_HH,...
 @F_H,X22_HH,...
 @phi_HH,X22_HH,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdH,X4_PdH,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdH,X4_CuH,rc_1);

 % H Central
 Ec_H_22 = Ec3(ri,a,index_H_TE6,3,ZZ,...
 @f_HH,X0_HH,...
 @F_H,X22_HH,...
 @phi_HH,X22_HH,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdH,X4_PdH,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdH,X4_CuH,rc_1);

 Ec_Pd075Cu025H050_TE3_TE6 = ( xx * Ec_Pd_12 + yy * ...
 Ec_Cu_12 + zz * Ec_H_12 + zzz * Ec_H_22)/(xx + yy + zz + zzz)

%***************************************************************
% For Pd075Cu025H075_O1_O2_O2
%***************************************************************
 ri = ri_PdCuH075_O1_O2_O2;
 index_Pd = index_PdCuH075_O1_O2_O2_Pd;
 index_Cu = index_PdCuH075_O1_O2_O2_Cu;
 index_H_O1 = index_PdCuH075_O1_O2_O2_H_O1;
 index_H_O2 = index_PdCuH075_O1_O2_O2_H_O2;

 a = a_PdCuH075_O1_O2_O2;

 XX = 1;
 YY = 1;
 ZZ = 1;

 xx = 0.75;
 yy = 0.25;
 zz = 0.25;
 zzz = 0.50;
 zzzz = 0.75;

 % Pd Central
 Ec_Pd_12 = Ec3(ri,a,index_Pd,1,XX,...
 @f_PdPd,X0_PdPd,...
 @F_Pd,X1_PdPd,...
 @phi_PdPd,X2_PdPd,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_PdH,rc_1);

 % Cu Central
 Ec_Cu_12 = Ec3(ri,a,index_Cu,2,YY,...
 @f_PdPd,X0_CuCu,...
 @F_Pd,X1_CuCu,...
 @phi_PdPd,X2_CuCu,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_CuH,rc_1);

 % H Central
 Ec_H_12 = Ec3(ri,a,index_H_O1,3,ZZ,...
 @f_HH,X0_HH,...
 @F_H,X22_HH,...
 @phi_HH,X22_HH,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdH,X4_PdH,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdH,X4_CuH,rc_1);

 % H Central
 Ec_H_22 = Ec3(ri,a,index_H_O2,3,ZZ,...
 @f_HH,X0_HH,...
 @F_H,X22_HH,...
 @phi_HH,X22_HH,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdH,X4_PdH,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdH,X4_CuH,rc_1);

 Ec_Pd075Cu025H075_O1_O2_O2_O1central = ( xx * Ec_Pd_12 + ...
 yy * Ec_Cu_12 + zzzz * Ec_H_12)/(xx + yy + zzzz)
 Ec_Pd075Cu025H075_O1_O2_O2_O2central = ( xx * Ec_Pd_12 + ...
 yy * Ec_Cu_12 + zzzz * Ec_H_22)/(xx + yy + zzzz)
 Ec_Pd075Cu025H075_O1_O2_O2 = ( xx * Ec_Pd_12 + yy * ...
 Ec_Cu_12 + zz * Ec_H_12 + zzz * Ec_H_22)/(xx + yy + zz + zzz)

%***************************************************************
% For Pd075Cu025H075_O2_O2_O2
%***************************************************************
 ri = ri_PdCuH075_O2_O2_O2;
 index_Pd = index_PdCuH075_O2_O2_O2_Pd;
 index_Cu = index_PdCuH075_O2_O2_O2_Cu;
 index_H = index_PdCuH075_O2_O2_O2_H;

 a = a_PdCuH075_O2_O2_O2;

 XX = 1;
 YY = 1;
 ZZ = 1;

 xx = 0.75;
 yy = 0.25;
 zz = 0.75;

 % Pd Central
 Ec_Pd_12 = Ec3(ri,a,index_Pd,1,XX,...
 @f_PdPd,X0_PdPd,...
 @F_Pd,X1_PdPd,...
 @phi_PdPd,X2_PdPd,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_PdH,rc_1);

 % Cu Central
 Ec_Cu_12 = Ec3(ri,a,index_Cu,2,YY,...
 @f_PdPd,X0_CuCu,...
 @F_Pd,X1_CuCu,...
 @phi_PdPd,X2_CuCu,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_CuH,rc_1);

 % H Central
 Ec_H_12 = Ec3(ri,a,index_H,3,ZZ,...
 @f_HH,X0_HH,...
 @F_H,X22_HH,...
 @phi_HH,X22_HH,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdH,X4_PdH,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdH,X4_CuH,rc_1);

 Ec_Pd075Cu025H075_O2_O2_O2 = ( xx * Ec_Pd_12 + yy * ...
 Ec_Cu_12 + zz * Ec_H_12)/(xx + yy + zz)

%***************************************************************
% For Pd075Cu025H075_T
%***************************************************************
 ri = ri_PdCuH075_T;
 index_Pd = index_PdCuH075_T_Pd;
 index_Cu = index_PdCuH075_T_Cu;
 index_H = index_PdCuH075_T_H;

 a = a_PdCuH075_T;

 XX = 1;
 YY = 1;
 ZZ = 1;

 xx = 0.75;
 yy = 0.25;
 zz = 0.75;

 % Pd Central
 Ec_Pd_12 = Ec3(ri,a,index_Pd,1,XX,...
 @f_PdPd,X0_PdPd,...
 @F_Pd,X1_PdPd,...
 @phi_PdPd,X2_PdPd,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_PdH,rc_1);

 % Cu Central
 Ec_Cu_12 = Ec3(ri,a,index_Cu,2,YY,...
 @f_PdPd,X0_CuCu,...
 @F_Pd,X1_CuCu,...
 @phi_PdPd,X2_CuCu,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_CuH,rc_1);

 % H Central
 Ec_H_12 = Ec3(ri,a,index_H,3,ZZ,...
 @f_HH,X0_HH,...
 @F_H,X22_HH,...
 @phi_HH,X22_HH,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdH,X4_PdH,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdH,X4_CuH,rc_1);

 Ec_Pd075Cu025H075_TE5_TE6_TE7 = ( xx * Ec_Pd_12 + yy * ...
 Ec_Cu_12 + zz * Ec_H_12)/(xx + yy + zz)

%***************************************************************
% For Pd075Cu025H075_TE1_TE2_TE3
%***************************************************************
 global ri_PdCuH075_TE1_TE2_TE3
 global index_PdCuH075_TE1_TE2_TE3_Pd
 global index_PdCuH075_TE1_TE2_TE3_Cu
 global index_PdCuH075_TE1_TE2_TE3_H_TE1
 global index_PdCuH075_TE1_TE2_TE3_H_TE2
 global index_PdCuH075_TE1_TE2_TE3_H_TE3

 ri = ri_PdCuH075_TE1_TE2_TE3;
 index_Pd = index_PdCuH075_TE1_TE2_TE3_Pd;
 index_Cu = index_PdCuH075_TE1_TE2_TE3_Cu;
 index_H_TE1 = index_PdCuH075_TE1_TE2_TE3_H_TE1;
 index_H_TE2 = index_PdCuH075_TE1_TE2_TE3_H_TE2;
 index_H_TE3 = index_PdCuH075_TE1_TE2_TE3_H_TE3;

 a = a_PdCuH075_T;

 XX = 1;
 YY = 1;
 ZZ = 1;

 xx = 0.75;
 yy = 0.25;
 zz = 0.25;
 zzz = 0.25;
 zzzz = 0.25;

 % Pd Central
 Ec_Pd_12 = Ec3(ri,a,index_Pd,1,XX,...
 @f_PdPd,X0_PdPd,...
 @F_Pd,X1_PdPd,...
 @phi_PdPd,X2_PdPd,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_PdH,rc_1);

 % Cu Central
 Ec_Cu_12 = Ec3(ri,a,index_Cu,2,YY,...
 @f_PdPd,X0_CuCu,...
 @F_Pd,X1_CuCu,...
 @phi_PdPd,X2_CuCu,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_CuH,rc_1);

 % H Central
 Ec_H_12 = Ec3(ri,a,index_H_TE1,3,ZZ,...
 @f_HH,X0_HH,...
 @F_H,X22_HH,...
 @phi_HH,X22_HH,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdH,X4_PdH,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdH,X4_CuH,rc_1);

 % H Central
 Ec_H_22 = Ec3(ri,a,index_H_TE2,3,ZZ,...
 @f_HH,X0_HH,...
 @F_H,X22_HH,...
 @phi_HH,X22_HH,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdH,X4_PdH,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdH,X4_CuH,rc_1);

 % H Central
 Ec_H_32 = Ec3(ri,a,index_H_TE3,3,ZZ,...
 @f_HH,X0_HH,...
 @F_H,X22_HH,...
 @phi_HH,X22_HH,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdH,X4_PdH,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdH,X4_CuH,rc_1);

 Ec_Pd075Cu025H075_TE1_TE2_TE3 = ( xx * Ec_Pd_12 + yy * ...
 Ec_Cu_12 + zz * Ec_H_12 + zzz * Ec_H_22 + zzzz * Ec_H_32)/(xx ...
 + yy + zz + zzz + zzzz)

%***************************************************************
% For Pd075Cu025H075_TE1_TE2_TE8
%***************************************************************
 global ri_PdCuH075_TE1_TE2_TE8
 global index_PdCuH075_TE1_TE2_TE8_Pd
 global index_PdCuH075_TE1_TE2_TE8_Cu
 global index_PdCuH075_TE1_TE2_TE8_H_TE1
 global index_PdCuH075_TE1_TE2_TE8_H_TE2
 global index_PdCuH075_TE1_TE2_TE8_H_TE8

 ri = ri_PdCuH075_TE1_TE2_TE8;
 index_Pd = index_PdCuH075_TE1_TE2_TE8_Pd;
 index_Cu = index_PdCuH075_TE1_TE2_TE8_Cu;
 index_H_TE1 = index_PdCuH075_TE1_TE2_TE8_H_TE1;
 index_H_TE2 = index_PdCuH075_TE1_TE2_TE8_H_TE2;
 index_H_TE8 = index_PdCuH075_TE1_TE2_TE8_H_TE8;

 a = a_PdCuH075_T;

 XX = 1;
 YY = 1;
 ZZ = 1;

 xx = 0.75;
 yy = 0.25;
 zz = 0.25;
 zzz = 0.25;
 zzzz = 0.25;

 % Pd Central
 Ec_Pd_12 = Ec3(ri,a,index_Pd,1,XX,...
 @f_PdPd,X0_PdPd,...
 @F_Pd,X1_PdPd,...
 @phi_PdPd,X2_PdPd,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_PdH,rc_1);

 % Cu Central
 Ec_Cu_12 = Ec3(ri,a,index_Cu,2,YY,...
 @f_PdPd,X0_CuCu,...
 @F_Pd,X1_CuCu,...
 @phi_PdPd,X2_CuCu,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_CuH,rc_1);

 % H Central
 Ec_H_12 = Ec3(ri,a,index_H_TE1,3,ZZ,...
 @f_HH,X0_HH,...
 @F_H,X22_HH,...
 @phi_HH,X22_HH,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdH,X4_PdH,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdH,X4_CuH,rc_1);

 % H Central
 Ec_H_22 = Ec3(ri,a,index_H_TE2,3,ZZ,...
 @f_HH,X0_HH,...
 @F_H,X22_HH,...
 @phi_HH,X22_HH,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdH,X4_PdH,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdH,X4_CuH,rc_1);

 % H Central
 Ec_H_32 = Ec3(ri,a,index_H_TE8,3,ZZ,...
 @f_HH,X0_HH,...
 @F_H,X22_HH,...
 @phi_HH,X22_HH,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdH,X4_PdH,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdH,X4_CuH,rc_1);

 Ec_Pd075Cu025H075_TE1_TE2_TE8 = ( xx * Ec_Pd_12 + yy * ...
 Ec_Cu_12 + zz * Ec_H_12 + zzz * Ec_H_22 + zzzz * Ec_H_32)/(xx ...
 + yy + zz + zzz + zzzz)

%***************************************************************
% For Pd075Cu025H100_O1_O2_O2_O2
%***************************************************************
 ri = ri_PdCuH100_O1_O2_O2_O2;
 index_Pd = index_PdCuH100_O1_O2_O2_O2_Pd;
 index_Cu = index_PdCuH100_O1_O2_O2_O2_Cu;
 index_H_O1 = index_PdCuH100_O1_O2_O2_O2_H_O1;
 index_H_O2 = index_PdCuH100_O1_O2_O2_O2_H_O2;

 a = a_PdCuH100_O1_O2_O2_O2;

 XX = 1;
 YY = 1;
 ZZ = 1;

 xx = 0.75;
 yy = 0.25;
 zz = 0.25;
 zzz = 0.75;
 zzzz = 1.00;

 % Pd Central
 Ec_Pd_12 = Ec3(ri,a,index_Pd,1,XX,...
 @f_PdPd,X0_PdPd,...
 @F_Pd,X1_PdPd,...
 @phi_PdPd,X2_PdPd,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_PdH,rc_1);

 % Cu Central
 Ec_Cu_12 = Ec3(ri,a,index_Cu,2,YY,...
 @f_PdPd,X0_CuCu,...
 @F_Pd,X1_CuCu,...
 @phi_PdPd,X2_CuCu,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_CuH,rc_1);

 % H Central
 Ec_H_12 = Ec3(ri,a,index_H_O1,3,ZZ,...
 @f_HH,X0_HH,...
 @F_H,X22_HH,...
 @phi_HH,X22_HH,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdH,X4_PdH,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdH,X4_CuH,rc_1);

 % H Central
 Ec_H_22 = Ec3(ri,a,index_H_O2,3,ZZ,...
 @f_HH,X0_HH,...
 @F_H,X22_HH,...
 @phi_HH,X22_HH,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdH,X4_PdH,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdH,X4_CuH,rc_1);
 Ec_Pd075Cu025H100_O1_O2_O2_O2_O1central = ( xx * Ec_Pd_12 ...
 + yy * Ec_Cu_12 + zzzz * Ec_H_12)/(xx + yy + zzzz)
 Ec_Pd075Cu025H100_O1_O2_O2_O2_O2central = ( xx * Ec_Pd_12 ...
 + yy * Ec_Cu_12 + zzzz * Ec_H_22)/(xx + yy + zzzz)
 Ec_Pd075Cu025H100_O1_O2_O2_O2 = ( xx * Ec_Pd_12 + yy * ...
 Ec_Cu_12 + zz * Ec_H_12 + zzz * Ec_H_22)/(xx + yy + zz + zzz)

%***************************************************************
% For Pd075Cu025H100_T
%***************************************************************
 ri = ri_PdCuH100_T;
 index_Pd = index_PdCuH100_T_Pd;
 index_Cu = index_PdCuH100_T_Cu;
 index_H = index_PdCuH100_T_H;

 a = a_PdCuH100_T;

 XX = 1;
 YY = 1;
 ZZ = 1;

 xx = 0.75;
 yy = 0.25;
 zz = 1.00;

 % Pd Central
 Ec_Pd_12 = Ec3(ri,a,index_Pd,1,XX,...
 @f_PdPd,X0_PdPd,...
 @F_Pd,X1_PdPd,...
 @phi_PdPd,X2_PdPd,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_PdH,rc_1);

 % Cu Central
 Ec_Cu_12 = Ec3(ri,a,index_Cu,2,YY,...
 @f_PdPd,X0_CuCu,...
 @F_Pd,X1_CuCu,...
 @phi_PdPd,X2_CuCu,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_CuH,rc_1);

 % H Central
 Ec_H_12 = Ec3(ri,a,index_H,3,ZZ,...
 @f_HH,X0_HH,...
 @F_H,X22_HH,...
 @phi_HH,X22_HH,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdH,X4_PdH,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdH,X4_CuH,rc_1);

 Ec_Pd075Cu025H100_TE1_TE5_TE6_TE7 = ( xx * Ec_Pd_12 + yy ...
 * Ec_Cu_12 + zz * Ec_H_12)/(xx + yy + zz)

%***************************************************************
% For Pd075Cu025H100_TE1_TE2_TE3_TE4
%***************************************************************
 global ri_PdCuH100_TE1_TE2_TE3_TE4
 global index_PdCuH100_TE1_TE2_TE3_TE4_Pd
 global index_PdCuH100_TE1_TE2_TE3_TE4_Cu
 global index_PdCuH100_TE1_TE2_TE3_TE4_H_TE1
 global index_PdCuH100_TE1_TE2_TE3_TE4_H_TE2
 global index_PdCuH100_TE1_TE2_TE3_TE4_H_TE3
 global index_PdCuH100_TE1_TE2_TE3_TE4_H_TE4

 ri = ri_PdCuH100_TE1_TE2_TE3_TE4;
 index_Pd = index_PdCuH100_TE1_TE2_TE3_TE4_Pd;
 index_Cu = index_PdCuH100_TE1_TE2_TE3_TE4_Cu;
 index_H_TE1 = index_PdCuH100_TE1_TE2_TE3_TE4_H_TE1;
 index_H_TE2 = index_PdCuH100_TE1_TE2_TE3_TE4_H_TE2;
 index_H_TE3 = index_PdCuH100_TE1_TE2_TE3_TE4_H_TE3;
 index_H_TE4 = index_PdCuH100_TE1_TE2_TE3_TE4_H_TE4;

 a = a_PdCuH100_T;

 XX = 1;
 YY = 1;
 ZZ = 1;

 xx = 0.75;
 yy = 0.25;
 zz = 0.25;

 % Pd Central
 Ec_Pd_12 = Ec3(ri,a,index_Pd,1,XX,...
 @f_PdPd,X0_PdPd,...
 @F_Pd,X1_PdPd,...
 @phi_PdPd,X2_PdPd,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_PdH,rc_1);

 % Cu Central
 Ec_Cu_12 = Ec3(ri,a,index_Cu,2,YY,...
 @f_PdPd,X0_CuCu,...
 @F_Pd,X1_CuCu,...
 @phi_PdPd,X2_CuCu,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_CuH,rc_1);

 % H Central
 Ec_H_12 = Ec3(ri,a,index_H_TE1,3,ZZ,...
 @f_HH,X0_HH,...
 @F_H,X22_HH,...
 @phi_HH,X22_HH,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdH,X4_PdH,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdH,X4_CuH,rc_1);

 % H Central
 Ec_H_22 = Ec3(ri,a,index_H_TE2,3,ZZ,...
 @f_HH,X0_HH,...
 @F_H,X22_HH,...
 @phi_HH,X22_HH,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdH,X4_PdH,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdH,X4_CuH,rc_1);

 % H Central
 Ec_H_32 = Ec3(ri,a,index_H_TE3,3,ZZ,...
 @f_HH,X0_HH,...
 @F_H,X22_HH,...
 @phi_HH,X22_HH,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdH,X4_PdH,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdH,X4_CuH,rc_1);

 % H Central
 Ec_H_42 = Ec3(ri,a,index_H_TE4,3,ZZ,...
 @f_HH,X0_HH,...
 @F_H,X22_HH,...
 @phi_HH,X22_HH,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdH,X4_PdH,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdH,X4_CuH,rc_1);

 Ec_Pd075Cu025H100_TE1_TE2_TE3_TE4 = ( xx * Ec_Pd_12 + yy ...
 * Ec_Cu_12 + zz * Ec_H_12 + zz * Ec_H_22 + zz * Ec_H_32 + zz ...
 * Ec_H_42)/(xx + yy + 4*zz)

%***************************************************************
% For Pd075Cu025H100_TE1_TE2_TE7_TE8
%***************************************************************
 global ri_PdCuH100_TE1_TE2_TE7_TE8
 global index_PdCuH100_TE1_TE2_TE7_TE8_Pd
 global index_PdCuH100_TE1_TE2_TE7_TE8_Cu
 global index_PdCuH100_TE1_TE2_TE7_TE8_H_TE1
 global index_PdCuH100_TE1_TE2_TE7_TE8_H_TE2
 global index_PdCuH100_TE1_TE2_TE7_TE8_H_TE7
 global index_PdCuH100_TE1_TE2_TE7_TE8_H_TE8

 ri = ri_PdCuH100_TE1_TE2_TE7_TE8;
 index_Pd = index_PdCuH100_TE1_TE2_TE7_TE8_Pd;
 index_Cu = index_PdCuH100_TE1_TE2_TE7_TE8_Cu;
 index_H_TE1 = index_PdCuH100_TE1_TE2_TE7_TE8_H_TE1;
 index_H_TE2 = index_PdCuH100_TE1_TE2_TE7_TE8_H_TE2;
 index_H_TE7 = index_PdCuH100_TE1_TE2_TE7_TE8_H_TE7;
 index_H_TE8 = index_PdCuH100_TE1_TE2_TE7_TE8_H_TE8;

 a = a_PdCuH100_T;

 XX = 1;
 YY = 1;
 ZZ = 1;

 xx = 0.75;
 yy = 0.25;
 zz = 0.25;

 % Pd Central
 Ec_Pd_12 = Ec3(ri,a,index_Pd,1,XX,...
 @f_PdPd,X0_PdPd,...
 @F_Pd,X1_PdPd,...
 @phi_PdPd,X2_PdPd,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_PdH,rc_1);

 % Cu Central
 Ec_Cu_12 = Ec3(ri,a,index_Cu,2,YY,...
 @f_PdPd,X0_CuCu,...
 @F_Pd,X1_CuCu,...
 @phi_PdPd,X2_CuCu,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdCu,X5_PdCu,rc_1,...
 3,ZZ,@f_HH,X0_HH,...
 @phi_PdH,X4_CuH,rc_1);

 % H Central
 Ec_H_12 = Ec3(ri,a,index_H_TE1,3,ZZ,...
 @f_HH,X0_HH,...
 @F_H,X22_HH,...
 @phi_HH,X22_HH,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdH,X4_PdH,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdH,X4_CuH,rc_1);

 % H Central
 Ec_H_22 = Ec3(ri,a,index_H_TE2,3,ZZ,...
 @f_HH,X0_HH,...
 @F_H,X22_HH,...
 @phi_HH,X22_HH,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdH,X4_PdH,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdH,X4_CuH,rc_1);

 % H Central
 Ec_H_32 = Ec3(ri,a,index_H_TE7,3,ZZ,...
 @f_HH,X0_HH,...
 @F_H,X22_HH,...
 @phi_HH,X22_HH,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdH,X4_PdH,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdH,X4_CuH,rc_1);

 % H Central
 Ec_H_42 = Ec3(ri,a,index_H_TE8,3,ZZ,...
 @f_HH,X0_HH,...
 @F_H,X22_HH,...
 @phi_HH,X22_HH,rc_1,...
 1,XX,@f_PdPd,X0_PdPd,...
 @phi_PdH,X4_PdH,rc_1,...
 2,YY,@f_PdPd,X0_CuCu,...
 @phi_PdH,X4_CuH,rc_1);

 Ec_Pd075Cu025H100_TE1_TE2_TE7_TE8 = ( xx * Ec_Pd_12 + yy ...
 * Ec_Cu_12 + zz * Ec_H_12 + zz * Ec_H_22 + zz * Ec_H_32 + zz ...
 * Ec_H_42)/(xx + yy + 4*zz)

%***************************************************************
% Table
%***************************************************************
 Model1 = [Ec_Pd075Cu025H025_O1; Ec_Pd075Cu025H025_O2; Ec_Pd075Cu025H025_TE1;...
 Ec_Pd075Cu025H050_O1_O2;Ec_Pd075Cu025H050_O2_O2;Ec_Pd075Cu025H050_TE3_TE4;...
 Ec_Pd075Cu025H050_TE1_TE8;Ec_Pd075Cu025H075_O1_O2_O2;...
 Ec_Pd075Cu025H075_O2_O2_O2;...
 Ec_Pd075Cu025H075_TE1_TE2_TE3;Ec_Pd075Cu025H075_TE1_TE2_TE8;...
 Ec_Pd075Cu025H100_O1_O2_O2_O2;Ec_Pd075Cu025H100_TE1_TE2_TE3_TE4;...
 Ec_Pd075Cu025H100_TE1_TE2_TE7_TE8];

 Siesta1 = [Ec_exp_PdCuH025_O1; Ec_exp_PdCuH025_O2;...
 Ec_exp_PdCuH025_TE1;...
 Ec_exp_PdCuH050_O1_O2; Ec_exp_PdCuH050_O2_O2;...
 Ec_exp_PdCuH050_TE3_TE4; Ec_exp_PdCuH050_TE1_TE8;...
 Ec_exp_PdCuH075_O1_O2_O2; Ec_exp_PdCuH075_O2_O2_O2;...
 Ec_exp_PdCuH075_TE1_TE2_TE3; Ec_exp_PdCuH075_TE1_TE2_TE8;...
 Ec_exp_PdCuH100_O1_O2_O2_O2;...
 Ec_exp_PdCuH100_TE1_TE2_TE3_TE4;...
 Ec_exp_PdCuH100_TE1_TE2_TE7_TE8];

 Rownames =
{'PdCuH025_O1','PdCuH025_O2','PdCuH025_TE1','PdCuH050_O1_O2', ...
'PdCuH050_O2_O2','PdCuH050_TE3_TE4','PdCuH050_TE1_TE8','PdCuH075_O1_O2_O2',...
'PdCuH075_O2_O2_O2','PdCuH075_TE1_TE2_TE3','PdCuH075_TE1_TE2_TE8',...
'PdCuH100_O1_O2_O2_O2','PdCuH100_TE1_TE2_TE3_TE4','PdCuH100_TE1_TE2_TE7_TE8'};

Columnames = {'Siesta';'Model'};
 Results = table(Siesta1,Model1,'VariableNames',Columnames,'RowNames',Rownames)

 ar = 2.1075;
 fig_height = 6;
 fig_width = ar*fig_height;

 % Two Body Potential
 figure(1)
 j = 1;
 for r = 0:0.01:6
   Phi_CuH(j) = phi_PdH(r,X4_CuH);
   j = j + 1;
 end
 r = [0:0.01:6];
 plot(r,Phi_CuH,'black-','markersize',3, 'linewidth',4)
 xlabel('r (A^o)','fontsize',24)
 ylabel('Two Body Potential (eV)','fontsize',24)
 legend('CuH')
 set(gca,'FontSize',24,'FontWeight','bold','linewidth',3)
 axis([0.0,6,-1,2.5])
 fig = figure(1);
 fig.Units = 'inches';
 fig.Position = [2 2 fig_width fig_height];

 % Comparison Two Body Potential
 figure(2)
 j = 1;
 for r = 0:0.01:6
   Phi_PdPd(j) = phi_PdPd(r,X2_PdPd);
   Phi_CuCu(j) = phi_PdPd(r,X2_CuCu);
   Phi_HH(j) = phi_HH(r,X22_HH);
   Phi_PdH(j) = phi_PdH(r,X4_PdH);
   Phi_CuH(j) = phi_PdH(r,X4_CuH);
   Phi_PdCu(j) = phi_PdCu(r,X5_PdCu);
   j = j + 1;
 end
 r = [0:0.01:6];
 plot(r,Phi_HH,'black:',r,Phi_PdH,'black-.',r,Phi_PdPd,'black--',...
 r,Phi_CuCu,'g:',r,Phi_CuH,'black-',r,Phi_PdCu,'b:','markersize',3,...
 'linewidth',4)
 xlabel('r (A^o)','fontsize',24)
 ylabel('Two Body Potential (eV)','fontsize',24)
 legend('HH','PdH','PdPd','CuCu','CuH','PdCu')
 set(gca,'FontSize',24,'FontWeight','bold','linewidth',3)
 axis([0.0,6,-1,2.5])
 fig = figure(2);
 fig.Units = 'inches';
 fig.Position = [2 2 fig_width fig_height];

 % Comparison Two Body Potential
 figure(22)
 plot(r,Phi_HH,'k:',r,Phi_PdH,'k-.',r,Phi_CuH,'k--',...
 'markersize',3, 'linewidth',4)
 xlabel('r (A^o)','fontsize',24)
 ylabel('Two Body Potential (eV)','fontsize',24)
 legend('HH','PdH','CuH')
 set(gca,'FontSize',24,'FontWeight','bold','linewidth',3)
 axis([0.0,6,-1,2.5])
 fig = figure(22);
 fig.Units = 'inches';
 fig.Position = [2 2 fig_width fig_height];

 % Comparison Two Body Potential
 figure(23)
 plot(r,Phi_PdPd,'k-',r,Phi_CuCu,'k:',r,Phi_PdCu,'k--',...
 'markersize',3, 'linewidth',4)
 xlabel('r (A^o)','fontsize',24)
 ylabel('Two Body Potential (eV)','fontsize',24)
 legend('PdPd','CuCu','PdCu')
 set(gca,'FontSize',24,'FontWeight','bold','linewidth',3)
 axis([1.5,6,-.3,1])
 fig = figure(23);
 fig.Units = 'inches';
 fig.Position = [2 2 fig_width fig_height];

 x = [1:12]';

 figure (3)
 x = [1:14]';
 Model1 = [Ec_Pd075Cu025H025_O1; Ec_Pd075Cu025H025_O2;Ec_Pd075Cu025H025_TE1;...

Ec_Pd075Cu025H050_O1_O2;Ec_Pd075Cu025H050_O2_O2;Ec_Pd075Cu025H050_TE3_TE4;...

Ec_Pd075Cu025H050_TE1_TE8;Ec_Pd075Cu025H075_O1_O2_O2;...
Ec_Pd075Cu025H075_O2_O2_O2;...

Ec_Pd075Cu025H075_TE1_TE2_TE3;Ec_Pd075Cu025H075_TE1_TE2_TE8;...
Ec_Pd075Cu025H100_O1_O2_O2_O2;Ec_Pd075Cu025H100_TE1_TE2_TE3_TE4;...
Ec_Pd075Cu025H100_TE1_TE2_TE7_TE8];

 Siesta1 = [Ec_exp_PdCuH025_O1; Ec_exp_PdCuH025_O2; Ec_exp_PdCuH025_TE1;...
 Ec_exp_PdCuH050_O1_O2; Ec_exp_PdCuH050_O2_O2; ...
 Ec_exp_PdCuH050_TE3_TE4; Ec_exp_PdCuH050_TE1_TE8;...
 Ec_exp_PdCuH075_O1_O2_O2; Ec_exp_PdCuH075_O2_O2_O2; ...
 Ec_exp_PdCuH075_TE1_TE2_TE3; Ec_exp_PdCuH075_TE1_TE2_TE8;...
 Ec_exp_PdCuH100_O1_O2_O2_O2; Ec_exp_PdCuH100_TE1_TE2_TE3_TE4; ...
 Ec_exp_PdCuH100_TE1_TE2_TE7_TE8];
 plot(x,Model1,'kO',x,Siesta1,'blackd','markersize',10,'linewidth',3)
 set(gca,'FontSize',12,'FontWeight','bold','linewidth',3)
 xlabel('x','fontsize',24)
 ylabel('E_c (eV/atom)','fontsize',24)
 legend('Model','Siesta','Location','Northwest')
 legend({},'fontsize',18)
 xticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14])
 xticklabels({'PdCuH025 O1','PdCuH025 O2','PdCuH025TE1','PdCuH050 O1 O2',...
 'PdCuH050 O2 O2','PdCuH050 TE3 TE4','PdCuH050 TE1TE8','PdCuH075 O1 O2 O2',...
 'PdCuH075 O2 O2 O2','PdCuH075 TE123','PdCuH075TE128', ...
 'PdCuH100 O1 O2 O2 O2','PdCuH100 TE1234','PdCuH100TE1278'})
 xtickangle(45)
 fig = figure(3);
 fig.Units = 'inches';
 fig.Position = [2 2 fig_width fig_height];

 x = [1:11]';

 Siesta = [Ec_exp_PdCuH025_O1; Ec_exp_PdCuH025_O2; Ec_exp_PdCuH025_T;...
 Ec_exp_PdCuH050_O1_O2; Ec_exp_PdCuH050_O2_O2; Ec_exp_PdCuH050_T;...
 Ec_exp_PdCuH075_O1_O2_O2; Ec_exp_PdCuH075_O2_O2_O2; Ec_exp_PdCuH075_T;...
 Ec_exp_PdCuH100_O1_O2_O2_O2; Ec_exp_PdCuH100_T];

 Fitting = [Ec_Pd075Cu025H025_O1; Ec_Pd075Cu025H025_O2; ...
 Ec_Pd075Cu025H050_O1_O2;Ec_Pd075Cu025H050_O2_O2;...
 Ec_Pd075Cu025H075_O1_O2_O2;Ec_Pd075Cu025H075_O2_O2_O2;...
 Ec_Pd075Cu025H100_O1_O2_O2_O2]';

 Model = [Ec_Pd075Cu025H050_TE1_TE2;Ec_Pd075Cu025H050_TE1_TE8;...
 Ec_Pd075Cu025H050_TE3_TE4;Ec_Pd075Cu025H050_TE3_TE6;...
 Ec_Pd075Cu025H075_TE5_TE6_TE7;Ec_Pd075Cu025H075_TE1_TE2_TE3;...
 Ec_Pd075Cu025H075_TE1_TE2_TE8;Ec_Pd075Cu025H100_TE1_TE5_TE6_TE7;...
 Ec_Pd075Cu025H100_TE1_TE2_TE3_TE4;Ec_Pd075Cu025H100_TE1_TE2_TE7_TE8];

 Siesta = [Ec_exp_PdCuH025_O1; Ec_exp_PdCuH025_O2; Ec_exp_PdCuH025_T;...
 Ec_exp_PdCuH050_O1_O2; Ec_exp_PdCuH050_O2_O2; ...
 Ec_exp_PdCuH050_T; Ec_exp_PdCuH050_T;...
 Ec_exp_PdCuH075_O1_O2_O2; Ec_exp_PdCuH075_O2_O2_O2; ...
 Ec_exp_PdCuH075_T;...
 Ec_exp_PdCuH100_O1_O2_O2_O2; Ec_exp_PdCuH100_T];

 Zhou_Experimental = [-3.396;-3.337;-3.373;-3.180;-3.147;...
 -3.171;-3.171;-3.035;-2.944;-3.025;-2.863;-2.919];
 Zhou = [-3.49499221;-3.2892551;-3.4706926;-3.23099;...
 -3.086482;-3.168897;-3.168897;-3.070289;-2.9575078;...
 -3.031653827;-2.95657414;-3.0171908];

 % PError = abs(ModelExperimental).*100./abs(Experimental);
 Rownames =
{'PdCuH050_TE1_TE2','PdCuH050_TE1_TE8','PdCuH050_TE3_TE4',...
'PdCuH050_TE3_TE8','PdCuH075_TE5_TE6_TE7','PdCuH075_TE1_TE2_TE3',...
 'PdCuH075_TE1_TE2_TE8','PdCuH100_TE1_TE5_TE6_TE7',...
 'PdCuH100_TE1_TE2_TE3_TE4','PdCuH100_TE1_TE2_TE7_TE8'};
 Columnames = {'Model'};
 Results = table(Model,'VariableNames',Columnames,'RowNames',Rownames);
end

%***************************************************************
function [Ec_,dEda_] = fitProperties_1(r,a,N,index,t1,y,f_11,dfdr_11,...
  d2fdr2_11,X0,...
  F,dFdrho,d2Fdrho2,X1,phi_11,dphidr_11,d2phidr2_11,X2,rc_1,...
  t2,x,f_22,dfdr_22,d2fdr2_22,X3,phi_12,dphidr_12,d2phidr2_12,X4,rc_2)
 Ec_ = Ec(r,a,index,t1,y,f_11,X0,F,X1,phi_11,X2,rc_1,t2,x,f_22,X3,...
 phi_12,X4,rc_2);
 dEda_ = dEda(r,a,index,t1,y,f_11,dfdr_11,X0,dFdrho,X1,dphidr_11,X2,rc_1,...
 t2,x,f_22,dfdr_22,X3,dphidr_12,X4,rc_2);
end

%***************************************************************
% Property Functions Used In Parameters Fitting
%***************************************************************
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
  % Ev_ = Ev(index,t1,a,phi_11,X2,f_11,X0,F,X1,r,rc_1);
  Ev_ = 0;
end

%***************************************************************
% Cohesive Energy for Interstitial Solid Solution
%***************************************************************
function f = Ec(ri,a,index,t1,y,f_11,X0,F_11,X1,phi_11,X2,rc_1,t2,x,...
  f_22,X3,phi_12,X4,rc_2)
  f = 0;
  Rho_12 = 0;
  Phi_12 = 0;
  Rho_11 = y * Rho(index,t1,ri,a,rc_1,f_11,X0);
  Phi_11 = y * Phi(index,t1,ri,a,rc_1,phi_11,X2);
  if nargin == 19
    Rho_12 = x * Rho(index,t2,ri,a,rc_2,f_22,X3);
    Phi_12 = x * Phi(index,t2,ri,a,rc_2,phi_12,X4);
  end
  Rho_1 = Rho_11 + Rho_12;
  F_1 = F_11(Rho_1,X1);
  f = F_1 + 0.5 * Phi_11 + 0.5 * Phi_12;
end

function f = Ec3(ri,a,index,t1,y,f_11,X0,F_11,X1,phi_11,X2,rc_1,t2,x,...
  f_22,X3,phi_12,X4,rc_2,t3,z,f_33,X5,phi_13,X6,rc_3)
  f = 0;
  Rho_12 = 0;
  Phi_12 = 0;
  Rho_13 = 0;
  Phi_13 = 0;
  Rho_11 = y * Rho(index,t1,ri,a,rc_1,f_11,X0);
  Phi_11 = y * Phi(index,t1,ri,a,rc_1,phi_11,X2);
  if nargin >= 19
    Rho_12 = x * Rho(index,t2,ri,a,rc_2,f_22,X3);
    Phi_12 = x * Phi(index,t2,ri,a,rc_2,phi_12,X4);
  end
  if nargin >= 26
    Rho_13 = z * Rho(index,t3,ri,a,rc_3,f_33,X5);
    Phi_13 = z * Phi(index,t3,ri,a,rc_3,phi_13,X6);
  end
  Rho_1 = Rho_11 + Rho_12 + Rho_13;
  F_1 = F_11(Rho_1,X1);
  f = F_1 + 0.5 * Phi_11 + 0.5 * Phi_12 + 0.5 * Phi_13;
end

%***************************************************************
% Elestic Constants for an Interstitial Solid Solution
%***************************************************************
function f = Cijkl(i,j,k,l,r,a,N,index,t1,y,f_11,dfdr_11,d2fdr2_11,X0,...
  dFdrho,d2Fdrho2,X1,dphidr_11,d2phidr2_11,X2,rc_1,t2,...
  x,f_22,dfdr_22,d2fdr2_22,X3,dphidr_12,d2phidr2_12,X4,rc_2)
  Rho_12 = 0;
  Vij_12 = 0;
  Vkl_12 = 0;
  Wijkl_12 = 0;
  Bijkl_12 = 0;
  Rho_11 = y * Rho(index,t1,r,a,rc_1,f_11,X0);
  Vij_11 = y * Vij(index,t1,r,a,rc_1,dfdr_11,X0,i,j,0,0);
  Vkl_11 = y * Vij(index,t1,r,a,rc_1,dfdr_11,X0,0,0,k,l);
  Wijkl_11 = y * Wijkl(index,t1,r,a,rc_1,dfdr_11,d2fdr2_11,X0,i,j,k,l);
  Bijkl_11 = y * Bijkl(index,t1,r,a,rc_1,dphidr_11,d2phidr2_11,X2,i,j,k,l);
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
  Elastic constants Cijkl
  V = (a^3)/N;
  Cijkl = (1/V)*( d2Fdrho2_1*(Vij_11 + Vij_12)*(Vkl_11 + Vkl_12) + ...
  dFdrho_1*(Wijkl_11 + Wijkl_12) + Bijkl_11 + Bijkl_12 );
  f = Cijkl * 1.602176462;
end

%***************************************************************
% Stress for an Interstitial solid solution
%***************************************************************
function f = S(i,j,r,a,N,index,t1,y,f_11,dfdr_11,X0,dFdrho,X1,dphidr_11,...
  X2,rc_1,...
  t2,x,f_22,dfdr_22,X3,dphidr_12,X4,rc_2)
  Rho_12 = 0;
  Vij_12 = 0;
  Aij_12 = 0;
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

%***************************************************************
% First derivative of Cohesive Energy with respect to a for an
% Interstitial solid solution
%***************************************************************
function f = dEda(ri,a,index,t1,y,f_11,dfdr_11,X0,dFdrho,X1,dphidr_11,...
  X2,rc_1,...
  t2,x,f_22,dfdr_22,X3,dphidr_12,X4,rc_2)
  Rho_12 = 0;
  dRhoda_12 = 0;
  dPhida_12 = 0;
  Rho_11 = y * Rho(index,t1,ri,a,rc_1,f_11,X0);
  dRhoda_11 = y * dRhoda(index,t1,ri,a,rc_1,dfdr_11,X0);
  dPhida_11 = y * dPhida(index,t1,ri,a,rc_1,dphidr_11,X2);
  if nargin == 21
    Rho_12 = x * Rho(index,t2,ri,a,rc_2,f_22,X3);
    dRhoda_12 = x * dRhoda(index,t2,ri,a,rc_2,dfdr_22,X3);
    dPhida_12 = x * dPhida(index,t2,ri,a,rc_2,dphidr_12,X4);
  end
  Rho_1 = Rho_11 + Rho_12;
  dRhoda_1 = dRhoda_11 + dRhoda_12;
  dFda_1 = dFda(dFdrho,Rho_1,dRhoda_1,X1);
  f = dFda_1 + 0.5 * dPhida_11 + 0.5 * dPhida_12;
end

%***************************************************************
% Second derivative of Cohesive Energy with respect to a for Interstitial
% Solid Solution
%***************************************************************
function f = d2Eda2(ri,a,index,t1,y,f_11,dfdr_11,d2fdr2_11,X0,...
  dFdrho,d2Fdrho2,X1,d2phidr2_11,X2,rc_1,t2,x,...
  f_22,dfdr_22,d2fdr2_22,X3,d2phidr2_12,X4,rc_2)
  Rho_12 = 0;
  dRhoda_12 = 0;
  d2Rhoda2_12 = 0;
  d2Phida2_12 = 0;
  Rho_11 = y * Rho(index,t1,ri,a,rc_1,f_11,X0);
  dRhoda_11 = y * dRhoda(index,t1,ri,a,rc_1,dfdr_11,X0);
  d2Rhoda2_11 = y * d2Rhoda2(index,t1,ri,a,rc_1,d2fdr2_11,X0);
  d2Phida2_11 = y * d2Phida2(index,t1,ri,a,rc_1,d2phidr2_11,X2);
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

%***************************************************************
% Bulk modulus
%***************************************************************
function f = Bm(ri,a,N,index,t1,y,f_11,dfdr_11,d2fdr2_11,X0,...
  dFdrho,d2Fdrho2,X1,d2phidr2_11,X2,rc_1,t2,x,f_22,...
  dfdr_22,d2fdr2_22,X3,d2phidr2_12,X4,rc_2)
  d2Eda2_ = 0;
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

%***************************************************************
% Vacancy formation Energy
%***************************************************************
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

%***************************************************************
% The Embedding Atom Model EAM
%***************************************************************
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

% First derivative of Atomic Electron Density with respect to ri,rj,rk and rl
function f = dfdrijkl(index,type,ri,a,rc,dfdr,X,i,j,k,l)
  f = Sumfuncrijkl(index,type,ri,a,rc,dfdr,X,i,j,k,l,3);
end

% Second derivative of Atomic Electron Density with respect to ri,rj,rk and rl
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

% Function Used in the calculations of Elastic Constants at equilibrium
function f = Wijkl(index,type,ri,a,rc,dfdr,d2fdr2,X,i,j,k,l)
  f = d2fdr2ijkl(index,type,ri,a,rc,d2fdr2,X,i,j,k,l) - ...
  dfdrijkl(index,type,ri,a,rc,dfdr,X,i,j,k,l)+ ...
  delta(i,l) * dfdri(index,type,ri,a,rc,dfdr,X,0,0,k,l);
end

% Function Used in the calculations of Elastic Constants at equilibrium
function f = Bijkl(index,type,ri,a,rc,dphidr,d2phidr2,X,i,j,k,l)
  f = d2Phidr2ijkl(index,type,ri,a,rc,d2phidr2,X,i,j,k,l) - ...
  dPhidrijkl(index,type,ri,a,rc,dphidr,X,i,j,k,l)+ ...
  delta(i,l) * dphidri(index,type,ri,a,rc,dphidr,X,0,0,k,l);
  f = 0.5 * f;
end

%***************************************************************
% Park Hijazi Pd EAM Potential and Derivatives
%***************************************************************
% Pd Embedding Energy Function as a function of electron density
function f = F_Pd(rho,X)
 f = 0;
 Fe = X(1);
 rhoe = X(2);
 n = X(3);
 if rho > 0
 f = -Fe*(1-n*log(rho/rhoe))*(rho/rhoe)^n;
 end
end

% First derivative of Pd Embedding Energy Function with respect
% to electron density
function f = dFdrho_Pd(rho,X)
 f = 0;
 Fe = X(1);
 rhoe = X(2);
 n = X(3);
 if rho > 0
 F = F_Pd(rho,X);
 f = (Fe*n/rho)*(rho/rhoe)^n+(n/rhoe)*F*(rho/rhoe)^(-1);
 end
end

% Second derivative of Pd Embedding Energy Function with respect
% to electron density
function f = d2Fdrho2_Pd(rho,X)
 f = 0;
 Fe = X(1);
 rhoe = X(2);
 n = X(3);
 if rho > 0
 F = F_Pd(rho,X);
 dF = dFdrho_Pd(rho,X);
 f = -(n/rho^2)*Fe*(rho/rhoe)^n+(n^2/rho)*(1/rhoe)*Fe*(rho/rhoe)^(n-1)+...
 (n/rhoe)*dF*(rho/rhoe)^(-1)-(n/rhoe^2)*F*(rho/rhoe)^(-2);
 end
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

%***************************************************************
% Hydrogen EAM Potential and Derivatives
%***************************************************************
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
 X2_HH = X(1:1:4);
 X0_HH = X(5:1:6);
 X1_HH = X(7:1:11);
 rho0H = X(11);
 f = phi_HH_u(rij,X2_HH) + 2 * dFdrho_H_u(rho0H,X1_HH) *
f_HH(rij,X0_HH);
end

% First derivative of H-H normalized pair potential with respect to rij
function f = dphidr_HH(rij,X)
 X2_HH = X(1:1:4);
 X0_HH = X(5:1:6);
 X1_HH = X(7:1:11);
 rho0H = X(11);
 f = dphidr_HH_u(rij,X2_HH) + 2 * dFdrho_H_u(rho0H,X1_HH) * ...
 dfdr_HH(rij,X0_HH);
end

% Second derivative of H-H normalized pair potential with respect to rij
function f = d2phidr2_HH(rij,X)
 X2_HH = X(1:1:4);
 X0_HH = X(5:1:6);
 X1_HH = X(7:1:11);
 rho0H = X(11);
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
 % EH = 0.055;
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
 % EH = 0.055;
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
 % EH = 0.055;
 f = -cH * ( (1+dH)*(rho+EH)^(dH) - dH*(aH + bH) * (rho+EH)^(dH-1) + ...
 (dH-1)*(aH * bH) *(rho+EH)^(dH-2) );
end

% H normalized Embedding Energy function
function f = F_H(rho,X)
 X1_HH = X(7:1:10);
 rho0H = X(11);
 f = F_H_u(rho,X1_HH) - dFdrho_H_u(rho0H,X1_HH) * rho;
end

% First derivative of H normalized Embedding function with respect to Rho
function f = dFdrho_H(rho,X)
 X1_HH = X(7:1:10);
 rho0H = X(11);
 f = dFdrho_H_u(rho,X1_HH) - dFdrho_H_u(rho0H,X1_HH);
end

% Second derivative of H normalized Embedding function with respect to Rho
function f = d2Fdrho2_H(rho,X)
 X1_HH = X(7:1:10);
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

%***************************************************************
% Summation function
%***************************************************************
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

function f = delta(i,j)
 if(i == j)
   f = 1;
 else
   f = 0;
 end
end

%***************************************************************
% Experimental data for FCC metals
%***************************************************************
function [afcce,Ecfcce,c11e,c12e,c44e,Bme,Eve,abcce,Ecbcce,cpre] ...
  = parameters(el)
  index = 1;
  elements = ['Cu';'Al';'Au';'Cu';'Ni';'Pd';'Pt';'Hi'];
  for i = 1:length(elements)
    x = elements(i,:);
    if el == x
      index = i;
    end
  end
  afcc = [4.09;4.05;4.08;3.615;3.52;3.89;3.92;3.38];
  Ecfcc = [2.85;3.36;3.93;3.54;4.45;3.91;5.77;2.119];
  % Elastic Constants in dyne/cm^2 10^12
  c11 = [1.24;1.14;1.86;1.70;2.465;2.3412;3.47;0.0];
  c12 = [0.934;0.619;1.57;1.225;1.473;1.7614;2.51;0.0];
  c44 = [0.461;0.316;0.42;0.758;1.247;0.7117;0.765;0.05*1.6021766208];
  cpr = [1;1;1;1;1;1;1;0.05*1.6021766208];
  % Unrelaxed
  Evfcc = [1.1;0.866;0.9;1.3;1.70;1.54;1.60;0.0];
  % Relaxed
  B = [1.04;0.793;1.67;1.38;1.804;1.9547;2.83;0.5*1.6021766208];
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

%***************************************************************
% Experimental and bb-initio data for PdH
%***************************************************************
function [afcce,Ecfcce,C44fcce,Cprfcce,Bmfcce] = PdH_parameters(el)
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
  % Elastic Constants with conv from eV/A^3 to dyne/cm^2 10^12
  C44 = [0.05,0.7117/1.6021766208,0.459,0.42,0.382,0.3440,...
  0.3810,0.3810] * 1.6021766208; % Pd from Rayne
  Cpr = [0.05,.2899/1.6021766208,0.055,0.135,0.164,0.146,...
  0.1630,0.1630] * 1.6021766208; % Pd from Rayne
  Bm = [0.50,1.9547/1.6021766208,1.05,1.05,1.05,1.05,...
  1.05,1.05] * 1.6021766208; % Pd from Rayne
  afcce = a(index1);
  Ecfcce = Ec(index1);
  C44fcce = C44(index1);
  Cprfcce = Cpr(index1);
  Bmfcce = Bm(index1);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pd Cutoff Transformed Functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f = phi_PdPd_cut(rij,X)
 global rc_1;
 global NP;
 f = phi_PdPd(rij,X) - phi_PdPd(rc_1,X) + (rc_1/NP) * ...
 (1-(rij/rc_1)^NP )* dphidr_PdPd(rc_1,X);
end

function f = dphidr_PdPd_cut(rij,X)
 global rc_1;
 global NP;
 f = dphidr_PdPd(rij,X) - (rij/rc_1)^(NP-1) * ...
 dphidr_PdPd(rc_1,X);
end

function f = d2phidr2_PdPd_cut(rij,X)
 global rc_1;
 global NP;
 f = d2phidr2_PdPd(rij,X)- ((NP-1)/rc_1) * (rij/rc_1)^(NP-2) * ...
 dphidr_PdPd(rc_1,X);
end

function f = f_PdPd_cut(rij,X)
 global rc_1;
 global NP;
 f = f_PdPd(rij,X) - f_PdPd(rc_1,X) + (rc_1/NP) * ...
 (1-(rij/rc_1)^NP) * dfdr_PdPd(rc_1,X);
end

function f = dfdr_PdPd_cut(rij,X)
 global rc_1;
 global NP;
 f = dfdr_PdPd(rij,X) - (rij/rc_1)^(NP-1) * ...
 dfdr_PdPd(rc_1,X);
end

function f = d2fdr2_PdPd_cut(rij,X)
 global rc_1;
 global NP;
 f = d2fdr2_PdPd(rij,X)- ((NP-1)/rc_1) * (rij/rc_1)^(NP-2) * ...
 dfdr_PdPd(rc_1,X);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hydrogen Cutoff Transformed functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f = phi_HH_cut(rij,X)
 global rc_2;
 global NP2;
 f = phi_HH(rij,X) - phi_HH(rc_2,X) + (rc_2/NP2) * ...
 (1-(rij/rc_2)^NP2 )* dphidr_HH(rc_2,X);
end

function f = dphidr_HH_cut(rij,X)
 global rc_2;
 global NP2;
 f = dphidr_HH(rij,X) - (rij/rc_2)^(NP2-1) * ...
 dphidr_HH(rc_2,X);
end

function f = d2phidr2_HH_cut(rij,X)
 global rc_2;
 global NP2;
 f = d2phidr2_HH(rij,X)- ((NP2-1)/rc_2) * (rij/rc_2)^(NP2-2) * ...
 dphidr_HH(rc_2,X);
end

function f = f_HH_cut(rij,X)
 global rc_2;
 global NP2;
 f = f_HH(rij,X) - f_HH(rc_2,X) + (rc_2/NP2) * ...
 (1-(rij/rc_2)^NP2) * dfdr_HH(rc_2,X);
end

function f = dfdr_HH_cut(rij,X)
 global rc_2;
 global NP2;
 f = dfdr_HH(rij,X) - (rij/rc_2)^(NP2-1) * dfdr_HH(rc_2,X);
end

function f = d2fdr2_HH_cut(rij,X)
 global rc_2;
 global NP2;
 f = d2fdr2_HH(rij,X)- ((NP2-1)/rc_2) * (rij/rc_2)^(NP2-2) * ...
 dfdr_HH(rc_2,X);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PdH Cutoff Transformed Pair Potential
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f = phi_PdH_cut(rij,X)
 global rc_3;
 global NP3;
 f = phi_PdH(rij,X) - phi_PdH(rc_3,X) + (rc_3/NP3) * ...
 (1-(rij/rc_3)^NP3 )* dphidr_PdH(rc_3,X);
end

function f = dphidr_PdH_cut(rij,X)
 global rc_3;
 global NP3;
 f = dphidr_PdH(rij,X) - (rij/rc_3)^(NP3-1) * dphidr_PdH(rc_3,X);
end

function f = d2phidr2_PdH_cut(rij,X)
 global rc_3;
 global NP3;
 f = d2phidr2_PdH(rij,X)- ((NP3-1)/rc_3) * (rij/rc_3)^(NP3-2) * ...
 dphidr_PdH(rc_3,X);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PdCu Pair Potential
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

function f = dphidr_PdCu(rij,X)
 X0_a = X(1:3);
 X0_b = X(4:6);
 X2_a = X(7:10);
 X2_b = X(11:14);
 f_a = f_PdPd(rij,X0_a);
 f_b = f_PdPd(rij,X0_b);
 phi_a = phi_PdPd(rij,X2_a);
 phi_b = phi_PdPd(rij,X2_b);
 dfdr_a = dfdr_PdPd(rij,X0_a);
 dfdr_b = dfdr_PdPd(rij,X0_b);
 dphidr_a = dphidr_PdPd(rij,X2_a);
 dphidr_b = dphidr_PdPd(rij,X2_b);
 f = .5*( ((-1*f_b*dfdr_a*f_a^-2 + dfdr_b*f_a^-1)*phi_a + (f_b*f_a^-1)*dphidr_a)...
 + ((-1*f_a*dfdr_b*f_b^-2 + dfdr_a*f_b^-1)*phi_b + (f_a*f_b^-1)*dphidr_b) );
end

function f = d2phidr2_PdCu(rij,X)
 X0_a = X(1:3);
 X0_b = X(4:6);
 X2_a = X(7:10);
 X2_b = X(11:14);
 f_a = f_PdPd(rij,X0_a);
 f_b = f_PdPd(rij,X0_b);
 phi_a = phi_PdPd(rij,X2_a);
 phi_b = phi_PdPd(rij,X2_b);
 dfdr_a = dfdr_PdPd(rij,X0_a);
 dfdr_b = dfdr_PdPd(rij,X0_b);
 dphidr_a = dphidr_PdPd(rij,X2_a);
 dphidr_b = dphidr_PdPd(rij,X2_b);
 d2fdr2_a = d2fdr2_PdPd(rij,X0_a);
 d2fdr2_b = d2fdr2_PdPd(rij,X0_b);
 d2phidr2_a = d2phidr2_PdPd(rij,X2_a);
 d2phidr2_b = d2phidr2_PdPd(rij,X2_b);
 Phi_ab = phi_ab(f_a,dfdr_a,d2fdr2_a,f_b,dfdr_b,d2fdr2_b,phi_a,dphidr_a,...
 d2phidr2_a,phi_b,dphidr_b,d2phidr2_b);
 Phi_ba = phi_ab(f_b,dfdr_b,d2fdr2_b,f_a,dfdr_a,d2fdr2_a,phi_b,dphidr_b,...
 d2phidr2_b,phi_a,dphidr_a,d2phidr2_a);
 f = .5*(Phi_ab + Phi_ba);
end

function f = phi_ab(f_a,dfdr_a,d2fdr2_a,f_b,dfdr_b,d2fdr2_b,phi_a,dphidr_a,...
  d2phidr2_a,phi_b,dphidr_b,d2phidr2_b)
  aa = -1*(dfdr_b*dfdr_a*f_a^-2 + f_b*d2fdr2_a*f_a^-2 - ...
  2*f_b*(dfdr_a^2)*f_a^-3)...
  + (d2fdr2_b*f_a^-1 - dfdr_b*f_a^-2*dfdr_a);
  a = aa*phi_a + (-1*f_b*dfdr_a*f_a^-2 + dfdr_b*f_a^-1)*dphidr_a;
  b = dfdr_b*f_a^-1*dphidr_a - f_b*f_a^-2*dfdr_a*dphidr_a + ...
  f_b*f_a^-1*d2phidr2_a;
  f = a + b;
end

