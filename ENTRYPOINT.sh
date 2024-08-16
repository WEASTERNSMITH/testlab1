#!/bin/bash

useradd -m -s /bin/bash $USER
usermod -append --groups sudo $USER
echo "$USER:$PASSWORD" | chpasswd
echo "$USER ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
chown -R $USER:$USER /home/$USER/.*

mkdir /home/$USER/.vnc
echo $VNC_PWD | vncpasswd -f > /home/$USER/.vnc/passwd
chmod 0600 /home/$USER/.vnc/passwd
chown -R $USER:$USER /home/$USER/.vnc

su - $USER -c "vncserver -rfbport 5901 -verbose -localhost no -autokill no >> /home/$USER/vnc.log &"
su - $USER -c "/usr/share/novnc/utils/launch.sh --listen 6081 --vnc localhost:5901 >> /home/$USER/novnc.log &"

wget https://github.com/coder/code-server/releases/download/v$VSCODE_VERSION/code-server_${VSCODE_VERSION}_amd64.deb
dpkg -i code-server_${VSCODE_VERSION}_amd64.deb
rm -rf code-server_${VSCODE_VERSION}.deb
su - $USER -c "mkdir -p /home/$USER/.config/code-server"
su - $USER -c "touch /home/$USER/.config/code-server/config.yaml"
echo -e "bind-addr: 127.0.0.1:8080\nauth: password\npassword: $VSCODE_PWD\ncert: false" >> /home/$USER/.config/code-server/config.yaml
su - $USER -c "code-server --bind-addr 127.0.0.1:10000 >> vscode.log &"

# Install zrok
curl -fSL "https://github.com/openziti/zrok/releases/download/v${ZROK_PACKAGE_VERSION}/zrok_${ZROK_PACKAGE_VERSION}_linux_amd64.tar.gz" -o zrok.tar.gz
mkdir zrok
tar -C zrok -xzf zrok.tar.gz
chmod +x zrok/zrok
mv zrok/zrok /usr/local/bin/zrok
rm -rf zrok zrok.tar.gz
su - $USER -c "zrok enable $ZROK_ENVIRONMENT"
su - $USER -c "zrok share public localhost:6081 --headless & zrok share private -b tcpTunnel 0.0.0.0:5901 --headless & zrok share public localhost:10000 --headless"
