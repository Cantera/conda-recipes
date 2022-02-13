echo "****************************"
echo "DEVEL LIBRARY INSTALL STARTED"
echo "****************************"

set -e

${BUILD_PREFIX}/bin/python `which scons` install
set +e

echo "****************************"
echo "DEVEL LIBRARY INSTALL COMPLETED SUCCESSFULLY"
echo "****************************"
