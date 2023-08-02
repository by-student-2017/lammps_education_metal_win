#! /bin/bash

INPFILE=('Cu_repeat_distance_ppp_130.in')
NEWDIRECT=('Cu_Sigma5_130_ppp')
MAXX=38
MAXY=21
MAXZ1=20
MAXZ2=20
MINGBENG=10000

mkdir MIN-GB-DATA

FILES=${#INP_FILE[*]}

for ((i=O; i < FILES; i++))
do
  for zplanesl in $(eval echo "{17..17}")
  do
    for zplanes2 in $(eval echo "{17. .17}")
    do
      for yplanes in $(eval echo "{21. .${MAXY}}")
      do
        for xplanes in $(eval echo "{38. .38")
        do
          sed -i "s/variable zplanesl equal.*/variable zplanesl equal ${zplanesl}/g" ${INPFILE}
          sed -i "s/variable zplanes2 equal.*/variable zplanes2 equal ${zplanes2}/g" ${INPFILE}
          sed -i "s/variable xplanes equal.*/variable xplanes equal ${xplanes}/g" ${INPFILE}
          sed -i "s/variable yplanes equal.*/variable yplanes equal ${yplanes}/g" ${INPFILE}
          sed -i "s/variable xmove equal.*/variable xmove equal ${xtrans}\*\$\{xinc\}/g" ${INPFILE}
          sed -i "s/variable ymove equal.*/variable ymove equal ${ytrans}\*\$\{yinc\}/g" ${INPFILE}
          
          rm -rf ${NEWDIRECT[$i]}/
          rm log.lammps
          
          mpirun -np 6 lmp_openmpi < ${INP-FILE[$i]}
          
          cd ${NEWDIRECT}
          gbenergy=$(echo $(echo dump.final_*.txt | grep -oE "[0-9]{4}"))
          echo dump.final_*.txt | grep -oE "[0-9]{4}"
          if [ $? -ne 0 ]; then
            unset gbenergy
            gbenergy=$(echo $(echo dump.final-*.txt | grep -oE "[0-9]{3}"))
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
            cp ${INPFILE} ${NEW_DIRECT}
            mv ${NEWDIRECT}/ MIN-GB-DATA/${NEWDIRECT}_${MINGBENG}
          fi
        done
      done
    done
  done
done
rm *-
exit 0