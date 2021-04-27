#!/bin/bash

continue=0
#just some really simple regex to prevent basic errors#
regex='(([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/[0-9]+))'

while [ $continue -eq 0 ]
do
echo "Enter Home networks, in CIDR notation (Ex. 192.168.0.0/24) ";
read networks;
for network in $(echo $networks | sed "s/,/ /g")
   do
	if echo $network | grep -qP "$regex"
	then
	  echo "$network is OK!"
	  continue=1
	else
	  echo "$network NOT OK!"
	  continue=0
	fi
   done
done
mv /opt/zeek/etc/networks.cfg /opt/zeek/etc/networks.cfg.bak
for cidr in $(echo $networks | sed "s/,/ /g")
do
	echo $cidr >> /opt/zeek/etc/networks.cfg
done

#Deploy settings and start zeek
/opt/zeek/bin/zeekctl install

/opt/zeek/bin/zeekctl deploy

/opt/zeek/bin/zeekctl start

echo "export PATH=/opt/zeek/bin:$PATH" >> ~/.bashrc
