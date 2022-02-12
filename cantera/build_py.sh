echo "****************************"
echo "PYTHON ${PY_VER} BUILD STARTED"
echo "****************************"

# Remove old Python build files, if they're present
if [ -d "build/python" ]; then
    rm -r build/python
    rm -r build/temp-py
fi

if [[ $PY_VER == "3.7" ]]; then
    scons build --debug=explain python_package='y' python_cmd="${PYTHON}"
else
    scons build python_package='y' python_cmd="${PYTHON}"
fi

echo "****************************"
echo "PYTHON ${PY_VER} BUILD COMPLETED SUCCESSFULLY"
echo "****************************"

$PYTHON -m pip install --no-deps build/python/dist/*.whl
