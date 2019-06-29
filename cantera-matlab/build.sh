set +x

echo "****************************"
echo "MATLAB BUILD STARTED"
echo "****************************"

if [[ "$DIRTY" != "1" ]]; then
    scons clean
fi

rm -f cantera.conf

cp "${RECIPE_DIR}/../.ci_support/cantera_base.conf" cantera.conf

echo "prefix = '${PREFIX}'" >> cantera.conf
echo "boost_inc_dir = '${PREFIX}/include'" >> cantera.conf

if [[ "${OSX_ARCH}" == "" ]]; then
    echo "CC = '${CC}'" >> cantera.conf
    echo "CXX = '${CXX}'" >> cantera.conf
else
    echo "CC = '${CLANG}'" >> cantera.conf
    echo "CXX = '${CLANGXX}'" >> cantera.conf
    echo "cc_flags = '-isysroot ${CONDA_BUILD_SYSROOT} -mmacosx-version-min=${MACOSX_DEPLOYMENT_TARGET}'" >> cantera.conf
fi

echo "matlab_toolbox = 'y'" >> cantera.conf
echo "matlab_path = '${MW_HEADERS_DIR}'" >> cantera.conf

set -xe

scons build -j${CPU_COUNT}
scons install

set +xe
