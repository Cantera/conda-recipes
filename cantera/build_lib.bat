call %RECIPE_DIR%/build_devel.bat
echo "****************************"
echo "DELETING files from devel except shared libraries and data"
echo "****************************"

rd /s /q %PREFIX%\Library\share\cantera\doc
rd /s /q %PREFIX%\Library\share\cantera\samples
rd /s /q %PREFIX%\Library\share\man
rd /s /q %PREFIX%\Library\share
rd /s /q %PREFIX%\Library\include\cantera
