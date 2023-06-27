echo ****************************
echo PYTHON %PYTHON% BUILD STARTED
echo ****************************

:: Remove old Python build files, if they are present
IF EXIST "build/python" RD /S /Q "build/python"
IF EXIST "build/temp-py" RD /S /Q "build/temp-py"
IF EXIST "%PREFIX%/bin/ck2yaml" DEL /F "%PREFIX%/bin/ck2yaml"
IF EXIST "%PREFIX%/bin/cti2yaml" DEL /F "%PREFIX%/bin/cti2yaml"
IF EXIST "%PREFIX%/bin/ctml2yaml" DEL /F "%PREFIX%/bin/ctml2yaml"
IF EXIST "%PREFIX%/bin/yaml2ck" DEL /F "%PREFIX%/bin/yaml2ck"

SET "ESC_PYTHON=%PYTHON:\=/%"
ECHO python_cmd="%ESC_PYTHON%" >> cantera.conf

:: Set the number of CPUs to use in building
SET /A CPU_USE=%CPU_COUNT% / 2
IF %CPU_USE% EQU 0 SET CPU_USE=1

CALL scons build -j%CPU_USE% python_package=y
IF ERRORLEVEL 1 EXIT 1

"%PYTHON%" -m pip install --no-deps --no-index --find-links=build\python\dist\ cantera
IF ERRORLEVEL 1 EXIT 1

:: Plugin library for loading Cantera Python extensions from C++
copy "%SRC_DIR%\build\lib\cantera_python*.dll" "%PREFIX%\Library\bin\"

ROBOCOPY "%SRC_DIR%\samples\python" "%PREFIX%\share\cantera\samples\python" /S /E

echo ****************************
echo PYTHON %PYTHON% BUILD COMPLETED SUCCESSFULLY
echo ****************************
