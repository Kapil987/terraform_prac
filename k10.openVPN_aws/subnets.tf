# 4. subnet, Public subnet
resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.firstvpc.id
  cidr_block        = var.subnet_prefix[0].cidr_block
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet_prefix[0].name
  }
}

# Private subnet
resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.firstvpc.id
  cidr_block        = var.subnet_prefix[1].cidr_block
  availability_zone = "us-east-1a"

  tags = {
    Name = var.subnet_prefix[1].name
  }
}