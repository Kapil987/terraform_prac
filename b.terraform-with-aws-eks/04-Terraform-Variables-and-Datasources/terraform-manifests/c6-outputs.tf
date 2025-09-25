# Terraform Output Values

# EC2 Instance Public IP
output "instance_publicip" {
  description = "EC2 Instance Public IP"
  value = aws_instance.myec2vm.public_ip
}

# EC2 Instance Public DNS
output "instance_publicdns" {
  description = "EC2 Instance Public DNS"
  value = aws_instance.myec2vm.public_dns
}

output "ami_id_data_source_amazon_linux" {
  value = data.aws_ami.amzlinux2.image_id
}

output "ami_id_data_source_amazon_ubuntu" {
  value = data.aws_ami.amzn_ubuntu.image_id
}