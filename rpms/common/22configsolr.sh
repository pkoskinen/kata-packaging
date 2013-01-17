#!/bin/sh
set -x
if [ -f /tmp/kata-SKIP22 ]
then
  echo "Skipping 22"
  exit 0
fi
instloc=$1
cp /opt/data/solr/conf/schema.xml /opt/data/solr/conf/schema.xml.bak
cp $instloc/pyenv/src/ckan/ckan/config/solr/schema-2.0.xml /opt/data/solr/conf/schema.xml
service tomcat6 restart
chkconfig tomcat6 on
