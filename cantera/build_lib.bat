call %RECIPE_DIR%/build_devel.bat
echo "****************************"
echo "DELETING files from devel except shared libraries"
echo "****************************"

rd /s /q %PREFIX%/share
rd /s /q %PREFIX%/include
rd /s /q %PREFIX%/bin
rd /s /q %PREFIX%/lib/pkg-config
rd /s /q %PREFIX%/lib/libcantera.a
