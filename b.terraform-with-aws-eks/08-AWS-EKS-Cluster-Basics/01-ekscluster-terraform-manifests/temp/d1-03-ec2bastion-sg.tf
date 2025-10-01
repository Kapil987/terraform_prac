module "public_bastion_sg" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "5.3.0"
  name        = "${local.name}-public-bastion-sg"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = module.vpc.vpc_id

  # ingress rules
  ingress_rules = ["ssh-tcp","http-80-tcp","https-443-tcp"] #ssh-tcp has a special meaning for this module its not just a description
  ingress_cidr_blocks = ["0.0.0.0/0"] # for all ingress_rule this/these cidr block will be allowed
  # ingress_with_cidr_blocks = [
  #   {
  #     from_port   = 22
  #     to_port     = 22
  #     protocol    = "tcp"
  #     description = "Custom SSH Port"
  #     cidr_blocks = "0.0.0.0/0"
  #   },
  #   {
  #     from_port   = 8080
  #     to_port     = 8080
  #     protocol    = "tcp"
  #     description = "Custom tcp Port"
  #     cidr_blocks = "0.0.0.0/0"
  #   },
  #   {
  #     from_port   = 80
  #     to_port     = 80
  #     protocol    = "tcp"
  #     description = "Custom HTTP Port"
  #     cidr_blocks = "0.0.0.0/0"
  #   },
  #   {
  #     from_port   = 443
  #     to_port     = 443
  #     protocol    = "tcp"
  #     description = "Custom HTTPs Port"
  #     cidr_blocks = "0.0.0.0/0"
  #   }
  # ]

  # egress rules
  egress_rules = ["all-all"] # #all-all has a special meaning for this module its not just a description
  # define egress rules with cidr blocks in detail
  # egress_with_cidr_blocks = [
  #   {
  #     from_port   = 80
  #     to_port     = 80
  #     protocol    = "tcp"
  #     description = "Allow outbound HTTP"
  #     cidr_blocks = ["0.0.0.0/0"]
  #   },
  #   {
  #     from_port   = 443
  #     to_port     = 443
  #     protocol    = "tcp"
  #     description = "Allow outbound HTTPS"
  #     cidr_blocks = ["0.0.0.0/0"]
  #   }
  # ]
  tags = local.common_tags
}
