#!/bin/bash
yum update -y
service httpd start
echo "All went Good" > /var/www/html/index.html