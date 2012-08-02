#!/bin/sh
set -x
instloc=$1

cd $instloc
source pyenv/bin/activate
cp $instloc/pyenv/src/ckan/ckan/config/solr/schema-1.4.xml /opt/solr/conf/schema.xml
service tomcat6 restart