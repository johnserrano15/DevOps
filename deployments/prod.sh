wget -O /tmp/packer.zip https://releases.hashicorp.com/packer/1.2.3/packer_1.2.3_linux_amd64.zip
wget -O /tmp/terraform.zip https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip
unzip /tmp/packer.zip -d ~/bin
unzip /tmp/terraform.zip -d ~/bin

packer validate deployments/template.json &&
packer build deployments/template.json &&

export TF_VAR_image_id=$(curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer $DIGITALOCEAN_API_TOKEN" "https://api.digitalocean.com/v2/images?private=true" | jq ."images[] | select(.name == \"devops-demo-$CIRCLE_BUILD_NUM\") | .id") &&

echo "Got the image id of the new digital ocean image" &&
echo $TF_VAR_image_id &&

cd infra &&
terraform init -input=false && 
terraform apply -input=false -auto-approve && cd .. &&
git config --global user.email "andrey_201015@hotmail.com" &&
git config --global user.name "Circle CI Script" &&
git add infra && git commit -m 'Deployed $CIRCLE_BUILD NUM [skip ci]' &&

git push origin master &&
echo "Deployed and saved!" &&
echo "Now deleting the image previously created" &&

curl -X DELETE -H"Content-Type: application/json" -H"Authorization: Bearer $DIGITALOCEAN_API_TOKEN""https://api.digitalocean.com/v2/images/$TF_VAR_image_id" &&
echo "Image deleted successfuly" &&
echo "Done!"