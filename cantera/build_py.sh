echo "******************************"
echo "PYTHON ${PY_VER} BUILD STARTED"
echo "******************************"

# Remove old Python build files, if they're present
rm -rf build/python
rm -rf build/temp-py
rm -rf build/lib/libcantera_python*
rm -f $PREFIX/bin/ck2yaml
rm -f $PREFIX/bin/cti2yaml
rm -f $PREFIX/bin/ctml2yaml
rm -f $PREFIX/bin/yaml2ck
rm -f $PREFIX/lib/libcantera_python*
rm -rf $PREFIX/lib/python3.*/site-packages/cantera

${BUILD_PREFIX}/bin/python `which scons` build python_package='y' python_cmd="${PYTHON}" -j${CPU_COUNT}

$PYTHON -m pip install --no-deps --no-index --find-links=build/python/dist cantera

mkdir -p $PREFIX/share/cantera/samples
cp -r $SRC_DIR/samples/python $PREFIX/share/cantera/samples/
mkdir -p $PREFIX/share/man
cp -r $SRC_DIR/platform/posix/man/* $PREFIX/share/man/man1/

# Plugin library for loading Cantera Python extensions from C++
mkdir -p $PREFIX/lib
cp $SRC_DIR/build/lib/libcantera_python* $PREFIX/lib/

if [[ "$target_platform" == osx-* ]]; then
   VERSION=$(echo $PKG_VERSION | cut -da -f1 | cut -db -f1 | cut -dr -f1)
   file_to_fix=$(find $SP_DIR -name "_cantera*.so" | head -n 1)
   ${OTOOL:-otool} -L $file_to_fix
   ${INSTALL_NAME_TOOL:-install_name_tool} -change build/lib/libcantera.${VERSION}.dylib "@rpath/libcantera.${VERSION}.dylib" $file_to_fix
fi

echo "********************************"
echo "PYTHON ${PY_VER} BUILD COMPLETED"
echo "********************************"
