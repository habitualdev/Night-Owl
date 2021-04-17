#!/bin/bash
pwd

# Copy all configs required by snort

cp config/snort.lua /usr/local/etc/snort/snort.lua

cp config/snort_defaults.lua /usr/local/etc/snort/snort_defaults.lua

cp /usr/local/snort/etc/snort/file_magic.lua /usr/local/etc/snort/file_magic.lua

# Add snort group and user for safety

groupadd snort

useradd snort -r -s /sbin/nologin -c SNORT_IDS -g snort

mkdir -p /var/log/snort

chmod -R 5775 /var/log/snort

chown -R snort:snort /var/log/snort

# Make the snort3 service, while also asking for the listening interface

cp config/snort3.service  /lib/systemd/system/snort3.service

ip a | grep "[0-9]: " | cut -d ":" -f 2 | sed -r 's/\s+//g'

read -p "Interface to listen on: " interface

cat /lib/systemd/system/snort3.service | sed "s/<interface>/$interface/g" > /lib/systemd/system/snort3.service

systemctl enable snort3

service snort3 start

./splunk.sh
