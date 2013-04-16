#! /bin/sh
e=$(date +%s)
min=$(($e/60))
version=$(($min%1000000))
here=$(pwd)
name=$(basename "$here")
nv="${name}-${version}"
if [ ! \(  "$name" = kata-ckan-dev \) -a ! \( "$name" = kata-ckan-prod \) -a ! \( "$name" = mcfg \) -a ! \( "$name" = dummy-deps \) ]
then
  echo "run this from kata-ckan-dev, kata-ckan-prod, mcfg or dummy-deps" >&2
  echo "script deletes files, which might not be generally"
  echo "a good idea if run from a random place" >&2
  exit 2
fi
if [ -d "${nv}" ]
# not very likely, but who cares...
then
  rm -rf "${nv}"
fi
if [ -x src/versioninfo.sh ]
then
  pushd src >/dev/null
  ./versioninfo
  pod >/dev/null
fi
cp -a src "${nv}"
tar cjhf "${nv}.tgz" "${nv}/"
rm -rf "${nv}"
pushd ~/rpmbuild >/dev/null
cd SPECS
if [ -L "${name}.spec" ]
then
  rm "${name}.spec"
fi
ln -s "${here}/${name}.spec"
cd ../SOURCES
if [ -L "${nv}.tgz" ]
# not very likely, but who cares...
then
  rm "${nv}.tgz" ]
fi
ln -s "${here}/${nv}.tgz"
cd ..
AUTOV="${version}" rpmbuild -ba "SPECS/${name}.spec"
rm "SPECS/${name}.spec"
rm "SOURCES/${nv}.tgz"
popd >/dev/null
rm "${nv}.tgz"


