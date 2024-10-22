#!/bin/bash

# Ubuntu 22.04 LTS
# sudo apt update
# sudo apt -y install lammps

INP_FILE=('Cu_repeat_distance_ppp_130.in')
NEW_DIRECT=('Cu_Sigma5_130_ppp')
#-------------
MAXX=25
MAXY=3
MAXZ1=3
MAXZ2=3
MINGBENG=10000
#-------------
xtrans=1
ytrans=1
xinc=0.1
yinc=0.1
#-------------

mkdir MIN-GB-DATA

FILES=${#INP_FILE[*]}

for ((i=0; i < FILES; i++))
do
  for zplanes1 in $(eval echo "{3..${MAXZ1}}")
  do
    for zplanes2 in $(eval echo "{3..${MAXZ2}}")
    do
      for yplanes in $(eval echo "{3..${MAXY}}")
      do
        for xplanes in $(eval echo "{25..${MAXX}")
        do
          sed -i "s/variable zplanes1 equal.*/variable zplanes1 equal ${zplanes1}/g" ${INP_FILE}
          sed -i "s/variable zplanes2 equal.*/variable zplanes2 equal ${zplanes2}/g" ${INP_FILE}
          sed -i "s/variable xplanes equal.*/variable xplanes equal ${xplanes}/g" ${INP_FILE}
          sed -i "s/variable yplanes equal.*/variable yplanes equal ${yplanes}/g" ${INP_FILE}
          sed -i "s/variable xmove equal.*/variable xmove equal ${xtrans}\*\$\{xinc\}/g" ${INP_FILE}
          sed -i "s/variable ymove equal.*/variable ymove equal ${ytrans}\*\$\{yinc\}/g" ${INP_FILE}
          
          rm -rf ${NEW_DIRECT[$i]}/
          rm log.lammps
          
          mpirun -np 6 lmp -in ${INP_FILE[$i]}
          
          cd ${NEW_DIRECT}
          gbenergy=$(echo $(echo dump.final_*.txt | grep -oE "[0-9]{4}"))
          echo dump.final_*.txt | grep -oE "[0-9]{4}"
          if [ $? -ne 0 ]; then
            unset gbenergy
            gbenergy=$(echo $(echo dump.final_*.txt | grep -oE "[0-9]{3}"))
            echo dump.final_*.txt | grep -oE "[0-9]{3}"
            if [ $? -ne 0 ]; then
              unset gbenergy
              gbenergy=$(echo $(echo dump.final_*.txt | grep -oE "[0-9]{2}"))
              echo dump.final_*.txt | grep -oE "[0-9]{2}"
            fi
          fi
          cd ../
          
          echo "${gbenergy}" >> gb_data.txt
          if [ $(eval echo "${gbenergy}") -lt $(eval echo "${MINGBENG}") ]; then
            unset MINGBENG
            MINGBENG=$((${gbenergy}))
            mv log.lammps ${NEW_DIRECT}
            cp ${INP_FILE} ${NEW_DIRECT}
            mv ${NEW_DIRECT}/ MIN-GB-DATA/${NEW_DIRECT}_${MINGBENG}
          fi
        done
      done
    done
  done
done

#rm *~
exit 0
