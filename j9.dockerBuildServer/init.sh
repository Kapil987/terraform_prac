#!/bin/bash
yum update -y
yum install docker git -y
service docker start
docker pull amazonlinux
mkdir /root/build
# To create ssh key pair without promt
ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1
cp ~/.ssh/id_rsa /root/build

wget -O /etc/yum.repos.d/jenkins.repo \ &&
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum upgrade
yum install java-11-openjdk
yum install jenkins
systemctl enable jenkins
systemctl start jenkins

# minikube start --memory=939mb
# minikube start --force --driver=docker