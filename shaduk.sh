useradd -m -s /bin/bash shakugan
usermod -append --groups sudo shakugan
echo "shakugan:AliAly032230" | chpasswd
echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
apt-get update && apt-get full-upgrade -y && apt-get -y dist-upgrade && apt-get -y autoremove
apt-get install openssh-server -y  &&
ssh-keygen -f id_rsa -b 4096 -N '' -f ~/.ssh/id_rsa &&
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys &&
mkdir -p /var/run/sshd &&
sed -i 's\#PermitRootLogin prohibit-password\PermitRootLogin yes\ ' /etc/ssh/sshd_config &&
sed -i 's\#PubkeyAuthentication yes\PubkeyAuthentication yes\ ' /etc/ssh/sshd_config &&
sed -i 's\#AuthorizedKeysFile	.ssh/authorized_keys .ssh/authorized_keys2\AuthorizedKeysFile	.ssh/authorized_keys\ ' /etc/ssh/sshd_config &&
/etc/init.d/ssh restart &&  wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 && chmod +x cloudflared-linux-amd64
./cloudflared-linux-amd64 tunnel --url localhost:22
