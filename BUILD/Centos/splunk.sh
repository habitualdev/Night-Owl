#!/bin/bash

wget -O splunkforwarder-amd64.rpm 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=8.1.2&product=universalforwarder&filename=splunkforwarder-8.1.2-545206cc9f70-linux-2.6-x86_64.rpm&wget=true'

dnf install -y ./splunkforwarder-amd64.rpm

echo 'export PATH="/opt/splunkforwarder/bin:$PATH"' >> /etc/profile

/opt/splunkforwarder/bin/splunk add monitor /var/log/snort --accept-license

read -p "Splunk host IP Address: " master

read -p "Splunk forwarder port: " port

/opt/splunkforwarder/bin/splunk add forward-server $master:$port

./zeek-install.sh
