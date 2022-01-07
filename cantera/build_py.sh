echo "****************************"
echo "PYTHON ${PY_VER} BUILD STARTED"
echo "****************************"

# Remove old Python build files, if they're present
if [ -d "build/python" ]; then
    rm -r build/python
    rm -r build/temp-py
    rm interfaces/cython/setup.py
    rm -rf interfaces/cython/build
    rm -rf interfaces/cython/dist
    rm -rf interfaces/cython/Cantera.egg-info
fi

scons build python_package='y' python_cmd="${PYTHON}"

echo "****************************"
echo "PYTHON ${PY_VER} BUILD COMPLETED SUCCESSFULLY"
echo "****************************"

cd interfaces/cython
$PYTHON setup.py build --build-lib=../../build/python install --single-version-externally-managed --record=record.txt
