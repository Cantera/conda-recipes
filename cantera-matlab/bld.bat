@ECHO off

echo ****************************
echo MATLAB BUILD STARTED
echo ****************************

COPY "%RECIPE_DIR%\..\.ci_support\cantera_base.conf" cantera.conf
ECHO msvc_version='14.2' >> cantera.conf

SET "STAGE_DIR=stage"
ECHO stage_dir="%STAGE_DIR%" >> cantera.conf
SET "PREFIX_DIR=some_random_prefix"
ECHO prefix="%PREFIX_DIR%" >> cantera.conf

:: Set the number of CPUs to use in building
SET /A CPU_USE=%CPU_COUNT% / 2
IF %CPU_USE% EQU 0 SET CPU_USE=1

SET "ESC_LIB_INC=%LIBRARY_INC:\=/%"
ECHO boost_inc_dir="%ESC_LIB_INC%" >> cantera.conf

ECHO matlab_toolbox='y' >> cantera.conf
SET "ESC_MW_HDR_DIR=%MW_HEADERS_DIR:\=/%"
ECHO matlab_path="%ESC_MW_HDR_DIR%" >> cantera.conf

CALL scons install
IF ERRORLEVEL 1 EXIT 1

:: "Install" just the Matlab interface. This method should
:: prevent this package from clobbering any existing
:: libcantera or Cantera Python interface files, possibly except the
:: data files and the license file.
ROBOCOPY "%STAGE_DIR%\%PREFIX_DIR%\share\cantera\samples\matlab" "%PREFIX%\share\cantera\samples\matlab" /S /E
ROBOCOPY "%STAGE_DIR%\%PREFIX_DIR%\share\cantera\matlab" "%PREFIX%\share\cantera\matlab" /S /E
ROBOCOPY "%STAGE_DIR%\%PREFIX_DIR%\share\cantera\data" "%PREFIX%\share\cantera\data" /S /E
ROBOCOPY "%STAGE_DIR%\%PREFIX_DIR%\share\cantera\doc" "%PREFIX%\share\cantera\doc" /S /E

echo ****************************
echo MATLAB BUILD COMPLETED SUCCESSFULLY
echo ****************************
