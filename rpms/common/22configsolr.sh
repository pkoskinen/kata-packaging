#!/bin/sh
set -x
if [ -f /tmp/kata-SKIP22 ]
then
  echo "Skipping 22"
  exit 0
fi
instloc=$1
patchdir=$2
postfix=-$(date +%y%m%d-%H%M%S)
chkconfig tomcat6 stop

pushd /opt/data/solr >/dev/null
patch -b -p2 -i "${patchdir}/solr.xml.patch"
popd >/dev/null

cp /opt/data/solr/collection1/conf/schema.xml /opt/data/solr/collection1/conf/schema.xml.bak-${postfix}
cp $instloc/pyenv/src/ckan/ckan/config/solr/schema-2.0.xml /opt/data/solr/collection1/conf/schema.xml
chown tomcat:tomcat /opt/data/solr/solr.xml
service tomcat6 start
chkconfig tomcat6 on
