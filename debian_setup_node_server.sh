#!/bin/bash

sudo apt-get update && sudo apt-get -y upgrade
sudo apt -y install curl nodejs
curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh
sudo bash ./nodesource_setup.sh
sudo apt -y install nodejs build-essential
curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh -o install_nvm.sh
bash ./install_nvm.sh
source $HOME/.profile
nvm install --lts



