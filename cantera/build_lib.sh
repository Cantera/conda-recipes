source $RECIPE_DIR/build_devel.sh
echo "****************************"
echo "DELETING files from devel except shared libraries and data"
echo "****************************"

rm -rf $PREFIX/share/cantera/doc
rm -rf $PREFIX/share/cantera/samples
rm -rf $PREFIX/share/man
rm -rf $PREFIX/include/cantera
rm -rf $PREFIX/bin
rm -rf $PREFIX/lib/pkgconfig
rm -rf $PREFIX/lib/libcantera.a

if [[ "$target_platform" == osx-* ]]; then
  ${OTOOL:-otool} -L $PREFIX/lib/libcantera.dylib
fi

echo "************************"
echo "DELETING files COMPLETED"
echo "************************"
