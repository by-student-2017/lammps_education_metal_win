echo "-------------------------------------------------------------"
echo erate1e-1 %date% %time%
cd ./erate1e-1
call ../run_msmpi_v2.bat
cd ../

echo "-------------------------------------------------------------"
echo erate1e-2 %date% %time%
cd ./erate1e-2
call ../run_msmpi_v2.bat
cd ../

echo "-------------------------------------------------------------"
echo erate1e-3 %date% %time%
cd ./erate1e-3
call ../run_msmpi_v2.bat
cd ../

echo "-------------------------------------------------------------"
echo erate1e-4 %date% %time%
cd ./erate1e-4
call ../run_msmpi_v2.bat
cd ../

echo "-------------------------------------------------------------"
echo erate1e-5 %date% %time%
cd ./erate1e-5
call ../run_msmpi_v2.bat
cd ../