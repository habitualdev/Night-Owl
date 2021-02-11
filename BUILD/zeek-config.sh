#Configure zeek with all the required home information

echo "[zeek]" > /opt/zeek/etc/node.cfg
echo "type=standalone" >> /opt/zeek/etc/node.cfg
echo "host=localhost" >> /opt/zeek/etc/node.cfg
echo "interface=ens160" >> /opt/zeek/etc/node.cfg

#Set up splunk forwarding of logs
echo "@load policy/tuning/json=logs.zeek" >> /opt/zeek/share/zeek/site/local.zeek

echo "[thruput]" >> /opt/splunkforwarder/etc/system/local/limits.conf
echo "maxKBps = 0 # means unlimited" >> /opt/splunkforwarder/etc/system/local/limits.conf

#Define the inputs
cat config/zeek-outputs.conf >> /opt/splunkforwarder/etc/system/local/inputs.conf

#create and enable zeek service
cp config/zeek.service  /lib/systemd/system/zeek.service
systemctl enable zeek


#begin logging
/opt/splunkforwarder/bin/splunk start
