set +x

echo "****************************"
echo "MATLAB BUILD STARTED"
echo "****************************"

scons clean

rm -f cantera.conf

# Use the compilers from the Conda environment
echo "CC = '$CC'" >> cantera.conf
echo "CXX = '$CXX'" >> cantera.conf

echo "prefix = '$PREFIX'" >> cantera.conf
echo "use_pch = False" >> cantera.conf

# We want the MATLAB interface but not the Fortran or Python interfaces
echo "matlab_toolbox = 'y'" >> cantera.conf
echo "matlab_path = '${MW_HEADERS_DIR}'" >> cantera.conf
echo "f90_interface = 'n'" >> cantera.conf
echo "system_sundials = 'n'" >> cantera.conf
echo "debug = 'n'" >> cantera.conf
echo "boost_inc_dir = '$PREFIX/include'" >> cantera.conf
echo "python_package = 'none'" >> cantera.conf

set -xe

scons build -j2
scons install

set +xe
