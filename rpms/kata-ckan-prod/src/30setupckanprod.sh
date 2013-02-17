#! /bin/sh
# remember: we are not root here (%ckanuser from the spec file)
set -x
if [ -f /tmp/kata-SKIP30 ]
then
  echo "Skipping 30"
  exit 0
fi
instloc=$1
cd $instloc
source pyenv/bin/activate
cd pyenv/src/ckan
if [ \! -e /tmp/kata-SKIP-dbinit ]
then
  paster --plugin=ckan db init
else
  paster --plugin=ckan db upgrade
fi
