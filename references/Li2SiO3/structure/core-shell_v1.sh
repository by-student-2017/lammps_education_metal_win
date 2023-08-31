#!/bin/bash

echo "-----------------------------------------------------------------"
echo "Usage: core-shell_v1.sh X"
echo "where X is the [atom type] you want to add shell."
echo "VESTA(*.cif) -> Ovito(input.data) -> core-shell_v1.sh X"
echo "input file name: input.data"
echo "-----------------------------------------------------------------"

#-----------------------------------------------------------------
if [ -f core-shell.data ]; then
  mv core-shell.data core-shell.data_old
fi
#-----------------------------------------------------------------

echo "-----------------------------------------------------------------"
echo "replace: win <CR><LF> '\r\n' => linux <LF> '\n'"
sed "s/\r//g" input.data > tmp1.data
echo "-----------------------------------------------------------------"

#-----------------------------------------------------------------
nas=`awk '{if($2=="atoms"){printf "%d",$1}}' tmp1.data`
nat=`awk '{if($2=="atom" && $3=="types"){printf "%d",$1}}' tmp1.data`
#-----------------------------------------------------------------
nbs1=`awk 'BEGIN{nbs1=0}{if($2=="bonds"){nbs1=$1}}END{printf "%d",(nbs1+1)}' tmp1.data`
nbt1=`awk 'BEGIN{nbt1=0}{if($2=="bond" && $3=="types"){nbt1=$1}}END{printf "%d",(nbt1+1)}' tmp1.data`
#-----------------------------------------------------------------
La1=`awk '{if($1=="Atoms" ){printf "%d",NR+1}}' tmp1.data`
Lm=`awk '{if($1=="Masses"){printf "%d",NR}}' tmp1.data`
Ln1=`awk 'END{printf "%d",NR+1}' tmp1.data`
Lb=`awk 'BEGIN{Lb=0}{if($1=="Bonds"){Lb=NR}}END{if(Lb==0){Lb=NR};printf "%d",Lb}' tmp1.data`
#-----------------------------------------------------------------

echo "-----------------------------------------------------------------"
echo "Number of atoms : "${nas}
echo "Number of atom types: "${nat}
echo "Number of bonds + 1 : "${nbs1}
echo "Number of bond types + 1: "${nbt1}
echo "Number of Lines + 1 : "${Ln1}   
echo "Line of Atoms + 1 : "${La1}
echo "Line of Masses: "${Lm}
echo "Line of Bonds : "${Lb}
echo "-----------------------------------------------------------------"

#-----------------------------------------------------------------
if [ "$1"=="" ]; then
  set $1 ${nat}
  echo "Auto set atom type making shell: "$1
fi
#-----------------------------------------------------------------

#-----------------------------------------------------------------
awk -v nat=${nat} '{if($2=="atom" && $3=="types"){
  printf "%d atom types \n",(nat+1)}else{print $0}
  }' tmp1.data > tmp2.data
#-----------------------------------------------------------------
awk -v La1=${La1} -v Lm=${Lm} -v cn=$1 -v nas=${nas} -v nat=${nat} -v nbt1=${nbt1} '
  BEGIN{ls=0}
  {
    # modified masses
    if(NR<=La1){
      if(NR==(Lm+1+cn)){
        printf "%d %7.4f # %s, core  of type %d \n",$1,($2-0.2),$4,cn
	el=$4
      }else if(NR==(Lm+1+nat+1)){
        printf "%d %7.4f # %s, shell of type %d \n \n",(nat+1),0.2,el,cn
      }else{
        print $0
      }
    }
    # modified Atoms
    if(NR>La1 && NR<=La1+nas){
      ls+=1
      if(NR>La1 && $3==cn){
        printf "%d %d %d %4.1f %f %f %f # core  atype %d btype %d \n", ls,$2,$3,$4,$5,$6,$7,cn,nbt1
        ls+=1
        printf "%d %d %d %4.1f %f %f %f # shell atype %d btype %d \n", ls,$2,(nat+1),$4,$5,$6,$7,cn,nbt1
      }else{
        printf "%d %d %d %4.1f %f %f %f %s %s %s %s %s %s \n", ls,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13
      }
      if(NR==La1+nas){
	printf "END_Atoms %d \n",ls
      }
    }
  }
  ' tmp2.data > tmp3.data
#-----------------------------------------------------------------
nLaend=`awk '{if($1=="END_Atoms"){printf "%d",(NR-1)}}' tmp3.data`
natoms=`awk '{if($1=="END_Atoms"){printf "%d",$2}}' tmp3.data`

echo "-----------------------------------------------------------------"
echo "Number of End Line (Atoms): "${nLaend}
echo "Number of atoms: "${natoms}
echo "-----------------------------------------------------------------"
sed -i "/END_Atoms/d" tmp3.data

#-----------------------------------------------------------------
awk -v natoms=${natoms} -v nLaend=${nLaend} '
  {
      if(NR<=nLaend){
      if($2=="atoms"){
        printf "%d atoms \n",natoms
      }else{
        print $0
      }
      if(NR==nLaend){
        printf "\nBonds\n\n"
      }
    }
  }
  ' tmp3.data > core-shell.data
new_Lb=`awk '{if($1=="Bonds"){printf "%d",NR}}' core-shell.data`
echo "-----------------------------------------------------------------"
echo "New Line of Bonds: "${new_Lb}
echo "-----------------------------------------------------------------"
#-----------------------------------------------------------------
awk -v new_Lb=${new_Lb} -v cn=$1 -v nbt1=${nbt1} '
  BEGIN{ls=0}
  {
    # old bonds
    if($9=="shell" && $10!=cn && NR<(new_Lb-1)){
      ls+=1
      printf "%d %d %d %d # core-shell (types:%d-%d) \n",ls,$13,($1-1),$1,$11,$3
    }
    # new bonds
    if($9=="shell" && $10==cn && NR<(new_Lb-1)){
      ls+=1
      printf "%d %d %d %d # core-shell (types:%d-%d) \n",ls,nbt1,($1-1),$1,$11,$3
    }
  }
  END{printf "END_Bonds %d",ls}
  ' core-shell.data > Bonds.data
#-----------------------------------------------------------------
nbonds=`awk '{if($1=="END_Bonds"){printf "%d",$2}}' Bonds.data`

echo "-----------------------------------------------------------------"
echo "Number of core-shell bonds: "${nbonds}
echo "-----------------------------------------------------------------"

#-----------------------------------------------------------------
cat Bonds.data >> core-shell.data
#-----------------------------------------------------------------
sed -i "/bonds/d" core-shell.data
sed -i "/bond types/d" core-shell.data
sed -i "/atoms/a ${nbonds} bonds" core-shell.data
sed -i "/atom types/a ${nbt1} bond types" core-shell.data
sed -i "s/charge/full/" core-shell.data
sed -i "/END_Bonds/d" core-shell.data
#-----------------------------------------------------------------

#-----------------------------------------------------------------
rm -f tmp1.data tmp2.data tmp3.data Bonds.data
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
