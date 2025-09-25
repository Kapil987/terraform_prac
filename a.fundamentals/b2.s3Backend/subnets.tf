# 4. subnet
resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.firstvpc.id
  cidr_block        = var.subnet_prefix[0].cidr_block
  availability_zone = var.subnet_az[0]

  tags = {
    Name = var.subnet_prefix[0].name
  }
}

# resource "aws_subnet" "subnet2" {
#   vpc_id            = aws_vpc.firstvpc.id
#   cidr_block        = var.subnet_prefix[1].cidr_block
#   availability_zone = var.subnet_az[1]

#   tags = {
#     Name = var.subnet_prefix[1].name
#   }
# }