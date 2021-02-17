dnf install cmake make gcc gcc-c++ flex bison jemalloc-devel libpcap-devel openssl-devel python3 python3-devel swig zlib-devel
dnf install libmaxminddb-devel
groupadd zeek
useradd zeek -g zeek
mkdir /opt/zeek
mkdir /opt/zeek/source
chown -R zeek:zeek /opt/zeek
chmod 750 /opt/zeek
su zeek -c './zeekbuild.sh'

setcap cap_net_raw=eip /opt/zeek/bin/zeek
setcap cap_net_raw=eip /opt/zeek/bin/capstats
