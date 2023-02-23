@ECHO off
REM This script adds the appropriate setup lines to startup.m
REM This script will edit files in the user's Documents directory,
REM in direct contravention of the guideline from Conda to not
REM edit any files outside the install prefix. This seems like the
REM easiest way to set these variables though; the alternative is
REM to make people type/add these lines themselves. /shrug
FOR /F "usebackq tokens=* delims=" %%A in (`powershell -ExecutionPolicy Bypass -Command "[Environment]::GetFolderPath('MyDocuments')"`) do @set "MATLAB_STARTUP=%%A\MATLAB\startup.m"
REM Set a variable with the name of the conda environment
for %%A in ("%PREFIX%") do set CONDA_ENV=%%~nxA

REM If the startup.m file already exists, delete any lines added by this script
IF EXIST "%MATLAB_STARTUP%" COPY "%MATLAB_STARTUP%" "%MATLAB_STARTUP%.cantera.bak"
IF EXIST "%MATLAB_STARTUP%.cantera.bak" FINDSTR /V /C:"%% added by Cantera %PKG_VERSION% Conda Installer for %CONDA_ENV% environment" "%MATLAB_STARTUP%.cantera.bak" > "%MATLAB_STARTUP%"

REM Add Cantera lines to the startup.m script
ECHO. >> "%MATLAB_STARTUP%"
ECHO setenv('CANTERA_DATA', '%PREFIX%\share\cantera\data') %% added by Cantera %PKG_VERSION% Conda Installer for %CONDA_ENV% environment>> "%MATLAB_STARTUP%"
ECHO addpath(genpath('%PREFIX%\share\cantera\matlab')) %% added by Cantera %PKG_VERSION% Conda Installer for %CONDA_ENV% environment>> "%MATLAB_STARTUP%"
