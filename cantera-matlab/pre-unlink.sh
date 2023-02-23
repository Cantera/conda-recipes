MATLAB_STARTUP="${HOME}/Documents/MATLAB/startup.m"

CONDA_ENV=${PREFIX##*/}

if [ -f "${MATLAB_STARTUP}" ]; then
    sed -i.cantera.bak "/.* % added by Cantera ${PKG_VERSION} Conda installer for ${CONDA_ENV} environment$/d" "${MATLAB_STARTUP}"
fi
