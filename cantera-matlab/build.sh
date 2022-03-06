set +x

echo "****************************"
echo "MATLAB BUILD STARTED"
echo "****************************"

cp "${RECIPE_DIR}/../.ci_support/cantera_base.conf" cantera.conf

echo "prefix = ''" >> cantera.conf
echo "boost_inc_dir = '${PREFIX}/include'" >> cantera.conf

# Stage the files to make copying easier later
STAGE_DIR="stage"
echo "stage_dir = '${STAGE_DIR}'" >> cantera.conf

echo "matlab_toolbox = 'y'" >> cantera.conf
echo "matlab_path = '${MW_HEADERS_DIR}'" >> cantera.conf

set -xe

${BUILD_PREFIX}/bin/python `which scons` build -j${CPU_COUNT}
${BUILD_PREFIX}/bin/python `which scons` install

# "Install" just the Matlab interface. This method should
# prevent this package from clobbering any existing
# libcantera or Cantera Python interface files, except the
# data files and the license file.
CT_SAMPLES_DIR="share/cantera/samples/matlab"
mkdir -p "${PREFIX}/${CT_SAMPLES_DIR}"
cp -R "${STAGE_DIR}/${CT_SAMPLES_DIR}/" "${PREFIX}/${CT_SAMPLES_DIR}"
CT_DATA_DIR="share/cantera/data"
mkdir -p "${PREFIX}/${CT_DATA_DIR}"
cp -R "${STAGE_DIR}/${CT_DATA_DIR}/" "${PREFIX}/${CT_DATA_DIR}"
CT_DOC_DIR="share/cantera/doc"
mkdir -p "${PREFIX}/${CT_DOC_DIR}"
cp -R "${STAGE_DIR}/${CT_DOC_DIR}/" "${PREFIX}/${CT_DOC_DIR}"
CT_LIB_DIR="lib/cantera/matlab"
mkdir -p "${PREFIX}/${CT_LIB_DIR}"
cp -R "${STAGE_DIR}/${CT_LIB_DIR}/" "${PREFIX}/${CT_LIB_DIR}"

set +xe

echo "****************************"
echo "MATLAB BUILD COMPLETED SUCCESSFULLY"
echo "****************************"
