CALL scons build python_package=y python_cmd="%PYTHON%"
cd interfaces/cython
"%PYTHON%" setup.py build --build-lib=../../build/python install
