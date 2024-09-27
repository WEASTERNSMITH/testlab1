mkdir Proot
cd Proot && ls 
curl -o gdown.zip http://66.70.200.164/proot/gdown.zip
unzip gdown.zip
chmod +x gdown
bash gdown proot 1UL8_Y-hbmBuOMLwec9aHog24zI6uUz7W && chmod +x proot
bash gdown teleport_9.2.4_amd64.deb 10ZO-Ceg_dMPUPDMaMnC83AAIalKF8YmN 
bash gdown focal.tar 1rncRR9Gimh8UgWkAo27Q6X8UW5iOXTnL
tar -xf focal.tar > /dev/null
./proot -S . dpkg -i teleport_9.2.4_amd64.deb
rm -rf focal.tar teleport_9.2.4_amd64.deb
