#!/bin/bash

if [ -z "$1" ] 
  then
    echo "Need to add 1 argument: domain name"
fi 
./basic_setup
sudo apt install git curl wget
git config --global user.email "22254235+crislin2046@users.noreply.github.com"
git config --global user.name "Cris Stringfellow"
git config --global core.editor "vim"
git config --global pull.rebase false
git config --global init.defaultBranch boss
sudo update-alternatives --config editor
sudo apt-get update && sudo apt-get -y upgrade
sudo apt -y install curl nodejs certbot vim 
sudo apt -y install nodejs build-essential
curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh -o install_nvm.sh
bash ./install_nvm.sh
# install for root as well
sudo bash ./install_nvm.sh
rm install_nvm.sh
source $HOME/.profile
source $HOME/.nvm/nvm.sh
source ~/.bash_profile
npm i -g npm
nvm install --lts
sudo nvm install --lts
sudo apt -y install dnsutils whois
sudo apt autoremove
if [ -z "$1" ] 
  then
    echo "skipping TLS cert issue"
  else
	sudo certbot certonly --manual --preferred-challenges dns --server https://acme-v02.api.letsencrypt.org/directory --manual-public-ip-logging-ok -d "*.$1" -d $1
fi 
mkdir -p ./sslcerts
sudo cp -r -L /etc/letsencrypt/live/$1 ./sslcerts/
npm i -g serve nodemon pm2
sudo npm i -g serve nodemon pm2
sudo apt install psmisc htop nethogs
sudo apt install libcgroup1 cgroup-tools
curl -L -o bat.deb https://github.com/sharkdp/bat/releases/download/v0.13.0/bat_0.13.0_amd64.deb
sudo dpkg -i bat.deb
rm bat.deb
npm i -g prettier
gclone https://github.com/eth-p/bat-extras.git
sudo ./bat-extras/build.sh --install
sudo rm -rf ./bat-extras
sudo apt -y install expect
sudo npm i -g sloc
sudo apt install cloc sloccount more-utils
sudo groupadd no-net
sudo useradd -g no-net netless
echo "Add the following line to sudoers"
echo "ALL ALL=(:no-net) NOPASSWD:ALL"
read -p "Enter to edit sudoers"
sudo visudo
echo "YOU. ARE. AWESOME! :p ;) xx"
