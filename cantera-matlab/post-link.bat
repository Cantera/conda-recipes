REM This script adds the appropriate setup lines to startup.m
REM This script will edit files in the user's Documents directory,
REM in direct contravention of the guideline from Conda to not
REM edit any files outside the install prefix. This seems like the
REM easiest way to set these variables though; the alternative is
REM to make people type/add these lines themselves. /shrug
@ECHO off
SET "MATLAB_STARTUP=%USERPROFILE%\Documents\MATLAB\startup.m"

REM Set a variable with the name of the conda environment
for %%A in ("%PREFIX%\") do set CONDA_ENV=%%~nxA

REM If the startup.m file already exists, delete any lines added by this script
IF EXIST "%MATLAB_STARTUP%" COPY "%MATLAB_STARTUP%" "%MATLAB_STARTUP%.cantera.bak"
IF EXIST "%MATLAB_STARTUP%.cantera.bak" FINDSTR /V "%% added by Cantera Conda Installer for %CONDA_ENV% environment" "%MATLAB_STARTUP%.cantera.bak" > "%MATLAB_STARTUP%"

REM Add Cantera lines to the startup.m script
ECHO. >> "%MATLAB_STARTUP%"
ECHO setenv('CANTERA_DATA', '%PREFIX%\Library\cantera\data') %% added by Cantera Conda Installer for %CONDA_ENV% environment>> "%MATLAB_STARTUP%"
ECHO addpath(genpath('%PREFIX%\Library\lib\cantera\matlab')) %% added by Cantera Conda Installer for %CONDA_ENV% environment>> "%MATLAB_STARTUP%"
