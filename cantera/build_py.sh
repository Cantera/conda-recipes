echo "****************************"
echo "PYTHON BUILD STARTED"
echo "$PY_VER    $NPY_VER"
echo "PYTHON IS $PYTHON"
echo "****************************"

scons build python_package='y' python_cmd="${PYTHON}"

echo "****************************"
echo "BUILD COMPLETED SUCCESSFULLY"
echo "****************************"

cd interfaces/cython
$PYTHON setup.py build --build-lib=../../build/python install
