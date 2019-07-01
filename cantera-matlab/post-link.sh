# This script adds the appropriate setup lines to startup.m
# This script will edit files in the user's Documents directory,
# in direct contravention of the guideline from Conda to not
# edit any files outside the install prefix. This seems like the
# easiest way to set these variables though; the alternative is
# to make people type/add these lines themselves. /shrug
MATLAB_STARTUP="${HOME}/Documents/MATLAB/startup.m"

CONDA_ENV=${PREFIX##*/}

if [ -f "${MATLAB_STARTUP}" ]; then
    sed -i '.cantera.bak' "/.* % added by Cantera Conda installer for ${CONDA_ENV} environment$/d" "${MATLAB_STARTUP}"
fi

echo "
addpath(genpath('${PREFIX}/lib/cantera/matlab')) % added by Cantera ${PKG_VERSION} Conda installer for ${CONDA_ENV} environment
setenv('CANTERA_DATA', '${PREFIX}/share/cantera/data') % added by Cantera ${PKG_VERSION} Conda installer for ${CONDA_ENV} environment" >> ${MATLAB_STARTUP}
