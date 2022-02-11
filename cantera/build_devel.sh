echo "****************************"
echo "DEVEL LIBRARY INSTALL STARTED"
echo "****************************"

set -e
if [ -f "cantera.conf.pre-py" ]; then
  cp cantera.conf.pre-py cantera.conf
fi
ls -la
scons install
set +e

echo "****************************"
echo "DEVEL LIBRARY INSTALL COMPLETED SUCCESSFULLY"
echo "****************************"
