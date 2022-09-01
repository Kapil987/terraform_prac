provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["C:\\Users\\Kapil\\.aws\\credentials"]
}

resource "aws_vpc" "firstvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "terraform-test"
  }
}