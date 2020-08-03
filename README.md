lammps_education_metal_win

Lammps Metal for education (windows 10 (64 bit))

------------------------------------------------------------------------------
■ lammps


□ インストール方法
1. http://packages.lammps.org/windows.html のHPで"64-bit Windows download area"をクリックする
2. LAMMPS-64bit-18Jun2019.exe をダウンロードして解凍する
3. ディフォルトの設定のまま最後まで進めばよい
以上で lammps のダウンロードと設定は完了です


□ 描画ソフト（gnuplotとOvito）
  gnuplotとOvitoについてはweb上に有益な情報が豊富にありますので、お手数をおかけしますが、そちらをご参照ください


------------------------------------------------------------------------------
■ 分子動力学シミュレーション


□ 入力ファイルのダウンロード
    by-student-2017 の lammps_education_metal_win (https://github.com/by-student-2017/lammps_education_metal_win) から入力ファイルをダウンロードして解凍する。右側の[Clone or download]をクリックしていただくと Download ZIP が表示されます


□ シミュレーションの実行
1. 各種のフォルダの中にあるrun.batをダブルクリックすれば計算が走る
2. cfgをOvitoで開けば構造が得られる
3. plotと記載のあるファイルをダブルクリックすれば図が得られる
  ※ 温度が目的の値になっているか、エネルギーが一定の値になっているかを確認してみてください
※ 以上の手順は、data.inにある原子の情報、そして、in.lmpのポテンシャルと出力の原子の情報を書きかえれば他の材料でも同様に計算が可能です（Avogadroなどのフリーソフトを用いて構造のファイル（data.in）を作られる方もいます）
※ plotから得られるG(r)はX線や中性子線の実験結果との比較に利用するものです。msdは自己拡散係数を求めるのに利用します
※ 計算終了後の構造を用いたい場合は"in.data"において"read_data data.in.restart"と"replicate 1 1 1"とします。
※ 歪と圧力の関係から弾性定数を求めるには、まず構造緩和（格子と原子）をして圧力の非常に小さい構造（体積）を得ます。そして、例えば、xの長さをわずかに変えて、原子だけ構造緩和し、出力される圧力 pxx, pyy, pxy (=σxx, σyy, σxy) [bar]などを用いて弾性定数を計算します。1 bar = 0.1 MPaです。lammpsで出力される圧力は圧縮が正になります。


□ 他の系（他の元素の組み合わせ）で計算したい場合
  例えば、ポテンシャルを”Fe-Cr-W”用から”Fe-Ni-Cr”用に変更するには以下のようにします。＃以降はコメントになります。”Fe-Cr-W”に関する行を＃を付けてコメントにし、コメントにされていた”Fe-Ni-Cr”の＃を除いて計算するようにします。加えて”# ----- Output setting -----”などでの元素記号は使用するポテンシャルの順番に書き換えてください。元素の書き換えが必要なファイルは”in.lmp”と”plot_msd.gpl”の2つです。


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


□ tutorial_1_Monte_Carlo
  モンテカルロ法を用いて、入力ファイルで指定した温度に対して熱力学的（ボルツマン分布的）に許される原子配置を計算します。LammpsのExampleにある2次元のMCを書き換えて3次元にしてあります（書き換えに誤りがありましたらすみません）。"time-stamped force-bias Monte Carlo"法は"tutorial_1_time-stamped_force-bias_Monte_Carlo"のファイルになります。swapは２つの原子の入れ替えを行うタイプ（正しく動作しているかは不明。SQSを得るために作りました）。


□ tutorial_2_MSD_and_RDF
  平均自乗変位と動径分布関数を計算します
  入力ファイルを理解するには[ https://amorphous.tf.chiba-u.jp/lecture.files/ms-workshop/molten.html ]を参照すると良いでしょう


□ tutorial_3_temp_and_press
  温度や圧力を変えたときの構造の変化のシミュレーション
  in.lmpファイル中の下の 298.0の値を変えれば温度が、1.0の値を変えれば圧力が変わります
  variable    temp index 298.0 # K
  variable    pres index 1.0 # 0.1 MPa (bar units)


□ tutorial_4_strain
  歪ませたときの構造の変化のシミュレーション
  in.lmpファイル中の下の 0.05の値を変えればx軸方向に単位胞が伸びます。縮める場合は負の小さな値にしてみてください。
  variable    Erate index 0.05 # 1/(1.0 fs), if Erate < 0.0 (compress)


□ tutorial_5_melt_and_cool
  温度を上げた後に冷やした場合の構造の変化のシミュレーション
  in.lmpファイル中の下の2673.0や1273.0, 673.0の値を変えると温度が変化します。どこまでの温度が可能かは用いるポテンシャルに依存します。使用しているポテンシャルの論文を参照してください
  variable    tempm index 2673.0 # K (heat)
  variable    temph index 1273.0 # K (cool No.1)
  variable    tempc index   673.0 # K (cool No.2)


□ tutorial_6_thermal
  熱伝導率の計算
  in.lmpファイル中の下の 298.0の値を変えれば温度が、1.0の値を変えれば圧力が変わります
  variable    temp index 298.0 # K
  variable    pres index 1.0 # 0.1 MPa (bar units)
  log.lammpsファイルの最後の方に、熱伝導率（average conductivity）が記載されています。温度（K,）の後に記載されているのは数密度（Number density）です。log.lammpsでStep数が増えていくと、v_Jxやv_Jyやv_Jzは0、v_k11やv_k22やv_k33はおおむね一定の値になっているかも確認してみてください
※ これは定性的または半定量的な熱伝導率の評価として利用されます


□ tutorial_7_viscosity
  粘性率（粘性係数、粘度とも呼ばれる）の計算
  in.lmpファイル中の下の 1298.0の値を変えれば温度が、1.0の値を変えれば圧力が変わります
  variable    temp index 1298.0 # K
  variable    pres index 1.0 # 0.1 MPa (bar units)
  log.lammpsファイルの最後の方に、粘性率（average viscosity）が記載されています。温度（K,）の後に記載されているのは数密度（Number density）です。log.lammpsでStep数が増えていくと、"v_pxy v_pxz v_pyz v_v11 v_v22 v_v33"はおおむね一定の値になっているかも確認してみてください
※ これは定性的または半定量的な粘性率の評価として利用されます


□ tutorial_8_elastic
  0Kでの弾性定数の計算。計算後、python3が使える場合は下記のコマンドで弾性定数の一覧が表示されます。
  [Shift+右クリック] > [Linuxシェルをここに開く] > python3 compliance_python3.py
  異なった元素で計算する場合は、data.inで構造、init.modで質量、potential.modでポテンシャルの指定を書き換えてください


□ tutorial_9_elastic_temp
  有限温度での弾性定数の計算。計算後、python3が使える場合は下記のコマンドで弾性定数の一覧が表示されます。
  [Shift+右クリック] > [Linuxシェルをここに開く] > python3 compliance_python3.py
  異なった元素で計算する場合は、data.inで構造、init.modで質量と温度、potential.modでポテンシャルの指定を書き換えてください


□ tutorial_10_phonon
  フォノン分散とフォノンDOSを計算します。しかし、FCCでのプリミティブセルやgrapheneにしか成功していません。プリミティブセルのみを対象に計算してみる価値はあるかもしれませんが、この部分の発展は後世に託したいと思います。
  ボランティア精神にあふれた天才が登場してくれるのを待ちましょう。


□ Reference_eam_database (Generalized EAM = GEAM)
  (Cu, Ag, Au, Ni, Pd, Pt, Al, Pb, Fe, Mo, Ta, W, Mg, Co, Ti, Zr)
  EAM形式のポテンシャルを作成するコードです。run.bat をクリックするとEAM形式のポテンシャル（*.set）が作成されます。入力ファイルは EAM.input で、既に記載されている記述と同じ形式にして元素だけ書き換えたり、記載する量を増やすことで幾つかの組み合わせのポテンシャルを作ることができます。References に lammps で実際に動かすときの in.lmp も追加しておきました。EAM_code にポテンシャル作成に必要な元素の情報が記載されています。EAM_code において他の元素の記述を増やしたり、計算したい系により合うようにするのも良いでしょう。README をご参照ください。第一原理計算の結果と会うようにパラメータを遺伝的アルゴリズム（GA）などを用いながら最適化させていくことがよく行われます。第一原理計算と potfit などを用いて EAM や ADP形式のポテンシャルを作成することも行われています。EAM_code をほぼ全ての元素準備したり、特定の必要な分野に特化したものなどを作って無償配布してくれるプロジェクトとかはないものかね。
  NISTなど既に論文などで公開されているlammpsのポテンシャルに300 Kでフィットするようにさせた（H He Li Be Na K Rb Cs Ca Sr Sm U V Nb Cr Mn Re Ru Rh Ir Zn Ga Cd C Si Sn P As O Se Te）をEAM_codeに追加しておきました。金属元素以外はフィットも悪くエネルギーの再現も良くないためhybridを用いてより精度を高めてください（金属元素ではあるがReとRuはフィットが悪い）。予測される計算精度は「金属元素-金属元素の組み合わせ　＞　金属元素-金属元素以外の組み合わせ　＞　金属元素以外-金属元素以外の組み合わせ」となります。
  ボランティア精神にあふれた奇特な方と天才が登場してくれるのを待ちましょう。


□ Ovito
  run.batをダブルクリックした後（計算後）に得られる data.in.restart を data.in などの名称に変えて他の計算に移ることも良いでしょう。この他、cfg > Ovito で最新の .cfg を開く > File > Export File > POSCAR File (*)としてPOSCARという名称で保存 > [Output reduced coordinates]にチェックを入れるとDirectになる。チェックなしだとCartesianになる > OK > VESTAで表示することが可能 > 他のファイル形式にして次の工程へ（第一原理計算に移るなど）（※ VESTAでPOSCARとして出力するとOvitoのPOSCARよりも見やすくなります）
  Ovito では右上の[Add modification]で[Polyhedral template maching]を選択することで右下にRMSDが表示されます。RMSD cutoffの値を0.01から大きくしていくとどれだけズレているかがわかります。
  Ovito では右上の[Add modification]で[Coordination analysis]を選択することで右下にRDFが表示されます。Cutoff radiusの値を変えてrの表示範囲を変えたりできます。"Compute partial RDFs"にチェックを入れることで各元素のRDFを見ることができます。
※ OvitoはVESTAからのPOSCARを読み込めるので、第一原理計算から得られた構造をVESTAでPOSCAR形式にすることで、上記のOvitoによるRMSDやRDFの解析が可能です。第一原理計算は通常0 Kです（第一原理計算でMDを選択するとと有限温度での計算になる）。そのため、分子動力学計算で温度がいくつに設定されているかを調べて比較しましょう（例えば、第一原理計算は通常0 Kであるので、分子動力学（lammpsなど）ではそれに近い4 K （He）や15 K（He冷凍機で冷やしたときに到達しやすい物質の温度）、77 K（液体窒素での温度）など、第一原理計算に近くした温度での結果と比較すると両者の差が縮まるだろうと考える（それがかなり上手くいくとは限らないが））。


※ そこそこ定量的な結果を与える第一原理計算とは異なり、分子動力学は定性や半定量的な結果を与えます。一方で、第一原理計算では3ヶ月から半年もかかる類似の計算も、分子動力学ではOSがWindowsのノートPCを用いても数十分で計算できます（有限温度やnsの計算も第一原理計算よりも容易です）。実験値と値は異なっていても、実験値と相関さえ出ていれば、多項式でフィットさせたり、機械学習などを用いて予測精度を高めることができます。最近では、分子動力学法でも第一原理計算に近い結果を与える手法も研究・開発が進んでおり、論文でその成果が報告されています。どのような用途にも利用可能な分子動力学用のポテンシャルを作ることはできませんが、目的の系に合うようなポテンシャルを作ることはできると思いますので、今後の発展とボランティア精神にあふれた奇特な方と天才が登場して”無償で”lammpsのポテンシャルが豊富になることを願いたいと思います。lammpsだけでなくDFTB+のパラメータやPWscfのVCAでPAWが可能になるなど”無償で”豊富になってくれると嬉しいのですが。食に困らず地位が安定して自由に研究できる環境があればよいのですが、ノーベル賞級の方でも研究資金に困る時代ですのであきらめるしかないのでしょうね。そういう意味では、東大教授に反発した北里柴三郎（ノーベル賞は受けていない）を助けた福沢諭吉は凄い方だと思います。

------------------------------------------------------------------------------
■ units and potential


  上記の入力ファイルはすべて"units metal"であるため、下に示すポテンシャルが利用可能です。


□ units metal

・Stillinger-Weber (SW)

・Tersoff

・EAM, FS

・MEAM

・ADP

・REBO, AIREBO

・COMB

・EIM

・BOP

・adiabatic core/shell model

・Streitz-Mintmire

・vashishta


  下に示す"units real"や"units lj"を用いる場合は上記の入力ファイルを大幅に書き換えないと正しい結果を得ることができません。


□ units real

・OPLS

・OPLS & Amber (https://github.com/agiliopadua/ilff)

・CHARMM(charmm22)

・dreiding

・ReaxFF


[UP1] C:\Program Files\LAMMPS 64-bit 18Jun2019\Examples


------------------------------------------------------------------------------
■ potential files
  上記の入力ファイルの例にあるポテンシャル以外にも、以下のサイトからポテンシャルを用いて利用することができます。利用するポテンシャルの論文やポテンシャルのファイルの中身を読んだり、実験や半経験的量子化学計算や第一原理計算などの結果と比較して定性的に結果が合うかどうかを確認してから本格的な研究に利用します。


□ potentials


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
・単体および任意の組み合わせに適用可能なポテンシャルとしてGEAMがある。2001年と2004年のものがある。


[12] Welcome to the Knowledgebase of Interatomic Models! (OpenKIM)
  https://openkim.org/


[13] potential_LAMMPS Reference Records
  https://github.com/usnistgov/iprPy/tree/master/library/potential_LAMMPS


[14] KIST Integrated Force Field Platform
  http://kiff.vfab.org/


------------------------------------------------------------------------------
■ References

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