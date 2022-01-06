#!/usr/bin/env bash

#git clone https://github.com/daeken/ldid.git
cd ./ldid
./make.sh
sudo cp ./ldid /usr/local/bin
cd ../
rm -rf ldid/
