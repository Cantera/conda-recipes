#!/bin/bash

# Remove the old builder environement, if it exists
conda env remove -y -n cantera-builder

# Create a conda environment to build Cantera. It has to be Python 2, for
# SCons compatibility. When SCons is available for Python 3, these machinations
# can be removed
conda create -y -n cantera-builder python=2 numpy scons cython

# The major version of the Python that will be used for the installer, not the
# version used for building
PY_MAJ_VER=${PY_VER:0:1}

# If we're installing for Python 2, we need 3to2 to convert the examples
if [ "${PY_MAJ_VER}" == "2" ]; then
    pip install 3to2
fi

# Using activate to activate the build environement didn't seem to work, so set
# the path manually
OLD_PATH=$PATH
export PATH=${PREFIX%_build}cantera-builder/bin:$PATH

scons clean

# We want neither the MATLAB interface nor the Fortran interface
echo "matlab_toolbox='n'" >> cantera.conf
echo "f90_interface='n'" >> cantera.conf
echo "system_sundials='n'" >> cantera.conf

# Run SCons to build the proper Python interface
if [ "${PY_MAJ_VER}" == "2" ]; then
    scons build -j$((CPU_COUNT/2)) python3_package='n' python_cmd=$PYTHON python_package='full'
else
    scons build -j$((CPU_COUNT/2)) python3_package='y' python3_cmd=$PYTHON python_package='none'
fi

# Remove the builder environment
conda env remove -y -n cantera-builder

# Reset the PATH
export PATH=$OLD_PATH

# Change to the Python interface directory and run the installer using the
# proper version of Python.
cd interfaces/cython
$PYTHON setup${PY_MAJ_VER}.py build --build-lib=../../build/python${PY_MAJ_VER} install
