#!/bin/bash
yum update -y
yum install docker git -y
service docker start
docker pull httpd ; docker pull amazonlinux
mkdir /root/build
# To create ssh key pair without promt
ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1
cp ~/.ssh/id_rsa /root/build