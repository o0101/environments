#!/usr/bin/env bash

which autoconf || sudo apt install -y autoconf
which make || sudo apt install -y build-essential
sudo apt install -y libcurl4-openssl-dev libz-dev libssl-dev libexpat-dev gettext asciidoc
TMPD1=$(mktemp -d)
cd $TMPD1
wget -O git.tar.gz https://github.com/git/git/archive/refs/tags/v2.41.0.tar.gz
gunzip git.tar.gz
tar -xf git.tar
rm git.tar
cd git*
pwd
echo $TMPD1
make configure
./configure --prefix=/usr
make all doc
sudo make install install-doc
cd $HOME
rm -rf $TMPD1
echo Git 2.41.0 installed!
git --version
