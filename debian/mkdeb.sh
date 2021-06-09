#!/bin/bash

version="1.0-3"
target="./reform-handbook_${version}/usr/share/doc/reform-handbook"

mkdir -p "${target}/usr/bin"
cp reform-handbook "${target}/usr/bin/"

mkdir -p "${target}/html"
rm -r "${target}/html"

cp -Rv ./DEBIAN "./reform-handbook_${version}/"
cp -Rv ../src/build/html "${target}/"

rm "${target}/html/_static/schem/"*.sla
rm "${target}/html/_static/"*.sla

for f in "${target}/html/_images/*"
do
    echo "mogrify: $f"
    mogrify -resize 1280 "$f"
done

du -ch ./reform-handbook_${version}

dpkg-deb -b ./reform-handbook_${version}
