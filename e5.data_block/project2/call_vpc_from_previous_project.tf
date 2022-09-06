provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["C:\\Users\\Kapil\\.aws\\credentials"]
}

# output "vpc_id" {
#   value = aws_vpc.firstvpc.id
# }

# 2. Subnet
resource "aws_subnet" "subnet1" {
  vpc_id            = data.terraform_remote_state.vpc.outputs.vpc_id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "pub-subnet-2"
  }
}