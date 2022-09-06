provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["C:\\Users\\Kapil\\.aws\\credentials"]
}

data "aws_vpc" "default" {
  default = true
}
# 6. Security Group
resource "aws_security_group" "allow_web" {
  name        = "Allow Web"
  description = "Allow web traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 82
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "tomcat"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow-web_terraform"
  }
}

# 9. Create EC2 
resource "aws_instance" "web" {
  ami                    = "ami-05fa00d4c63e32376"
  instance_type          = "t2.micro"
  availability_zone      = "us-east-1a" # Hardcoded to avoid aws randomly creates in any AZ
  key_name               = "dpt06"
  vpc_security_group_ids = [aws_security_group.allow_web.id]
  tags = {
    Name = "docker-test-tf"
  }

  user_data = file("init.sh")
  
# Key and local file will not get deleted, when EC2 is destroyed
  provisioner "file" {
    source      = "C:\\Learnings\\terraform_prac\\11.Docker\\Dockerfile"
    destination = "/home/ec2-user/Dockerfile"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("C:\\Users\\Kapil\\Downloads\\dpt06.pem")
      host        = aws_instance.web.public_ip
    }
  }

}



output "pub-ip" {
  value = aws_instance.web.public_ip
}

