#!/bin/bash

old=`grep "^Version:" ./v2ray-linux-amd64/DEBIAN/control | cut -d ' ' -f2`
version=$1
wget https://github.com/v2ray/v2ray-core/releases/download/v"${version}"/v2ray-linux-64.zip || exit 1
unzip v2ray-linux-64.zip -d v2ray-linux-64
cp -v ./v2ray-linux-64/v2ray ./v2ray-linux-amd64/usr/bin/v2ray/
cp -v ./v2ray-linux-64/v2ctl ./v2ray-linux-amd64/usr/bin/v2ray/
cp -v ./v2ray-linux-64/geoip.dat ./v2ray-linux-amd64/usr/bin/v2ray/
cp -v ./v2ray-linux-64/geosite.dat ./v2ray-linux-amd64/usr/bin/v2ray/
cp -v ./v2ray-linux-64/systemd/v2ray.service ./v2ray-linux-amd64/etc/systemd/system/
size=`du -sk v2ray-linux-amd64/ | cut -f1`
sed -i -e "/^Version:/cVersion: $version" -e "/^Installed-Size:/cInstalled-Size: $size" ./v2ray-linux-amd64/DEBIAN/control
sed -i "s/$old/$version/g" ./README.md ./build.sh
rm -rf ./v2ray-linux-64*
