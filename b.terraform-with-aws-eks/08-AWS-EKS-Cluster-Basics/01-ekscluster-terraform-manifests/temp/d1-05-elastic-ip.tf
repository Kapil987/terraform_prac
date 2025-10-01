resource "aws_eip" "for_bastion1" {
  instance = module.ec2_public.id
  domain   = "vpc"

  tags = local.common_tags
  depends_on = [module.ec2_public, module.vpc ]
}