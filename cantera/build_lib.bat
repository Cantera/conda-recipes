COPY cantera.conf cantera.conf.bak
FINDSTR /V "python_cmd" cantera.conf.bak > cantera.conf
CALL scons install python_package='none'
