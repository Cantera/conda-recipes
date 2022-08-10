call %RECIPE_DIR%/build_devel.bat
echo "****************************"
echo "DELETING files from devel except shared libraries and data"
echo "****************************"

rd /s /q %PREFIX%\share\cantera\doc
rd /s /q %PREFIX%\share\cantera\samples
rd /s /q %PREFIX%\share\man
rd /s /q %PREFIX%\Library\include\cantera
rd /s /q %PREFIX%\Scripts
del /f %PREFIX%\Library\lib\cantera.lib
del /f %PREFIX%\Library\lib\cantera_shared.lib

echo "****************************"
echo "DELETING files COMPLETED"
echo "****************************"
