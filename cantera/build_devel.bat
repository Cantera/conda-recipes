ECHO ************************
ECHO DEVEL BUILD STARTED
ECHO ************************

CALL scons install

RD /S /Q "%PREFIX%/share/cantera/samples"
ROBOCOPY "%SRC_DIR%/samples/cxx" "%PREFIX%/share/cantera/samples/cxx" /S /E
DEL /F "%PREFIX%/share/cantera/samples/cxx/SCons*"
DEL /F "%PREFIX%/share/cantera/samples/cxx/*Make*"

ECHO ************************
ECHO DEVEL BUILD COMPLETED SUCCESSFULLY
ECHO ************************
