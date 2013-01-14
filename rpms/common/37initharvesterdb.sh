#! /bin/sh
# remember: we are not root here (%ckanuser from the spec file)
set -x
if [ -f /tmp/kata-SKIP37 ]
then
  echo "Skipping 37"
  exit 0
fi
instloc=$1
cd $instloc
if [ \! -e /tmp/kata-SKIP-dbinit ]
then
  source pyenv/bin/activate
  paster --plugin=ckanext-harvest harvester initdb --config=$instloc/pyenv/src/ckan/development.ini
else
  # CKAN DB exists, no need to init harvester DB either
  true
fi 
