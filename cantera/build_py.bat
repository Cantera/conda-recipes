SET "ESC_PYTHON=%PYTHON:\=/%"
CALL scons build python_package=y python_cmd="%ESC_PYTHON%"
cd interfaces/cython
"%PYTHON%" setup.py build --build-lib=../../build/python install
