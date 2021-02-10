#!/bin/bash

wget -O splunkforwarder-amd64.deb 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=8.1.2&product=universalforwarder&filename=splunkforwarder-8.1.2-545206cc9f70-linux-2.6-amd64.deb&wget=true'

apt install ./splunkforwarder-amd64.deb

export PATH="/opt/splunkforwarder/bin:$PATH"

read master -p "Splunk host IP Address: "

read port -p "Splunk forwarder port: "

/opt/splunkforwarder/bin/splunk add forward-server $master:$port --accept-license

/opt/splunkforwarder/bin/splunk add monitor /var/log/snort

./zeek-config.sh
