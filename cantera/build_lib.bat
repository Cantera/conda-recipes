call %RECIPE_DIR%/build_devel.bat
echo "****************************"
echo "DELETING files from devel except shared libraries and data"
echo "****************************"

rd /s /q %PREFIX%\share\cantera\samples
rd /s /q %PREFIX%\Library\include\cantera
del /f %PREFIX%\Scripts\*2yaml.*
del /f %PREFIX%\Scripts\yaml2*
del /f %PREFIX%\Library\lib\cantera.lib
del /f %PREFIX%\Library\lib\cantera_shared.lib
del /f %PREFIX%\Library\lib\cantera_shared.exp

echo "****************************"
echo "DELETING files COMPLETED"
echo "****************************"
