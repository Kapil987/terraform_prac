#!/bin/bash
yum update -y
yum install docker git -y
service docker start
sudo chkconfig docker on

PROJECT_PATH="/root/projectFiles"
# Docker compose
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

mkdir $PROJECT_PATH

# Docker-compose yml
echo "version: '2'
services:
  website1:
    image: kapil0123/spotify-website-demo
  website2:
    image: kapil0123/romofyi-website-demo
  website3:
    image: kapil0123/construction-website-demo" > $PROJECT_PATH/docker-compose.yml

docker-compose -f $PROJECT_PATH/docker-compose.yml pull


# scripts
echo "#!/bin/sh
arr=(kapil0123/spotify-website-demo kapil0123/romofyi-website-demo kapil0123/construction-website-demo)
docker_stop_rm () {
        docker stop webapp
        docker rm -f webapp
        echo \${arr[0]}
}
docker_stop_rm
docker run -d --name webapp -p 80:80 \${arr[0]}" > $PROJECT_PATH/start10.sh

sed s/0\]}/1\]}/g $PROJECT_PATH/start10.sh > $PROJECT_PATH/start20.sh
sed s/0\]}/2\]}/g $PROJECT_PATH/start10.sh > $PROJECT_PATH/start30.sh

chmod +x $PROJECT_PATH/*.sh

# Crontab restore
echo "* * * * * ( $PROJECT_PATH/start10.sh )
* * * * * ( sleep 20 ; $PROJECT_PATH/start20.sh )
* * * * * ( sleep 40 ; $PROJECT_PATH/start30.sh )" > $PROJECT_PATH/crontab.backup

crontab -u root $PROJECT_PATH/crontab.backup

## Notes
# Cloud init script executes in '/'
# [root@ip-172-31-20-160 lib]# find / -name docker-compose.yml
# /docker-compose.yml
