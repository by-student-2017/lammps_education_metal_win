#!/bin/bash
##############################################################################
# To use this script make 2 flolders named "xyz_files" and "Characterization" #
# Put this script in the "Characterization" floder #
# Inside "xyz_files" put xyz files, NCPac.inp, NCPac.exe #
# Replace these two lines inside NCPac.inp #
# infile - name of xyz input file [in_filexyz] #
# nax nay naz - x,y,z cell length (Angstrom) (used if in_pbc_option=1) [in_xl,in_yl,in_zl] #
# Now you can make this script executable using : chmod 777 name.sh #
# This script extracts g(r), S(Q), Bond length, bond count, bond angle, coordination no. #
# Script by: Rajan Khadka, Bikash Timalsina #
#------------------------------------------------------------------------------------------------------------------#
NO_OF_FILES=`ls ../xyz_files | grep xyz | wc -l` 
for (( i=1; i<=$NO_OF_FILES; i++ ))
do
file=`ls ../xyz_files | grep xyz | sed -n ${i}p`
folder=`echo $file | sed -r 's/.{4}$//'`
mkdir $folder
cp ../xyz_files/$file ./$folder
cp ../xyz_files/NCPac.inp ./$folder
cp ../xyz_files/NCPac.exe ./$folder
var1=`sed -n 2p ./$folder/$file | awk -F "\"" '{print $2}' | awk -F " " '{print $1}'`
var2=`sed -n 2p ./$folder/$file | awk -F "\"" '{print $2}' | awk -F " " '{print $5}'`
var3=`sed -n 2p ./$folder/$file | awk -F "\"" '{print $2}' | awk -F " " '{print $9}'`
var11=`echo "$var1+0.1" | bc -l`
var22=`echo "$var2+0.1" | bc -l`
var33=`echo "$var3+0.1" | bc -l`
sed -i "s/infile/$file/" ./$folder/NCPac.inp
sed -i "s/nax/$var11/" ./$folder/NCPac.inp
sed -i "s/nay/$var22/" ./$folder/NCPac.inp
sed -i "s/naz/$var33/" ./$folder/NCPac.inp
cd ./$folder
./NCPac.exe ./NCPac.inp > logs
echo "completed processing file: $i/$NO_OF_FILES"
sleep 2s
echo "Creating bond directories ..."
if [ ! -d "../Bond_Length" ];
then
mkdir ../Bond_Length
touch ../Bond_Length/od_BOND_length.dat
fi
if [ ! -d "../Bond_Types" ];
then
mkdir ../Bond_Types
touch ../Bond_Types/od_BOND_types.dat
fi
if [ ! -d "../Bond_Classify" ];
then
mkdir ../Bond_Classify
touch ../Bond_Classify/od_CLASSIFY.dat
fi
if [ ! -d "../Bond_COORD" ];
then
mkdir ../Bond_COORD
touch ../Bond_COORD/od_COORD.dat
fi
if [ ! -d "../Bond_SQ" ];
then
mkdir ../Bond_SQ
touch ../Bond_SQ/od_SQ.dat
fi
if [ ! -d "../Bond_G3" ];
then
mkdir ../Bond_G3
touch ../Bond_G3/od_G3.dat
touch ../Bond_G3/od_G3_Total.dat
touch ../Bond_G3/od_G3_111.dat
touch ../Bond_G3/od_G3_112.dat
touch ../Bond_G3/od_G3_113.dat
touch ../Bond_G3/od_G3_122.dat
touch ../Bond_G3/od_G3_123.dat
touch ../Bond_G3/od_G3_133.dat
touch ../Bond_G3/od_G3_211.dat
touch ../Bond_G3/od_G3_212.dat
touch ../Bond_G3/od_G3_213.dat
touch ../Bond_G3/od_G3_222.dat
touch ../Bond_G3/od_G3_223.dat
touch ../Bond_G3/od_G3_233.dat
touch ../Bond_G3/od_G3_311.dat
touch ../Bond_G3/od_G3_312.dat
touch ../Bond_G3/od_G3_313.dat
touch ../Bond_G3/od_G3_322.dat
touch ../Bond_G3/od_G3_323.dat
touch ../Bond_G3/od_G3_333.dat
fi
if [ ! -d "../Bond_G2" ];
then
mkdir ../Bond_G2
touch ../Bond_G2/od_G2.dat
touch ../Bond_G2/od_G2_Total.dat
touch ../Bond_G2/od_G2_11.dat
touch ../Bond_G2/od_G2_12.dat
touch ../Bond_G2/od_G2_13.dat
touch ../Bond_G2/od_G2_22.dat
touch ../Bond_G2/od_G2_23.dat
touch ../Bond_G2/od_G2_33.dat
fi
echo "Bond directories created. Writing to bond directories"
sed -n 3p ./od_BOND_length.dat >> ../Bond_Length/od_BOND_length.dat
sed -n 3p ./od_BOND_types.dat >> ../Bond_Types/od_BOND_types.dat
sed -n 3p ./od_CLASSIFY.dat >> ../Bond_Classify/od_CLASSIFY.dat
sed -n 3,6p ./od_COORD.dat >> ../Bond_COORD/od_COORD.dat
sed -n 3p ./od_SQ.dat >> ../Bond_SQ/od_SQ.dat
sed -n 3,21p ./od_G3.dat >> ../Bond_G3/od_G3.dat
sed -n 3p ./od_G3.dat >> ../Bond_G3/od_G3_Total.dat
sed -n 4p ./od_G3.dat >> ../Bond_G3/od_G3_111.dat
sed -n 5p ./od_G3.dat >> ../Bond_G3/od_G3_112.dat
sed -n 6p ./od_G3.dat >> ../Bond_G3/od_G3_113.dat
sed -n 7p ./od_G3.dat >> ../Bond_G3/od_G3_122.dat
sed -n 8p ./od_G3.dat >> ../Bond_G3/od_G3_123.dat
sed -n 9p ./od_G3.dat >> ../Bond_G3/od_G3_133.dat
sed -n 10p ./od_G3.dat >> ../Bond_G3/od_G3_211.dat
sed -n 11p ./od_G3.dat >> ../Bond_G3/od_G3_212.dat
sed -n 12p ./od_G3.dat >> ../Bond_G3/od_G3_213.dat
sed -n 13p ./od_G3.dat >> ../Bond_G3/od_G3_222.dat
sed -n 14p ./od_G3.dat >> ../Bond_G3/od_G3_223.dat
sed -n 15p ./od_G3.dat >> ../Bond_G3/od_G3_233.dat
sed -n 16p ./od_G3.dat >> ../Bond_G3/od_G3_311.dat
sed -n 17p ./od_G3.dat >> ../Bond_G3/od_G3_312.dat
sed -n 18p ./od_G3.dat >> ../Bond_G3/od_G3_313.dat
sed -n 19p ./od_G3.dat >> ../Bond_G3/od_G3_322.dat
sed -n 20p ./od_G3.dat >> ../Bond_G3/od_G3_323.dat
sed -n 21p ./od_G3.dat >> ../Bond_G3/od_G3_333.dat
sed -n 2,9p ./od_G2.dat >> ../Bond_G2/od_G2.dat
sed -n 3p ./od_G2.dat >> ../Bond_G2/od_G2_Total.dat
sed -n 4p ./od_G2.dat >> ../Bond_G2/od_G2_11.dat
sed -n 5p ./od_G2.dat >> ../Bond_G2/od_G2_12.dat
sed -n 6p ./od_G2.dat >> ../Bond_G2/od_G2_13.dat
sed -n 7p ./od_G2.dat >> ../Bond_G2/od_G2_22.dat
sed -n 8p ./od_G2.dat >> ../Bond_G2/od_G2_23.dat
sed -n 9p ./od_G2.dat >> ../Bond_G2/od_G2_33.dat
sleep 3s
cd ..
done
#-------------------------------------------------The End-------------------------------------------------------