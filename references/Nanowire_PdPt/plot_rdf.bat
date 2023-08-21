@echo off

echo "Set up new_rdf.dat for plot_rdf_all_v2.gpl"

set file_name=data.rdf
set ndata=100

del new_rdf.dat

for /f "tokens=1-4" %%a in (%file_name%) do (
  if "%%b"=="%ndata%" (
    echo; >> new_rdf.dat
  ) else (
    echo %%a %%b %%c %%d >> new_rdf.dat
  )
)

plot_rdf_all_v2.gpl

rem findstr /V/R/C "^* 100" %file_name% > new_rdf.dat
rem findstr /V/R/C " 100$" %file_name% > new_rdf.dat