lammps_education_metal_win

Lammps Metal for education (windows 10 (64 bit))


------------------------------------------------------------------------------
�� lammps


�� �C���X�g�[�����@
1. http://packages.lammps.org/windows.html ��HP��"64-bit Windows download area"���N���b�N����
2. LAMMPS-64bit-18Jun2019.exe ���_�E�����[�h���ĉ𓀂���
3. �f�B�t�H���g�̐ݒ�̂܂܍Ō�܂Ői�߂΂悢
�ȏ�� lammps �̃_�E�����[�h�Ɛݒ�͊����ł�


�� �`��\�t�g�ignuplot��Ovito�j
  gnuplot��Ovito�ɂ��Ă�web��ɗL�v�ȏ�񂪖L�x�ɂ���܂��̂ŁA���萔�����������܂����A����������Q�Ƃ�������


------------------------------------------------------------------------------
�� ���q���͊w�V�~�����[�V����


�� ���̓t�@�C���̃_�E�����[�h
    by-student-2017 �� lammps_education_metal_win (https://github.com/by-student-2017/lammps_education_metal_win) ������̓t�@�C�����_�E�����[�h���ĉ𓀂���B�E����[Clone or download]���N���b�N���Ă��������� Download ZIP ���\������܂�


�� �V�~�����[�V�����̎��s
1. �e��̃t�H���_�̒��ɂ���run.bat���_�u���N���b�N����Όv�Z������
2. cfg��Ovito�ŊJ���΍\����������
3. plot�ƋL�ڂ̂���t�@�C�����_�u���N���b�N����ΐ}��������
  �� ���x���ړI�̒l�ɂȂ��Ă��邩�A�G�l���M�[�����̒l�ɂȂ��Ă��邩���m�F���Ă݂Ă�������
�� �ȏ�̎菇�́Adata.in�ɂ��錴�q�̏��A�����āAin.lmp�̃|�e���V�����Əo�͂̌��q�̏�������������Α��̍ޗ��ł����l�Ɍv�Z���\�ł��iAvogadro�Ȃǂ̃t���[�\�t�g��p���č\���̃t�@�C���idata.in�j�������������܂��j
�� plot���瓾����G(r)��X���⒆���q���̎������ʂƂ̔�r�ɗ��p������̂ł��Bmsd�͎��Ȋg�U�W�������߂�̂ɗ��p���܂�
�� �v�Z�I����̍\����p�������ꍇ��"in.data"�ɂ�����"read_data data.in.restart"��"replicate 1 1 1"�Ƃ��܂��B
�� �c�ƈ��͂̊֌W����e���萔�����߂�ɂ́A�܂��\���ɘa�i�i�q�ƌ��q�j�����Ĉ��͂̔��ɏ������\���i�̐ρj�𓾂܂��B�����āA�Ⴆ�΁Ax�̒������킸���ɕς��āA���q�����\���ɘa���A�o�͂���鈳�� pxx, pyy, pxy (=��xx, ��yy, ��xy) [bar]�Ȃǂ�p���Ēe���萔���v�Z���܂��B1 bar = 0.1 MPa�ł��Blammps�ŏo�͂���鈳�͈͂��k�����ɂȂ�܂��B


�� ���̌n�i���̌��f�̑g�ݍ��킹�j�Ōv�Z�������ꍇ
  �Ⴆ�΁A�|�e���V�������hFe-Cr-W�h�p����hFe-Ni-Cr�h�p�ɕύX����ɂ͈ȉ��̂悤�ɂ��܂��B���ȍ~�̓R�����g�ɂȂ�܂��B�hFe-Cr-W�h�Ɋւ���s������t���ăR�����g�ɂ��A�R�����g�ɂ���Ă����hFe-Ni-Cr�h�́��������Čv�Z����悤�ɂ��܂��B�����āh# ----- Output setting -----�h�Ȃǂł̌��f�L���͎g�p����|�e���V�����̏��Ԃɏ��������Ă��������B���f�̏����������K�v�ȃt�@�C���́hin.lmp�h�Ɓhplot_msd.gpl�h��2�ł��B


#----------(before)----------

#-----(Fe-Ni-Cr) (FCC)

#pair_style      eam/fs

#pair_coeff      * * ./eam/Fe-Ni-Cr_fcc.eam.fs Fe Ni Cr

#-----(Fe-Cr-W)


pair_style      hybrid/overlay eam/alloy eam/fs


pair_coeff      * * eam/alloy ./eam/FeCrW_d.eam.alloy Fe Cr W


pair_coeff      * * eam/fs    ./eam/FeCrW_s.eam.fs Fe Cr W


#---------------------------

#----------(after)----------

#-----(Fe-Ni-Cr) (FCC)


pair_style      eam/fs


pair_coeff      * * ./eam/Fe-Ni-Cr_fcc.eam.fs Fe Ni Cr

#-----(Fe-Cr-W)

#pair_style      hybrid/overlay eam/alloy eam/fs

#pair_coeff      * * eam/alloy ./eam/FeCrW_d.eam.alloy Fe Cr W

#pair_coeff      * * eam/fs    ./eam/FeCrW_s.eam.fs Fe Cr W

#---------------------------


�� tutorial_1_Monte_Carlo
  �����e�J�����@��p���āA���̓t�@�C���Ŏw�肵�����x�ɑ΂��ĔM�͊w�I�i�{���c�}�����z�I�j�ɋ�����錴�q�z�u���v�Z���܂��BLammps��Example�ɂ���2������MC������������3�����ɂ��Ă���܂��i���������Ɍ�肪����܂����炷�݂܂���j�B"time-stamped force-bias Monte Carlo"�@��"tutorial_1_time-stamped_force-bias_Monte_Carlo"�̃t�@�C���ɂȂ�܂��Bswap�͂Q�̌��q�̓���ւ����s���^�C�v�i���������삵�Ă��邩�͕s���BSQS�𓾂邽�߂ɍ��܂����j�B


�� tutorial_2_MSD_and_RDF
  ���ώ���ψʂƓ��a���z�֐����v�Z���܂�
  ���̓t�@�C���𗝉�����ɂ�[https://amorphous.tf.chiba-u.jp/lecture.files/ms-workshop/molten.html]���Q�Ƃ���Ɨǂ��ł��傤


�� tutorial_3_temp_and_press
  ���x�∳�͂�ς����Ƃ��̍\���̕ω��̃V�~�����[�V����
  in.lmp�t�@�C�����̉��� 298.0�̒l��ς���Ή��x���A1.0�̒l��ς���Έ��͂��ς��܂�
  variable    temp index 298.0 # K
  variable    pres index 1.0 # 0.1 MPa (bar units)


�� tutorial_4_strain
  �c�܂����Ƃ��̍\���̕ω��̃V�~�����[�V����
  in.lmp�t�@�C�����̉��� 0.05�̒l��ς����x�������ɒP�ʖE���L�т܂��B�k�߂�ꍇ�͕��̏����Ȓl�ɂ��Ă݂Ă��������B
  variable    Erate index 0.05 # 1/(1.0 fs), if Erate < 0.0 (compress)


�� tutorial_5_melt_and_cool
  ���x���グ����ɗ�₵���ꍇ�̍\���̕ω��̃V�~�����[�V����
  in.lmp�t�@�C�����̉���2673.0��1273.0, 673.0�̒l��ς���Ɖ��x���ω����܂��B�ǂ��܂ł̉��x���\���͗p����|�e���V�����Ɉˑ����܂��B�g�p���Ă���|�e���V�����̘_�����Q�Ƃ��Ă�������
  variable    tempm index 2673.0 # K (heat)
  variable    temph index 1273.0 # K (cool No.1)
  variable    tempc index   673.0 # K (cool No.2)


�� tutorial_6_thermal
  �M�`�����̌v�Z
  in.lmp�t�@�C�����̉��� 298.0�̒l��ς���Ή��x���A1.0�̒l��ς���Έ��͂��ς��܂�
  variable    temp index 298.0 # K
  variable    pres index 1.0 # 0.1 MPa (bar units)
  log.lammps�t�@�C���̍Ō�̕��ɁA�M�`�����iaverage conductivity�j���L�ڂ���Ă��܂��B���x�iK,�j�̌�ɋL�ڂ���Ă���̂͐����x�iNumber density�j�ł��Blog.lammps��Step���������Ă����ƁAv_Jx��v_Jy��v_Jz��0�Av_k11��v_k22��v_k33�͂����ނˈ��̒l�ɂȂ��Ă��邩���m�F���Ă݂Ă�������
�� ����͒萫�I�܂��͔���ʓI�ȔM�`�����̕]���Ƃ��ė��p����܂�


�� tutorial_7_viscosity
  �S�����i�S���W���A�S�x�Ƃ��Ă΂��j�̌v�Z
  in.lmp�t�@�C�����̉��� 1298.0�̒l��ς���Ή��x���A1.0�̒l��ς���Έ��͂��ς��܂�
  variable    temp index 1298.0 # K
  variable    pres index 1.0 # 0.1 MPa (bar units)
  log.lammps�t�@�C���̍Ō�̕��ɁA�S�����iaverage viscosity�j���L�ڂ���Ă��܂��B���x�iK,�j�̌�ɋL�ڂ���Ă���̂͐����x�iNumber density�j�ł��Blog.lammps��Step���������Ă����ƁA"v_pxy v_pxz v_pyz v_v11 v_v22 v_v33"�͂����ނˈ��̒l�ɂȂ��Ă��邩���m�F���Ă݂Ă�������
�� ����͒萫�I�܂��͔���ʓI�ȔS�����̕]���Ƃ��ė��p����܂�


�� tutorial_8_elastic
  0K�ł̒e���萔�̌v�Z�B�v�Z��Apython3���g����ꍇ�͉��L�̃R�}���h�Œe���萔�̈ꗗ���\������܂��B
  [Shift+�E�N���b�N] > [Linux�V�F���������ɊJ��] > python3 compliance_python3.py
  �قȂ������f�Ōv�Z����ꍇ�́Adata.in�ō\���Ainit.mod�Ŏ��ʁApotential.mod�Ń|�e���V�����̎w������������Ă�������


�� tutorial_9_elastic_temp
  0K�ł̒e���萔�̌v�Z�B�v�Z��Apython3���g����ꍇ�͉��L�̃R�}���h�Œe���萔�̈ꗗ���\������܂��B
  [Shift+�E�N���b�N] > [Linux�V�F���������ɊJ��] > python3 compliance_python3.py
  �قȂ������f�Ōv�Z����ꍇ�́Adata.in�ō\���Ainit.mod�Ŏ��ʁApotential.mod�Ń|�e���V�����̎w������������Ă�������

------------------------------------------------------------------------------
�� units and potential
  ��L�̓��̓t�@�C���͂��ׂ�"units metal"�ł��邽�߁A���Ɏ����|�e���V���������p�\�ł��B

�� units metal
�EStillinger-Weber
�ETersoff
�EEAM, FS
�EMEAM
�EREBO, AIREBO
�ECOMB
�EEIM
�Eadiabatic core/shell model
�EStreitz-Mintmire
�Evashishta


  ���Ɏ���"units real"��"units lj"��p����ꍇ�͏�L�̓��̓t�@�C����啝�ɏ��������Ȃ��Ɛ��������ʂ𓾂邱�Ƃ��ł��܂���B


�� units real
�EOPLS
�EOPLS & Amber (https://github.com/agiliopadua/ilff)
�ECHARMM(charmm22)
�Edreiding
�EReaxFF


[UP1] C:\Program Files\LAMMPS 64-bit 18Jun2019\Examples


------------------------------------------------------------------------------
�� potential files
  ��L�̓��̓t�@�C���̗�ɂ���|�e���V�����ȊO�ɂ��A�ȉ��̃T�C�g����|�e���V������p���ė��p���邱�Ƃ��ł��܂��B���p����|�e���V�����̘_����|�e���V�����̃t�@�C���̒��g��ǂ񂾂�A�����┼�o���I�ʎq���w�v�Z���ꌴ���v�Z�Ȃǂ̌��ʂƔ�r���Ē萫�I�Ɍ��ʂ��������ǂ������m�F���Ă���{�i�I�Ȍ����ɗ��p���܂��B


�� potentials


[1] NIST Interatomic Potential
  https://www.ctcms.nist.gov/potentials/
  https://www.ctcms.nist.gov/potentials/resources.html


[2] Database of Published Interatomic Potential Parameters
  https://www.ucl.ac.uk/klmc/Potentials/


[3] EAM potentials
  https://sites.google.com/site/eampotentials/Home


[4] JARVIS for Force-fields
  https://www.ctcms.nist.gov/~knc6/periodic.html


[5] Embedded Atom Method (EAM) Tabulation
  https://atsimpotentials.readthedocs.io/en/latest/potentials/eam_tabulation.html


[6] Carbon Potentials
  http://www.carbonpotentials.org/potentials


[7] XMD - Molecular Dynamics for Metals and Ceramics 
  http://xmd.sourceforge.net/eam.html


[8] Potentials generated with potfit
  https://www.potfit.net/wiki/doku.php?id=potentials:main


[9] Interatomic Potential Generation
  https://icme.hpc.msstate.edu/mediawiki/index.php/Interatomic_Potential_Generation


[10] Potentials
  https://norman.jiht.ru/wiki/index.php/Potentials


[11] Dr. Adri van Duin 
  https://www.engr.psu.edu/adri/
�E�P�̂���єC�ӂ̑g�ݍ��킹�ɓK�p�\�ȃ|�e���V�����Ƃ���GEAM������B2001�N��2004�N�̂��̂�����B


[12] Welcome to the Knowledgebase of Interatomic Models! (OpenKIM)
  https://openkim.org/


[13] potential_LAMMPS Reference Records
  https://github.com/usnistgov/iprPy/tree/master/library/potential_LAMMPS


[14] KIST Integrated Force Field Platform
  http://kiff.vfab.org/


------------------------------------------------------------------------------
�� References

[MC1] Monte Carlo simulations with LAMMPS
  https://lammps.sandia.gov/workshops/Aug15/PDF/talk_Thompson1.pdf


[MC2] fix tfmc command (amorphous -> crystal)
  https://lammps.sandia.gov/doc/fix_tfmc.html
  https://lammps.sandia.gov/threads/msg69314.html
  https://lammps.sandia.gov/threads/msg69318.html
  https://lammps.sandia.gov/threads/msg69323.html
  https://lammps.sandia.gov/threads/msg69348.html
  https://lammps.sandia.gov/threads/msg69352.html


[SGC1] vcsgc-lammps (semi-grandcanonical) (pair_style eam/cd, eam/alloy or  eam/fs)
  https://vcsgc-lammps.materialsmodeling.org/


[GCMC1] fix gcmc command
  https://lammps.sandia.gov/doc/fix_gcmc.html


[GCMC2] Grand canonical Monte Carlo simulations of gas uptake in microporous materials using LAMMPS
  https://www.osti.gov/servlets/purl/1120653


[GCMC3] pysimm
  https://www.sciencedirect.com/science/article/pii/S2352711018300141 (paper)
  https://pysimm.org/ (code)


[R1] Nanofluidics An Introduction
  https://books.google.co.jp/books?id=VwqWDwAAQBAJ


------------------------------------------------------------------------------ 