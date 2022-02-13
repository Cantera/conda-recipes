echo "****************************"
echo "PYTHON ${PY_VER} BUILD STARTED"
echo "****************************"

# Remove old Python build files, if they're present
if [ -d "build/python" ]; then
    rm -r build/python
    rm -r build/temp-py
    rm $PREFIX/bin/ck2cti || true
    rm $PREFIX/bin/ck2yaml || true
    rm $PREFIX/bin/ctml_writer || true
    rm $PREFIX/bin/cti2yaml || true
    rm $PREFIX/bin/ctml2yaml || true
fi

${BUILD_PREFIX}/bin/python `which scons` build --debug=explain python_package='y' python_cmd="${PYTHON}"

echo "****************************"
echo "PYTHON ${PY_VER} BUILD COMPLETED SUCCESSFULLY"
echo "****************************"

$PYTHON -m pip install --no-deps build/python/dist/*.whl

if [[ "$target_platform" == osx-* ]]; then
   VERSION=$(echo $PKG_VERSION | cut -db -f1)
   file_to_fix=$(find $SP_DIR -name "_cantera*.so" | head -n 1)
   ${OTOOL:-otool} -L $file_to_fix
   ${INSTALL_NAME_TOOL:-install_name_tool} -change build/lib/libcantera.${VERSION}.dylib "@rpath/libcantera.${VERSION}.dylib" $file_to_fix
fi
