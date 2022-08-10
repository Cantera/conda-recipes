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

CALL scons build python_package=y
IF ERRORLEVEL 1 EXIT 1

"%PYTHON%" -m pip install --no-deps --no-index --find-links=build\python\dist\ cantera
IF ERRORLEVEL 1 EXIT 1

echo ****************************
echo PYTHON %PYTHON% BUILD COMPLETED SUCCESSFULLY
echo ****************************
