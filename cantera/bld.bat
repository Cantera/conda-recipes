@ECHO off

echo ****************************
echo BUILD STARTED
echo ****************************

:: IF %ARCH% EQU 64 (
::	  CALL "%VS141COMNTOOLS%"\..\..\VC\bin\amd64\vcvars64.bat
:: ) ELSE (
::    CALL "%VS150COMNTOOLS%"\..\..\VC\bin\vcvars32.bat
:: )

DEL /F cantera.conf

:: Set the number of CPUs to use in building
SET /A CPU_USE=%CPU_COUNT% / 2
IF %CPU_USE% EQU 0 SET CPU_USE=1

:: Have to use CALL to prevent the script from exiting after calling SCons
CALL scons clean
IF ERRORLEVEL 1 EXIT 1

:: Put important settings into cantera.conf for the build. Use VS 2015 to
:: compile the interface.
ECHO msvc_version='14.1' >> cantera.conf
ECHO matlab_toolbox='n' >> cantera.conf
ECHO debug='n' >> cantera.conf
ECHO f90_interface='n' >> cantera.conf
ECHO system_sundials='n' >> cantera.conf
ECHO python_package='none' >> cantera.conf

SET "ESC_PREFIX=%PREFIX:\=/%"
ECHO prefix="%ESC_PREFIX%" >> cantera.conf
ECHO boost_inc_dir="%ESC_PREFIX%/Library/include" >> cantera.conf
ECHO use_pch = False >> cantera.conf

CALL scons build -j%CPU_USE%
IF ERRORLEVEL 1 EXIT 1

echo "****************************"
echo "BUILD COMPLETED SUCCESSFULLY"
echo "****************************"
