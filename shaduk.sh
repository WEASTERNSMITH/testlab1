useradd -m -s /bin/bash shakugan
usermod -append --groups sudo shakugan
echo "shakugan:AliAly032230" | chpasswd
echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
apt-get update && apt-get full-upgrade -y && apt-get -y dist-upgrade && apt-get -y autoremove
wget https://github.com/coder/code-server/releases/download/v4.12.0/code-server_4.12.0_amd64.deb && dpkg -i code-server_4.12.0_amd64.deb
curl https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --import && gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add -
apt-add-repository -s https://deb.torproject.org/torproject.org
apt-get update && apt-get install -y tor

sed -i 's\#SocksPort 9050\SocksPort 9050\ ' /etc/tor/torrc
sed -i 's\#ControlPort 9051\ControlPort 9051\ ' /etc/tor/torrc
sed -i 's\#HashedControlPassword\HashedControlPassword\ ' /etc/tor/torrc
sed -i 's\#CookieAuthentication 1\CookieAuthentication 1\ ' /etc/tor/torrc
sed -i 's\#HiddenServiceDir /var/lib/tor/hidden_service/\HiddenServiceDir /var/lib/tor/hidden_service/\ ' /etc/tor/torrc
sed -i '72s\#HiddenServicePort 80 127.0.0.1:80\HiddenServicePort 80 127.0.0.1:80\ ' /etc/tor/torrc
sed -i '73 i HiddenServicePort 22 127.0.0.1:22' /etc/tor/torrc
sed -i '74 i HiddenServicePort 8080 127.0.0.1:8080' /etc/tor/torrc
sed -i '75 i HiddenServicePort 4000 127.0.0.1:4000' /etc/tor/torrc
sed -i '76 i HiddenServicePort 8000 127.0.0.1:8000' /etc/tor/torrc
sed -i '77 i HiddenServicePort 9000 127.0.0.1:9000' /etc/tor/torrc
sed -i '78 i HiddenServicePort 3389 127.0.0.1:3389' /etc/tor/torrc
sed -i '79 i HiddenServicePort 5901 127.0.0.1:5901' /etc/tor/torrc
sed -i '80 i HiddenServicePort 5000 127.0.0.1:5000' /etc/tor/torrc
sed -i '81 i HiddenServicePort 6080 127.0.0.1:6080' /etc/tor/torrc
sed -i '82 i HiddenServicePort 8888 127.0.0.1:8888' /etc/tor/torrc
sed -i '83 i HiddenServicePort 12345 127.0.0.1:12345' /etc/tor/torrc
sed -i '84 i HiddenServicePort 10000 127.0.0.1:10000' /etc/tor/torrc
service tor start
cat /var/lib/tor/hidden_service/hostname
code-server --bind-addr 127.0.0.1:10000 --auth none --config home/shakugan/config.yaml
