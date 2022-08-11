echo "***************************"
echo "DEVEL LIBRARY BUILD STARTED"
echo "***************************"

set -e

${BUILD_PREFIX}/bin/python `which scons` install
set +e

rm -r $PREFIX/share/cantera/samples
cp -r $SRC_DIR/samples/cxx $PREFIX/share/cantera/samples/cxx
rm $PREFIX/share/cantera/samples/cxx/SCons*
rm $PREFIX/share/cantera/samples/cxx/*Make*

echo "*****************************"
echo "DEVEL LIBRARY BUILD COMPLETED"
echo "*****************************"
