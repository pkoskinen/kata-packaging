#! /bin/sh
rpms/kata-ckan-dev/src/versioninfo.sh
mv version.info rpms/kata-ckan-dev/src
cd rpms/kata-ckan-dev
./build-from-repo.sh
