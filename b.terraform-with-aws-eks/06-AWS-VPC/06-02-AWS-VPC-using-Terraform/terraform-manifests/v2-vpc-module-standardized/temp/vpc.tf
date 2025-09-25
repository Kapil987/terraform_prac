module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "6.0.1"
  name = "${local.name}--${var.vpc_name}"
  cidr = "10.0.0.0/16"

  azs             = var.list_of_azs
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

# database subnets
  database_subnets = var.vpc_database_subnets
  enable_nat_gateway = true
  enable_vpn_gateway = false
  map_public_ip_on_launch = true

  single_nat_gateway = true
  public_subnet_tags = {
    Type = "Public Subnets"
  }

  private_subnet_tags = {
    Type = "Private Subnets"
  }
  database_subnet_tags = {
    Type = "Private Database Subnets"
  }
  # Description: A map of tags to add to all resources
  tags = local.common_tags

  # Description: Additional tags for the VPC
  vpc_tags = local.common_tags
}

