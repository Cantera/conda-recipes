echo "****************************"
echo "DEVEL LIBRARY INSTALL STARTED"
echo "****************************"

set -e
# Remove the python_cmd configuration because Python is not
# a host dependency of the libcantera package
sed -i.bak '/python_cmd/d' cantera.conf
rm -f cantera.conf.bak*
scons install python_package='none'
set +e

echo "****************************"
echo "DEVEL LIBRARY INSTALL COMPLETED SUCCESSFULLY"
echo "****************************"
