#!/bin/bash

# Remove the old builder environement, if it exists
if [[ -d "$PREFIX/../cantera-builder" ]]; then
    conda env remove -yq -p "$PREFIX/../cantera-builder"
fi

# Create a conda environment to build Cantera. It has to be Python 2, for
# SCons compatibility. When SCons is available for Python 3, these machinations
# can be removed
conda create -yq -p "$PREFIX/../cantera-builder" -c cantera/label/builddeps python=2 scons cython 3to2 boost

# The major version of the Python that will be used for the installer, not the
# version used for building
PY_MAJ_VER=${PY_VER:0:1}

OLD_CONDA_ENV="$CONDA_DEFAULT_ENV"
set +x
source activate "$PREFIX/../cantera-builder"

scons clean

# We want neither the MATLAB interface nor the Fortran interface
echo "matlab_toolbox='n'" >> cantera.conf
echo "f90_interface='n'" >> cantera.conf
echo "system_sundials='n'" >> cantera.conf
echo "debug='n'" >> cantera.conf
echo "boost_inc_dir = '$PREFIX/../cantera-builder/include'" >> cantera.conf

if [[ "$CONDA_ARCH" == "linux_x86" ]]; then
  echo "cc_flags='-m32'" >> cantera.conf
  echo "no_debug_linker_flags='-m32'" >> cantera.conf
fi

if [[ "$CONDA_ARCH" != "osx_x64" ]]; then
    echo "blas_lapack_libs = 'mkl_rt,dl'" >> cantera.conf
    echo "blas_lapack_dir = '$PREFIX/lib'" >> cantera.conf
fi

set -x

# Run SCons to build the proper Python interface
if [ "${PY_MAJ_VER}" == "2" ]; then
    scons build -j$((CPU_COUNT/2)) python3_package='n' python_cmd=$PYTHON python_package='full'
else
    scons build -j$((CPU_COUNT/2)) python3_package='y' python3_cmd=$PYTHON python_package='none'
fi

# Remove the builder environment
set +x
source activate "$OLD_CONDA_ENV"
set -x
conda env remove -yq -p "$PREFIX/../cantera-builder"

# Change to the Python interface directory and run the installer using the
# proper version of Python.
cd interfaces/cython
$PYTHON setup${PY_MAJ_VER}.py build --build-lib=../../build/python${PY_MAJ_VER} install
