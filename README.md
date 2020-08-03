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
  ���̓t�@�C���𗝉�����ɂ�[ https://amorphous.tf.chiba-u.jp/lecture.files/ms-workshop/molten.html ]���Q�Ƃ���Ɨǂ��ł��傤


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
  �L�����x�ł̒e���萔�̌v�Z�B�v�Z��Apython3���g����ꍇ�͉��L�̃R�}���h�Œe���萔�̈ꗗ���\������܂��B
  [Shift+�E�N���b�N] > [Linux�V�F���������ɊJ��] > python3 compliance_python3.py
  �قȂ������f�Ōv�Z����ꍇ�́Adata.in�ō\���Ainit.mod�Ŏ��ʂƉ��x�Apotential.mod�Ń|�e���V�����̎w������������Ă�������


�� tutorial_10_phonon
  �t�H�m�����U�ƃt�H�m��DOS���v�Z���܂��B�������AFCC�ł̃v���~�e�B�u�Z����graphene�ɂ����������Ă��܂���B�v���~�e�B�u�Z���݂̂�ΏۂɌv�Z���Ă݂鉿�l�͂��邩������܂��񂪁A���̕����̔��W�͌㐢�ɑ��������Ǝv���܂��B
  �{�����e�B�A���_�ɂ��ӂꂽ�V�˂��o�ꂵ�Ă����̂�҂��܂��傤�B


�� Reference_eam_database (Generalized EAM = GEAM)
  (Cu, Ag, Au, Ni, Pd, Pt, Al, Pb, Fe, Mo, Ta, W, Mg, Co, Ti, Zr)
  EAM�`���̃|�e���V�������쐬����R�[�h�ł��Brun.bat ���N���b�N�����EAM�`���̃|�e���V�����i*.set�j���쐬����܂��B���̓t�@�C���� EAM.input �ŁA���ɋL�ڂ���Ă���L�q�Ɠ����`���ɂ��Č��f����������������A�L�ڂ���ʂ𑝂₷���ƂŊ���̑g�ݍ��킹�̃|�e���V��������邱�Ƃ��ł��܂��BReferences �� lammps �Ŏ��ۂɓ������Ƃ��� in.lmp ���ǉ����Ă����܂����BEAM_code �Ƀ|�e���V�����쐬�ɕK�v�Ȍ��f�̏�񂪋L�ڂ���Ă��܂��BEAM_code �ɂ����đ��̌��f�̋L�q�𑝂₵����A�v�Z�������n�ɂ�荇���悤�ɂ���̂��ǂ��ł��傤�BREADME �����Q�Ƃ��������B��ꌴ���v�Z�̌��ʂƉ�悤�Ƀp�����[�^����`�I�A���S���Y���iGA�j�Ȃǂ�p���Ȃ���œK�������Ă������Ƃ��悭�s���܂��B��ꌴ���v�Z�� potfit �Ȃǂ�p���� EAM �� ADP�`���̃|�e���V�������쐬���邱�Ƃ��s���Ă��܂��BEAM_code ���قڑS�Ă̌��f����������A����̕K�v�ȕ���ɓ����������̂Ȃǂ�����Ė����z�z���Ă����v���W�F�N�g�Ƃ��͂Ȃ����̂��ˁB
  NIST�ȂǊ��ɘ_���ȂǂŌ��J����Ă���lammps�̃|�e���V������300 K�Ńt�B�b�g����悤�ɂ������iH He Li Be Na K Rb Cs Ca Sr Sm U V Nb Cr Mn Re Ru Rh Ir Zn Ga Cd C Si Sn P As O Se Te�j��EAM_code�ɒǉ����Ă����܂����B�������f�ȊO�̓t�B�b�g�������G�l���M�[�̍Č����ǂ��Ȃ�����hybrid��p���Ă�萸�x�����߂Ă��������i�������f�ł͂��邪Re��Ru�̓t�B�b�g�������j�B�\�������v�Z���x�́u�������f-�������f�̑g�ݍ��킹�@���@�������f-�������f�ȊO�̑g�ݍ��킹�@���@�������f�ȊO-�������f�ȊO�̑g�ݍ��킹�v�ƂȂ�܂��B
  �{�����e�B�A���_�ɂ��ӂꂽ����ȕ��ƓV�˂��o�ꂵ�Ă����̂�҂��܂��傤�B


�� Ovito
  run.bat���_�u���N���b�N������i�v�Z��j�ɓ����� data.in.restart �� data.in �Ȃǂ̖��̂ɕς��đ��̌v�Z�Ɉڂ邱�Ƃ��ǂ��ł��傤�B���̑��Acfg > Ovito �ōŐV�� .cfg ���J�� > File > Export File > POSCAR File (*)�Ƃ���POSCAR�Ƃ������̂ŕۑ� > [Output reduced coordinates]�Ƀ`�F�b�N�������Direct�ɂȂ�B�`�F�b�N�Ȃ�����Cartesian�ɂȂ� > OK > VESTA�ŕ\�����邱�Ƃ��\ > ���̃t�@�C���`���ɂ��Ď��̍H���ցi��ꌴ���v�Z�Ɉڂ�Ȃǁj�i�� VESTA��POSCAR�Ƃ��ďo�͂����Ovito��POSCAR�������₷���Ȃ�܂��j
  Ovito �ł͉E���[Add modification]��[Polyhedral template maching]��I�����邱�ƂŉE����RMSD���\������܂��BRMSD cutoff�̒l��0.01����傫�����Ă����Ƃǂꂾ���Y���Ă��邩���킩��܂��B
  Ovito �ł͉E���[Add modification]��[Coordination analysis]��I�����邱�ƂŉE����RDF���\������܂��BCutoff radius�̒l��ς���r�̕\���͈͂�ς�����ł��܂��B"Compute partial RDFs"�Ƀ`�F�b�N�����邱�ƂŊe���f��RDF�����邱�Ƃ��ł��܂��B
�� Ovito��VESTA�����POSCAR��ǂݍ��߂�̂ŁA��ꌴ���v�Z���瓾��ꂽ�\����VESTA��POSCAR�`���ɂ��邱�ƂŁA��L��Ovito�ɂ��RMSD��RDF�̉�͂��\�ł��B��ꌴ���v�Z�͒ʏ�0 K�ł��i��ꌴ���v�Z��MD��I������ƂƗL�����x�ł̌v�Z�ɂȂ�j�B���̂��߁A���q���͊w�v�Z�ŉ��x�������ɐݒ肳��Ă��邩�𒲂ׂĔ�r���܂��傤�i�Ⴆ�΁A��ꌴ���v�Z�͒ʏ�0 K�ł���̂ŁA���q���͊w�ilammps�Ȃǁj�ł͂���ɋ߂�4 K �iHe�j��15 K�iHe�Ⓚ�@�ŗ�₵���Ƃ��ɓ��B���₷�������̉��x�j�A77 K�i�t�̒��f�ł̉��x�j�ȂǁA��ꌴ���v�Z�ɋ߂��������x�ł̌��ʂƔ�r����Ɨ��҂̍����k�܂邾�낤�ƍl����i���ꂪ���Ȃ��肭�����Ƃ͌���Ȃ����j�j�B


�� ����������ʓI�Ȍ��ʂ�^�����ꌴ���v�Z�Ƃ͈قȂ�A���q���͊w�͒萫�┼��ʓI�Ȍ��ʂ�^���܂��B����ŁA��ꌴ���v�Z�ł�3�������甼�N��������ގ��̌v�Z���A���q���͊w�ł�OS��Windows�̃m�[�gPC��p���Ă����\���Ōv�Z�ł��܂��i�L�����x��ns�̌v�Z����ꌴ���v�Z�����e�Ղł��j�B�����l�ƒl�͈قȂ��Ă��Ă��A�����l�Ƒ��ւ����o�Ă���΁A�������Ńt�B�b�g��������A�@�B�w�K�Ȃǂ�p���ė\�����x�����߂邱�Ƃ��ł��܂��B�ŋ߂ł́A���q���͊w�@�ł���ꌴ���v�Z�ɋ߂����ʂ�^�����@�������E�J�����i��ł���A�_���ł��̐��ʂ��񍐂���Ă��܂��B�ǂ̂悤�ȗp�r�ɂ����p�\�ȕ��q���͊w�p�̃|�e���V��������邱�Ƃ͂ł��܂��񂪁A�ړI�̌n�ɍ����悤�ȃ|�e���V��������邱�Ƃ͂ł���Ǝv���܂��̂ŁA����̔��W�ƃ{�����e�B�A���_�ɂ��ӂꂽ����ȕ��ƓV�˂��o�ꂵ�āh�����Łhlammps�̃|�e���V�������L�x�ɂȂ邱�Ƃ��肢�����Ǝv���܂��Blammps�����łȂ�DFTB+�̃p�����[�^��PWscf��VCA��PAW���\�ɂȂ�Ȃǁh�����Łh�L�x�ɂȂ��Ă����Ɗ������̂ł����B�H�ɍ��炸�n�ʂ����肵�Ď��R�Ɍ����ł����������΂悢�̂ł����A�m�[�x���܋��̕��ł����������ɍ��鎞��ł��̂ł�����߂邵���Ȃ��̂ł��傤�ˁB���������Ӗ��ł́A���勳���ɔ��������k���ĎO�Y�i�m�[�x���܂͎󂯂Ă��Ȃ��j������������@�g�͐��������Ǝv���܂��B

------------------------------------------------------------------------------
�� units and potential


  ��L�̓��̓t�@�C���͂��ׂ�"units metal"�ł��邽�߁A���Ɏ����|�e���V���������p�\�ł��B


�� units metal

�EStillinger-Weber (SW)

�ETersoff

�EEAM, FS

�EMEAM

�EADP

�EREBO, AIREBO

�ECOMB

�EEIM

�EBOP

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