function EAM_Parameters_Fitting
 warning off
 % Clear command window
 clc
67
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
 a_PdCuH025_o1 = 3.8880;
68
 a_PdCuH025_o2 = 3.8785;
 a_PdCuH025_T = 3.9062;
 a_PdCuH050_O1_O2 = 3.9429;
 a_PdCuH050_O2_O2 = 3.9347;
 a_PdCuH050_T = 3.9858;
 a_PdCuH075_O1_O2_O2 = 3.9871;
 a_PdCuH075_O2_O2_O2 = 3.9761;
 a_PdCuH075_T = 4.0602;
 a_PdCuH100_O1_O2_O2_O2 = 4.0366;
 a_PdCuH100_T = 4.1399;
 Ec_exp_PdCuH000 = -3.8775;
 Ec_exp_PdCuH025_O1 = -3.6198;
 Ec_exp_PdCuH025_O2 = -3.5912;
 Ec_exp_PdCuH025_T = -3.5748;
 Ec_exp_PdCuH050_O1_O2 = -3.4351;
 Ec_exp_PdCuH050_O2_O2 = -3.3999;
 Ec_exp_PdCuH050_T = -3.3899;
 Ec_exp_PdCuH075_O1_O2_O2 = -3.2973;
 Ec_exp_PdCuH075_O2_O2_O2 = -3.2617;
 Ec_exp_PdCuH075_T = -3.2644;
 Ec_exp_PdCuH100_O1_O2_O2_O2 = -3.1773;
 Ec_exp_PdCuH100_T = -3.1475;
 a_PdCuH025_TE1 = 3.9062;
 a_PdCuH050_TE3_TE4 = 3.9857;
 a_PdCuH050_TE1_TE8 = 4.0036;
 a_PdCuH075_TE1_TE2_TE3 = 4.0417;
 a_PdCuH075_TE1_TE2_TE8 = 4.0677;
 a_PdCuH075_TE5_TE6_TE7 = 4.2134;
 a_PdCuH100_TE1_TE2_TE3_TE4 = 4.1226;
 a_PdCuH100_TE1_TE2_TE7_TE8 = 4.1330;
 a_PdCuH100_TE1_TE5_TE6_TE7 = 4.3011;
 Ec_exp_PdCuH025_TE1 = -3.5748;
 Ec_exp_PdCuH050_TE3_TE4 = -3.3899;
 Ec_exp_PdCuH050_TE1_TE8 = -3.3828;
 Ec_exp_PdCuH075_TE1_TE2_TE3 = -3.2315;
 Ec_exp_PdCuH075_TE1_TE2_TE8 = -3.2529;
 Ec_exp_PdCuH075_TE5_TE6_TE7 = -3.1415;
 Ec_exp_PdCuH100_TE1_TE2_TE3_TE4 = -3.1105;
 Ec_exp_PdCuH100_TE1_TE2_TE7_TE8 = -3.1101;
 Ec_exp_PdCuH100_TE1_TE5_TE6_TE7 = -3.0388;
 global ri_PdCuH000;
 global index_PdCuH000_Pd
 global index_PdCuH000_Cu
69
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
70
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
 global rc_1
 global rc_2
 global rc_3
 global NP
 global NP2
 global NP3
 global x_Pd
 global x_Cu
 global S_Cu
 global S_Pd
 global x_PdH
 % Pd and Cu fitting parameters
 x_Pd = [2.054085 0.216817 8.414105 7.221224 
0.999999 3.316887];
 x_Cu = [2.5045 0.175425 8.713725 6.906629 0.560027 
3.648665];
 % % % re fit scaling only mixing rule potential-Pd-Cu
 S_Pd = 1.7097;
 S_Cu = 1.3419;
 x_PdH = [0.589510 1.104827 0.942490 2.145808 
0.942201...
 0.740938 2.373944 1.702142 8.370790 
62.343273...
71
 0.000100 1.187000 1.300000 3.474173];
 NP = 0;
 NP2 = 0;
 NP3 = 0;
 rc_1 = 5.35;
 rc_2 = 5.35;
 rc_3 = 5.35;
 global ri_PdH100_OC;
 global index_PdH100_OC_1;
 load PdH100_OC_SORTED.data;
 ri_PdH100_OC = PdH100_OC_SORTED(:,:);
 ra_OC = [1 0 0 0];
 index_PdH100_OC_1 = 
find(ismember(ri_PdH100_OC,ra_OC,'rows'));
 % Position Code For Tetrahedral H Atoms
 % TE1 0.025 0.025 0.025
 % TE2 0.075 0.025 0.025
 % TE3 0.025 0.075 0.025
 % TE4 0.025 0.025 0.075
 % TE5 0.075 0.075 0.025
 % TE6 0.025 0.075 0.075
 % TE7 0.075 0.025 0.075
 % TE8 0.075 0.075 0.075
 load PdCuH000_sorted_6x6x6.data;
 load PdCuH025_O1_sorted_6x6x6.dat;
 load PdCuH025_O2_sorted_6x6x6.dat;
 load PdCuH025_T_sorted_6x6x6_25_25_25.dat;
 load PdCuH025_T_sorted_6x6x6_75_75_75.dat;
 load PdCuH025_T_sorted_6x6x6_25_75_75.dat;
 load PdCuH050_O1_O2_sorted_6x6x6.dat;
 load PdCuH050_O2_O2_sorted_6x6x6.dat;
 load PdCuH050_T_sorted_6x6x6_252525_752525.dat;
 load PdCuH050_T_sorted_6x6x6_252525_757575.dat;
 load PdCuH075_O1_O2_O2_sorted_6x6x6.dat;
 load PdCuH075_O2_O2_O2_sorted_6x6x6.dat;
 load PdCuH075_T_sorted_6x6x6.dat;
 load PdCuH100_O1_O2_O2_O2_sorted_6x6x6.dat;
 load PdCuH100_T_sorted_6x6x6.dat;
72
 % Atomic positions for structure
 ri_PdCuH000 = PdCuH000_sorted_6x6x6(:,:);
 ri_PdCuH025_o1 = PdCuH025_O1_sorted_6x6x6(:,:);
 ri_PdCuH025_o2 = PdCuH025_O2_sorted_6x6x6(:,:);
ri_PdCuH025_T_25_25_25 = 
PdCuH025_T_sorted_6x6x6_25_25_25(:,:);
 ri_PdCuH025_T_75_75_75 = 
PdCuH025_T_sorted_6x6x6_75_75_75(:,:);
 ri_PdCuH025_T_25_75_75 = 
PdCuH025_T_sorted_6x6x6_25_75_75(:,:);
 ri_PdCuH050_O1_O2 = PdCuH050_O1_O2_sorted_6x6x6(:,:);
 ri_PdCuH050_O2_O2 = PdCuH050_O2_O2_sorted_6x6x6(:,:);
 ri_PdCuH075_O1_O2_O2 = PdCuH075_O1_O2_O2_sorted_6x6x6(:,:);
 ri_PdCuH075_O2_O2_O2 = PdCuH075_O2_O2_O2_sorted_6x6x6(:,:);
 ri_PdCuH075_T = PdCuH075_T_sorted_6x6x6(:,:);
 ri_PdCuH100_O1_O2_O2_O2 = 
PdCuH100_O1_O2_O2_O2_sorted_6x6x6(:,:);
 ri_PdCuH100_T = PdCuH100_T_sorted_6x6x6(:,:);
 % Indices for OC central atoms
 ra_1 = [1 1 1 0]; % face center Pd
 ra_2 = [2 0 0 0]; % corner Cu
 index_PdCuH000_Pd = find(ismember(ri_PdCuH000,ra_1,'rows'));
 index_PdCuH000_Cu = find(ismember(ri_PdCuH000,ra_2,'rows'));
 ra_1 = [1 1 1 0]; % face center Pd
 ra_2 = [2 0 0 0]; % corner Cu
 ra_3 = [3 1 1 1]; % body center H
 index_PdCuH025_o1_Pd = 
find(ismember(ri_PdCuH025_o1,ra_1,'rows'));
 index_PdCuH025_o1_Cu = 
find(ismember(ri_PdCuH025_o1,ra_2,'rows'));
 index_PdCuH025_o1_H = 
find(ismember(ri_PdCuH025_o1,ra_3,'rows'));
 ra_1 = [1 1 1 0]; % face center Pd
 ra_2 = [2 0 0 0]; % corner Cu
 ra_3 = [3 1 0 0]; % edge H
 index_PdCuH025_o2_Pd = 
find(ismember(ri_PdCuH025_o2,ra_1,'rows'));
 index_PdCuH025_o2_Cu = 
find(ismember(ri_PdCuH025_o2,ra_2,'rows'));
 index_PdCuH025_o2_H = 
find(ismember(ri_PdCuH025_o2,ra_3,'rows'));
 ra_1 = [1 1 1 0]; % face center Pd
73
 ra_2 = [2 0 0 0]; % corner Cu
 ra_3 = [3 .5 .5 .5]; % TE H
 index_PdCuH025_T_Pd_25_25_25 = 
find(ismember(ri_PdCuH025_T_25_25_25,ra_1,'rows'));
 index_PdCuH025_T_Cu_25_25_25 = 
find(ismember(ri_PdCuH025_T_25_25_25,ra_2,'rows'));
index_PdCuH025_T_H_25_25_25 = 
find(ismember(ri_PdCuH025_T_25_25_25,ra_3,'rows'));
 ra_1 = [1 1 1 0]; % face center Pd
 ra_2 = [2 0 0 0]; % corner Cu
 ra_3 = [3 1.5 1.5 1.5]; % TE H
 index_PdCuH025_T_Pd_75_75_75 = 
find(ismember(ri_PdCuH025_T_75_75_75,ra_1,'rows'));
 index_PdCuH025_T_Cu_75_75_75 = 
find(ismember(ri_PdCuH025_T_75_75_75,ra_2,'rows'));
 index_PdCuH025_T_H_75_75_75 = 
find(ismember(ri_PdCuH025_T_75_75_75,ra_3,'rows'));
 ra_1 = [1 1 1 0]; % face center Pd
 ra_2 = [2 0 0 0]; % corner Cu
 ra_3 = [3 .5 1.5 1.5]; % TE H
 index_PdCuH025_T_Pd_25_75_75 = 
find(ismember(ri_PdCuH025_T_25_75_75,ra_1,'rows'));
 index_PdCuH025_T_Cu_25_75_75 = 
find(ismember(ri_PdCuH025_T_25_75_75,ra_2,'rows'));
 index_PdCuH025_T_H_25_75_75 = 
find(ismember(ri_PdCuH025_T_25_75_75,ra_3,'rows'));
 ra_1 = [1 1 1 0]; % face center Pd
 ra_2 = [2 0 0 0]; % corner Cu
 ra_3 = [3 1 1 1]; % body center H
 ra_4 = [3 1 0 0]; % edge H
 index_PdCuH050_O1_O2_Pd = 
find(ismember(ri_PdCuH050_O1_O2,ra_1,'rows'));
 index_PdCuH050_O1_O2_Cu = 
find(ismember(ri_PdCuH050_O1_O2,ra_2,'rows'));
 index_PdCuH050_O1_O2_H_O1 = 
find(ismember(ri_PdCuH050_O1_O2,ra_3,'rows'));
 index_PdCuH050_O1_O2_H_O2 = 
find(ismember(ri_PdCuH050_O1_O2,ra_4,'rows'));
 ra_1 = [1 1 1 0]; % face center Pd
 ra_2 = [2 0 0 0]; % corner Cu
 ra_3 = [3 1 0 0]; % edge H
 index_PdCuH050_O2_O2_Pd = 
find(ismember(ri_PdCuH050_O2_O2,ra_1,'rows'));
74
 index_PdCuH050_O2_O2_Cu = 
find(ismember(ri_PdCuH050_O2_O2,ra_2,'rows'));
 index_PdCuH050_O2_O2_H = 
find(ismember(ri_PdCuH050_O2_O2,ra_3,'rows'));
 ri_PdCuH050_TE1_TE2 = 
PdCuH050_T_sorted_6x6x6_252525_752525(:,:);
 global ri_PdCuH050_TE1_TE2;
 global index_PdCuH050_TE1_TE2_Pd
 global index_PdCuH050_TE1_TE2_Cu
 global index_PdCuH050_TE1_TE2_H_TE1
 global index_PdCuH050_TE1_TE2_H_TE2
 ra_1 = [1 1 1 0]; % face center Pd
 ra_2 = [2 0 0 0]; % corner Cu
 ra_3 = [3 .5 .5 .5]; % TE H
 ra_4 = [3 1.5 .5 .5]; % TE H
 index_PdCuH050_TE1_TE2_Pd = 
find(ismember(ri_PdCuH050_TE1_TE2,ra_1,'rows'));
 index_PdCuH050_TE1_TE2_Cu = 
find(ismember(ri_PdCuH050_TE1_TE2,ra_2,'rows'));
 index_PdCuH050_TE1_TE2_H_TE1 = 
find(ismember(ri_PdCuH050_TE1_TE2,ra_3,'rows'));
 index_PdCuH050_TE1_TE2_H_TE2 = 
find(ismember(ri_PdCuH050_TE1_TE2,ra_4,'rows'));
 ri_PdCuH050_TE1_TE8 = 
PdCuH050_T_sorted_6x6x6_252525_757575(:,:);
 global ri_PdCuH050_TE1_TE8;
 global index_PdCuH050_TE1_TE8_Pd
 global index_PdCuH050_TE1_TE8_Cu
 global index_PdCuH050_TE1_TE8_H_TE1
 global index_PdCuH050_TE1_TE8_H_TE8
 ra_1 = [1 1 1 0]; % face center Pd
 ra_2 = [2 0 0 0]; % corner Cu
 ra_3 = [3 .5 .5 .5]; % TE H
 ra_4 = [3 1.5 1.5 1.5]; % TE H
 index_PdCuH050_TE1_TE8_Pd = 
find(ismember(ri_PdCuH050_TE1_TE8,ra_1,'rows'));
 index_PdCuH050_TE1_TE8_Cu = 
find(ismember(ri_PdCuH050_TE1_TE8,ra_2,'rows'));
 index_PdCuH050_TE1_TE8_H_TE1 = 
find(ismember(ri_PdCuH050_TE1_TE8,ra_3,'rows'));
75
 index_PdCuH050_TE1_TE8_H_TE8 = 
find(ismember(ri_PdCuH050_TE1_TE8,ra_4,'rows'));
 ra_1 = [1 1 1 0]; % face center Pd
 ra_2 = [2 0 0 0]; % corner Cu
 ra_3 = [3 1 1 1]; % body center H
 ra_4 = [3 1 0 0]; % edge H
 index_PdCuH075_O1_O2_O2_Pd = 
find(ismember(ri_PdCuH075_O1_O2_O2,ra_1,'rows'));
 index_PdCuH075_O1_O2_O2_Cu = 
find(ismember(ri_PdCuH075_O1_O2_O2,ra_2,'rows'));
 index_PdCuH075_O1_O2_O2_H_O1 = 
find(ismember(ri_PdCuH075_O1_O2_O2,ra_3,'rows'));
 index_PdCuH075_O1_O2_O2_H_O2 = 
find(ismember(ri_PdCuH075_O1_O2_O2,ra_4,'rows'));
 ra_1 = [1 1 1 0]; % face center Pd
 ra_2 = [2 0 0 0]; % corner Cu
 ra_3 = [3 1 0 0]; % edge H
 % ra_3 = [3 0 0 1]; % edge H
 index_PdCuH075_O2_O2_O2_Pd = 
find(ismember(ri_PdCuH075_O2_O2_O2,ra_1,'rows'));
 index_PdCuH075_O2_O2_O2_Cu = 
find(ismember(ri_PdCuH075_O2_O2_O2,ra_2,'rows'));
 index_PdCuH075_O2_O2_O2_H = 
find(ismember(ri_PdCuH075_O2_O2_O2,ra_3,'rows'));
 ra_1 = [1 1 1 0]; % face center Pd
 ra_2 = [2 0 0 0]; % corner Cu
 ra_3 = [3 .5 .5 .5]; % TE H
 % ra_4 = [3 1.5 .5 .5]; % TE H
 index_PdCuH075_T_Pd = 
find(ismember(ri_PdCuH075_T,ra_1,'rows'));
 index_PdCuH075_T_Cu = 
find(ismember(ri_PdCuH075_T,ra_2,'rows'));
 index_PdCuH075_T_H = 
find(ismember(ri_PdCuH075_T,ra_3,'rows'));
 ra_1 = [1 1 1 0]; % face center Pd
 ra_2 = [2 0 0 0]; % corner Cu
 ra_3 = [3 1 1 1]; % body center H
 ra_4 = [3 1 0 0]; % edge H
 index_PdCuH100_O1_O2_O2_O2_Pd = 
find(ismember(ri_PdCuH100_O1_O2_O2_O2,ra_1,'rows'));
 index_PdCuH100_O1_O2_O2_O2_Cu = 
find(ismember(ri_PdCuH100_O1_O2_O2_O2,ra_2,'rows'));
76
 index_PdCuH100_O1_O2_O2_O2_H_O1 = 
find(ismember(ri_PdCuH100_O1_O2_O2_O2,ra_3,'rows'));
 index_PdCuH100_O1_O2_O2_O2_H_O2 = 
find(ismember(ri_PdCuH100_O1_O2_O2_O2,ra_4,'rows'));
 ra_1 = [1 1 1 0]; % face center Pd
 ra_2 = [2 0 0 0]; % corner Cu
 ra_3 = [3 .5 .5 .5]; % TE H
 index_PdCuH100_T_Pd = 
find(ismember(ri_PdCuH100_T,ra_1,'rows'));
 index_PdCuH100_T_Cu = 
find(ismember(ri_PdCuH100_T,ra_2,'rows'));
 index_PdCuH100_T_H = 
find(ismember(ri_PdCuH100_T,ra_3,'rows'));
 load PdCuH050_T_sorted_6x6x6_TE3_TE4.dat;
 load PdCuH050_T_sorted_6x6x6_TE3_TE6.dat;
 load PdCuH075_T_sorted_6x6x6_TE1_TE2_TE3.dat;
 load PdCuH075_T_sorted_6x6x6_TE1_TE2_TE8.dat;
 load PdCuH100_T_sorted_6x6x6_TE1_TE2_TE3_TE4.dat;
 load PdCuH100_T_sorted_6x6x6_TE1_TE2_TE7_TE8.dat;
 global ri_PdCuH050_TE3_TE4
 global index_PdCuH050_TE3_TE4_Pd
 global index_PdCuH050_TE3_TE4_Cu
 global index_PdCuH050_TE3_TE4_H_TE3
 global index_PdCuH050_TE3_TE4_H_TE4
 ri_PdCuH050_TE3_TE4 = PdCuH050_T_sorted_6x6x6_TE3_TE4(:,:);
 ra_1 = [1 1 1 0]; % face center Pd
 ra_2 = [2 0 0 0]; % corner Cu
 ra_3 = [3 .5 1.5 .5]; % TE H
 ra_4 = [3 .5 .5 1.5]; % TE H
 index_PdCuH050_TE3_TE4_Pd = 
find(ismember(ri_PdCuH050_TE3_TE4,ra_1,'rows'));
 index_PdCuH050_TE3_TE4_Cu = 
find(ismember(ri_PdCuH050_TE3_TE4,ra_2,'rows'));
 index_PdCuH050_TE3_TE4_H_TE3 = 
find(ismember(ri_PdCuH050_TE3_TE4,ra_3,'rows'));
 index_PdCuH050_TE3_TE4_H_TE4 = 
find(ismember(ri_PdCuH050_TE3_TE4,ra_4,'rows'));
 global ri_PdCuH050_TE3_TE6
 global index_PdCuH050_TE3_TE6_Pd
 global index_PdCuH050_TE3_TE6_Cu
 global index_PdCuH050_TE3_TE6_H_TE3
77
 global index_PdCuH050_TE3_TE6_H_TE6
 ri_PdCuH050_TE3_TE6 = PdCuH050_T_sorted_6x6x6_TE3_TE6(:,:);
 ra_1 = [1 1 1 0]; % face center Pd
 ra_2 = [2 0 0 0]; % corner Cu
 ra_3 = [3 .5 1.5 .5]; % TE H
 ra_4 = [3 .5 1.5 1.5]; % TE H
 index_PdCuH050_TE3_TE6_Pd = 
find(ismember(ri_PdCuH050_TE3_TE6,ra_1,'rows'));
 index_PdCuH050_TE3_TE6_Cu = 
find(ismember(ri_PdCuH050_TE3_TE6,ra_2,'rows'));
 index_PdCuH050_TE3_TE6_H_TE3 = 
find(ismember(ri_PdCuH050_TE3_TE6,ra_3,'rows'));
 index_PdCuH050_TE3_TE6_H_TE6 = 
find(ismember(ri_PdCuH050_TE3_TE6,ra_4,'rows'));
 global ri_PdCuH075_TE1_TE2_TE3
 global index_PdCuH075_TE1_TE2_TE3_Pd
 global index_PdCuH075_TE1_TE2_TE3_Cu
 global index_PdCuH075_TE1_TE2_TE3_H_TE1
 global index_PdCuH075_TE1_TE2_TE3_H_TE2
 global index_PdCuH075_TE1_TE2_TE3_H_TE3
 ri_PdCuH075_TE1_TE2_TE3 = 
PdCuH075_T_sorted_6x6x6_TE1_TE2_TE3(:,:);
 ra_1 = [1 1 1 0]; % face center Pd
 ra_2 = [2 0 0 0]; % corner Cu
 ra_3 = [3 .5 .5 .5]; % TE H
 ra_4 = [3 1.5 .5 .5]; % TE H
 ra_5 = [3 .5 1.5 .5]; % TE H
 index_PdCuH075_TE1_TE2_TE3_Pd = 
find(ismember(ri_PdCuH075_TE1_TE2_TE3,ra_1,'rows'));
 index_PdCuH075_TE1_TE2_TE3_Cu = 
find(ismember(ri_PdCuH075_TE1_TE2_TE3,ra_2,'rows'));
 index_PdCuH075_TE1_TE2_TE3_H_TE1 = 
find(ismember(ri_PdCuH075_TE1_TE2_TE3,ra_3,'rows'));
 index_PdCuH075_TE1_TE2_TE3_H_TE2 = 
find(ismember(ri_PdCuH075_TE1_TE2_TE3,ra_4,'rows'));
 index_PdCuH075_TE1_TE2_TE3_H_TE3 = 
find(ismember(ri_PdCuH075_TE1_TE2_TE3,ra_5,'rows'));
 global ri_PdCuH075_TE1_TE2_TE8
 global index_PdCuH075_TE1_TE2_TE8_Pd
 global index_PdCuH075_TE1_TE2_TE8_Cu
 global index_PdCuH075_TE1_TE2_TE8_H_TE1
78
 global index_PdCuH075_TE1_TE2_TE8_H_TE2
 global index_PdCuH075_TE1_TE2_TE8_H_TE8
 ri_PdCuH075_TE1_TE2_TE8 = 
PdCuH075_T_sorted_6x6x6_TE1_TE2_TE8(:,:);
 ra_1 = [1 1 1 0]; % face center Pd
 ra_2 = [2 0 0 0]; % corner Cu
 ra_3 = [3 .5 .5 .5]; % TE H
 ra_4 = [3 1.5 .5 .5]; % TE H
 ra_5 = [3 1.5 1.5 1.5]; % TE H
 index_PdCuH075_TE1_TE2_TE8_Pd = 
find(ismember(ri_PdCuH075_TE1_TE2_TE8,ra_1,'rows'));
 index_PdCuH075_TE1_TE2_TE8_Cu = 
find(ismember(ri_PdCuH075_TE1_TE2_TE8,ra_2,'rows'));
 index_PdCuH075_TE1_TE2_TE8_H_TE1 = 
find(ismember(ri_PdCuH075_TE1_TE2_TE8,ra_3,'rows'));
 index_PdCuH075_TE1_TE2_TE8_H_TE2 = 
find(ismember(ri_PdCuH075_TE1_TE2_TE8,ra_4,'rows'));
 index_PdCuH075_TE1_TE2_TE8_H_TE8 = 
find(ismember(ri_PdCuH075_TE1_TE2_TE8,ra_5,'rows'));
 global ri_PdCuH100_TE1_TE2_TE3_TE4
 global index_PdCuH100_TE1_TE2_TE3_TE4_Pd
 global index_PdCuH100_TE1_TE2_TE3_TE4_Cu
 global index_PdCuH100_TE1_TE2_TE3_TE4_H_TE1
 global index_PdCuH100_TE1_TE2_TE3_TE4_H_TE2
 global index_PdCuH100_TE1_TE2_TE3_TE4_H_TE3
 global index_PdCuH100_TE1_TE2_TE3_TE4_H_TE4
 ri_PdCuH100_TE1_TE2_TE3_TE4 = 
PdCuH100_T_sorted_6x6x6_TE1_TE2_TE3_TE4(:,:);
 ra_1 = [1 1 1 0]; % face center Pd
 ra_2 = [2 0 0 0]; % corner Cu
 ra_3 = [3 .5 .5 .5]; % TE H
 ra_4 = [3 1.5 .5 .5]; % TE H
 ra_5 = [3 .5 1.5 .5]; % TE H
 ra_6 = [3 .5 .5 1.5]; % TE H
 index_PdCuH100_TE1_TE2_TE3_TE4_Pd = 
find(ismember(ri_PdCuH100_TE1_TE2_TE3_TE4,ra_1,'rows'));
 index_PdCuH100_TE1_TE2_TE3_TE4_Cu = 
find(ismember(ri_PdCuH100_TE1_TE2_TE3_TE4,ra_2,'rows'));
 index_PdCuH100_TE1_TE2_TE3_TE4_H_TE1 = 
find(ismember(ri_PdCuH100_TE1_TE2_TE3_TE4,ra_3,'rows'));
 index_PdCuH100_TE1_TE2_TE3_TE4_H_TE2 = 
find(ismember(ri_PdCuH100_TE1_TE2_TE3_TE4,ra_4,'rows'));
79
 index_PdCuH100_TE1_TE2_TE3_TE4_H_TE3 = 
find(ismember(ri_PdCuH100_TE1_TE2_TE3_TE4,ra_5,'rows'));
 index_PdCuH100_TE1_TE2_TE3_TE4_H_TE4 = 
find(ismember(ri_PdCuH100_TE1_TE2_TE3_TE4,ra_6,'rows'));
 global ri_PdCuH100_TE1_TE2_TE7_TE8
 global index_PdCuH100_TE1_TE2_TE7_TE8_Pd
 global index_PdCuH100_TE1_TE2_TE7_TE8_Cu
 global index_PdCuH100_TE1_TE2_TE7_TE8_H_TE1
 global index_PdCuH100_TE1_TE2_TE7_TE8_H_TE2
 global index_PdCuH100_TE1_TE2_TE7_TE8_H_TE7
 global index_PdCuH100_TE1_TE2_TE7_TE8_H_TE8
 ri_PdCuH100_TE1_TE2_TE7_TE8 = 
PdCuH100_T_sorted_6x6x6_TE1_TE2_TE7_TE8(:,:);
 ra_1 = [1 1 1 0]; % face center Pd
 ra_2 = [2 0 0 0]; % corner Cu
 ra_3 = [3 .5 .5 .5]; % TE H
 ra_4 = [3 1.5 .5 .5]; % TE H
 ra_5 = [3 1.5 .5 1.5]; % TE H
 ra_6 = [3 1.5 1.5 1.5]; % TE H
 index_PdCuH100_TE1_TE2_TE7_TE8_Pd = 
find(ismember(ri_PdCuH100_TE1_TE2_TE7_TE8,ra_1,'rows'));
 index_PdCuH100_TE1_TE2_TE7_TE8_Cu = 
find(ismember(ri_PdCuH100_TE1_TE2_TE7_TE8,ra_2,'rows'));
 index_PdCuH100_TE1_TE2_TE7_TE8_H_TE1 = 
find(ismember(ri_PdCuH100_TE1_TE2_TE7_TE8,ra_3,'rows'));
 index_PdCuH100_TE1_TE2_TE7_TE8_H_TE2 = 
find(ismember(ri_PdCuH100_TE1_TE2_TE7_TE8,ra_4,'rows'));
 index_PdCuH100_TE1_TE2_TE7_TE8_H_TE7 = 
find(ismember(ri_PdCuH100_TE1_TE2_TE7_TE8,ra_5,'rows'));
 index_PdCuH100_TE1_TE2_TE7_TE8_H_TE8 = 
find(ismember(ri_PdCuH100_TE1_TE2_TE7_TE8,ra_6,'rows'));
 % Used in Thesis
 Xl_CuH = [0.78 2.1 1.7 1.9];
 X0_CuH = [0.755217 2.16562 1.76185 
2.3539];
 Xu_CuH = [0.8 2.2 1.8 2];
 tic
 options.MaxFunEvals = 70000;
 options.TolFun = 1.00e-7;
 options.TolX = 1.00e-7;
80
 % Perform Constrained Optimization
 [x,fval] = 
fmincon(@objfun_18_07_09,X0_CuH,[],[],[],[],Xl_CuH,Xu_CuH,[],
options)
 % stop timer
 toc
 Check_Fit_18_07_09(x,false,false)
 objfun_18_07_09(x);
 format long
 x
end