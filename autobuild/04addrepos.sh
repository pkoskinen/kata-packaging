#! /bin/sh
# funet.fi mirror empty on 16-Apr-2013
sudo yum install -y http://ftp.df.lth.se/pub/fedora-epel/6/x86_64/epel-release-6-8.noarch.rpm
curl -O http://download.opensuse.org/repositories/security://shibboleth/CentOS_CentOS-6/security:shibboleth.repo
sudo cp security:shibboleth.repo /etc/yum.repos.d/
