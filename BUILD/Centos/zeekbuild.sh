cd /opt/zeek/source
wget https://download.zeek.org/zeek-3.2.2.tar.gz
tar -xzvf zeek-3.2.2.tar.gz
cd zeek-3.2.2
./configure --prefix=/opt/zeek --enable-jemalloc
make
make install
