#Configure zeek with all the required home information


ipaddr=$(ip address | grep "scope global" | cut -d " " -f 6 | cut -d "/" -f 1)

####HOME NETWORKS####
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

echo "type=standalone" > /opt/zeek/etc/node.cfg
echo "host=$ipaddr" >> /opt/zeek/etc/node.cfg
echo "interface=ens160" >> /opt/zeek/etc/node.cfg

echo "@load policy/tuning/json=logs.zeek" >> /opt/zeek/share/zeek/site/local.zeek


