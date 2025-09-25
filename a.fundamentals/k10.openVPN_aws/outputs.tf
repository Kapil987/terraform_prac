# output "server_public_ip" {
#   value = aws_eip.webservereip.public_ip
# }

output "server_private_ip" {
  value = aws_instance.web.private_ip
}

output "server_instance_id" {
  value = aws_instance.web.id
}

output "vpc_id" {
  value = aws_vpc.firstvpc.id
}