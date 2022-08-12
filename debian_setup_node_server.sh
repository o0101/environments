#!/bin/bash

if [ -z "$1" ]
  then
    echo "Need to add 1 argument: domain name"
fi
./basic_setup
sudo apt -y install git curl wget psmisc moreutils bc htop
sudo apt -y install software-properties-common
sudo apt-get -y install dh-autoreconf libcurl4-gnutls-dev libexpat1-dev \
  gettext libz-dev libssl-dev
sudo apt-get -y install asciidoc xmlto docbook2x
sudo apt-get -y install install-info
TMPD1=$(mktemp -d)
cd $TMPD1
wget -O git.tar.gz https://github.com/git/git/archive/refs/tags/v2.34.4.tar.gz
gunzip git.tar.gz
tar -xf git.tar
cd git/
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
addswap 4G
git config --global gpg.format ssh
git config --global user.email "22254235+crislin2046@users.noreply.github.com"
git config --global user.name "Cris Stringfellow"
git config --global core.editor "vim"
git config --global pull.rebase false
git config --global init.defaultBranch boss
sudo update-alternatives --config editor
sudo timedatectl set-timezone Asia/Singapore
sudo apt-get update && sudo apt-get -y upgrade
sudo apt -y install curl nodejs certbot vim
sudo apt -y install nodejs build-essential
if nvm; then 
  echo "nvm installed. skipping..."
else
  curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh -o install_nvm.sh
  bash ./install_nvm.sh
  # install for root as well
  sudo bash ./install_nvm.sh
  rm install_nvm.sh
  source $HOME/.profile
  source $HOME/.nvm/nvm.sh
  source ~/.bash_profile
  nvm install --lts
  sudo nvm install --lts
  npm i -g npm@latest
fi
sudo apt -y install dnsutils whois
sudo apt autoremove
if [ -z "$1" ]
  then
    echo "skipping TLS cert issue"
  else
        #sudo certbot certonly --manual --preferred-challenges dns --server https://acme-v02.api.letsencrypt.org/directory --manual-public-ip-logging-ok -d "*.$1" -d $1
	tls $1
fi
mkdir -p $HOME/sslcerts
sudo -u root ./scripts/cp_certs.sh $1 $HOME/sslcerts/
sudo chown $USER:$USER $HOME/sslcerts/*
which serve || npm i -g serve
which pm2 || npm i -g pm2
which nodemon || npm i -g nodemon
#sudo npm i -g serve nodemon pm2 npm
sudo apt install psmisc htop nethogs 
sudo apt install strace 
sudo apt install reptyr
sudo apt install libcgroup1 cgroup-tools
if which bat; then
  echo "bat exists...skipping..."
else
  curl -L -o bat.deb https://github.com/sharkdp/bat/releases/download/v0.13.0/bat_0.13.0_amd64.deb
  sudo dpkg -i bat.deb
  rm bat.deb
  npm i -g prettier
  gclone https://github.com/eth-p/bat-extras.git
  sudo ./bat-extras/build.sh --install
  sudo rm -rf ./bat-extras
fi
sudo apt -y install expect
sloc || npm i -g sloc
sudo apt install cloc sloccount moreutils
ldid | ./setup_ldid.sh
sudo apt install qemu binfmt-support qemu-user-static
sudo groupadd no-net
sudo useradd -g no-net netless
if sudo grep no-net /etc/sudoers; then
  echo "no-net already in sudoers. skipping..."
else
  echo "Add the following line to sudoers"
  echo "ALL ALL=(:no-net) NOPASSWD:ALL"
  read -p "Enter to edit sudoers"
  read | sudo visudo
fi
echo "YOU. ARE. AWESOME! :p ;) xx"
