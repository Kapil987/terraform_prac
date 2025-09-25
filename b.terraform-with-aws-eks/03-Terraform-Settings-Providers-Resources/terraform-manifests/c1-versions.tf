# Terraform Block
terraform {
  #required_version = "~> 0.14" # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx
  required_version = ">= 1.6.0" 
  required_providers {
    # for argument you will have equal (=) symbol for block you will have curly braces ({})
    aws = {
      source = "hashicorp/aws"
      ##version = ">= 4.65"
      version = ">= 5.31"
    }
  } 
}  
# Provider Block
provider "aws" {
  region = "us-east-1"
}

/*
Note-1:  AWS Credentials Profile (profile = "default") configured on your local desktop terminal  
$HOME/.aws/credentials
*/

terraform {
  required_version = "1.12.2"
  required_providers {
    aws = {
      source = "value"
      version = "value"

    }
  }
}