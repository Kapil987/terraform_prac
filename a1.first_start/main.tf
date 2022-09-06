provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["C:\\Users\\Kapil\\.aws\\credentials"]
}

variable "subnet_prefix" {
  description = "cidr block for subnets"
}

# 1. VPC
resource "aws_vpc" "firstvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "terraform-test"
  }
}

# 2. Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.firstvpc.id

  tags = {
    Name = "web-igw-1"
  }
}

# 3. Route Table
resource "aws_route_table" "test-route" {
  vpc_id = aws_vpc.firstvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "web-pub-01"
  }
}


# 4. subnet
resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.firstvpc.id
  cidr_block        = var.subnet_prefix[0].cidr_block
  availability_zone = "us-east-1a"

  tags = {
    Name = var.subnet_prefix[0].name
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.firstvpc.id
  cidr_block        = var.subnet_prefix[1].cidr_block
  availability_zone = "us-east-1a"

  tags = {
    Name = var.subnet_prefix[1].name
  }
}

# 5 Route table association
resource "aws_route_table_association" "pub-route" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.test-route.id
}

# 6. Security Group
resource "aws_security_group" "allow_web" {
  name        = "Allow Web"
  description = "Allow web traffic"
  vpc_id      = aws_vpc.firstvpc.id

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
    to_port     = 80
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

# 7. Network Interface
resource "aws_network_interface" "webnic" {
  subnet_id       = aws_subnet.subnet1.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.allow_web.id]

}

# 8. EIP association
resource "aws_eip" "webservereip" {
  instance                  = aws_instance.web.id
  network_interface         = aws_network_interface.webnic.id
  associate_with_private_ip = "10.0.1.50"
  vpc                       = true
  depends_on = [
    aws_internet_gateway.gw
  ]
}

output "server_public_ip" {
  value = aws_eip.webservereip.public_ip
}

output "server_private_ip" {
  value = aws_instance.web.private_ip
}

output "server_instance_id" {
  value = aws_instance.web.id
}

output "vpc_id" {
  value = aws_vpc.firstvpc.id
}

# 9. Create EC2 
resource "aws_instance" "web" {
  ami               = "ami-072aa37bbd1554d3c"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a" # Hardcoded to avoid aws randomly creates in any AZ
  key_name          = "dpt06"

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.webnic.id
  }
  tags = {
    Name = "terraform-test"
  }

  user_data = "${file("init.sh")}"
}
