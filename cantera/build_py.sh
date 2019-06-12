echo "****************************"
echo "PYTHON BUILD STARTED"
echo "****************************"

scons build python_package='y' python_cmd="${PYTHON}"

echo "****************************"
echo "PYTHON BUILD COMPLETED SUCCESSFULLY"
echo "****************************"

cd interfaces/cython
$PYTHON setup.py build --build-lib=../../build/python install
