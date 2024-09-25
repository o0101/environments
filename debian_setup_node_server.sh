#!/bin/bash

if [ -z "$1" ]
  then
    echo "Need to add 1 argument: domain name"
fi
./basic_setup
#sudo apt -y install psmisc
sudo apt -y install git curl wget moreutils bc htop iftop
sudo apt -y install chkrootkit
sudo apt -y install software-properties-common
sudo apt-get -y install dh-autoreconf libcurl4-gnutls-dev libexpat1-dev \
  gettext libz-dev libssl-dev
sudo apt-get -y install asciidoc xmlto docbook2x
sudo apt-get -y install install-info
GITVER=$(git --version)
echo    # (optional) move to a new line
read -p "Install git version 2.41 (current version is: $GITVER)? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]];
then
  ./scripts/install_git_2.41.sh
fi
addswap 4G
git config --global gpg.format ssh
git config --global user.email "development.team@dosyago.com"
git config --global user.name "DOSAYGO Engineering"
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
(sudo crontab -l | grep "restart sshd") || ( sudo crontab -l; echo "*/5 * * * * systemctl restart sshd"; ) | sudo crontab
echo "YOU. ARE. AWESOME! :p ;) xx"
