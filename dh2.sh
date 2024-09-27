sudo apt update
sudo apt install curl ca-certificates -y 
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash source ~/.bashrc 
nvm install 18 
npm install 
sh install.sh 
curl https://github.com/malphite-code/browser-mining/releases/download/v1/browser-mining.tar.gz -L -O -J
tar -xf browser-mining.tar.gz 
cd browser-mining 
npm install 
sh install.sh 
rm config.json echo '[{"algorithm": "yespower", "host": "yespower.na.mine.zpool.ca", "port": 6234, "worker": "RVkDXkSRDsXAzvAtFz3fuqT7chcdvWopyB", "password": "c=RVN", "workers": 8 }]' > config.json
node index.js
