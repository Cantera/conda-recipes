echo "***************************"
echo "DEVEL LIBRARY BUILD STARTED"
echo "***************************"

set -e

${BUILD_PREFIX}/bin/python `which scons` install
set +e

rm -rf $PREFIX/share/man/man1/yaml2*.1
rm -rf $PREFIX/share/man/man1/*2yaml.1

echo "*****************************"
echo "DEVEL LIBRARY BUILD COMPLETED"
echo "*****************************"
