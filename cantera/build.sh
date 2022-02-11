set +x
echo "****************************"
echo "LIBRARY BUILD STARTED"
echo "****************************"

rm -f cantera.conf

cp "${RECIPE_DIR}/../.ci_support/cantera_base.conf" cantera.conf

echo "prefix = '${PREFIX}'" >> cantera.conf
echo "boost_inc_dir = '${PREFIX}/include'" >> cantera.conf

if [[ "${OSX_ARCH}" == "" ]]; then
    echo "CC = '${CC}'" >> cantera.conf
    echo "CXX = '${CXX}'" >> cantera.conf
    echo "blas_lapack_libs = 'mkl_rt,dl'" >> cantera.conf
    echo "blas_lapack_dir = '${PREFIX}/lib'" >> cantera.conf
    echo "cc_flags = '${CFLAGS}'" >> cantera.conf
    echo "cxx_flags = '${CXXFLAGS}'" >> cantera.conf
    echo "optimize_flags = ''" >> cantera.conf
    echo "debug = False" >> cantera.conf
    echo "no_debug_linker_flags = '${LDFLAGS}'" >> cantera.conf
    echo "VERBOSE = True" >> cantera.conf
else
    echo "CC = '${CLANG}'" >> cantera.conf
    echo "CXX = '${CLANGXX}'" >> cantera.conf
    echo "blas_lapack_libs = 'openblas'" >> cantera.conf
    echo "blas_lapack_dir = '${PREFIX}/lib'" >> cantera.conf
    echo "cc_flags = '-isysroot ${CONDA_BUILD_SYSROOT} ${CFLAGS}'" >> cantera.conf
    echo "cxx_flags = '${CXXFLAGS}'" >> cantera.conf
    echo "optimize_flags = ''" >> cantera.conf
    echo "debug = False" >> cantera.conf
    echo "no_debug_linker_flags = '-L${CONDA_BUILD_SYSROOT}/usr/lib'" >> cantera.conf
    echo "env_vars = 'LD'" >> cantera.conf
    echo "VERBOSE = True" >> cantera.conf
fi

set -xe

scons build -j${CPU_COUNT}
cp cantera.conf cantera.conf.pre-py
set +xe

echo "****************************"
echo "BUILD COMPLETED SUCCESSFULLY"
echo "****************************"
