wget -O packer.zip https://releases.hashicorp.com/packer/1.2.3/packer_1.2.3_linux_amd64.zip
unzip packer.zip
sudo chmod +x packer
./packer validate deployments/template.json
./packer build deployments/template.json