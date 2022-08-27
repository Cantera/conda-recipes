set +x

echo "****************************"
echo "MATLAB BUILD STARTED"
echo "****************************"

cp "${RECIPE_DIR}/../.ci_support/cantera_base.conf" cantera.conf

PREFIX_DIR="some_random_prefix"
echo "prefix = '${PREFIX_DIR}'" >> cantera.conf
echo "boost_inc_dir = '${PREFIX}/include'" >> cantera.conf

# Stage the files to make copying easier later
STAGE_DIR="stage"
echo "stage_dir = '${STAGE_DIR}'" >> cantera.conf

if [[ "${OSX_ARCH}" == "" ]]; then
    echo "optimize_flags = ''" >> cantera.conf
    echo "debug = False" >> cantera.conf
    echo "logging = 'debug'" >> cantera.conf
else
    echo "cc_flags = '-isysroot ${CONDA_BUILD_SYSROOT}'" >> cantera.conf
    echo "optimize_flags = ''" >> cantera.conf
    echo "debug = False" >> cantera.conf
    echo "no_debug_linker_flags = '-isysroot ${CONDA_BUILD_SYSROOT}'" >> cantera.conf
    echo "use_rpath_linkage = False" >> cantera.conf
    echo "logging = 'debug'" >> cantera.conf
fi

echo "matlab_toolbox = 'y'" >> cantera.conf
echo "matlab_path = '${MW_HEADERS_DIR}'" >> cantera.conf

set -xe

${BUILD_PREFIX}/bin/python ${BUILD_PREFIX}/bin/scons install

# "Install" just the Matlab interface. This method should
# prevent this package from clobbering any existing
# libcantera or Cantera Python interface files, except the
# data files and the license file.
CT_SAMPLES_DIR="share/cantera/samples"
mkdir -p "${PREFIX}/${CT_SAMPLES_DIR}"
cp -R "${STAGE_DIR}/${PREFIX_DIR}/${CT_SAMPLES_DIR}/matlab" "${PREFIX}/${CT_SAMPLES_DIR}/"
CT_SHARED_DIR="share/cantera"
cp -R "${STAGE_DIR}/${PREFIX_DIR}/${CT_SHARED_DIR}/data" "${PREFIX}/${CT_SHARED_DIR}/"
cp -R "${STAGE_DIR}/${PREFIX_DIR}/${CT_SHARED_DIR}/doc" "${PREFIX}/${CT_SHARED_DIR}/"
cp -R "${STAGE_DIR}/${PREFIX_DIR}/${CT_SHARED_DIR}/matlab" "${PREFIX}/${CT_SHARED_DIR}/"

set +xe

echo "****************************"
echo "MATLAB BUILD COMPLETED SUCCESSFULLY"
echo "****************************"
