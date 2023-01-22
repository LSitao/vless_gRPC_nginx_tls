#!/bin/bash

rm -rf /usr/iu/
rm /usr/bin/iu
bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ remove
rm /usr/server.crt
rm /usr/server.key
rm /etc/nginx/conf.d/grpc_proxy.conf
clear 
echo "Bye"
echo
sleep 1
