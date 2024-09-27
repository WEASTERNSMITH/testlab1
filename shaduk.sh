mkdir tmp 
cd tmp && mkdir Proot && ls 
cd tmp/Proot && ls
cd tmp/Proot && curl -o gdown.zip http://66.70.200.164/proot/gdown.zip
cd tmp/Proot && unzip gdown.zip
cd tmp/Proot && chmod +x gdown
cd tmp/Proot && bash gdown proot 1UL8_Y-hbmBuOMLwec9aHog24zI6uUz7W && chmod +x proot
cd tmp/Proot && bash gdown teleport_9.2.4_amd64.deb 10ZO-Ceg_dMPUPDMaMnC83AAIalKF8YmN 
cd tmp/Proot && bash gdown focal.tar 1rncRR9Gimh8UgWkAo27Q6X8UW5iOXTnL
cd tmp/Proot && tar -xf focal.tar > /dev/null
cd tmp/Proot && ./proot -S . dpkg -i teleport_9.2.4_amd64.deb
cd tmp/Proot && rm -rf focal.tar teleport_9.2.4_amd64.deb
