echo "***************************"
echo "DEVEL LIBRARY BUILD STARTED"
echo "***************************"

set -e

${BUILD_PREFIX}/bin/python `which scons` install
set +e

rm -rf $PREFIX/share/man

echo "*****************************"
echo "DEVEL LIBRARY BUILD COMPLETED"
echo "*****************************"
