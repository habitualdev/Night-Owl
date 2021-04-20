#!/bin/bash

workdir=$(pwd)

cd /etc/yum.repos.d/
wget -4 https://download.opensuse.org/repositories/security:zeek/CentOS_8/security:zeek.repo
yum install zeek-lts
echo 'export PATH="$PATH:/opt/zeek/bin"' >> /etc/profile
cd $workdir

#Configure zeek with all the required home information
ip a | grep "[0-9]: " | cut -d ":" -f 2 | sed -r 's/\s+//g'

read -p "Interface to listen on: " interface
sensor_hostname=$(hostname)

echo "[zeek]" > /opt/zeek/etc/node.cfg
echo "type=standalone" >> /opt/zeek/etc/node.cfg
echo "host=$sensor_hostname" >> /opt/zeek/etc/node.cfg
echo "interface=$interface" >> /opt/zeek/etc/node.cfg

#Set up splunk forwarding of logs
echo "@load policy/tuning/json-logs.zeek" >> /opt/zeek/share/zeek/site/local.zeek

echo "[thruput]" >> /opt/splunkforwarder/etc/system/local/limits.conf
echo "maxKBps = 0 # means unlimited" >> /opt/splunkforwarder/etc/system/local/limits.conf

#Define the inputs
cat config/zeek-outputs.conf >> /opt/splunkforwarder/etc/system/local/inputs.conf

#create and enable zeek service
cp config/zeek.service  /lib/systemd/system/zeek.service
systemctl enable zeek


#begin logging
/opt/splunkforwarder/bin/splunk start

./steno-build.sh
