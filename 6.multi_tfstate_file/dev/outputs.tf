# Outputs for dev
output "vpc_id" {
  value = aws_vpc.firstvpc.id
}

output "sg_id" {
  value = aws_security_group.allow_web.id
}

output "sub1_id" {
  value = aws_subnet.subnet1.id
}
