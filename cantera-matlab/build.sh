set +x

echo "****************************"
echo "MATLAB BUILD STARTED"
echo "****************************"

if [[ "$DIRTY" != "1" ]]; then
    scons clean
fi

rm -f cantera.conf

# Use the compilers from the Conda environment
if [[ "${OSX_ARCH}" == "" ]]; then
    echo "CC = '${CC}'" >> cantera.conf
    echo "CXX = '${CXX}'" >> cantera.conf
else
    echo "CC = '${CLANG}'" >> cantera.conf
    echo "CXX = '${CLANGXX}'" >> cantera.conf
    echo "cc_flags = '-isysroot ${CONDA_BUILD_SYSROOT} -mmacosx-version-min=${MACOSX_DEPLOYMENT_TARGET}'" >> cantera.conf
fi

echo "prefix = '${PREFIX}'" >> cantera.conf
echo "use_pch = False" >> cantera.conf

# We want the MATLAB interface but not the Fortran or Python interfaces
echo "matlab_toolbox = 'y'" >> cantera.conf
echo "matlab_path = '${MW_HEADERS_DIR}'" >> cantera.conf
echo "f90_interface = 'n'" >> cantera.conf
echo "system_sundials = 'n'" >> cantera.conf
echo "debug = 'n'" >> cantera.conf
echo "boost_inc_dir = '$PREFIX/include'" >> cantera.conf
echo "python_package = 'none'" >> cantera.conf

set -xe

scons build -j${CPU_COUNT}
scons install

set +xe
