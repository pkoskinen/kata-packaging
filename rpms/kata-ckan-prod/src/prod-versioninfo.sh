#! /bin/sh
date="$(date)"
echo "--- $date ---: Part I (sourcediffs)" >kata-prod.versioninfo
cat sourcediffs.txt >>kata-prod.versioninfo
echo "--- $date ---: Part II (from dev.rpm)" >>kata-prod.versioninfo
cat /usr/share/doc/kata-ckan-dev/kataversion.txt >>kata-prod.versioninfo
echo "--- $date ---: End of Part II" >>kata-prod.versioninfo
