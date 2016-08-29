#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive;

# Install Node.js
# ref: https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions
curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
apt-get install -y nodejs

# Update npm
npm install -g npm

npm install -g mongo-express

# build-essential and g++ for npm install
# libkrb5-dev for kerberos (mongoose)
apt-get -y install build-essential g++ libkrb5-dev

# Install MongoDB
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
apt-get update
apt-get install -y mongodb-org

# Install git
apt-get install -y git

# Clone the API
su -c "git clone https://github.com/cashweaver/plant-api.git" vagrant

# Install nodejs requirements
su -c "cd plant-api; npm install" vagrant

# Configure mongo-express
su -c "cd plant-api; mv mongo-express-config.js node_modules/mongo-express/config.js" vagrant
