data "aws_availability_zones" "list_of_azs_from_data_block" {
  state = "available"
  # exclude_names = ["us-east-1a","us-east-1b"]
}

# Datasource for AMI
data "aws_ami" "amzn_ubuntu" {
  most_recent      = true
  owners           = ["amazon"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-*-amd64-server-*"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}