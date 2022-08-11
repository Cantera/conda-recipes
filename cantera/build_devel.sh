echo "***************************"
echo "DEVEL LIBRARY BUILD STARTED"
echo "***************************"

set -e

${BUILD_PREFIX}/bin/python `which scons` install
set +e

echo "*****************************"
echo "DEVEL LIBRARY BUILD COMPLETED"
echo "*****************************"
