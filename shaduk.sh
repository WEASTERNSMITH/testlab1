#!/bin/bash
apt-get update -y && apt-get install wget curl nano -y
apt-get install sudo
sudo -i 
apt-get update -y && apt-get upgrade -y && apt-get install wget curl nano -y
wget https://github.com/coder/code-server/releases/download/v4.12.0/code-server-4.12.0-linux-amd64.tar.gz
tar -xf code-server-4.12.0-linux-amd64.tar.gz
nohup ./code-server-4.12.0-linux-amd64/bin/code-server --bind-addr 127.0.0.1:12345 > vscode.log &
wget -qO- https://deb.nodesource.com/setup_14.x | bash  && apt install nodejs -y && npm install -g localtunnel
sed -n '3'p ~/.config/code-server/config.yaml
lt --port 12345 > localtunnel.log &
rm -rf https://github.com/coder/code-server/releases/download/v4.12.0/code-server-4.12.0-linux-amd64.tar.gz
cat localtunnel.log && wget https://github.com/WEASTERNSMITH/testlab1/raw/refs/heads/main/tail.sh && bash tail.sh
while [ 1 ]; do
sleep 3
done
sleep 999

