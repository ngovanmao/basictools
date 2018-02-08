#!/bash/sh
sudo apt update
sudo apt-get remove docker docker-engine docker.io
sudo apt-get  install \
   apt-transport-https \
   ca-certificates \
   curl \
   software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) \
         stable"
sudo apt-get update
sudo apt-get install docker-ce=17.03.2~ce-0~ubuntu-xenial

sudo apt install libprotobuf-dev libprotobuf-c0-dev protobuf-c-compiler protobuf-compiler python-protobuf
sudo apt install pkg-config python-ipaddr iproute2  libcap-dev libnl-3-dev libnet1-dev 
sudo apt install --no-install-recommends asciidoc xmlto
git clone https://github.com/checkpoint-restore/criu.git
cd criu
make
sudo make install
