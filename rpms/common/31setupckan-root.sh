#! /bin/sh
# this script is run as root (previous NNsetupckan.sh as %ckanuser)
set -x
if [ -f /tmp/kata-SKIP31 ]
then
  echo "Skipping 31"
  exit 0
fi
ckauser=$1
mkdir -p /opt/data/ckan
pushd /opt/data/ckan >/dev/null
mkdir data sstore data_tree
chown ${ckauser}:${ckanuser} data sstore data_tree
# Apache setup script will later change this again, but let's simulate the
# previous behavior when these directories where still in the pyenv code
# tree and created by ckanuser

cp /home/ckan/pyenv/src/development.ini /etc/kata.ini
python /usr/share/mcfg/tool/mcfg.py run /usr/share/mcfg/config/kata-template.ini /root/kata-master.ini 30
# run it a second time to support replace_by_ip for development systems
# previous increment number "stolen from 30setupckanprod. It could not run 
# mcfg without switchuser anyway. Should we want to add that later, we need the
# switch user back to root here anyway and then we should detect the "theft" 
python /usr/share/mcfg/tool/mcfg.py run /usr/share/mcfg/config/kata-template.ini /root/kata-master.ini 31
# set same rights as development.ini used to have (from 32setupapache.sh)
# this also allows 36ckaninstallenxtensions.sh to edit the extensions list
chown  ckan:apache /etc/kata.ini
chmod -R 755 /home/ckan
semanage fcontext -a -t http_sys_content_t /etc/kata.ini
restorecon /etc/kata.ini
