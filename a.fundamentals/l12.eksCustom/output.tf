output "endpoint" {
  value = aws_eks_cluster.eks.endpoint
}
output "cluster-name" {
  value = aws_eks_cluster.eks.name
}

# output "random-id" {
#   value = random_id.ec2-unique-name.id
# }