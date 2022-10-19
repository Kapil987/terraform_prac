#!/bin/bash
yum update -y
yum install git -y
yum install docker git -y
service docker start
# docker pull amazonlinux
mkdir /root/build
# To create ssh key pair without promt
# ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1
# cp ~/.ssh/id_rsa /root/build


# Jenkins Installation
# sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
# sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
# amazon-linux-extras install java-openjdk11 -y 
# yum install jenkins -y
# systemctl start jenkins
# systemctl stop jenkins
# mkdir /var/lib/jenkins/test
# git clone https://github.com/Kapil987/temp.git /var/lib/jenkins/test
# cp -r /var/lib/jenkins/test/jobs /var/lib/jenkins
# systemctl start jenkins