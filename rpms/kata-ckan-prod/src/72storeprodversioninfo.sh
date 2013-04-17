#! /bin/sh
set -x
if [ -f /tmp/kata-SKIP72 ]
then
  echo "Skipping 72"
  exit 0
fi
datadir=$1
docdir=$2
date="$(date)"
echo "--- $date ---: Part I" >>$docdir/kataversion.txt
cat ${datadir}/sourcediffs.txt >>$docdir/kataversion.txt
echo "--- $date ---: Part II" >>$docdir/kataversion.txt
cat ${datadir}/katadevversion.txt >>$docdir/kataversion.txt
echo "--- $date ---: End of Part II" >>$docdir/kataversion.txt