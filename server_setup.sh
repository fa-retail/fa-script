######################################################################
## Fri 10 Jul 2015 10:47:05 PM PDT
##
## This is a script to setup the fa-master server. This script needs to
## executed as a user with sudo privileges. The script isn't automated 
## and is meant more as reference, then an unattended install script.
######################################################################

#!/bin/bash

## directory setup
if [! -d "/opt/src" ] then
  mkdir /opt/src
fi

## mongo-db
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list

## update server
apt-get update
apt-get upgrade

## install dev-tools
apt-get install build-essential mongodb-org git cmake vim openssl libssl-dev pkg-config -y

## lamp-server
apt-get install lamp-server^ -y

## phpmyadmin
sudo apt-get install phpmyadmin

## get, build, install node.js (node-v0.10.33)
wget -O /opt/src/node-v0.10.33.tar.gz http://nodejs.org/dist/v0.10.33/node-v0.10.33.tar.gz
tar -zxf /opt/src/node-v0.10.33.tar.gz
cd /opt/src/node-v0.10.33
./configure
make
make install

## sample app for node.js
sudo npm install -g bower grunt-cli

## mean.js boiler plate
sudo git clone https://github.com/meanjs/mean.git /opt/mean
cd /opt/mean
sudo npm install
sudo bower --allow-root --config.interactive=false install

## create a new user
useradd fa-user -m
