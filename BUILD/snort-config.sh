#!/bin/bash
pwd
cp BUILD/config/snort.lua /usr/local/etc/snort/snort.lua

cp BUILD/config/snort_defaults.lua /usr/local/etc/snort/snort_defaults.lua

groupadd snort

useradd snort -r -s /sbin/nologin -c SNORT_IDS -g snort

mkdir -p /var/log/snort

chmod -R 5775 /var/log/snort

chown -R snort:snort /var/log/snort

cp BUILD/config/snort3.service  /lib/systemd/system/snort3.service

systemctl enable snort3

service snort3 start
