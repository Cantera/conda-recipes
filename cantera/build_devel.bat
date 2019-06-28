COPY cantera.conf cantera.conf.bak
FINDSTR /V "python_cmd" cantera.conf.bak > cantera.conf
COPY cantera.conf cantera.conf.bak
FINDSTR /V "python_package" cantera.conf.bak > cantera.conf
ECHO python_package = 'none' >> cantera.conf
CALL scons install
