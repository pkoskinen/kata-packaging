#! /bin/sh
# configure our dependencies (packages which have been installed before)
set -x
if [ -f /tmp/kata-SKIP04 ]
then
  echo "Skipping 04"
  exit 0
fi
patchdir=$1

# the rpm package has installed several jobs to cron.daily
# because ckan is not yet readily installed they will fail if run now
# stop crond here to avoid this (actually there is a small window
# of opprotunity that it has already happened. It's not really fatal,
# but a nuisance because root will receive mail. This typically happened
# in dev.rpm installation, because dev installation lasts 55-58 minutes
service crond stop

service tomcat6 stop
cd /etc/tomcat6
patch -b -p2 -i "${patchdir}/tomcat6.conf.patch"
python /usr/share/mcfg/tool/mcfg.py run /usr/share/mcfg/config/kata-template.ini /root/kata-master.ini 4
service tomcat6 start
# only apache account has access to the DB (besides postgres admin), allow it
# to run setup scripts and cron jobs
chsh -s /bin/bash apache
mkdir /home/ckan
chown apache:apache /home/ckan
