#!/bin/bash
yum update -y
yum install docker git -y
service docker start
docker pull httpd ; docker pull amazonlinux
mkdir /root/build