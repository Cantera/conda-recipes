#!/bin/bash

PY_MAJ_VER=${PY_VER:0:1}

if [ "${PY_MAJ_VER}" == "2" ]; then
    conda install -y -c cantera/label/builddeps 3to2
fi

scons clean

# We want neither the MATLAB interface nor the Fortran interface
echo "matlab_toolbox='n'" >> cantera.conf
echo "f90_interface='n'" >> cantera.conf
echo "system_sundials='n'" >> cantera.conf
echo "debug='n'" >> cantera.conf
echo "boost_inc_dir = '$PREFIX/include'" >> cantera.conf

if [[ "$CONDA_ARCH" == "linux_x86" ]]; then
  echo "cc_flags='-m32'" >> cantera.conf
  echo "no_debug_linker_flags='-m32'" >> cantera.conf
fi

if [[ "$CONDA_ARCH" == "osx_x64" ]]; then
    echo "no_debug_linker_flags='-Wl,-headerpad_max_install_names'" >> cantera.conf
else
    echo "blas_lapack_libs = 'mkl_rt,dl'" >> cantera.conf
    echo "blas_lapack_dir = '$PREFIX/lib'" >> cantera.conf
fi

set -x

# Run SCons to build the proper Python interface
scons build -j$((CPU_COUNT/2)) python_package=y python_cmd=$PYTHON

# Change to the Python interface directory and run the installer using the
# proper version of Python.
cd interfaces/cython
$PYTHON setup${PY_MAJ_VER}.py build --build-lib=../../build/python${PY_MAJ_VER} install
