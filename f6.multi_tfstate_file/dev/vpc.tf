provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["C:\\Users\\Kapil\\.aws\\credentials"]
  profile = "default"
}

# 1. VPC
resource "aws_vpc" "firstvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "terraform-test"
  }
}

# 2. Subnet
resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.firstvpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "pub-sub"
  }
}




