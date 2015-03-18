#!/bin/bash

# mono-3.6.0.39
TAG=$@
if [ -z $TAG ]; then
  TAG="master"
fi
echo "Building Mono from Git Using $TAG"

PREFIX="/usr/local"
chown -R `whoami` $PREFIX

# Ensure that all required packages are installed.
echo "Installing Mono Build Prerequisites"
apt-get update
apt-get install -y git mono-devel
apt-get install -y autoconf libtool automake build-essential mono-devel gettext

echo "Downloading mono source"
# PATH=$PREFIX/bin:$PATH
git clone --branch $TAG https://github.com/mono/mono.git /mono
cd /mono
./autogen.sh
# ./autogen.sh --prefix=$PREFIX
make
make install

#
# Remove leftover cruft
#
# cd ..
# rm -rf mono

# Remove unnecessary packages
# apt-get purge -y autoconf libtool automake build-essential gettext

# Remove unnecessary dependencies 
# apt-get autoremove
#apt-get clean
# rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

