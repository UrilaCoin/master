CONFIG='/root/.urila/urila.conf'

apt-add-repository -y ppa:bitcoin/bitcoin
apt update
apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" make software-properties-common \
build-essential libtool autoconf libssl-dev libboost-dev libboost-chrono-dev libboost-filesystem-dev libboost-program-options-dev \
libboost-system-dev libboost-test-dev libboost-thread-dev sudo automake git wget curl libdb4.8-dev bsdmainutils libdb4.8++-dev \
libminiupnpc-dev libgmp3-dev ufw pkg-config libevent-dev  libdb5.3++ unzip libzmq5
git clone https://github.com/akshaynexus/urila
cd urila
chmod -R 775 *
bash autogen.sh
./configure
sudo fallocate -l 3G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo cp /etc/fstab /etc/fstab.bak
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab


make install
  cat << EOF >> $CONFIG
logintimestamps=1
maxconnections=256
server=1
listen=1
daemon=1
rpcuser=user
rpcpassword=pass
rpcallowip=127.0.0.1
EOF
urilad
