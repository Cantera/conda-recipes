@ECHO off
FOR /F "usebackq tokens=* delims=" %%A in (`powershell -ExecutionPolicy Bypass -Command "[Environment]::GetFolderPath('MyDocuments')"`) do @set "MATLAB_STARTUP=%%A\MATLAB\startup.m"

REM Set a variable with the name of the conda environment
for %%A in ("%PREFIX%") do set CONDA_ENV=%%~nxA

REM If the startup.m file already exists, delete any lines added by this script
IF EXIST "%MATLAB_STARTUP%" COPY "%MATLAB_STARTUP%" "%MATLAB_STARTUP%.cantera.bak"
IF EXIST "%MATLAB_STARTUP%.cantera.bak" FINDSTR /V /C:"%% added by Cantera %PKG_VERSION% Conda Installer for %CONDA_ENV% environment" "%MATLAB_STARTUP%.cantera.bak" > "%MATLAB_STARTUP%"
