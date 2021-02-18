workdir=$(pwd)

cd /etc/yum.repos.d/
wget https://download.opensuse.org/repositories/security:zeek/CentOS_8/security:zeek.repo
yum install zeek-lts
cd $workdir
