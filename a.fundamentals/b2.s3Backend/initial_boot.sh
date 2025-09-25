#!/bin/bash
yum update -y
service httpd start
echo "All went Good, S3 backend setup completed" > /var/www/html/index.html