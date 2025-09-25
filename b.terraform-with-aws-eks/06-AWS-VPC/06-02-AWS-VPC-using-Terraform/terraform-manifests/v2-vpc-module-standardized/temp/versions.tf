terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.13.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      Project   = "ACME-Corp-Website"
      ManagedBy = "Terraform"
    }
  }
}

variable "business_divsion" {
  default = "HR"
}

variable "environment" {
  default = "dev"
}

variable "vpc_name" {
  default = "frontend-app"
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "list_of_azs" {
  type = list(string)
  default = [ "us-east-1a", "us-east-1b"]  
}

variable "vpc_database_subnets" {
  type = list(string)
  default = [ "10.0.150.0/24" , "10.0.152.0/24" ]
}
locals {
  owners = var.business_divsion
  environment = var.environment
  name = "${local.owners}--${local.environment}"
  common_tags = {
    owners = local.owners
    environment = local.environment
    createdBy = "Terraform-learnings"
  }
}