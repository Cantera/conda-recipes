echo "****************************"
echo "PYTHON ${PY_VER} BUILD STARTED"
echo "****************************"

# Remove old Python build files, if they're present
if [ -d "build/python" ]; then
    rm -r build/python
    rm -r build/temp-py
fi

scons build python_package='y' python_cmd="${PYTHON}"

echo "****************************"
echo "PYTHON ${PY_VER} BUILD COMPLETED SUCCESSFULLY"
echo "****************************"

$PYTHON -m pip install build/python/dist/*.whl
