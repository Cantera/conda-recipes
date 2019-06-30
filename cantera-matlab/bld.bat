@ECHO off

echo ****************************
echo MATLAB BUILD STARTED
echo ****************************

REM IF %ARCH% EQU 64 (
REM     CALL "%VS140COMNTOOLS%"\..\..\VC\bin\amd64\vcvars64.bat
REM ) ELSE (
REM     CALL "%VS140COMNTOOLS%"\..\..\VC\bin\vcvars32.bat
REM )

:: Have to use CALL to prevent the script from exiting after calling SCons
CALL scons clean
IF ERRORLEVEL 1 EXIT 1

DEL /F cantera.conf

COPY "%RECIPE_DIR%\..\.ci_support\cantera_base.conf" cantera.conf
ECHO msvc_version='14.1' >> cantera.conf

SET "STAGE_DIR=stage"
ECHO stage_dir="%STAGE_DIR%" >> cantera.conf
ECHO prefix="" >> cantera.conf

:: Set the number of CPUs to use in building
SET /A CPU_USE=%CPU_COUNT% / 2
IF %CPU_USE% EQU 0 SET CPU_USE=1

SET "ESC_LIB_INC=%LIBRARY_INC:\=/%"
ECHO boost_inc_dir="%ESC_LIB_INC%" >> cantera.conf

ECHO matlab_toolbox='y' >> cantera.conf
SET "ESC_MW_HDR_DIR=%MW_HEADERS_DIR:\=/%"
ECHO matlab_path="%ESC_MW_HDR_DIR%" >> cantera.conf

CALL scons build -j%CPU_USE%
IF ERRORLEVEL 1 EXIT 1

CALL scons install
IF ERRORLEVEL 1 EXIT 1

:: "Install" just the Matlab interface. This method should
:: prevent this package from clobbering any existing
:: libcantera or Cantera Python interface files, possibly except the
:: data files and the license file.
ROBOCOPY "%STAGE_DIR%\samples\matlab" "%LIBRARY_PREFIX%\cantera\samples\matlab" /S /E
ROBOCOPY "%STAGE_DIR%\matlab" "%LIBRARY_LIB%\cantera\matlab" /S /E
ROBOCOPY "%STAGE_DIR%\data" "%LIBRARY_PREFIX%\cantera\data" /S /E
ROBOCOPY "%STAGE_DIR%\doc" "%LIBRARY_PREFIX%\cantera\doc" /S /E

echo ****************************
echo MATLAB BUILD COMPLETED SUCCESSFULLY
echo ****************************
