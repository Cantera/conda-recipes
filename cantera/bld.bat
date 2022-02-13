@ECHO off

echo ****************************
echo BUILD STARTED
echo ****************************

COPY "%RECIPE_DIR%\..\.ci_support\cantera_base.conf" cantera.conf
ECHO msvc_version='14.1' >> cantera.conf

:: Set the number of CPUs to use in building
SET /A CPU_USE=%CPU_COUNT% / 2
IF %CPU_USE% EQU 0 SET CPU_USE=1

SET "ESC_PREFIX=%PREFIX:\=/%"
ECHO prefix="%ESC_PREFIX%/Library" >> cantera.conf
ECHO boost_inc_dir="%ESC_PREFIX%/Library/include" >> cantera.conf
ECHO renamed_shared_libraries="False" >> cantera.conf

CALL scons build -j%CPU_USE%
IF ERRORLEVEL 1 EXIT 1

echo ****************************
echo BUILD COMPLETED SUCCESSFULLY
echo ****************************
