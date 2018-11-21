SET "ESC_PYTHON=%PYTHON:\=/%"
CALL scons build python_package=y python_cmd="%ESC_PYTHON%"
IF ERRORLEVEL 1 EXIT 1
cd interfaces/cython
"%PYTHON%" setup.py build --build-lib=../../build/python install
