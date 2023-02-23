set +x
echo "******************"
echo "MAIN BUILD STARTED"
echo "******************"

cp "${RECIPE_DIR}/../.ci_support/cantera_base.conf" cantera.conf

echo "prefix = '${PREFIX}'" >> cantera.conf

if [[ "${OSX_ARCH}" == "" ]]; then
    echo "CC = '${CC}'" >> cantera.conf
    echo "CXX = '${CXX}'" >> cantera.conf
    # TODO: reactivate MKL; it is disabled as a temporary fix of #29 to resolve #31
    # echo "blas_lapack_libs = 'mkl_rt,dl'" >> cantera.conf
    echo "cc_flags = '${CFLAGS}'" >> cantera.conf
    echo "optimize_flags = ''" >> cantera.conf
    echo "debug = False" >> cantera.conf
    echo "use_rpath_linkage = False" >> cantera.conf
    echo "no_debug_linker_flags = '${LDFLAGS}'" >> cantera.conf
    echo "renamed_shared_libraries = False" >> cantera.conf
    echo "logging = 'debug'" >> cantera.conf
else
    echo "CC = '${CLANG}'" >> cantera.conf
    echo "CXX = '${CLANGXX}'" >> cantera.conf
    echo "blas_lapack_libs = 'openblas'" >> cantera.conf
    echo "cc_flags = '-isysroot ${CONDA_BUILD_SYSROOT} ${CFLAGS}'" >> cantera.conf
    echo "optimize_flags = ''" >> cantera.conf
    echo "debug = False" >> cantera.conf
    echo "no_debug_linker_flags = '${LDFLAGS} -isysroot ${CONDA_BUILD_SYSROOT}'" >> cantera.conf
    echo "logging = 'debug'" >> cantera.conf
    echo "renamed_shared_libraries = False" >> cantera.conf
    echo "use_rpath_linkage = False" >> cantera.conf
fi

echo "extra_inc_dirs = '${PREFIX}/include'" >> cantera.conf
echo "extra_lib_dirs = '${PREFIX}/lib'" >> cantera.conf

set -xe

${BUILD_PREFIX}/bin/python `which scons` build -j${CPU_COUNT}
cp cantera.conf cantera.conf.pre-py
set +xe

echo "********************"
echo "MAIN BUILD COMPLETED"
echo "********************"
