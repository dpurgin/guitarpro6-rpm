#!/bin/bash

GP6FILE="gp6-full-linux-r11621.deb"

# Check for Guitar Pro 6 archive
if [ ! -f "${GP6FILE}" ]; then
    echo "Download the Guitar Pro 6 Linux version (${GP6FILE}) and put it into this directory."
    exit 0
fi

mkdir prep
pushd prep 1>/dev/null

# Download Ubuntu libssl-0.9.8
echo " > Downloading Ubuntu OpenSSL 0.9.8"
wget -q http://security.ubuntu.com/ubuntu/pool/universe/o/openssl098/libssl0.9.8_0.9.8o-7ubuntu3.2.14.04.1_i386.deb 1>/dev/null

# unpack data from both deb archives
echo " > Unpacking Ubuntu OpenSSL 0.9.8"
ar x libssl0.9.8_0.9.8o-7ubuntu3.2.14.04.1_i386.deb data.tar.xz
# pick out needed libs
tar -xf data.tar.xz ./lib/i386-linux-gnu/libcrypto.so.0.9.8 --strip-components 3
tar -xf data.tar.xz ./lib/i386-linux-gnu/libssl.so.0.9.8  --strip-components 3

echo " > Unpacking Guitar Pro 6"
ar x "../${GP6FILE}" data.tar.gz
# get needed Guitar Pro directory
tar -xf data.tar.gz ./opt/GuitarPro6 --strip-components 2

# create directories for rpm package
echo " > Generating package structure"
BASE="GuitarPro6-6.1.6"
RPMLIB="${BASE}/usr/lib"
RPMBIN="${BASE}/usr/bin"
RPMAPPS="${BASE}/usr/share/applications"
RPMPIX="${BASE}/usr/share/pixmaps"
mkdir -p "${RPMLIB}"
mkdir -p "${RPMBIN}"
mkdir -p "${RPMAPPS}"
mkdir -p "${RPMPIX}"

# move directory to destination
mv GuitarPro6 "${RPMLIB}"

# move libs to destination
mv libcrypto.so.0.9.8 "${RPMLIB}/GuitarPro6"
mv libssl.so.0.9.8 "${RPMLIB}/GuitarPro6"


# put shared files
cp ../guitarpro6.png "${RPMPIX}"
cp ../GuitarPro6.desktop "${RPMAPPS}"

# put fixed launcher
cp ../launcher.sh "${RPMLIB}/GuitarPro6"
chmod +x "${RPMLIB}/GuitarPro6/launcher.sh"

# put fake gksudo
cp ../gksudo "${RPMBIN}"
chmod +x "${RPMBIN}/gksudo"

# put GuitarPro bin link
ln -s ../lib/GuitarPro6/launcher.sh "${RPMBIN}/GuitarPro"

# put desktop file
cp ../GuitarPro6.desktop "${RPMAPPS}"

# Put icon
cp ../guitarpro6.png "${RPMPIX}"

# create tar.bz2 to be used by the SPEC
echo " > Compressing archive (might take a minute)"
tar cfj "${BASE}.tar.bz2" "${BASE}"

popd 1>/dev/null

mv "prep/${BASE}.tar.bz2" .

echo " > Cleaning up"
rm -r prep

echo " > Done"
