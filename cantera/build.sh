set +x

echo "****************************"
echo "LIBRARY BUILD STARTED"
echo "CONDA_BUILD_SYSROOT IS $CONDA_BUILD_SYSROOT"
echo "****************************"

scons clean

rm -f cantera.conf

# Use the compilers from the Conda environment
echo "CC = '$CC'" >> cantera.conf
echo "CXX = '$CXX'" >> cantera.conf

echo "prefix = '$PREFIX'" >> cantera.conf
echo "use_pch = False" >> cantera.conf

# We want neither the MATLAB interface nor the Fortran interface
echo "matlab_toolbox = 'n'" >> cantera.conf
echo "f90_interface = 'n'" >> cantera.conf
echo "system_sundials = 'n'" >> cantera.conf
echo "debug = 'n'" >> cantera.conf
echo "boost_inc_dir = '$PREFIX/include'" >> cantera.conf
echo "python_package = 'none'" >> cantera.conf

if [[ "$ARCH" == "32" ]]; then
  echo "cc_flags='-m32'" >> cantera.conf
  echo "no_debug_linker_flags='-m32'" >> cantera.conf
fi

if [[ "$OSX_ARCH" == "" ]]; then
    echo "blas_lapack_libs = 'mkl_rt,dl'" >> cantera.conf
    echo "blas_lapack_dir = '$PREFIX/lib'" >> cantera.conf
fi

set -xe

scons build -j2

set +xe

echo "****************************"
echo "BUILD COMPLETED SUCCESSFULLY"
echo "****************************"
