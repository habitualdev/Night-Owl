#!/bin/bash

read -p "IP Address of your Night Owl Master: :" master_owl

cat install-salt-minion.sh | sed -r "s/<master>/$master_owl/g"  > install-salt-minion-$master_owl.sh

read -p "IP Address of minion to be added: " minion
read -p "Username on $minion (Must have sudo privileges): " minion_user

ssh $minion_user@$minion "sudo bash -s" < install-salt-minion-$master_owl.sh

salt-key -A 
