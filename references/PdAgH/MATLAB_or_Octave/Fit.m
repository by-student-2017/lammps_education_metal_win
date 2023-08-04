function EAM_Parameters_Fitting 
 
 global a_PdAgH025_o1;
 global a_PdAgH025_o2;
 global a_PdAgH025_T;
 global a_PdAgH050_O1_O2;
 global a_PdAgH050_O2_O2;
 global a_PdAgH050_T;
 global a_PdAgH075_O1_O2_O2;
 global a_PdAgH075_O2_O2_O2;
 global a_PdAgH075_T; 
 global a_PdAgH100_O1_O2_O2_O2;
 global a_PdAgH100_T; 
 
 
 global Ec_exp_PdAgH025_O1;
 global Ec_exp_PdAgH025_O2;
 global Ec_exp_PdAgH025_T;
 global Ec_exp_PdAgH050_O1_O2;
 global Ec_exp_PdAgH050_O2_O2;
 global Ec_exp_PdAgH050_T;
 global Ec_exp_PdAgH075_O1_O2_O2;
 global Ec_exp_PdAgH075_O2_O2_O2;
 global Ec_exp_PdAgH075_T; 
 global Ec_exp_PdAgH100_O1_O2_O2_O2;
 global Ec_exp_PdAgH100_T; 
 
 
 global a_PdAgH025_TE1
 global a_PdAgH025_TE6
 global a_PdAgH025_TE8
 global a_PdAgH050_TE1_TE2
 global a_PdAgH050_TE3_TE4
 global a_PdAgH050_TE3_TE6
 global a_PdAgH050_TE1_TE8
 global a_PdAgH075_TE1_TE2_TE3
 global a_PdAgH075_TE1_TE2_TE8
 global a_PdAgH075_TE5_TE6_TE7
 global a_PdAgH100_TE1_TE2_TE3_TE4
 global a_PdAgH100_TE1_TE2_TE7_TE8

 global a_PdAgH100_TE1_TE5_TE6_TE7 
 
 global Ec_exp_PdAgH025_TE1 
 global Ec_exp_PdAgH050_TE3_TE4
 global Ec_exp_PdAgH050_TE1_TE8 
 global Ec_exp_PdAgH075_TE1_TE2_TE3
 global Ec_exp_PdAgH075_TE1_TE2_TE8
 global Ec_exp_PdAgH075_TE5_TE6_TE7
 global Ec_exp_PdAgH100_TE1_TE2_TE3_TE4
 global Ec_exp_PdAgH100_TE1_TE2_TE7_TE8
 global Ec_exp_PdAgH100_TE1_TE5_TE6_TE7
 
% % % spin polarized 18x18x18 kgrid CG results factor shifted
 a_PdAgH025_o1 = 4.0042;
 a_PdAgH025_o2 = 4.0056;
 a_PdAgH050_O1_O2 = 4.0663;
 a_PdAgH050_O2_O2 = 4.0800;
 a_PdAgH075_O1_O2_O2 = 4.1277;
 a_PdAgH075_O2_O2_O2 = 4.1315;
 a_PdAgH075_T = 4.2134;
 a_PdAgH100_O1_O2_O2_O2 = 4.1848;
 a_PdAgH100_T = 4.3011;
 Ec_exp_PdAgH025_O1 = -3.4634;
 Ec_exp_PdAgH025_O2 = -3.4045;
 Ec_exp_PdAgH025_T = -3.4633;
 Ec_exp_PdAgH050_O1_O2 = -3.2946;
 Ec_exp_PdAgH050_O2_O2 = -3.2416; 
 Ec_exp_PdAgH050_T = -3.2556; 
 Ec_exp_PdAgH075_O1_O2_O2 = -3.1677;
 Ec_exp_PdAgH075_O2_O2_O2 = -3.1008;
 Ec_exp_PdAgH075_T = -3.1415; 
 Ec_exp_PdAgH100_O1_O2_O2_O2 = -3.0465;
 Ec_exp_PdAgH100_T = -3.0388;
 a_PdAgH025_TE1 = 4.0016;
 a_PdAgH025_TE6 = 4.0016;
 a_PdAgH025_TE8 = 4.0016;
 
 a_PdAgH050_TE1_TE2 = 4.1239;
 a_PdAgH050_TE3_TE4 = 4.1239;
 a_PdAgH050_TE3_TE6 = 4.1239;
 a_PdAgH050_TE1_TE8 = 4.1387;
 a_PdAgH075_TE1_TE2_TE3 = 4.2027;
 a_PdAgH075_TE1_TE2_TE8 = 4.2203;
 a_PdAgH075_TE5_TE6_TE7 = 4.2134;
 a_PdAgH100_TE1_TE2_TE3_TE4 = 4.2874;
 a_PdAgH100_TE1_TE2_TE7_TE8 = 4.2983;
 a_PdAgH100_TE1_TE5_TE6_TE7 = 4.3011; 
 Ec_exp_PdAgH025_TE1 = -3.4633;
 Ec_exp_PdAgH050_TE3_TE4 = -3.2556;
 Ec_exp_PdAgH050_TE1_TE8 = -3.2559;
 Ec_exp_PdAgH075_TE1_TE2_TE3 = -3.1126;
 Ec_exp_PdAgH075_TE1_TE2_TE8 = -3.1339;
 Ec_exp_PdAgH075_TE5_TE6_TE7 = -3.1415;
 Ec_exp_PdAgH100_TE1_TE2_TE3_TE4 = -3.0009;
 Ec_exp_PdAgH100_TE1_TE2_TE7_TE8 = -3.0065;
 Ec_exp_PdAgH100_TE1_TE5_TE6_TE7 = -3.0388; 
 
 
 global rc_1
 global rc_2
 global rc_3 
 
 rc_1 = 5.35;
 rc_2 = 5.35;
 rc_3 = 5.35;
 
 
 global x_Pd
 global x_Ag
 
 global S_Ag
 global S_Pd
 
 global x_PdH
 
% % % Hijazi Yang Pd
 x_Pd = [2.054085 0.216817 8.414105 7.221224 0.999999 
3.316887];
% % % 
 x_Ag = [1.584768032776473 0.154164182657381 8.491335427574112...
 7.183185289310671 1.022270092304303 2.213230197455566];
% % % re fit scaling only mixing rule potential
 S_Ag = 1.8319;
 S_Pd = 1.1063;
 x_PdH = [0.589510 1.104827 0.942490 2.145808 0.942201...
 0.740938 2.373944 1.702142 8.370790 62.343273...
 0.000100 1.187000 1.300000 3.474173];
% % % Position Code For Tetrahedral H Atoms
% % % TE1 0.025 0.025 0.025
% % % TE2 0.075 0.025 0.025
% % % TE3 0.025 0.075 0.025
% % % TE4 0.025 0.025 0.075
% % % TE5 0.075 0.075 0.025
% % % TE6 0.025 0.075 0.075
% % % TE7 0.075 0.025 0.075
% % % TE8 0.075 0.075 0.075
 
% % % Load Pd075Ag025H000 structure and find indices
 global ri_PdAgH000;
 global index_PdAgH000_Pd
 global index_PdAgH000_Ag 
 load PdAgH000_sorted_6x6x6.data; 
 ri_PdAgH000 = PdAgH000_sorted_6x6x6(:,:);
 ra_1 = [1 1 1 0]; % face center Pd
 ra_2 = [2 0 0 0]; % corner Ag
 index_PdAgH000_Pd = find(ismember(ri_PdAgH000,ra_1,'rows'));
 index_PdAgH000_Ag = find(ismember(ri_PdAgH000,ra_2,'rows')); 
 
 
% % % Load Pd075Ag025H025 (O1) structure and find indices
 global ri_PdAgH025_O1;
 global index_PdAgH025_O1_Pd1
 global index_PdAgH025_O1_Pd2
 global index_PdAgH025_O1_Pd3
 global index_PdAgH025_O1_Ag
 global index_PdAgH025_O1_H
 load PdAgH025_O1_sorted_6x6x6.dat;
 ri_PdAgH025_O1 = PdAgH025_O1_sorted_6x6x6(:,:);
 ra_1 = [1 1 1 0]; % face center Pd
 ra_2 = [1 1 0 1]; % face center Pd
 ra_3 = [1 0 1 1]; % face center Pd
 ra_4 = [2 0 0 0]; % corner Ag
 ra_5 = [3 1 1 1]; % body center H 
 index_PdAgH025_O1_Pd1 = find(ismember(ri_PdAgH025_O1,ra_1,'rows'));
 index_PdAgH025_O1_Pd2 = find(ismember(ri_PdAgH025_O1,ra_2,'rows'));
 index_PdAgH025_O1_Pd3 = find(ismember(ri_PdAgH025_O1,ra_3,'rows'));
 index_PdAgH025_O1_Ag = find(ismember(ri_PdAgH025_O1,ra_4,'rows'));
 index_PdAgH025_O1_H = find(ismember(ri_PdAgH025_O1,ra_5,'rows'));
 
 
% % % Load Pd075Ag025H025 (O2) structure and find indices
 global ri_PdAgH025_o2;
 global index_PdAgH025_o2_Pd1
 global index_PdAgH025_o2_Pd2
 global index_PdAgH025_o2_Pd3
 global index_PdAgH025_o2_Ag
 global index_PdAgH025_o2_H
 load PdAgH025_O2_sorted_6x6x6.dat;
 ri_PdAgH025_o2 = PdAgH025_O2_sorted_6x6x6(:,:);
 ra_1 = [1 1 1 0]; % face center Pd
 ra_2 = [2 0 0 0]; % corner Ag
 ra_3 = [3 1 0 0]; % edge H 
 ra_4 = [1 1 0 1]; % face center Pd
 ra_5 = [1 0 1 1]; % face center Pd
 index_PdAgH025_o2_Pd1 = find(ismember(ri_PdAgH025_o2,ra_1,'rows'));
 index_PdAgH025_o2_Ag = find(ismember(ri_PdAgH025_o2,ra_2,'rows'));
 index_PdAgH025_o2_H = find(ismember(ri_PdAgH025_o2,ra_3,'rows')); 
 index_PdAgH025_o2_Pd2 = find(ismember(ri_PdAgH025_o2,ra_4,'rows'));
 index_PdAgH025_o2_Pd3 = find(ismember(ri_PdAgH025_o2,ra_5,'rows'));
% % % Load Pd075Ag025H050 (O1 O2) structure and find indices
 global ri_PdAgH050_O1_O2;
 global index_PdAgH050_O1_O2_Pd1
 global index_PdAgH050_O1_O2_Pd2
 global index_PdAgH050_O1_O2_Pd3
 global index_PdAgH050_O1_O2_Ag
 global index_PdAgH050_O1_O2_H_O1 
 global index_PdAgH050_O1_O2_H_O2
 load PdAgH050_O1_O2_sorted_6x6x6.dat;
 ri_PdAgH050_O1_O2 = PdAgH050_O1_O2_sorted_6x6x6(:,:);
 ra_1 = [1 1 1 0]; % face center Pd
 ra_2 = [2 0 0 0]; % corner Ag
 ra_3 = [3 1 1 1]; % body center H 
 ra_4 = [3 1 0 0]; % edge H 
 ra_5 = [1 1 0 1]; % face center Pd
 ra_6 = [1 0 1 1]; % face center Pd
 index_PdAgH050_O1_O2_Pd1 = find(ismember(ri_PdAgH050_O1_O2,ra_1,'rows'));
 index_PdAgH050_O1_O2_Pd2 = find(ismember(ri_PdAgH050_O1_O2,ra_5,'rows'));
 index_PdAgH050_O1_O2_Pd3 = find(ismember(ri_PdAgH050_O1_O2,ra_6,'rows'));
 index_PdAgH050_O1_O2_Ag = find(ismember(ri_PdAgH050_O1_O2,ra_2,'rows'));
 index_PdAgH050_O1_O2_H_O1 = 
find(ismember(ri_PdAgH050_O1_O2,ra_3,'rows')); 
 index_PdAgH050_O1_O2_H_O2 = 
find(ismember(ri_PdAgH050_O1_O2,ra_4,'rows')); 
 
% % % Load Pd075Ag025H050 (O2 O2) structure and find indices
 global ri_PdAgH050_O2_O2;
 global index_PdAgH050_O2_O2_Pd1
 global index_PdAgH050_O2_O2_Pd2
 global index_PdAgH050_O2_O2_Pd3
 global index_PdAgH050_O2_O2_Ag
 global index_PdAgH050_O2_O2_H1
 global index_PdAgH050_O2_O2_H3 
 load PdAgH050_O2_O2_sorted_6x6x6.dat;
 ri_PdAgH050_O2_O2 = PdAgH050_O2_O2_sorted_6x6x6(:,:);
 ra_1 = [1 1 1 0]; % face center Pd
 ra_2 = [2 0 0 0]; % corner Ag
 ra_3 = [3 1 0 0]; % edge H 
 ra_4 = [3 0 0 1]; % edge H 
 ra_5 = [1 1 0 1]; % face center Pd
 ra_6 = [1 0 1 1]; % face center Pd
 index_PdAgH050_O2_O2_Pd1 = find(ismember(ri_PdAgH050_O2_O2,ra_1,'rows'));
 index_PdAgH050_O2_O2_Pd2 = find(ismember(ri_PdAgH050_O2_O2,ra_5,'rows'));
 index_PdAgH050_O2_O2_Pd3 = find(ismember(ri_PdAgH050_O2_O2,ra_6,'rows'));
 index_PdAgH050_O2_O2_Ag = find(ismember(ri_PdAgH050_O2_O2,ra_2,'rows'));
 index_PdAgH050_O2_O2_H1 = find(ismember(ri_PdAgH050_O2_O2,ra_3,'rows'));
 index_PdAgH050_O2_O2_H3 = find(ismember(ri_PdAgH050_O2_O2,ra_4,'rows'));
 
% % % Load Pd075Ag025H025 (TE1) structure and find indices
 global ri_PdAgH025_TE1;
 global index_PdAgH025_TE1_Pd
 global index_PdAgH025_TE1_Ag
 global index_PdAgH025_TE1_H
 load PdAgH025_T_sorted_6x6x6_TE1.dat
 ri_PdAgH025_TE1 = PdAgH025_T_sorted_6x6x6_TE1(:,:); 
 ra_1 = [1 1 1 0]; % face center Pd
 ra_2 = [2 0 0 0]; % corner Ag
 ra_3 = [3 .5 .5 .5]; % TE H 
 index_PdAgH025_TE1_Pd = find(ismember(ri_PdAgH025_TE1,ra_1,'rows'));
 index_PdAgH025_TE1_Ag = find(ismember(ri_PdAgH025_TE1,ra_2,'rows'));
 index_PdAgH025_TE1_H = find(ismember(ri_PdAgH025_TE1,ra_3,'rows')); 
 
 
% % % Load Pd075Ag025H025 (TE6) structure and find indices
 global ri_PdAgH025_TE6;
 global index_PdAgH025_TE6_Pd
 global index_PdAgH025_TE6_Ag
 global index_PdAgH025_TE6_H
 load PdAgH025_T_sorted_6x6x6_TE6.dat
 ri_PdAgH025_TE6 = PdAgH025_T_sorted_6x6x6_TE6(:,:); 
 ra_1 = [1 1 1 0]; % face center Pd
 ra_2 = [2 0 0 0]; % corner Ag
 ra_3 = [3 .5 1.5 1.5]; % TE H 
 index_PdAgH025_TE6_Pd = find(ismember(ri_PdAgH025_TE6,ra_1,'rows'));
 index_PdAgH025_TE6_Ag = find(ismember(ri_PdAgH025_TE6,ra_2,'rows'));
 index_PdAgH025_TE6_H = find(ismember(ri_PdAgH025_TE6,ra_3,'rows')); 
 
 
% % % Load Pd075Ag025H025 (TE8) structure and find indices
 global ri_PdAgH025_TE8;
 global index_PdAgH025_TE8_Pd
 global index_PdAgH025_TE8_Ag
 global index_PdAgH025_TE8_H
 load PdAgH025_T_sorted_6x6x6_TE8.dat
 ri_PdAgH025_TE8 = PdAgH025_T_sorted_6x6x6_TE8(:,:); 
 ra_1 = [1 1 1 0]; % face center Pd
 ra_2 = [2 0 0 0]; % corner Ag
 ra_3 = [3 1.5 1.5 1.5]; % TE H 
 index_PdAgH025_TE8_Pd = find(ismember(ri_PdAgH025_TE8,ra_1,'rows'));
 index_PdAgH025_TE8_Ag = find(ismember(ri_PdAgH025_TE8,ra_2,'rows'));
 index_PdAgH025_TE8_H = find(ismember(ri_PdAgH025_TE8,ra_3,'rows')); 
 
 
% % % Load Pd075Ag025H050 (TE1 TE2) structure and find indices
 global ri_PdAgH050_TE1_TE2;
 global index_PdAgH050_TE1_TE2_Pd1
 global index_PdAgH050_TE1_TE2_Pd2
 global index_PdAgH050_TE1_TE2_Pd3
 global index_PdAgH050_TE1_TE2_Ag
 global index_PdAgH050_TE1_TE2_H_TE1 
 global index_PdAgH050_TE1_TE2_H_TE2 
 load PdAgH050_T_sorted_6x6x6_TE1_TE2.dat
 ri_PdAgH050_TE1_TE2 = PdAgH050_T_sorted_6x6x6_TE1_TE2(:,:); 
 ra_1 = [1 1 1 0]; % face center Pd
 ra_2 = [1 1 0 1]; % face center Pd
 ra_3 = [1 0 1 1]; % face center Pd
 ra_4 = [2 0 0 0]; % corner Ag
 ra_5 = [3 .5 .5 .5]; % TE H
 ra_6 = [3 1.5 .5 .5]; % TE H 
 index_PdAgH050_TE1_TE2_Pd1 = 
find(ismember(ri_PdAgH050_TE1_TE2,ra_1,'rows'));
 index_PdAgH050_TE1_TE2_Pd2 = 
find(ismember(ri_PdAgH050_TE1_TE2,ra_2,'rows'));
 index_PdAgH050_TE1_TE2_Pd3 = 
find(ismember(ri_PdAgH050_TE1_TE2,ra_3,'rows'));
 index_PdAgH050_TE1_TE2_Ag = 
find(ismember(ri_PdAgH050_TE1_TE2,ra_4,'rows'));
 index_PdAgH050_TE1_TE2_H_TE1 = 
find(ismember(ri_PdAgH050_TE1_TE2,ra_5,'rows'));
 index_PdAgH050_TE1_TE2_H_TE2 = 
find(ismember(ri_PdAgH050_TE1_TE2,ra_6,'rows'));
 
 
% % % Load Pd075Ag025H050 (TE1 TE8) structure and find indices
 global ri_PdAgH050_TE1_TE8;
 global index_PdAgH050_TE1_TE8_Pd
 global index_PdAgH050_TE1_TE8_Ag
 global index_PdAgH050_TE1_TE8_H_TE1 
 global index_PdAgH050_TE1_TE8_H_TE8 
 load PdAgH050_T_sorted_6x6x6_TE1_TE8.dat
 ri_PdAgH050_TE1_TE8 = PdAgH050_T_sorted_6x6x6_TE1_TE8(:,:);
 ra_1 = [1 1 1 0]; % face center Pd
 ra_2 = [2 0 0 0]; % corner Ag
 ra_3 = [3 .5 .5 .5]; % TE H 
 ra_4 = [3 1.5 1.5 1.5]; % TE H 
 index_PdAgH050_TE1_TE8_Pd = 
find(ismember(ri_PdAgH050_TE1_TE8,ra_1,'rows'));
 index_PdAgH050_TE1_TE8_Ag = 
find(ismember(ri_PdAgH050_TE1_TE8,ra_2,'rows'));
 index_PdAgH050_TE1_TE8_H_TE1 = 
find(ismember(ri_PdAgH050_TE1_TE8,ra_3,'rows'));
 index_PdAgH050_TE1_TE8_H_TE8 = 
find(ismember(ri_PdAgH050_TE1_TE8,ra_4,'rows'));
 
 
% % % Load Pd075Ag025H075 (O1 O2 O2) structure and find indices
 global ri_PdAgH075_O1_O2_O2;
 global index_PdAgH075_O1_O2_O2_Pd1
 global index_PdAgH075_O1_O2_O2_Pd2
 global index_PdAgH075_O1_O2_O2_Pd3
 global index_PdAgH075_O1_O2_O2_Ag
 global index_PdAgH075_O1_O2_O2_H1 
 global index_PdAgH075_O1_O2_O2_H2 
 global index_PdAgH075_O1_O2_O2_H3 
 load PdAgH075_O1_O2_O2_sorted_6x6x6.dat;
 ri_PdAgH075_O1_O2_O2 = PdAgH075_O1_O2_O2_sorted_6x6x6(:,:); 
 ra_1 = [1 1 1 0]; % face center Pd
 ra_5 = [1 1 0 1]; % face center Pd
 ra_6 = [1 0 1 1]; % face center Pd
 ra_2 = [2 0 0 0]; % corner Ag
 ra_3 = [3 1 1 1]; % body center H 
 ra_4 = [3 1 0 0]; % edge H 
 ra_7 = [3 0 0 1]; % edge H
 index_PdAgH075_O1_O2_O2_Pd1 = 
find(ismember(ri_PdAgH075_O1_O2_O2,ra_1,'rows'));
 index_PdAgH075_O1_O2_O2_Pd2 = 
find(ismember(ri_PdAgH075_O1_O2_O2,ra_5,'rows'));
 index_PdAgH075_O1_O2_O2_Pd3 = 
find(ismember(ri_PdAgH075_O1_O2_O2,ra_6,'rows'));
 index_PdAgH075_O1_O2_O2_Ag = 
find(ismember(ri_PdAgH075_O1_O2_O2,ra_2,'rows'));
 index_PdAgH075_O1_O2_O2_H1 = 
find(ismember(ri_PdAgH075_O1_O2_O2,ra_3,'rows')); 
 index_PdAgH075_O1_O2_O2_H2 = 
find(ismember(ri_PdAgH075_O1_O2_O2,ra_4,'rows')); 
 index_PdAgH075_O1_O2_O2_H3 = 
find(ismember(ri_PdAgH075_O1_O2_O2,ra_7,'rows')); 
 
% % % Load Pd075Ag025H075 (O2 O2 O2) structure and find indices
 global ri_PdAgH075_O2_O2_O2;
 global index_PdAgH075_O2_O2_O2_Pd1
 global index_PdAgH075_O2_O2_O2_Pd2
 global index_PdAgH075_O2_O2_O2_Pd3
 global index_PdAgH075_O2_O2_O2_Ag
 global index_PdAgH075_O2_O2_O2_H1 
 global index_PdAgH075_O2_O2_O2_H2 
 global index_PdAgH075_O2_O2_O2_H3 
 load PdAgH075_O2_O2_O2_sorted_6x6x6.dat;
 ri_PdAgH075_O2_O2_O2 = PdAgH075_O2_O2_O2_sorted_6x6x6(:,:);
 ra_1 = [1 1 1 0]; % face center Pd
 ra_2 = [1 1 0 1]; % face center Pd
 ra_3 = [1 0 1 1]; % face center Pd
 ra_4 = [2 0 0 0]; % corner Ag
 ra_5 = [3 1 0 0]; % edge H 
 ra_6 = [3 0 1 0]; % edge H 
 ra_7 = [3 0 0 1]; % edge H 
 index_PdAgH075_O2_O2_O2_Pd1 = 
find(ismember(ri_PdAgH075_O2_O2_O2,ra_1,'rows'));
 index_PdAgH075_O2_O2_O2_Pd2 = 
find(ismember(ri_PdAgH075_O2_O2_O2,ra_2,'rows'));
 index_PdAgH075_O2_O2_O2_Pd3 = 
find(ismember(ri_PdAgH075_O2_O2_O2,ra_3,'rows'));
 index_PdAgH075_O2_O2_O2_Ag = 
find(ismember(ri_PdAgH075_O2_O2_O2,ra_4,'rows'));
 index_PdAgH075_O2_O2_O2_H1 = 
find(ismember(ri_PdAgH075_O2_O2_O2,ra_5,'rows'));
 index_PdAgH075_O2_O2_O2_H2 = 
find(ismember(ri_PdAgH075_O2_O2_O2,ra_6,'rows'));
 index_PdAgH075_O2_O2_O2_H3 = 
find(ismember(ri_PdAgH075_O2_O2_O2,ra_7,'rows'));
 
 
% % % Load structure Pd075Ag025H075 (TE5 TE6 TE7) and find indices 
 global ri_PdAgH075_T;
 global index_PdAgH075_T_Pd
 global index_PdAgH075_T_Ag
 global index_PdAgH075_T_H 
 load PdAgH075_T_sorted_6x6x6.dat;
 ri_PdAgH075_T = PdAgH075_T_sorted_6x6x6(:,:);
 ra_1 = [1 1 1 0]; % face center Pd
 ra_2 = [2 0 0 0]; % corner Ag
 ra_3 = [3 .5 .5 .5]; % TE H 
% ra_4 = [3 1.5 .5 .5]; % TE H 
 index_PdAgH075_T_Pd = find(ismember(ri_PdAgH075_T,ra_1,'rows'));
 index_PdAgH075_T_Ag = find(ismember(ri_PdAgH075_T,ra_2,'rows'));
 index_PdAgH075_T_H = find(ismember(ri_PdAgH075_T,ra_3,'rows'));
% index_PdAgH075_T_H = find(ismember(ri_PdAgH075_T,ra_4,'rows'));
% % % Load Pd075Ag025H100 (O1 O2 O2 O2) structure and find indices
 global ri_PdAgH100_O1_O2_O2_O2;
 global index_PdAgH100_O1_O2_O2_O2_Pd1
 global index_PdAgH100_O1_O2_O2_O2_Pd2
 global index_PdAgH100_O1_O2_O2_O2_Pd3
 global index_PdAgH100_O1_O2_O2_O2_Ag
 global index_PdAgH100_O1_O2_O2_O2_H1 
 global index_PdAgH100_O1_O2_O2_O2_H2
 global index_PdAgH100_O1_O2_O2_O2_H3
 global index_PdAgH100_O1_O2_O2_O2_H4
 load PdAgH100_O1_O2_O2_O2_sorted_6x6x6.dat;
 ri_PdAgH100_O1_O2_O2_O2 = PdAgH100_O1_O2_O2_O2_sorted_6x6x6(:,:);
 ra_1 = [1 1 1 0]; % face center Pd
 ra_5 = [1 1 0 1]; % face center Pd
 ra_6 = [1 0 1 1]; % face center Pd
 ra_2 = [2 0 0 0]; % corner Ag
 ra_3 = [3 1 1 1]; % body center H 
 ra_4 = [3 1 0 0]; % edge H 
 ra_7 = [3 0 1 0]; % edge H 
 ra_8 = [3 0 0 1]; % edge H 
 index_PdAgH100_O1_O2_O2_O2_Pd1 = 
find(ismember(ri_PdAgH100_O1_O2_O2_O2,ra_1,'rows'));
 index_PdAgH100_O1_O2_O2_O2_Pd2 = 
find(ismember(ri_PdAgH100_O1_O2_O2_O2,ra_5,'rows'));
 index_PdAgH100_O1_O2_O2_O2_Pd3 = 
find(ismember(ri_PdAgH100_O1_O2_O2_O2,ra_6,'rows'));
 index_PdAgH100_O1_O2_O2_O2_Ag = 
find(ismember(ri_PdAgH100_O1_O2_O2_O2,ra_2,'rows'));
 index_PdAgH100_O1_O2_O2_O2_H1 = 
find(ismember(ri_PdAgH100_O1_O2_O2_O2,ra_3,'rows')); 
 index_PdAgH100_O1_O2_O2_O2_H2 = 
find(ismember(ri_PdAgH100_O1_O2_O2_O2,ra_4,'rows')); 
 index_PdAgH100_O1_O2_O2_O2_H3 = 
find(ismember(ri_PdAgH100_O1_O2_O2_O2,ra_7,'rows')); 
 index_PdAgH100_O1_O2_O2_O2_H4 = 
find(ismember(ri_PdAgH100_O1_O2_O2_O2,ra_8,'rows')); 
 
% % % Load Pd075Ag025H100 (TE1 TE5 TE6 TE7) structure and find indices
 global ri_PdAgH100_T;
 global index_PdAgH100_T_Pd
 global index_PdAgH100_T_Ag
 global index_PdAgH100_T_H 
 load PdAgH100_T_sorted_6x6x6.dat;
 ri_PdAgH100_T = PdAgH100_T_sorted_6x6x6(:,:);
 ra_1 = [1 1 1 0]; % face center Pd
 ra_2 = [2 0 0 0]; % corner Ag
 ra_3 = [3 .5 .5 .5]; % TE H 
% ra_4 = [3 1.5 .5 .5]; % TE H 
 index_PdAgH100_T_Pd = find(ismember(ri_PdAgH100_T,ra_1,'rows'));
 index_PdAgH100_T_Ag = find(ismember(ri_PdAgH100_T,ra_2,'rows'));
 index_PdAgH100_T_H = find(ismember(ri_PdAgH100_T,ra_3,'rows'));
% index_PdAgH100_T_H = find(ismember(ri_PdAgH100_T,ra_4,'rows'));
% % % Load Pd075Ag025H050 (TE3 TE4) structure and find indices
 global ri_PdAgH050_TE3_TE4
 global index_PdAgH050_TE3_TE4_Pd
 global index_PdAgH050_TE3_TE4_Ag
 global index_PdAgH050_TE3_TE4_H_TE3
 global index_PdAgH050_TE3_TE4_H_TE4 
 load PdAgH050_T_sorted_6x6x6_TE3_TE4.dat;
 ri_PdAgH050_TE3_TE4 = PdAgH050_T_sorted_6x6x6_TE3_TE4(:,:);
 ra_1 = [1 1 1 0]; % face center Pd
 ra_2 = [2 0 0 0]; % corner Ag
 ra_3 = [3 .5 1.5 .5]; % TE H 
 ra_4 = [3 .5 .5 1.5]; % TE H 
 index_PdAgH050_TE3_TE4_Pd = 
find(ismember(ri_PdAgH050_TE3_TE4,ra_1,'rows'));
 index_PdAgH050_TE3_TE4_Ag = 
find(ismember(ri_PdAgH050_TE3_TE4,ra_2,'rows'));
 index_PdAgH050_TE3_TE4_H_TE3 = 
find(ismember(ri_PdAgH050_TE3_TE4,ra_3,'rows'));
 index_PdAgH050_TE3_TE4_H_TE4 = 
find(ismember(ri_PdAgH050_TE3_TE4,ra_4,'rows'));
 
% % % Load Pd075Ag025H050 (TE3 TE6) structure and find indices
 global ri_PdAgH050_TE3_TE6
 global index_PdAgH050_TE3_TE6_Pd
 global index_PdAgH050_TE3_TE6_Ag
 global index_PdAgH050_TE3_TE6_H_TE3
 global index_PdAgH050_TE3_TE6_H_TE6 
 load PdAgH050_T_sorted_6x6x6_TE3_TE6.dat;
 ri_PdAgH050_TE3_TE6 = PdAgH050_T_sorted_6x6x6_TE3_TE6(:,:);
 ra_1 = [1 1 1 0]; % face center Pd
 ra_2 = [2 0 0 0]; % corner Ag
 ra_3 = [3 .5 1.5 .5]; % TE H 
 ra_4 = [3 .5 1.5 1.5]; % TE H 
 index_PdAgH050_TE3_TE6_Pd = 
find(ismember(ri_PdAgH050_TE3_TE6,ra_1,'rows'));
 index_PdAgH050_TE3_TE6_Ag = 
find(ismember(ri_PdAgH050_TE3_TE6,ra_2,'rows'));
 index_PdAgH050_TE3_TE6_H_TE3 = 
find(ismember(ri_PdAgH050_TE3_TE6,ra_3,'rows'));
 index_PdAgH050_TE3_TE6_H_TE6 = 
find(ismember(ri_PdAgH050_TE3_TE6,ra_4,'rows'));
% % % Load Pd075Ag025H075 (TE1 TE2 TE3) structure and find indices
 global ri_PdAgH075_TE1_TE2_TE3
 global index_PdAgH075_TE1_TE2_TE3_Pd1
 global index_PdAgH075_TE1_TE2_TE3_Pd2
 global index_PdAgH075_TE1_TE2_TE3_Pd3
 global index_PdAgH075_TE1_TE2_TE3_Ag
 global index_PdAgH075_TE1_TE2_TE3_H_TE1
 global index_PdAgH075_TE1_TE2_TE3_H_TE2 
 global index_PdAgH075_TE1_TE2_TE3_H_TE3 
 load PdAgH075_T_sorted_6x6x6_TE1_TE2_TE3.dat;
 ri_PdAgH075_TE1_TE2_TE3 = PdAgH075_T_sorted_6x6x6_TE1_TE2_TE3(:,:);
 ra_1 = [1 1 1 0]; % face center Pd
 ra_2 = [1 1 0 1]; % face center Pd
 ra_3 = [1 0 1 1]; % face center Pd
 ra_4 = [2 0 0 0]; % corner Ag
 ra_5 = [3 .5 .5 .5]; % TE H 
 ra_6 = [3 1.5 .5 .5]; % TE H 
 ra_7 = [3 .5 1.5 .5]; % TE H 
 index_PdAgH075_TE1_TE2_TE3_Pd1 = 
find(ismember(ri_PdAgH075_TE1_TE2_TE3,ra_1,'rows'));
 index_PdAgH075_TE1_TE2_TE3_Pd2 = 
find(ismember(ri_PdAgH075_TE1_TE2_TE3,ra_2,'rows'));
 index_PdAgH075_TE1_TE2_TE3_Pd3 = 
find(ismember(ri_PdAgH075_TE1_TE2_TE3,ra_3,'rows'));
 index_PdAgH075_TE1_TE2_TE3_Ag = 
find(ismember(ri_PdAgH075_TE1_TE2_TE3,ra_4,'rows'));
 index_PdAgH075_TE1_TE2_TE3_H_TE1 = 
find(ismember(ri_PdAgH075_TE1_TE2_TE3,ra_5,'rows'));
 index_PdAgH075_TE1_TE2_TE3_H_TE2 = 
find(ismember(ri_PdAgH075_TE1_TE2_TE3,ra_6,'rows'));
 index_PdAgH075_TE1_TE2_TE3_H_TE3 = 
find(ismember(ri_PdAgH075_TE1_TE2_TE3,ra_7,'rows'));
% % % Load Pd075Ag025H075 (TE1 TE2 TE8) structure and find indices
 global ri_PdAgH075_TE1_TE2_TE8
 global index_PdAgH075_TE1_TE2_TE8_Pd1
 global index_PdAgH075_TE1_TE2_TE8_Pd2
 global index_PdAgH075_TE1_TE2_TE8_Pd3
 global index_PdAgH075_TE1_TE2_TE8_Ag
 global index_PdAgH075_TE1_TE2_TE8_H_TE1
 global index_PdAgH075_TE1_TE2_TE8_H_TE2 
 global index_PdAgH075_TE1_TE2_TE8_H_TE8 
 load PdAgH075_T_sorted_6x6x6_TE1_TE2_TE8.dat;
 ri_PdAgH075_TE1_TE2_TE8 = PdAgH075_T_sorted_6x6x6_TE1_TE2_TE8(:,:);
 ra_1 = [1 1 1 0]; % face center Pd
 ra_2 = [1 1 0 1]; % face center Pd
 ra_3 = [1 0 1 1]; % face center Pd
 ra_4 = [2 0 0 0]; % corner Ag
 ra_5 = [3 .5 .5 .5]; % TE H 
 ra_6 = [3 1.5 .5 .5]; % TE H 
 ra_7 = [3 1.5 1.5 1.5]; % TE H 
 index_PdAgH075_TE1_TE2_TE8_Pd1 = 
find(ismember(ri_PdAgH075_TE1_TE2_TE8,ra_1,'rows'));
 index_PdAgH075_TE1_TE2_TE8_Pd2 = 
find(ismember(ri_PdAgH075_TE1_TE2_TE8,ra_2,'rows'));
 index_PdAgH075_TE1_TE2_TE8_Pd3 = 
find(ismember(ri_PdAgH075_TE1_TE2_TE8,ra_3,'rows'));
 index_PdAgH075_TE1_TE2_TE8_Ag = 
find(ismember(ri_PdAgH075_TE1_TE2_TE8,ra_4,'rows'));
 index_PdAgH075_TE1_TE2_TE8_H_TE1 = 
find(ismember(ri_PdAgH075_TE1_TE2_TE8,ra_5,'rows'));
 index_PdAgH075_TE1_TE2_TE8_H_TE2 = 
find(ismember(ri_PdAgH075_TE1_TE2_TE8,ra_6,'rows'));
 index_PdAgH075_TE1_TE2_TE8_H_TE8 = 
find(ismember(ri_PdAgH075_TE1_TE2_TE8,ra_7,'rows'));
% % % Load Pd075Ag025H100 (TE1 TE2 TE3 TE4) structure and find indices
 global ri_PdAgH100_TE1_TE2_TE3_TE4
 global index_PdAgH100_TE1_TE2_TE3_TE4_Pd1
 global index_PdAgH100_TE1_TE2_TE3_TE4_Pd2
 global index_PdAgH100_TE1_TE2_TE3_TE4_Pd3
 global index_PdAgH100_TE1_TE2_TE3_TE4_Ag
 global index_PdAgH100_TE1_TE2_TE3_TE4_H_TE1
 global index_PdAgH100_TE1_TE2_TE3_TE4_H_TE2 
 global index_PdAgH100_TE1_TE2_TE3_TE4_H_TE3 
 global index_PdAgH100_TE1_TE2_TE3_TE4_H_TE4 
 load PdAgH100_T_sorted_6x6x6_TE1_TE2_TE3_TE4.dat;
 ri_PdAgH100_TE1_TE2_TE3_TE4 = 
PdAgH100_T_sorted_6x6x6_TE1_TE2_TE3_TE4(:,:);
 ra_1 = [1 1 1 0]; % face center Pd
 ra_2 = [1 1 0 1]; % face center Pd
 ra_3 = [1 0 1 1]; % face center Pd
 ra_4 = [2 0 0 0]; % corner Ag
 ra_5 = [3 .5 .5 .5]; % TE H 
 ra_6 = [3 1.5 .5 .5]; % TE H 
 ra_7 = [3 .5 1.5 .5]; % TE H 
 ra_8 = [3 .5 .5 1.5]; % TE H 
 index_PdAgH100_TE1_TE2_TE3_TE4_Pd1 = 
find(ismember(ri_PdAgH100_TE1_TE2_TE3_TE4,ra_1,'rows'));
 index_PdAgH100_TE1_TE2_TE3_TE4_Pd2 = 
find(ismember(ri_PdAgH100_TE1_TE2_TE3_TE4,ra_2,'rows'));
 index_PdAgH100_TE1_TE2_TE3_TE4_Pd3 = 
find(ismember(ri_PdAgH100_TE1_TE2_TE3_TE4,ra_3,'rows'));
 index_PdAgH100_TE1_TE2_TE3_TE4_Ag = 
find(ismember(ri_PdAgH100_TE1_TE2_TE3_TE4,ra_4,'rows'));
 index_PdAgH100_TE1_TE2_TE3_TE4_H_TE1 = 
find(ismember(ri_PdAgH100_TE1_TE2_TE3_TE4,ra_5,'rows'));
 index_PdAgH100_TE1_TE2_TE3_TE4_H_TE2 = 
find(ismember(ri_PdAgH100_TE1_TE2_TE3_TE4,ra_6,'rows'));
 index_PdAgH100_TE1_TE2_TE3_TE4_H_TE3 = 
find(ismember(ri_PdAgH100_TE1_TE2_TE3_TE4,ra_7,'rows'));
 index_PdAgH100_TE1_TE2_TE3_TE4_H_TE4 = 
find(ismember(ri_PdAgH100_TE1_TE2_TE3_TE4,ra_8,'rows'));
% % % Load Pd075Ag025H100 (TE1 TE2 TE7 TE8) structure and find indices
 global ri_PdAgH100_TE1_TE2_TE7_TE8
 global index_PdAgH100_TE1_TE2_TE7_TE8_Pd
 global index_PdAgH100_TE1_TE2_TE7_TE8_Ag
 global index_PdAgH100_TE1_TE2_TE7_TE8_H_TE1
 global index_PdAgH100_TE1_TE2_TE7_TE8_H_TE2 
 global index_PdAgH100_TE1_TE2_TE7_TE8_H_TE7
 global index_PdAgH100_TE1_TE2_TE7_TE8_H_TE8 
 load PdAgH100_T_sorted_6x6x6_TE1_TE2_TE7_TE8.dat;
 ri_PdAgH100_TE1_TE2_TE7_TE8 = 
PdAgH100_T_sorted_6x6x6_TE1_TE2_TE7_TE8(:,:);
 ra_1 = [1 1 1 0]; % face center Pd
 ra_2 = [2 0 0 0]; % corner Ag
 ra_3 = [3 .5 .5 .5]; % TE H 
 ra_4 = [3 1.5 .5 .5]; % TE H 
 ra_5 = [3 1.5 .5 1.5]; % TE H 
 ra_6 = [3 1.5 1.5 1.5]; % TE H 
 index_PdAgH100_TE1_TE2_TE7_TE8_Pd = 
find(ismember(ri_PdAgH100_TE1_TE2_TE7_TE8,ra_1,'rows'));
 index_PdAgH100_TE1_TE2_TE7_TE8_Ag = 
find(ismember(ri_PdAgH100_TE1_TE2_TE7_TE8,ra_2,'rows'));
 index_PdAgH100_TE1_TE2_TE7_TE8_H_TE1 = 
find(ismember(ri_PdAgH100_TE1_TE2_TE7_TE8,ra_3,'rows'));
 index_PdAgH100_TE1_TE2_TE7_TE8_H_TE2 = 
find(ismember(ri_PdAgH100_TE1_TE2_TE7_TE8,ra_4,'rows'));
 index_PdAgH100_TE1_TE2_TE7_TE8_H_TE7 = 
find(ismember(ri_PdAgH100_TE1_TE2_TE7_TE8,ra_5,'rows'));
 index_PdAgH100_TE1_TE2_TE7_TE8_H_TE8 = 
find(ismember(ri_PdAgH100_TE1_TE2_TE7_TE8,ra_6,'rows'));
 
 
% % % Fitting Constraints
% % Used in Thesis
% % % % % f = 0.4417 x = 1.476745339175117 1.967649395899897 
1.741864506174084 1.850016663067700 
 Xl_AgH = [.1 1 1 1.85];
 X0_AgH = [.1 1 1 3];
 Xu_AgH = [10 10 10 3];
x = [1.476745339175117 1.967649395899897 1.741864506174084 
1.850016663067700 ]
 tic % start timer
 
 options.MaxFunEvals = 70000;
 options.TolFun = 1.00e-7;
 options.TolX = 1.00e-7;
 
% %%%% Perform Constrained Optimization
% [x,fval] = 
fmincon(@objfun_18_07_13,X0_AgH,[],[],[],[],Xl_AgH,Xu_AgH,[],options)
% %%%% Perform Unconstrained Optimization
% % % % [x,fval] = fminunc(@objfun_18_03_22,X0_AgH,options)
% %%%% Perform Genetic Algorithm Optimization
% rng('default')
% options = 
optimoptions(@ga,'Generations',500,'PopulationSize',100,'HybridFcn',@fmincon)
;
% [x, fval] = ga(@objfun_18_07_13,4,[],[],[],[], Xl_AgH ,Xu_AgH 
,[],options) 
 toc % stop timer
 
 Check_Fit_18_07_13(x,false,false)
 
 objfun_18_07_13(x);
 format long
 x
end