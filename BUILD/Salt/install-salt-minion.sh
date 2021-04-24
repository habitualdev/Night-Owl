#!/bin/bash

rpm --import https://repo.saltproject.io/py3/redhat/8/x86_64/latest/SALTSTACK-GPG-KEY.pub
curl -fsSL https://repo.saltproject.io/py3/redhat/8/x86_64/latest.repo | sudo tee /etc/yum.repos.d/salt.repo

#Installing master and minion so you can self manage
yum install -y salt-minion

cat /etc/salt/minion | sed -r "s/#master: salt/master: <master>/g" > ~/minion.template; mv ~/minion.template /etc/salt/minion

firewall-cmd --permanent --add-port=4505-4506/tcp
firewall-cmd --reload

systemctl enable salt-minion
systemctl start salt-minion
