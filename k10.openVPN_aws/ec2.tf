# Public Create EC2 
# https://aws.amazon.com/marketplace/pp/prodview-y3m73u6jd5srk manually accept subscription
resource "aws_instance" "web" {
  ami               = var.ami_id
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a" # Hardcoded to avoid aws randomly creates in any AZ
  key_name          = "dpt06"
  subnet_id = aws_subnet.subnet1.id
  vpc_security_group_ids = [aws_security_group.allow_web.id]
  tags = {
    Name = "OpenVPN-tf"
  }
}

resource "aws_instance" "private_server" {
  ami               = "ami-05fa00d4c63e32376"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a" # Hardcoded to avoid aws randomly creates in any AZ
  key_name          = "dpt06"
  subnet_id = aws_subnet.subnet2.id
  vpc_security_group_ids = [aws_security_group.priv-sc.id]
  tags = {
    Name = "DB-tf"
  }
}
