mkdir Proot
cd Proot && wget https://uk.lxd.images.canonical.com/images/ubuntu/jammy/amd64/cloud/20220628_07:42/rootfs.tar.xz && tar -xvf rootfs.tar.xz > /dev/null
cd Proot && wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
cd Proot && curl -LO https://proot.gitlab.io/proot/bin/proot && chmod +x proot
cd Proot && ./proot -S . dpkg -i cloudflared-linux-amd64.deb
cd Proot && ./proot -S . cloudflared update
cd Proot && ./proot -S . cloudflared tunnel --url localhost:9000
