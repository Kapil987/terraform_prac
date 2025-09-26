module "ec2_public" {
  source = "terraform-aws-modules/ec2-instance/aws"
  version = "6.1.1"

  name = "${local.name}-bastion-instance"

  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  monitoring             = false
  # subnet_id              = var.vpc_public_subnets[0]
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.public_bastion_sg.security_group_id]
  ami                    = data.aws_ami.amzn_ubuntu.id

  tags = local.common_tags
}
