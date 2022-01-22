#!/bin/bash

echo '[Install OpenJDK8]'
echo "deb http://deb.debian.org/debian/ sid main" >> /etc/apt/sources.list
apt-get update 
apt-get install -y openjdk-8-jdk
apt-get install -y sudo
apt-get install -y nginx
apt-get install -y curl

/etc/init.d/nginx start

echo '[Install Jenkins]'

curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/  | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get -y update
sudo apt-get -y install jenkins
sudo apt install -y curl
/etc/init.d/jenkins start

echo '[Install Horusec]'
apt -y install jq
apt -y install git
curl -fsSL https://raw.githubusercontent.com/ZupIT/horusec/master/deployments/scripts/install.sh | bash -s latest

echo '[Install Docker]'
sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release -y
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt -y install docker-ce docker-ce-cli containerd.io

echo '[DONE]'
