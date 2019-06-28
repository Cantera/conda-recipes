@ECHO off

echo ****************************
echo MATLAB BUILD STARTED
echo ****************************

REM IF %ARCH% EQU 64 (
REM 	CALL "%VS140COMNTOOLS%"\..\..\VC\bin\amd64\vcvars64.bat
REM ) ELSE (
REM 	CALL "%VS140COMNTOOLS%"\..\..\VC\bin\vcvars32.bat
REM )

DEL /F cantera.conf

:: Set the number of CPUs to use in building
SET /A CPU_USE=%CPU_COUNT% / 2
IF %CPU_USE% EQU 0 SET CPU_USE=1

:: Have to use CALL to prevent the script from exiting after calling SCons
CALL scons clean

:: Put important settings into cantera.conf for the build. Use VS 2015 to
:: compile the interface.
ECHO msvc_version='14.0' >> cantera.conf
ECHO matlab_toolbox='y' >> cantera.conf
ECHO matlab_path='%CD%/../mw_headers' >> cantera.conf
ECHO debug='n' >> cantera.conf
ECHO f90_interface='n' >> cantera.conf
ECHO system_sundials='n' >> cantera.conf
ECHO python_package='none' >> cantera.conf

SET "ESC_PREFIX=%PREFIX:\=/%"
ECHO prefix="%ESC_PREFIX%" >> cantera.conf
ECHO boost_inc_dir="%ESC_PREFIX%/Library/include" >> cantera.conf

CALL scons build -j%CPU_USE%

echo ****************************
echo BUILD COMPLETED SUCCESSFULLY
echo ****************************
