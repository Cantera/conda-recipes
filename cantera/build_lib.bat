call %RECIPE_DIR%/build_devel.bat
echo "****************************"
echo "DELETING files from devel except shared libraries"
echo "****************************"

rd /s /q %PREFIX%\Library\share
rd /s /q %PREFIX%\Library\include\cantera
