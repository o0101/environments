#!/usr/bin/env bash

sudo apt install git
git clone https://github.com/crisdosyago/environments.git
cd environments/
./debian_setup_node_server.sh $1
