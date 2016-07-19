#!/bin/bash

# Remove the old builder environement, if it exists
conda env remove -yq -n cantera-builder

# Create a conda environment to build Cantera. It has to be Python 2, for
# SCons compatibility. When SCons is available for Python 3, these machinations
# can be removed
conda create -yq -n cantera-builder python=2 numpy=$NPY_VER scons cython 3to2 mkl

# The major version of the Python that will be used for the installer, not the
# version used for building
PY_MAJ_VER=${PY_VER:0:1}

set +x
source activate cantera-builder

scons clean

# We want neither the MATLAB interface nor the Fortran interface
echo "matlab_toolbox='n'" >> cantera.conf
echo "f90_interface='n'" >> cantera.conf
echo "system_sundials='n'" >> cantera.conf
echo "blas_lapack_libs = 'm,dl,mkl_rt,mkl_intel_lp64,mkl_core,mkl_intel_thread,iomp5'" >> cantera.conf
echo "blas_lapack_dir = '$PREFIX/lib'" >> cantera.conf

# Run SCons to build the proper Python interface
if [ "${PY_MAJ_VER}" == "2" ]; then
    scons build -j$((CPU_COUNT/2)) python3_package='n' python_cmd=$PYTHON python_package='full'
else
    scons build -j$((CPU_COUNT/2)) python3_package='y' python3_cmd=$PYTHON python_package='none'
fi

scons test-python3

# Remove the builder environment
set +x
source deactivate
set -x
conda env remove -yq -n cantera-builder

# Change to the Python interface directory and run the installer using the
# proper version of Python.
cd interfaces/cython
$PYTHON setup${PY_MAJ_VER}.py build --build-lib=../../build/python${PY_MAJ_VER} install
