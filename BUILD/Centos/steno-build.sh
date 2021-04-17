#!/bin/bash

workdir=$(pwd)

dnf install -y go jq
git clone https://github.com/google/stenographer
cd stenographer
go get github.com/google/stenographer
mkdir -p /usr/local/go/bin
ln -s /usr/bin/go /usr/local/go/bin/go
mkdir -p /etc/stenographer/certs
cp ../config/steno.conf /etc/stenographer/config

mkdir /stenopackets
mkdir /stenoindex
chown stenographer:stenographer /stenopackets
chown stenographer:stenographer /stenoindex

./install_el7.sh
cp stenocurl /usr/bin
cp stenoread /usr/bin

cd $workdir

./hoot.sh
