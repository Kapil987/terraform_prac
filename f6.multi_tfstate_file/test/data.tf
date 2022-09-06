data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "31-08-dev-terraform-state"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "import_sg" {
  backend = "s3"
  config = {
    bucket = "31-08-dev-terraform-state"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "import_subnet1" {
  backend = "s3"
  config = {
    bucket = "31-08-dev-terraform-state"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
  }
}

# This is querying directly AWS, not from any of the exported values
# aws ec2 describe-images --filters "Name=name,Values=web*" --region us-east-1
data "aws_ami" "test_ami" {
  most_recent      = true
  # name_regex       = "^web-*"
  owners           = ["346709026098"]

  # filter {
  #   name   = "name"
  #   values = ["web-*"]
  # }

}