module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.0.1"
  name    = var.vpc_name
  cidr    = var.vpc_cidr_block

  # azs              = var.vpc_list_of_azs
  azs              = data.aws_availability_zones.list_of_azs_from_data_block.names
  private_subnets  = var.vpc_private_subnets
  public_subnets   = var.vpc_public_subnets
  database_subnets = var.vpc_database_subnets

  enable_nat_gateway = true
  enable_vpn_gateway = false
  map_public_ip_on_launch = true
  single_nat_gateway = true

  # public_subnet_tags_per_az = var.public_subnet_tags_per_az

  public_subnet_tags = {
    Type = "Public Subnets"
    "kubernetes.io/role/elb" = 1
    # Add this tag if you need compatibility with older EKS/K8s versions or older AWS Load Balancer Controller.
    "kubernetes.io/cluster/${local.eks_cluster_name}" = "shared"
  }

  # https://docs.aws.amazon.com/eks/latest/userguide/network-reqs.html
  private_subnet_tags = {
    Type = "Private Subnets"
    "kubernetes.io/role/internal-elb" = 1
    #  Add this tag if you need compatibility with older EKS/K8s versions or older AWS Load Balancer Controller.
    "kubernetes.io/cluster/${local.eks_cluster_name}" = "shared"
  }
  database_subnet_tags = {
    Type = "Private Database Subnets"
  }
  # Description: A map of tags to add to all resources
  tags = local.common_tags

  # Description: Additional tags for the VPC
  vpc_tags = local.common_tags

}
