provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["C:\\Users\\Kapil\\.aws\\credentials"]
}

# 1. VPC
resource "aws_vpc" "firstvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "terraform-test"
  }
}

### To undestate data block in terraform
## Either you declare this output block in this file or create a separate outputs.tf
## This output block will export vpc_id in the backend tfstate
## When another project wants the vpc_id created  this information will be feteched from backend
## in another project vpc_id can be used as data.terraform_remote_state.vpc.outputs.vpc_id

output "vpc_id" {
  value = aws_vpc.firstvpc.id
}
