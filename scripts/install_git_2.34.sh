#!/usr/bin/env bash

TMPD1=$(mktemp -d)
cd $TMPD1
wget -O git.tar.gz https://github.com/git/git/archive/refs/tags/v2.34.4.tar.gz
gunzip git.tar.gz
tar -xf git.tar
rm git.tar
cd git*
pwd
echo $TMPD!
make configure
./configure --prefix=/usr
make all doc info
sudo make install install-doc install-html install-info
cd $HOME
rm -rf $TMPD1
TMPD2=$(mktemp -d)
cd $TEMPD1
wget -O ssh.tar.gz https://cloudflare.cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-8.8p1.tar.gz
gunzip ssh.tar.gz
tar -xf ssh.tar
cd openssh*
./configure
make
sudo make install
cd $HOME
rm -rf $TMPD2
