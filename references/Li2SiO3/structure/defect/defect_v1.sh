#!/bin/bash

echo "-----------------------------------------------------------------"
echo "Usage: defect_v1.sh N0 E1 N1 E2 N2"
echo "e.g., Usage: defect_v1.sh 2 1 2 3 1"
echo "  => Total 2 molecules, 1(Li:type1)*2, 3(O:type3)*1, so 2 Li2O defect"
echo "where X is the [atom type] you want to add shell."
echo "VESTA(*.cif)(making supercell) -> Ovito(input.data) -> defect_v1.sh X"
echo "input file name: input.data"
echo "-----------------------------------------------------------------"

#-----------------------------------------------------------------
if [ -f defect.data ]; then
  mv defect.data defect.data_old
fi
#-----------------------------------------------------------------

echo "-----------------------------------------------------------------"
echo "replace: win <CR><LF> '\r\n' => linux <LF> '\n'"
sed "s/\r//g" input.data > tmp1.data
echo "-----------------------------------------------------------------"

#-----------------------------------------------------------------
nas=`awk '{if($2=="atoms"){printf "%d",$1}}' tmp1.data`
#-----------------------------------------------------------------
xlo=`awk '{if($3=="xlo"){printf "%12.5f",$1}}' tmp1.data`
ylo=`awk '{if($3=="ylo"){printf "%12.5f",$1}}' tmp1.data`
zlo=`awk '{if($3=="zlo"){printf "%12.5f",$1}}' tmp1.data`
#-----------------------------------------------------------------
xhi=`awk '{if($4=="xhi"){printf "%12.5f",$2}}' tmp1.data`
yhi=`awk '{if($4=="yhi"){printf "%12.5f",$2}}' tmp1.data`
zhi=`awk '{if($4=="zhi"){printf "%12.5f",$2}}' tmp1.data`
#-----------------------------------------------------------------
La1=`awk '{if($1=="Atoms" ){printf "%d",NR+1}}' tmp1.data`
Lm=`awk '{if($1=="Masses"){printf "%d",NR}}' tmp1.data`
Ln1=`awk 'END{printf "%d",NR+1}' tmp1.data`
#-----------------------------------------------------------------

echo "-----------------------------------------------------------------"
echo "xlo xhi: "${xlo}" "${xhi}
echo "ylo yhi: "${ylo}" "${yhi}
echo "zlo zhi: "${zlo}" "${zhi}
echo "-----------------------------------------------------------------"
echo "Number of atoms : "${nas}
echo "Number of Lines + 1 : "${Ln1}
echo "Line of Atoms + 1 : "${La1}
echo "Line of Masses: "${Lm}
echo "-----------------------------------------------------------------"

awk -v La1=${La1} '(NR>La1){printf "%s # %d \n",$0,(NR-La1)}' tmp1.data > tmp2.data

for i in $(seq 1 $1)
do
  echo "Delete set :"${i}
  
  awk -v E1=$2 '($3==E1){printf "%s # %d \n",$0,NR}' tmp2.data > E1.data
  awk -v E2=$4 '($3==E2){printf "%s # %d \n",$0,NR}' tmp2.data > E2.data
  LnE1=`awk 'END{print NR}' E1.data`
  LnE2=`awk 'END{print NR}' E2.data`
  
  echo "-----------------------------------------------------------------"
  echo "Number of type "$2": "${LnE1}" at "${i}
  echo "Number of type "$3": "${LnE2}" at "${i}
  echo "-----------------------------------------------------------------"
  
  awk -v seed=${RANDOM} -v LnE1=${LnE1} '
    BEGIN{
      #srand(seed)
      #DNR=int(rand()*LnE1)+1
      DNR=int((seed/32767)*LnE1)+1
    }
    {
      if( !($9==DNR) ){printf "%d %d %d %6.3f %12.5f %12.5f %12.5f # %d \n",$1,$2,$3,$4,$5,$6,$7,NR
      }else{x=$5;y=$6;z=$7}
    }
    END{
      printf "%12.5f %12.5f %12.5f # DNR %d",x,y,z,DNR
    }' tmp2.data > tmp3.data
  grep DNR tmp3.data > E1_DNR.data
  
  x=`awk 'END{printf "%f",$1}' E1_DNR.data`
  y=`awk 'END{printf "%f",$2}' E1_DNR.data`
  z=`awk 'END{printf "%f",$3}' E1_DNR.data`
  #E1_DNR=`awk 'END{printf "%d",$4}' E1_DNR.data`
  
  for j in $(seq 1 $3)
  do
    awk -v x=$x -v y=$y -v z=$z -v E1=$2 '
      BEGIN{
        dr_old = 99999.9
      }
      {
        # origin
        dx2 = ($5-x)^2; dy2 = ($6-y)^2; dz2 = ($7-z)^2;
        dr = (dx2 + dy2 + dz2)^(1/2)
        if( dr <= dr_old &&  $3==E1 ){
          E1_DNR=NR
          dr_old = dr
        }
      }
      END{
        printf "%d", E1_DNR
      }' tmp2.data > E1_DNR.data
      
      E1_DNR=`awk 'END{printf "%d",$1}' E1_DNR.data`
      echo ${E1_DNR}
      awk -v E1_DNR=${E1_DNR} '{if( !(NR==E1_DNR) ){print $0}}' tmp2.data > tmp3.data
      mv tmp3.data tmp2.data
  done
  
  for j in $(seq 1 $5)
  do
    awk -v x=$x -v y=$y -v z=$z -v E2=$4 '
      BEGIN{
        dr_old = 99999.9
      }
      {
        # origin
        dx2 = ($5-x)^2; dy2 = ($6-y)^2; dz2 = ($7-z)^2;
        dr = (dx2 + dy2 + dz2)^(1/2)
        if( dr <= dr_old &&  $3==E2 ){
          E2_DNR=NR
          dr_old = dr
        }
      }
      END{
        printf "%d", E2_DNR
      }' tmp2.data > E2_DNR.data
      
      E2_DNR=`awk 'END{printf "%d",$1}' E2_DNR.data`
      echo ${E2_DNR}
      awk -v E2_DNR=${E2_DNR} '{if( !(NR==E2_DNR) ){print $0}}' tmp2.data > tmp3.data
      mv tmp3.data tmp2.data
  done
  
done

echo "Delete set : END (results)"

awk -v E1=$2 '($3==E1){printf "%s # %d \n",$0,NR}' tmp2.data > E1.data
awk -v E2=$4 '($3==E2){printf "%s # %d \n",$0,NR}' tmp2.data > E2.data
LnE1=`awk 'END{print NR}' E1.data`
LnE2=`awk 'END{print NR}' E2.data`

echo "-----------------------------------------------------------------"
echo "Number of type "$2": "${LnE1}" at "${i}
echo "Number of type "$3": "${LnE2}" at "${i}
echo "-----------------------------------------------------------------"

new_nas=`cat tmp2.data | wc -l`
awk -v new_nas=${new_nas} '{if($2=="atoms"){printf "%d atoms \n",new_nas}else{print $0}}' tmp1.data > tmp4.data
awk -v La1=${La1} '(NR<=La1){print $0}' tmp4.data > defect.data
cat tmp2.data >> defect.data

#-----------------------------------------------------------------
rm -f tmp1.data tmp2.data E1.data E2.data E1_DNR.data E2_DNR.data tmp3.data tmp4.data
#-----------------------------------------------------------------

echo "-----------------------------------------------------------------"
echo "replace: linux <LF> '\n' => win <CR><LF> '\r\n'"
sed -i "s/$/\r/g" core-shell.data
echo "-----------------------------------------------------------------"

echo "-----------------------------------------------------------------"
echo "show new input file"
echo "-----------------------------------------------------------------"
cat core-shell.data
echo "-----------------------------------------------------------------"
