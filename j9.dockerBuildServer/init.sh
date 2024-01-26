#!/bin/bash
## Installing on ubuntu

docker_ubuntu_install() {
  # Run the following command to uninstall all conflicting packages:
  for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

  # Add Docker's official GPG key:
  sudo apt-get update
  sudo apt-get install ca-certificates curl gnupg -y
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo -S curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor --yes -o /etc/apt/keyrings/docker.gpg
  sudo chmod a+r /etc/apt/keyrings/docker.gpg

  # Add the repository to Apt sources:
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
}

# Call the function
docker_ubuntu_install

# yum update -y
# yum install git -y
# yum install docker git -y
# service docker start
# # docker pull amazonlinux
# mkdir /root/build
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
