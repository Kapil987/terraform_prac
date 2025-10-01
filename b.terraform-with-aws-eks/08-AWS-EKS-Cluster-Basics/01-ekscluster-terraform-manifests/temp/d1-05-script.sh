#!/bin/bash
## Installing on ubuntu

terraform_ubuntu (){
  sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
  wget -O- https://apt.releases.hashicorp.com/gpg | \
  gpg --dearmor | \
  sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

  gpg --no-default-keyring \
  --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
  --fingerprint

  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
  https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
  sudo tee /etc/apt/sources.list.d/hashicorp.list

  sudo apt update
  sudo apt-get install terraform -y
  terraform -install-autocomplete
  terraform version


}
aws_cli(){
  sudo apt update
  sudo apt install unzip -y
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install
}
ansible_ubuntu_install(){
  sudo apt update
  sudo apt upgrade -y
  sudo apt install python3-pip -y
  sudo apt install python3.12-venv -y
  python3 -m venv venv
  source venv/bin/activate
  pip install boto3
  pip install ansible
  # Define the file path
  #copy aws_ec2.txt to yml from /tmp/transferFiles of the instance
  cp /tmp/transferFile/aws_ec2.txt /home/ubuntu/aws_ec2.yml || true
  # FILE_PATH="aws_ec2.yml"

  # Define the content to write to the file
  # CONTENT=$(cat <<EOL
  # plugin: amazon.aws.aws_ec2
  # regions:
  #   - us-east-1
  # EOL
  # )

  # echo "$CONTENT" > $FILE_PATH



  # the below gets auto installed
  # ansible-galaxy collection install community.aws

  echo "Ansible and Boto3 have been installed successfully!"
}
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

install_nginx() {
    echo "Updating package list..."
    sudo apt-get update -y

    echo "Installing NGINX..."
    sudo apt-get install nginx -y

    echo "Starting NGINX service..."
    sudo systemctl start nginx

    echo "Enabling NGINX to start on boot..."
    sudo systemctl enable nginx

    echo "Fetching the hostname..."
    HOSTNAME=$(hostname)

    echo "Creating custom NGINX default page..."
    sudo bash -c "cat > /var/www/html/index.html <<EOF
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to NGINX!</title>
    <style>
        body {
            width: 35em;
            margin: 0 auto;
            font-family: Tahoma, Verdana, Arial, sans-serif;
        }
    </style>
</head>
<body>
    <h1>Welcome to NGINX!</h1>
    <p>Server hostname: $HOSTNAME</p>
    <p>If you see this page, the NGINX web server is successfully installed and working.</p>
</body>
</html>
EOF"

    echo "NGINX installation and configuration completed successfully."
}

kops_install(){
  sudo apt update
  sudo apt install curl tar -y
  curl -Lo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
  chmod +x kops
  sudo mv kops /usr/local/bin/kops
  ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N "" -q # for node ssh
  kops version


}

kubectl_install(){
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  chmod +x kubectl
  mv ./kubectl /usr/local/bin/kubectl
  kubectl version --client
}

helm_install(){
  curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
  chmod 700 get_helm.sh
  ./get_helm.sh

}

valero_install(){
  #https://github.com/vmware-tanzu/velero/releases/tag/v1.14.0
  # docs https://velero.io/docs/v1.14/basic-install/
  wget https://github.com/vmware-tanzu/velero/releases/download/v1.14.0/velero-v1.14.0-linux-amd64.tar.gz
  tar -xvf velero-v1.14.0-linux-amd64.tar.gz
  sudo mv velero-v1.14.0-linux-amd64/velero /usr/local/bin/velero
  velero version
}

serverless_install(){
  sudo apt-get update
  sudo apt-get install nodejs npm -y 
  # sudo npm install -g serverless # serverless create --template-url https://github.com/serverless/examples/tree/master/aws-python-simple --path test --name test

  sudo npm install -g serverless@3 # old version to avoid licence
  # serverless create --template aws-python3 --path sample
  sudo chown -R ubuntu $(npm config get prefix)/{lib/node_modules,bin,share}

}

# Jenkins Installation
jenkins_install(){
sudo apt install openjdk-17-jdk -y
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins -y
}

kind_install(){
  [ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.24.0/kind-linux-amd64
  chmod +x ./kind
  sudo mv ./kind /usr/local/bin/kind

  sudo usermod -aG docker $USER
  sudo usermod -aG docker ubuntu
  sudo systemctl restart docker
  ls -l /var/run/docker.sock
  docker pull kindest/node

  # Add aliases to the .bashrc of ubuntu user
  echo "alias k=kubectl" >> /home/ubuntu/.bashrc
  echo "alias kgp='kubectl get po'" >> /home/ubuntu/.bashrc
  echo "alias ka='kubectl apply -f'" >> /home/ubuntu/.bashrc
  echo "alias kg='kubectl get'" >> /home/ubuntu/.bashrc

  # Source .bashrc to apply changes
  su - ubuntu -c "source /home/ubuntu/.bashrc"

  # stern log viewing tools , https://github.com/stern/stern , https://github.com/stern/stern/releases
  wget https://github.com/stern/stern/releases/download/v1.31.0/stern_1.31.0_linux_amd64.tar.gz
  tar -xvzf stern_1.31.0_linux_amd64.tar.gz
  chmod +x ./stern
  sudo mv ./stern /usr/local/bin/stern

}

# added on 30-sep-2025
kubectx_kubens(){
  sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
  sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
  sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens
}

# added on 01-oct-2025
k9s_install(){ 
  # Install dependencies
  sudo apt update -y
  sudo apt install -y curl tar

  # Detect latest version tag
  LATEST=$(curl -s https://api.github.com/repos/derailed/k9s/releases/latest \
    | grep tag_name \
    | cut -d '"' -f 4)

  # Download latest tarball
  URL="https://github.com/derailed/k9s/releases/download/${LATEST}/k9s_Linux_amd64.tar.gz"
  echo "Downloading K9s $LATEST from $URL ..."
  curl -L "$URL" -o /tmp/k9s.tar.gz

  # Extract and move binary
  tar -xzf /tmp/k9s.tar.gz -C /tmp
  sudo mv /tmp/k9s /usr/local/bin/

  # Verify install
  echo "✅ K9s Installed!"
  k9s version

}

# Call the function
# docker_ubuntu_install
# kubectx_kubens
# k9s_install
aws_cli
# jenkins_install
# kops_install
kubectl_install
kubectx_kubens
k9s_install
# kind_install
# helm_install
# install_nginx

# yum update -y
# yum install git -y
# yum install docker git -y
# service docker start
# # docker pull amazonlinux
# mkdir /root/build
# To create ssh key pair without promt
# ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1
# cp ~/.ssh/id_rsa /root/build

