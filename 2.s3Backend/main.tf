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

# 5 Route table association
resource "aws_route_table_association" "pub-route" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.test-route.id
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