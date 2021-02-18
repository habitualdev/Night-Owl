#!/bin/bash

wget -O splunkforwarder-amd64.rpm 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=8.1.2&product=universalforwarder&filename=splunkforwarder-8.1.2-545206cc9f70-linux-2.6-x86_64.rpm&wget=true'

dnf install ./splunkforwarder-amd64.rpm

export PATH="/opt/splunkforwarder/bin:$PATH"

/opt/splunkforwarder/bin/splunk add monitor /var/log/snort --accept-license

./zeek-install.sh
