#! /bin/sh
cd rpmbuild/SOURCES
curl -O http://www.poolsaboveground.com/apache/lucene/solr/4.3.0/solr-4.3.0.tgz 
cd ../SPECS
ln -s ../../rpms/solr/solr.spec
arch=$(rpm -q --qf '%{arch}\n' --specfile solr.spec | head -n 1)
# just in case, make sure the * in yum install command below will not match
# several files
rm -f ../RPMS/${arch}/solr-4.3.0-*.el6.${arch}.rpm
rpmbuild -ba solr.spec
cd ../RPMS/${arch}
sudo yum install -y solr-4.3.0-*.el6.${arch}.rpm
