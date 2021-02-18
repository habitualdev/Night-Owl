workdir=$(pwd)

cd /etc/yum.repos.d/
wget https://download.opensuse.org/repositories/security:zeek/CentOS_8/security:zeek.repo
yum install zeek-lts
echo 'export PATH="$PATH:/opt/zeek/bin"' >> /etc/profile
cd $workdir
./zeek-config.sh
